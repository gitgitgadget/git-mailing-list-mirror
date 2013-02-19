From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] user-manual: Reorganize the reroll sections,
 adding 'git rebase -i'
Date: Tue, 19 Feb 2013 10:47:04 -0800
Message-ID: <7vwqu45efr.fsf@alter.siamese.dyndns.org>
References: <20130219093429.GA4024@odin.tremily.us>
 <cover.1361267945.git.wking@tremily.us>
 <e9f8a25c05f9cfe89c6bcbefb69f40cd629f9925.1361267945.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Feb 19 19:47:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7sE2-0007Qo-LE
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 19:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933295Ab3BSSrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 13:47:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933193Ab3BSSrI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 13:47:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C058ADFD;
	Tue, 19 Feb 2013 13:47:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U+21gjOuhHiDosAZl8cofaudeN8=; b=DOa8iV
	2JIhTjN6ptJWuP12fhqbM59dPw3Ys3pt+NE7x1s8xfyIqOyrkwWiCtAkvXiF4YWg
	Vd6pocGg+yvrO8BjpkBp0GrYV0Jjxdofx3zI8BPVV9lr8u+WLCm0NaSry/VDR13U
	KOykbgljlHduJIVZ84LVkeCKvj+WG2gYRaT8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NTyKekW4phjIXQ5DGb3hch4vVon8U4+L
	p0Ur2/f9DBU3cI75O8jMNdEGYj1a2+hiZNOIRTPgI4lvawYWAgKQRNfR/LPBB49F
	vNHynqGR6akLkKEaT+en391O5LgNrZtv41AkAJCnAxfy5cO2+Oa+X9Ydc+t+kSty
	EEYA3If8T8k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3D31ADFB;
	Tue, 19 Feb 2013 13:47:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61FCDADFA; Tue, 19 Feb 2013
 13:47:06 -0500 (EST)
In-Reply-To: <e9f8a25c05f9cfe89c6bcbefb69f40cd629f9925.1361267945.git.wking@tremily.us>
 (W. Trevor King's message of "Tue, 19 Feb 2013 05:05:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C227AFA2-7AC4-11E2-90E6-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216644>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> I think this interface is often more convenient than extended cherry
> picking or using 'git format-patch'.  In fact, I removed the
> cherry-pick section entirely.  The entry-level suggestions for
> rerolling are now:
>
> 1. git commit --amend
> 2. git format-patch origin
>    git reset --hard origin
>    ...edit and reorder patches...
>    git am *.patch
> 3. git rebase -i origin
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---

Thanks.

> +Sometimes you want to edit a commit deeper in your history.  One
> +approach is to use `git format-patch` to create a series of patches,
> +then reset the state to before the patches:
>  
>  -------------------------------------------------
> +$ git format-patch origin
> +$ git reset --hard origin
>  -------------------------------------------------

Technically speaking, this does not "reset to before the patches".
You would need "git reset --hard $(git merge-base origin HEAD)" or
something like that.

I think this is fine as-is in the flow of text, where we haven't
taught the readers the use of merge-base to find the fork point.
