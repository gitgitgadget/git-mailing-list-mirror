From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] completion: add missing terminator in case statement
Date: Mon, 21 Jul 2014 10:26:47 -0700
Message-ID: <xmqqmwc2k4h4.fsf@gitster.dls.corp.google.com>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jul 21 19:27:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9HMi-0008A2-Jc
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 19:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933215AbaGUR1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 13:27:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63945 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933190AbaGUR1C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 13:27:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8E0E29017;
	Mon, 21 Jul 2014 13:27:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rdKc2pmzmK8RFKmL8bHltmue8CY=; b=YZeRWd
	XW/7N28vZDmT3a6udEfagT/FmvgHWlCAzQmkOwt3vnEOxfO7QDOBBTPCcjtm9MYy
	6krro337NVqi5ArPTbVPsWDjTAMIaGBoWgqdVmRkxRfs2SrPgciLFEySwIsk5DaF
	5AEuO6fsrZ63T1IuEndIRj8hrSc1Scj1aJNHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uC8Vk9yZoGwuziWt1D7QxmsiVh5PC9Ds
	Tpw4MCrEZwGojRXiVO3yzxpo7lliFXNxO7f6WTaumWjflC9fvR7jgjydtMKhZP/z
	9JWsU88BpCfEVDGnyuLdQc7z0nBrRrYAmv3W6hmZOBMyeWhkvx+nMZGSmnHqD7jj
	zBT3ZeRu2X8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B131D29013;
	Mon, 21 Jul 2014 13:27:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A39A62AFE5;
	Mon, 21 Jul 2014 13:26:48 -0400 (EDT)
In-Reply-To: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
	(John Keeping's message of "Sat, 19 Jul 2014 10:45:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 322175BC-10FC-11E4-8DE2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253980>

John Keeping <john@keeping.me.uk> writes:

> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---

As these ;; are separators not terminators, this is not strictly
necessary.  Squashing it into a change that adds more case arms to
this case statement is of course not just good but necessary,
though.

>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 7a6e1d7..d0b2895 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1627,6 +1627,7 @@ _git_push ()
>  	--repo)
>  		__gitcomp_nl "$(__git_remotes)"
>  		return
> +		;;
>  	esac
>  	case "$cur" in
>  	--repo=*)
