From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree Ready #2
Date: Mon, 20 Feb 2012 23:10:32 -0800
Message-ID: <7vmx8cirvb.fsf@alter.siamese.dyndns.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
 <8739acra5j.fsf@smith.obbligato.org>
 <20120215050855.GB29902@sigill.intra.peff.net>
 <87sjicpsr1.fsf@smith.obbligato.org> <87ty2ro1zf.fsf@smith.obbligato.org>
 <20120220205346.GA6335@sigill.intra.peff.net>
 <7vd399jdwc.fsf@alter.siamese.dyndns.org>
 <87ehtowxu7.fsf@smith.obbligato.org>
 <7vwr7gitjl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Tue Feb 21 08:10:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzjs0-0005fa-9j
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 08:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab2BUHKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 02:10:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253Ab2BUHKf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 02:10:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB6332443;
	Tue, 21 Feb 2012 02:10:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q+4+CpLiIzCTJ9sesGXlgjwOpXs=; b=lYGe6H
	Clq3XpUd60+R9I0UBh+V4XNgBnypoBcKM8uEXlaIO2+Z0Q5oRAbW1NL/ZBuRYHXd
	t3YiKGJQx3OeLsrGMsIwD6P+yp9Nx5TCTbThXHUkvxQrZJiv3chZHa49+UU+iuKM
	SXiVdAReIelk0l/RX8oS2h48L61QgpjDjPC1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXqftlGqI/IC4JFq05i4JlduWSFbqca1
	nAEhGHvhB0AU/Yy0Ph/d2RMJ2d0Rjgt11OjUR4WwqFQDPU5CGgG80vB3da/e7vBO
	Af6Dl+SAT9HX9qiJGixWg0P2kzzWDU+VL7TCmQuq2TcvdAaV2RpOpuwmim7h93Em
	TsyrY+ruReI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D11C12442;
	Tue, 21 Feb 2012 02:10:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6105C2441; Tue, 21 Feb 2012
 02:10:34 -0500 (EST)
In-Reply-To: <7vwr7gitjl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 20 Feb 2012 22:34:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25D17DDC-5C5B-11E1-8B74-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191137>

Junio C Hamano <gitster@pobox.com> writes:

> greened@obbligato.org (David A. Greene) writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>> It sounds like the simplest and cleanest would be to treat it as if its
>>> current version came as a patch submission, cook it just like any other
>>> topic in 'pu' down to 'next' down to eventually 'master', with the usual
>>> review cycle of pointing out what is wrong and needs fixing followed by a
>>> series of re-rolls.
>>
>> Ok, but we will preserve the history via the subtree merge, yes?
>
> I'll comment on just this part, but a short answer is "no, I do not think
> so".
>
> Even though you left "Jeff King writes", you removed everything he said
> that I was quoting, and in order to understand why the answer is 'no', it
> would have been better if you kept this part from what he said in your
> reply:
>
>>> ... Either way, I do think it's
>>> worth saving the commit history by doing a real merge.
>
> as that was what I was agreeing to with my "as if ... a patch submission".

Ehh, s/agree/disagree/;
