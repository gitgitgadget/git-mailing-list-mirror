From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: improve description of GIT_EDITOR and
 preference order
Date: Fri, 23 Mar 2012 11:18:09 -0700
Message-ID: <7vty1ftc4e.fsf@alter.siamese.dyndns.org>
References: <loom.20120323T133648-453@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rodrigo Silva "\(MestreLion\)" <linux@rodrigosilva.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 19:18:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB94E-0003qJ-Gm
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 19:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759176Ab2CWSSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 14:18:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759016Ab2CWSSM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 14:18:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 444C173ED;
	Fri, 23 Mar 2012 14:18:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FMFrxdBFqoQW2uTmwp4T20ztfjc=; b=jJ34f+
	LMLaUAcoAJZbRLAVCgU38lYh8hzEuaJpZa/a3Z2ETNEZMShbTIgEXZUbyt1cvkq5
	6Bx3cSEOdifSPIDnCle88mzTyn7tXNPD5lw97iNx7T4ljvhHt7uiHkz+C6vMDN0a
	OXhsBMadZ4e0Pd5xkTwj2ZgmLKdoHXSpNd900=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dGhkwE9uqLafrflxn9nmm3CmqNgycU4L
	2CI3Q8VANaQsc2K6as2pGkyUTE3hxJMt/Yp2xDdH29Cl730U7SNkw0vvplwmnnbH
	hBZW0MvrvaNMIDgsTRkif5yeQbiuG4K9GR13ttWuX8Zxl2yVrRxdFYvEi9BYyjXl
	TNjfnoyLaVA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39FC273EC;
	Fri, 23 Mar 2012 14:18:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEC7673EA; Fri, 23 Mar 2012
 14:18:11 -0400 (EDT)
In-Reply-To: <loom.20120323T133648-453@post.gmane.org> (Rodrigo Silva's
 message of "Fri, 23 Mar 2012 12:38:42 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CAF4166-7514-11E1-9F8D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193784>

Rodrigo Silva "(MestreLion)"  <linux@rodrigosilva.com> writes:

> Previously GIT_EDITOR was not listed in git(1) "Environment Variables" section,
> which could be very confusing to users. Include it in "other" subsection along
> with a link to git-var(1), since that is the page that fully describes all
> places where editor can be set and also their preference order.
>
> Also, git-var(1) did not say that hardcoded fallback 'vi' may have been changed
> at build time. A user could be puzzled if 'nano' pops up even when none of the
> mentioned environment vars or config.editor are set. Clarify this.
>
> Ideally, the build system should be changed to reflect the chosen fallback
> editor when creating the man pages. Not sure if that is even possible though.
>
> Signed-off-by: Rodrigo Silva (MestreLion) <linux@rodrigosilva.com>
> ---
>  Documentation/git-var.txt |    3 ++-
>  Documentation/git.txt     |    6 ++++++
>  2 files changed, 8 insertions(+), 1 deletions(-)
>
>  Granted, this is a very minor issue, but if any user stumble on this, this
>  patch may reduce investigation from 50 minutes to 5
>
>  Patch was tested in 1.7.1, but sources show this is still present in 1.7.10-rc1
>
> diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
> index 5317cc2..9c49163 100644
> --- a/Documentation/git-var.txt
> +++ b/Documentation/git-var.txt
> @@ -43,7 +43,8 @@ GIT_EDITOR::
>      `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
>      --nofork`.  The order of preference is the `$GIT_EDITOR`
>      environment variable, then `core.editor` configuration, then
> -    `$VISUAL`, then `$EDITOR`, and then finally 'vi'.
> +    `$VISUAL`, then `$EDITOR`, and then finally a hardcoded fallback
> +    editor set at build time, by default 'vi'.

I do not think this is needed; please file a bug to whoever is replacing
'vi' with 'nono' and distributing the resulting binary, without updating
this part of the documentation.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index d5b7667..fac57ba 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -711,6 +711,12 @@ other
>  	a pager.  See also the `core.pager` option in
>  	linkgit:git-config[1].
>  
> +'GIT_EDITOR'::
> +    This environment variable overrides `$EDITOR` and `$VISUAL`.
> +    It is used by several git comands when, on interactive mode,
> +    an editor is to be launched. See also linkgit:git-var[1]
> +    and the `core.editor` option in linkgit:git-config[1].
> +

This is a good addition.  Thanks.

>  'GIT_SSH'::
>  	If this environment variable is set then 'git fetch'
>  	and 'git push' will use this command instead
