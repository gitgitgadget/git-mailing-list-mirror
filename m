From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Generalized "string function" syntax
Date: Mon, 19 Oct 2009 16:18:02 -0700
Message-ID: <7vd44jx9at.fsf@alter.siamese.dyndns.org>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
 <4ADA3153.7070606@lsrfire.ath.cx> <7v63ad5o8p.fsf@alter.siamese.dyndns.org>
 <4ADAD0D2.504@lsrfire.ath.cx> <7vr5t0nwu8.fsf@alter.siamese.dyndns.org>
 <4ADCF117.2030905@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Oct 20 01:18:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N01UX-0000dd-Uv
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 01:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbZJSXSG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 19:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757936AbZJSXSG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 19:18:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757925AbZJSXSF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 19:18:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E6C3B7EA36;
	Mon, 19 Oct 2009 19:18:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zH8XVXdxzOHq
	Efac6sWpUbBJV2k=; b=jbBSRQPuniKjJbeqqyK5BCFfhyWbnCorhz2GEGDBDcx+
	u9t7Biv6SSw2Gn+H02I39I8IEi08apx3A9kv03zwyWGWmKt5SPmKoBWvfWK/Hjq1
	dObF0IAZUJS+l+ylBG97/075gomBO3qMtlzyq5EusPrdYasie6TNoY7pW335jmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YgrEZC
	9tb4sSUCy4tHGqfbet8xuOVdR2xbp7WTnuvZXQwwO7p8pivARaoLPR87wOPxb24K
	1eKqMwtaZIt2H+0iw2WJE/HQfc/iFmWyiSNXETZ2ZY4hcjxTZ8cWPAqer3SUitbN
	OfFrjqFli93IFO7Tmt26KJOM6vOxBwDdeJRTc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C15C37EA35;
	Mon, 19 Oct 2009 19:18:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CD60E7EA34; Mon, 19 Oct 2009
 19:18:03 -0400 (EDT)
In-Reply-To: <4ADCF117.2030905@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue\, 20 Oct 2009 01\:07\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8852C44-BD05-11DE-AA85-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130743>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
> ...
>> I was more worried about painting ourselves now in a corner we canno=
t get
>> out of easily later.  Even if my answer to question "what are we goi=
ng to
>> add" may be "nothing I can think of right now", it does not make me =
happy.
>
> If wrapping wasn't implemented as a nested function, nesting could st=
ill
> be introduced independently and used for other things -- once these
> other things arrive.

True.  I do not think we _need_ nested expansion; obviously we have liv=
ed
without it for a long time.

> I'm more in favour of adding ways to customize the shape of the eleme=
nts
> rather than adding string functions.  %S(width=3D76,indent=3D4) over
> %[wrap(76,4)%s%].

Yeah, %X(some modifier) that can apply to any 'X' looks much simpler an=
d
easier to look at.  The way the code is structured currently it might b=
e
more work and risk to break things, though.
