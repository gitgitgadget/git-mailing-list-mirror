From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2013, #03; Thu, 12)
Date: Mon, 16 Dec 2013 09:14:15 -0800
Message-ID: <xmqqy53kpvko.fsf@gitster.dls.corp.google.com>
References: <xmqqwqj9r2ig.fsf@gitster.dls.corp.google.com>
	<xmqqa9g1qrzj.fsf@gitster.dls.corp.google.com>
	<20131216123040.GZ11745@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Mon Dec 16 18:14:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsbkP-0000zT-1K
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 18:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab3LPROV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 12:14:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466Ab3LPROU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 12:14:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 187FE595C2;
	Mon, 16 Dec 2013 12:14:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5JUL0Y9NE7MiQvxQLK/9KegI2cs=; b=D/KReO
	y+4fEuEmQjvfWZhcCpMiNTKaJmWPWlskjIiM5wERYVNJ9pnCMyaCMPjPrNnDT8Qp
	hOARzr9qhlDtUJkradL3zma5zUAKujGf8q7dAI+sGSHMNiaxINuenO9THuuWeLKK
	naHnQGuuci+p0Xpv3PC86KADgu+SN6h3mbQZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mY/o87UL0u7ORMziVPIjRvzBLTOu6dMy
	HkTNrL8T0GShcxqp7zLQL/Cbso4ctsbLQw/HwvvGD1Ns7Wx3kAkus4OcxxMbu3ux
	ig73Z9Z1JWFXE1UtYnaavdkFZ89+fUQNKTJn9sqEfb0T+vKVk2KaFAdYHPCYOCcQ
	TF8y6arBxUc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05BBF595C1;
	Mon, 16 Dec 2013 12:14:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D0DA595C0;
	Mon, 16 Dec 2013 12:14:19 -0500 (EST)
In-Reply-To: <20131216123040.GZ11745@mars-attacks.org> (Nicolas Vigier's
	message of "Mon, 16 Dec 2013 13:30:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7FD6D46E-6675-11E3-AC4E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239340>

Nicolas Vigier <boklm@mars-attacks.org> writes:

> On Sun, 15 Dec 2013, Junio C Hamano wrote:
>
>> Besides, we would need at least something like this to make sure
>> that people have a way to selectively disable configured default
>> when necessary, perhaps like this.
>
> This looks like a good idea.

I said "at least" because I suspect this is far from sufficient.
When the variable is set, there is no way to say "do not bother
signing commits when stashing WIP changes", for example, no?

Scripted Porcelains that happen to use commit-tree are all affected,
while those that have been rewritten in C and internally make calls
to commit_tree() (e.g. "git merge") will not be affected by it.  I
still am not convinced that this configuration variable is a good
idea in the first place, but I am not its audience, so....
