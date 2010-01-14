From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in 
 summary
Date: Thu, 14 Jan 2010 11:44:39 -0800
Message-ID: <7vy6k0bheg.fsf@alter.siamese.dyndns.org>
References: <20100113173408.GA16652@coredump.intra.peff.net>
 <20100113184510.GA22849@coredump.intra.peff.net>
 <5722BD3D-E7C9-47F7-B547-09B14D87DA39@wincent.com>
 <201001141602.22244.trast@student.ethz.ch>
 <94a0d4531001141104w74dbaf35jb5fded9e266bc04b@mail.gmail.com>
 <7vy6k0cxbz.fsf@alter.siamese.dyndns.org>
 <94a0d4531001141136m3eb51d11rafdf7f0672e68dff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 20:45:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVVco-0003Fw-LH
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 20:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287Ab0ANToy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 14:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756882Ab0ANToy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 14:44:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626Ab0ANTox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2010 14:44:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74BD09089A;
	Thu, 14 Jan 2010 14:44:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dbNmM6eNAbE/
	zd6qOp4AkddYxu8=; b=Dy9k2KjihRkYGmH6M5USEN8JUqLsh5JmeceAr8fDVP+2
	9/RnfOKLRWe1seY9GJ5sBFJrOIBRS3BZnDs6+YtkDlohYd1N2Q0/ws0+Au3cFR0m
	K2QhB664XVsnWV004wg9xqhgvzO3ebqIm3jrR5XaBIxKD3scWOmuB8DhAW2ZQTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bKsaMm
	p8jbMMhl9ksSuNSDalk4Oqb6AWb5Yy/Ton8mMjgL7Kw5r+mzO86Sygy9By7bNt75
	3Mq4W/YEnVHGFEZPNg/36uYJkk5PO6O5+9JBM3G8LLmUKeOzWuU19I0Lm8fzsMvq
	oL9+4G3zai4ih/ds4YY0Ymd5u2AKFrl79Innw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C8DB90890;
	Thu, 14 Jan 2010 14:44:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1825690886; Thu, 14 Jan
 2010 14:44:40 -0500 (EST)
In-Reply-To: <94a0d4531001141136m3eb51d11rafdf7f0672e68dff@mail.gmail.com>
 (Felipe Contreras's message of "Thu\, 14 Jan 2010 21\:36\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4544257A-0145-11DF-82E5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137016>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Jan 14, 2010 at 9:15 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> I think the point of the message you are responding to is that it ha=
s
>> already been proven that there are users that never reads any of the
>> zillions of "your first 10 minutes with Git". =C2=A0How that _could_=
 ever
>> possibly be the reason/justification why you would want to push that
>> change to our documentation?
>
> Users are lazy.

And the ones that suffer from the issue discussed in this thread will n=
ot
read the manual your patch touches.  When you make changes to the manua=
l,
you should not be targetting them, as they won't read it anyway.  Inste=
ad,
the description of the manual should aim to help people who _read_ it.
