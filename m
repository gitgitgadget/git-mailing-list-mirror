From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] document submodule sync --recursive
Date: Thu, 03 Dec 2015 12:17:12 -0800
Message-ID: <xmqqh9jzthh3.fsf@gitster.mtv.corp.google.com>
References: <1449171207-27201-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, cederp@opera.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 21:17:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4aJb-0003dJ-Qo
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 21:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbbLCURQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 15:17:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753426AbbLCURP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 15:17:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 568962F528;
	Thu,  3 Dec 2015 15:17:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HQ1nl9RUo5bweGLlBzH4sBbQnUQ=; b=SreOr2
	NUFNLlx99z6w4wK335rH9IPo/0ZNWfQtsemAn/Uu7Jj+S+aIY2deeTR/LEphkl5e
	A62JSg8oSY/BhjHxl7jCi+A1G0H44FjSi/5Iw/k8zdpErI54XGV6go0DNTeqh5Yt
	b5cmrq7PeXtFcAx075oAU4Yr/MJxaH2Z4btGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tb30K6ltFK8MDtNaS1OokSjXpEdqTCR9
	LQVFzfHMNsChre+gkYVsFhtoeTjxr00wBxXf8fuPN3H3UU45GAFJ0kRk8zapE6mH
	Y90O1hSqExdAQJM2HwFFi9BkMLqkPUugXVkqJsOGrsDEXP6N+wkoN6iqkJVt9DTU
	6Fg4H8B+oaY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4BC682F527;
	Thu,  3 Dec 2015 15:17:14 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BAAA32F526;
	Thu,  3 Dec 2015 15:17:13 -0500 (EST)
In-Reply-To: <1449171207-27201-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 3 Dec 2015 11:33:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D74E71F6-99FA-11E5-84CE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281967>

Stefan Beller <sbeller@google.com> writes:

> The git-submodule(1) is inconsistent. In the synopsis, it says:
>
>        git submodule [--quiet] sync [--recursive] [--] [<path>...]
>
> The description of the sync does not mention --recursive, and the
> description of --recursive says that it is only available for foreach,
> update and status.
>
> The option appears to work, so the documentation should be
> updated.
>
> Tested-by: Per Cederqvist <cederp@opera.com>

Isn't this Reported-by? (genuine question; I haven't caught up with
my inbox backlog and do not claim having seen everything Per wrote
to this list).

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  This applies on origin/master.

Thanks.  Should it go to maintenance track (iow, was the feature
that wasn't documented already in maint)?

>  
>  Thanks Per for reporting,
>  Stefan
>
>  Documentation/git-submodule.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index f17687e..cd8d126 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -237,6 +237,9 @@ sync::
>  +
>  "git submodule sync" synchronizes all submodules while
>  "git submodule sync \-- A" synchronizes submodule "A" only.
> ++
> +If `--recursive` is specified, this command will recurse into the
> +registered submodules, and update any nested submodules within.
>  
>  OPTIONS
>  -------
> @@ -364,7 +367,7 @@ the submodule itself.
>  for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
>  
>  --recursive::
> -	This option is only valid for foreach, update and status commands.
> +	This option is only valid for foreach, update, status and sync commands.
>  	Traverse submodules recursively. The operation is performed not
>  	only in the submodules of the current repo, but also
>  	in any nested submodules inside those submodules (and so on).
