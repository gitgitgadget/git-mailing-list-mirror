From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: replace unnecessary sed invocation
Date: Thu, 18 Mar 2010 07:48:39 -0700
Message-ID: <7vwrx9vg6w.fsf@alter.siamese.dyndns.org>
References: <1268889045-21751-1-git-send-email-bebarino@gmail.com>
 <4BA22AEE.8000606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 15:49:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsH1w-0003P1-Dl
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 15:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280Ab0CROsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 10:48:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab0CROsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 10:48:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CE6AA302E;
	Thu, 18 Mar 2010 10:48:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tQT/msJyUNTmT18zEzMePiD6nk8=; b=Kf1CBv
	x4XdLgUYj/3bNPF9PumuUfZJtbpOzEKlS9dpojZNq9fCO1CKEeCqHqmjQJpndkHj
	DTmViXAAvmUp4AyW3Rm3UWohn86LAgsh2AzZduFjWYgi2Pw4VkWt9pSFETOXRwHw
	2Zr+F/72SDDQujiu3nFMhV4GHV81NamISV6oI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=knHOGoZaIOF0f324V6daUgo3gge1aEmk
	BJrvmdLR9sSU52wRWg3Z4mmzuD/XkXH5f479jxqag/UMMdiha920hz4co3vriL/N
	BIF0cDDu2iHJnOaoaoOkHrLPHhLgPwlaXzcC3hKeWnMVHJZwY8TvDkjrtSuN/AaU
	+BTDee1l4aw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3984DA3028;
	Thu, 18 Mar 2010 10:48:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92690A3023; Thu, 18 Mar
 2010 10:48:41 -0400 (EDT)
In-Reply-To: <4BA22AEE.8000606@gmail.com> (Gabriel Filion's message of "Thu\,
 18 Mar 2010 09\:30\:22 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A627018-329D-11DF-8BAB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142472>

Gabriel Filion <lelutin@gmail.com> writes:

>> +curr_branch_short="${curr_branch#refs/heads/}"
>
> This modification is a bashism. This syntax is not compatible with other
> shells.

To me, the above looks like "${parameter#word}", which is a plain vanilla
POSIX shell construct that we adopted to use in our scripts.

There are bash-only constructs we decided never to use in our scripts;
among them are "${parameter/pattern/string}" and "${parameter:offset}",
both are not in POSIX.
