From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport.txt: cvsps-2 is deprecated
Date: Thu, 24 Jan 2013 12:04:11 -0800
Message-ID: <7v7gn2bb5w.fsf@alter.siamese.dyndns.org>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
 <20130122234554.GI7498@serenity.lan>
 <7vobgglpv4.fsf@alter.siamese.dyndns.org>
 <20130123092858.GJ7498@serenity.lan>
 <7vsj5rhlfs.fsf@alter.siamese.dyndns.org>
 <20130123211237.GR7498@serenity.lan>
 <7vip6ndveb.fsf@alter.siamese.dyndns.org>
 <20130124191845.GS7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 24 21:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyT2J-0003uN-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 21:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab3AXUER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 15:04:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518Ab3AXUEN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 15:04:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DF20B96D;
	Thu, 24 Jan 2013 15:04:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WBMJPDuXjQK7/X7OOXsWT2LPvTY=; b=W67e4v
	T/RexQxYoTJ5kFLpXVQ0F7CbRgVtk9689kZ+IJWSjDc91jB5SfEWMwrf7dxyPpoP
	MxH57Avnpq/E8F4Gvndi8AXI6iKqHCPa4Hr/vV0N/G/P3w1FNCSW5TZcNuQd6M3i
	xzV/UeSqrr5fWudvJIYzIdse/C0t//JQlLFLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t266o8Edd8i5iE4bxoJxQ6VQuq+uIykh
	8AJemQSWvx//owHuva8upIS68Sd4nemeKJEnn6D39gS7KnxnDnG88gNfZ8zbCnNs
	biC92Sks9v3BD0WuriH7O+S0S1rc4om+ak9/iQ1ineyTcMeZ7/1KDUmv8x9a55Kh
	TSRuxxZmZkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41164B96C;
	Thu, 24 Jan 2013 15:04:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74EAAB966; Thu, 24 Jan 2013
 15:04:12 -0500 (EST)
In-Reply-To: <20130124191845.GS7498@serenity.lan> (John Keeping's message of
 "Thu, 24 Jan 2013 19:18:45 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38C5D166-6661-11E2-8E29-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214450>

John Keeping <john@keeping.me.uk> writes:

> git-cvsimport relies on version 2 of cvsps and does not work with the
> new version 3.  Since cvsps 3.x does not currently work as well as
> version 2 for incremental import, document this fact.
>
> Specifically, there is no way to make new git-cvsimport that supports
> cvsps 3.x and have a seamless transition for existing users since cvsps
> 3.x needs a time from which to continue importing and git-cvsimport does
> not save the time of the last import or import into a specific namespace
> so there is no safe way to calculate the time of the last import.

Isn't the whole "and git-cvsimport does not save the time..."  part
something that can be fixed in the new cvsimport that reads the
output from cvsps3?

To me, it sounds more like

    cvsps2 + cvsimport has an unfixable bugs and there have been an
    effort to rewrite cvsps2 from scratch.  The resulting cvsp3
    currently is unusable with cvsimport, especially when importing
    the history incrementally, and it isn't expected that it will
    ever be usable with cvsimport again.

    There are other tools that analyse the original history better
    and emits more correct output when used to convert the whole
    history, and hopefully cvsps3 + fast-import would become one of
    them.  Suggest users to use them instead of cvsimport when they
    are not doing an incremental import.

By the way, do we want to make any recommendation to the distro
folks which cvsps they should ship?  It appears that not shipping
cvsps2 would be a major regression if cvsps3 does not plan to
support incrementals, so shipping both might be the safest way for
them to support their users with different needs.

Thanks.  I think the patch text itself is good.

> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> On Wed, Jan 23, 2013 at 09:04:12PM -0800, Junio C Hamano wrote:
>> Care to roll a proper patch with a log message?  I'll discard the
>> topic for now and replace it with your documentation update.
>
> Here it is.
>
>  Documentation/git-cvsimport.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index 9d5353e..f059ea9 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -18,6 +18,12 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> +*WARNING:* `git cvsimport` uses cvsps version 2, which is considered
> +deprecated; it does not work with cvsps version 3 and later.  If you are
> +performing a one-shot import of a CVS repository consider using
> +link:http://cvs2svn.tigris.org/cvs2git.html[cvs2git] or
> +link:https://github.com/BartMassey/parsecvs[parsecvs].
> +
>  Imports a CVS repository into git. It will either create a new
>  repository, or incrementally import into an existing one.
