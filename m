From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 14:54:29 -0800
Message-ID: <7v1vgk94gq.fsf@alter.siamese.dyndns.org>
References: <20100215225001.GA944@book.hvoigt.net>
 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
 <7vocjpnc5v.fsf@alter.siamese.dyndns.org>
 <7vljetlx8r.fsf@alter.siamese.dyndns.org>
 <20100216180209.GA1532@book.hvoigt.net>
 <7vocjpng1w.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002161458410.1946@xanadu.home>
 <20100216205732.GB1860@book.hvoigt.net>
 <alpine.LFD.2.00.1002161606570.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 23:54:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhWJf-00010c-U8
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 23:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933359Ab0BPWyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 17:54:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933312Ab0BPWyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 17:54:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED0079A3FC;
	Tue, 16 Feb 2010 17:54:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lahC4Lkp9hO7cmo2XpUb2LNej4U=; b=jQXtmn
	BG620oNaIC/VGBGmsn1YU61KYtFKlTcdecpgPfrhDUFH66EuIhq6TbknEpHRVFNT
	Y9yPeaRJMZO46ksU5k0lXsLstFQ4+7lHqo9Or35ilerDHtfz7fXfYlFDfDQ43hic
	SVuQ3oY20X8U0kGAYMkeq5HLeks2e63Xd8ffQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=inCTs6qZIG12x99Fy7doQJETUzNoESxS
	il6yFMTHoZSdnxKrzWg9eHQQIIfV8tv7j31EAkCTO9LwB8zslY3zehlzRvFmEklG
	emE8ps1IHDuEoVvbUbYpiCDmnMIV1P5TG6FA2UX4HOGQyO/C/5xoZIdefNJbt24G
	HFOfTTzU2nY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 870589A3FB;
	Tue, 16 Feb 2010 17:54:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D4379A3F8; Tue, 16 Feb
 2010 17:54:30 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002161606570.1946@xanadu.home> (Nicolas
 Pitre's message of "Tue\, 16 Feb 2010 16\:20\:14 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41869170-1B4E-11DF-9AB5-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140160>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Tue, 16 Feb 2010, Heiko Voigt wrote:
>
>> On Tue, Feb 16, 2010 at 03:00:47PM -0500, Nicolas Pitre wrote:
>> > What do you expect from academia?  School and real life are still too 
>> > often disconnected.
>> 
>> If you want to offend people that try to help out in real life. This is
>> exactly the kind of comment that does it.
>
> Because you think that I'm not giving my own time helping people solving 
> real life issues? If so I'd suggest you do a quick background check on 
> myself.

I don't think Heiko is saying he was offended by you, but is saying he was
offended by me saying "Don't they teach this in schools anymore?"  I was
simply curious about the answer to that question.  If they don't teach C,
it is not Heiko's fault---no need to get offended.  I admit that I did go
"Huh?  Never repeat?  What's the point?" when I first saw the idiom.

By learning and sticking to idioms people get more efficient, because
there is no need to think if it is better to have "do { ... } while()"
inside or outside yourself; cleverer people have already figured out the
best way and that is how idioms came about.  Once you learn them, your
eyes will coast over the outer cruft and focus on the essential part of
the macro "..." without even spending any extra effort to actively squelch
the surrounding "do {" and "} while (0)".  These literally become part of
background noise and do not bother you anymore to the point that they are
not even ugly.

Think of this as a mutual/collective learning experience.  As Dscho said
on this topic on msysgit list, Heiko _is_ the hero in figuring out what
was originally broken, even though the proposed solution might have been
suboptimal.  I know figuring out what is broken have taken a lot more
effort than my looking over his solution and reaching a better solution.
Correct diagnosis is often more than 80% of solving a problem.
