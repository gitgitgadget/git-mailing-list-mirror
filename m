From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] bash completion: add bash.showUntrackedFiles option
Date: Tue, 12 Feb 2013 14:17:20 -0800
Message-ID: <7vwquddvnz.fsf@alter.siamese.dyndns.org>
References: <1360699936-28688-1-git-send-email-martinerikwerner@gmail.com>
 <1360699936-28688-2-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:17:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5OAf-0007Pm-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 23:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425Ab3BLWRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 17:17:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45425 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389Ab3BLWRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 17:17:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71534CB5D;
	Tue, 12 Feb 2013 17:17:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=skpYU40xN+AO+91F/TGZRp/u2qE=; b=NaHTFm
	qZrQPY65Zlv90hU8z52si2ef84uxJ4Q7hZQ9JtZ/pO46ykYnQGA6bPVbPfbjUWo9
	ITKfCjEW8iu5a0Jn2uql0cgepXQE6q5uj3L5MPD9R8X9Am1bXQcxrY7Mkixs/bht
	iH6NM+vtYmj+MIbS3d2aDSfpum+mHZ/AH9vQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TX1bIgNs5UjzMtA5tOJGPHACtjSNUMxK
	7ALUsWiQjs5Ef11YMnmRn42dojwuT7leTxdsKovUWpILVAwg5Zl2spAe/sFeh3NE
	w39UAZ2P4x8ZjFLyC7gKf4k3UkPUQlfjlFo/WLXM8kk2a7th+72w4q/f+kAbXBK0
	kqOYB/C/RI4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 369B3CB56;
	Tue, 12 Feb 2013 17:17:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40734CB50; Tue, 12 Feb 2013
 17:17:23 -0500 (EST)
In-Reply-To: <1360699936-28688-2-git-send-email-martinerikwerner@gmail.com>
 (Martin Erik Werner's message of "Tue, 12 Feb 2013 21:12:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9A8F926-7561-11E2-A46D-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216207>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> Add a config option 'bash.showUntrackedFiles' which allows enabling
> the prompt showing untracked files on a per-repository basis. This is
> useful for some repositories where the 'git ls-files ...' command may
> take a long time.
>
> Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> ---

OK.

The subject needs to be corrected, though ;-) No need to resend.
I'll do s/completion/prompt/ while applying.

Thanks.

>  contrib/completion/git-prompt.sh |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 9bef053..9b2eec2 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -43,7 +43,10 @@
>  #
>  # If you would like to see if there're untracked files, then you can set
>  # GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're untracked
> -# files, then a '%' will be shown next to the branch name.
> +# files, then a '%' will be shown next to the branch name.  You can
> +# configure this per-repository with the bash.showUntrackedFiles
> +# variable, which defaults to true once GIT_PS1_SHOWUNTRACKEDFILES is
> +# enabled.
>  #
>  # If you would like to see the difference between HEAD and its upstream,
>  # set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
> @@ -332,8 +335,10 @@ __git_ps1 ()
>  			fi
>  
>  			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
> -				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
> -					u="%"
> +				if [ "$(git config --bool bash.showUntrackedFiles)" != "false" ]; then
> +					if [ -n "$(git ls-files --others --exclude-standard)" ]; then
> +						u="%"
> +					fi
>  				fi
>  			fi
