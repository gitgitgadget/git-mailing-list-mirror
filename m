From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash: teach __git_ps1 about REVERT_HEAD
Date: Sun, 31 Mar 2013 19:51:40 -0700
Message-ID: <7vk3onm08z.fsf@alter.siamese.dyndns.org>
References: <1364689848-52647-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 04:52:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMUqw-0000I9-Sw
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 04:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab3DACvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 22:51:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755742Ab3DACvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 22:51:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C4BCE895;
	Mon,  1 Apr 2013 02:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QVoSDCtP0/zY3oHZ9+zx6azs0PI=; b=ZnBYks
	/WcVVN/UCyiIMD3FqmtDGFBVZ8YYcFBRNuQZ9oEiOkX7KzYWopTpw0yphnSO0y68
	iQusdklEKEBGlmEn4UTavsBGBcomQ+KbDXp9P+EwckQJ1KUXXM/Gx9tw2hqTBfrI
	r/u3BkqwVdwYJbMLHUgmBDxeS29d+nqpMstEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vy4+UUCeb9KvKrnvoEH40dD0ISfygjCO
	/BYjGaxN/6LPJOxjjQ5BKnsgLfYYoDhpaT91ROdLlAf5vkBgRGrw4kJT6VK2SFq8
	8kyGbCs+2RivE4QUnVC+oVjheL9gLEEv6Kk6Q9aLpmwm84Ssp7ZXoF0Xr2EqV+q4
	zoDEMdZyQKk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 347E4E893;
	Mon,  1 Apr 2013 02:51:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CD1DE88D; Mon,  1 Apr 2013
 02:51:41 +0000 (UTC)
In-Reply-To: <1364689848-52647-1-git-send-email-robin.rosenberg@dewire.com>
 (Robin Rosenberg's message of "Sun, 31 Mar 2013 01:30:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14DFB3EE-9A77-11E2-AA2D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219661>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  contrib/completion/git-prompt.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 341422a..756a951 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -282,6 +282,8 @@ __git_ps1 ()
>  				r="|MERGING"
>  			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
>  				r="|CHERRY-PICKING"
> +			elif [ -f "$g/REVERT_HEAD" ]; then
> +				r="|REVERTING"

Obviously a good thing to do; thanks.

>  			elif [ -f "$g/BISECT_LOG" ]; then
>  				r="|BISECTING"
>  			fi
