From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Tue, 08 Mar 2011 11:49:59 -0800
Message-ID: <7vipvte6jc.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
 <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
 <4D6A6291.8050206@drmicha.warpmail.net>
 <7v7hclulz0.fsf@alter.siamese.dyndns.org>
 <7v39n9uldp.fsf@alter.siamese.dyndns.org>
 <4D6B4F6B.1040209@drmicha.warpmail.net>
 <20110228121726.GA5197@sigill.intra.peff.net>
 <20110228122335.GB5197@sigill.intra.peff.net>
 <7vy650hvwa.fsf@alter.siamese.dyndns.org>
 <20110228222352.GC5854@sigill.intra.peff.net>
 <7vfwr7hh7f.fsf@alter.siamese.dyndns.org>
 <7vy64zg0ms.fsf@alter.siamese.dyndns.org>
 <AANLkTinBTWPrAOq9BOkBJc5GOhFkzsr__9wqEWnWdwYR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Mart =?utf-8?Q?S=C3=B5mermaa?= <mrts.pydev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:50:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px2vE-000675-UN
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 20:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab1CHTuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 14:50:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab1CHTuM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 14:50:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D1B23443;
	Tue,  8 Mar 2011 14:51:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1W+ALo/z8vom
	olNRfYNGAy58Ma8=; b=J+Nf5QJhWAfApG6oHZscJIQs209tnsNqoxLLfzHDkS88
	gbknmAatMfIKQqanmdcAfI99vxYpG8m//5nO/SVPy4Z2WLFcAsWmLHb6Ubyc5N35
	6iY2WmvjVeVrSlBvUACu1uEfElUMjXpN2y1a4SSn4kAeuI7djBoLT3alzbsfdvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=j/XBbz
	WJm3GZtszDSl8FaMg0j7OH+lipTWpRfi7bOu/sZJS3CaigyWxr8Us7qvpkWW5iAW
	T7Rils2X4Bgls2WpddXrR6eE9nDvTlwCKiVDZkQc0sH2IykRDWXPjmIhFcIIslNG
	jYWAX5diIbNBEyV9UncsyzUiSqOj3RnzYky+k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D2F0343F;
	Tue,  8 Mar 2011 14:51:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 07714343C; Tue,  8 Mar 2011
 14:51:28 -0500 (EST)
In-Reply-To: <AANLkTinBTWPrAOq9BOkBJc5GOhFkzsr__9wqEWnWdwYR@mail.gmail.com>
 ("Mart =?utf-8?Q?S=C3=B5mermaa=22's?= message of "Mon, 7 Mar 2011 22:38:03
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78A727E8-49BD-11E0-8C61-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168682>

Mart S=C3=B5mermaa <mrts.pydev@gmail.com> writes:

> On Tue, Mar 1, 2011 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> In any case, a minimum patch to give what Mart wanted to see would
>> probably look like this. =C2=A0I'll leave bugfixes, documentation an=
d tests to
>> the readers ;-).
>
> The minimum looks to be the optimum -- IMHO this is entirely sufficie=
nt,

I suspect not, as I don't think I ever did anything to the codepath for=
 -B
output, and I also recall spending some time thinking about this issue =
in
an earlier message that I mentioned -B besides "deletion", none of the
suggestions in which I don't think I tried to implement.

I also vaguely recall that I suspected that the output may not have the
usual "index deadbeaf..000000 mode" line and that I chose to ignore it.

So, no, not good enough ;-).
