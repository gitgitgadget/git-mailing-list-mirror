From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not strip empty lines / trailing spaces from a commit
 message template
Date: Thu, 11 Mar 2010 21:54:56 -0800
Message-ID: <7vd3zat77z.fsf@alter.siamese.dyndns.org>
References: <4B97C157.4020806@gmail.com>
 <20100311081213.GA13575@sigill.intra.peff.net>
 <20100311083148.GA13786@sigill.intra.peff.net>
 <7vaaueziv8.fsf@alter.siamese.dyndns.org>
 <20100311224656.GA25553@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 12 06:55:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npxq6-0001jn-N4
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 06:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab0CLFzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 00:55:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab0CLFzE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 00:55:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56467A13BE;
	Fri, 12 Mar 2010 00:55:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BF9Ll5cO58olBzz1OBxg0xYXnHk=; b=UXsugO
	7wvhixM4yQ79MNEx6sZspPpxdo3S1jLmS/K1fD75UvmtiQlEd8ycUf++uR1E4QIL
	DPY2OI5m4mUmrR+/9xVTu7Ekiq1HV3Qj3gBP3RMBQLW61DB26RqrjVgOj/O+P0I9
	LPo5MdhHoaQAUbo0mKd89CTwtgzjfToCxRn4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JtWZM67zn6m5iFd8EivUMsN1M0N41Igm
	cD9GlWEZDk0JMP+OpfksyX5eHIkAveuKK+Ab+Pw530L4gBlXL5v1xLnlQHThyZ/3
	7CkfoH0BLU3RMFYv8Svb/boiI863qQrssjyADXyi2sQz4p7jf03uNtKspQtdmZrW
	P9117xzfevw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E5D3A13BC;
	Fri, 12 Mar 2010 00:55:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E1DEA13BA; Fri, 12 Mar
 2010 00:54:57 -0500 (EST)
In-Reply-To: <20100311224656.GA25553@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 11 Mar 2010 17\:46\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CC0B8512-2D9B-11DF-8F6E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142019>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 11, 2010 at 12:46:51PM -0800, Junio C Hamano wrote:
>
>> > How about a test to check the new behavior?
>> 
>> Speaking of tests, t2203 will segfault with your patch.  I don't think the
>> following does, though.
>
> I thought I ran the tests, but obviously not. I see the segfault here.
> It is not just t2203, but any "git commit" with no message will cause
> it.
>
> Your patch looks right, and is more readable, too, I think.

Ok, Sebastian can use that code in his reroll with tests, then.

Thanks.
