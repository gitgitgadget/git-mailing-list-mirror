From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Do not install shell libraries executable
Date: Sun, 31 Jan 2010 12:05:31 -0800
Message-ID: <7vockaca5w.fsf@alter.siamese.dyndns.org>
References: <20100129102518.GA5875@coredump.intra.peff.net>
 <20100129103723.GC6025@coredump.intra.peff.net>
 <20100129145025.GA22703@progeny.tock>
 <7vhbq2g3a9.fsf@alter.siamese.dyndns.org>
 <20100131083459.GA18561@progeny.tock>
 <7vy6jecb0y.fsf@alter.siamese.dyndns.org>
 <20100131200028.GA4045@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 21:05:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbg3O-0004yJ-Gu
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 21:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969Ab0AaUFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 15:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894Ab0AaUFq
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 15:05:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab0AaUFp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2010 15:05:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D030B958A7;
	Sun, 31 Jan 2010 15:05:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=79EW+dXCvUBM
	wSqpDk8JydPnzh4=; b=LrSrCG/253rZE+JNgLHlYRLIA9DI65YShGh+ki0FPw+R
	5IDknuY/krFpPREPKb2V8+I/techNxd84ESAKg8Pn2TM6MoClrKCVu2O3otax6sa
	hB/aan3RJcPmJJzr7Oezc/2nJ/D1K04Nrn10Jr8HxdAgySnNWYpTJc1WAFPwHwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ETIf8m
	QEjNcLkoZ7eh+45BkJZ0jCrlml0lY/90GMQqp1I6vDr9EWiVrN80Y2akJsMK1m6i
	mxE9wJrc5B7/6E17Vd7oMaN8WUg+mprWi+KVZIEbMGZKOksbUbaHBr1Of/V2K0gN
	2RPGoCLORGOPQnU9F4VQQa+8cBRat6iFnVz8Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BF35958A6;
	Sun, 31 Jan 2010 15:05:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C057958A5; Sun, 31 Jan
 2010 15:05:32 -0500 (EST)
In-Reply-To: <20100131200028.GA4045@progeny.tock> (Jonathan Nieder's message
 of "Sun\, 31 Jan 2010 14\:00\:28 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 002BCF58-0EA4-11DF-A521-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138558>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> How much would it hurt the distro packagers, if we don't take this p=
atch
>> before 1.7.0?  If this would help a lot, let's give it a bit higher
>> priority and make sure 1.7.0 ships with (a corrected version of) it;
>> otherwise I'd say we should not merge this before 1.7.0.
>
> Given that Peff=E2=80=99s fix is in, I don=E2=80=99t think it is need=
ed at all.  So I
> would say, better to let it wait.

I was referring to this from your original:

    It was also confusing dpkg-shlibdeps, so I recently came up with
    this fix.  Both fixes seem like good changes to me, and both
    could be applied.  Your fix has the virtue of being shorter,
    hence safer.

Is Jeff's mergetool-lib change enough to address this issue as well?
