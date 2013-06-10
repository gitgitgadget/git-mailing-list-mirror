From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Mon, 10 Jun 2013 08:56:58 -0700
Message-ID: <7vppvuj6wl.fsf@alter.siamese.dyndns.org>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
	<7vd2rvqgra.fsf@alter.siamese.dyndns.org>
	<CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
	<7vy5ajozuj.fsf@alter.siamese.dyndns.org>
	<CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
	<7vfvwrowd0.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Qr54+8hbkZ+jmXB628SCPwg1zZo80UBhFe2PCrgQP4Q@mail.gmail.com>
	<20130610093904.GG2091@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 10 17:57:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um4T6-0004zy-Ks
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 17:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940Ab3FJP5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 11:57:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab3FJP5L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jun 2013 11:57:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD89D2616F;
	Mon, 10 Jun 2013 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rTeSdzn9R96y
	H466F5lAozZWcps=; b=HPh3n+pCtpor+NdfnEhWNihs/fn4szDa3N7V2seA+dj1
	lCnQRlawe3xPkMxmCCRQMix6h7wCbPiiDC3HcQRL9KY6ornDZ7lepYrZ8S22Zv//
	25N1C77+QjokuwcL3n9nUDGkRUSEsn0VeYNlR2NnfmppORWON0xoyLZjMDoMyTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fTQTo5
	cOdRJwx9qjl4RUGhovB7ELEWIx9B305jvOnhig5w9vs5erFrQUVWLXqI46xkOcKq
	xMG7qlnhWVoOLse/7jBvvxMKIuTX0QTRu7LSeM9DR7PpWd6o09etvASiAzt1J2nn
	8ob+H4NTsKiBTW8s11wUnetyNAGz9UgigoStg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A16BD2616E;
	Mon, 10 Jun 2013 15:57:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECBF126168;
	Mon, 10 Jun 2013 15:57:09 +0000 (UTC)
In-Reply-To: <20130610093904.GG2091@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Mon, 10 Jun 2013 11:39:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6882AB2C-D1E6-11E2-92C4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227306>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Sun, Jun 09, 2013 at 03:41:54PM -0500, Felipe Contreras wrote:
>> There
>> will not be a need for test_string_must_be_empty() just like there's
>> no need for test_string_cmp().
>
> Actually, if there were a test_string_cmp(), that would be the test
> helper function I used most often.

Hmm, there indeed are quite a many "At this point, the variable's
value must be this" in the test scripts.  With things like this:

    t/t0002-gitfile.sh:     test "$SHA" =3D "$(git rev-list HEAD)"

we can go to the trash directory upon seeing a failure to run the
command used on the RHS, but the value in $SHA is cumbersome to find
out (either running it under sh -x or insert an extra echo before
it), so such a helper function may be useful.

Do you really need a general comparison ("does A sort before B") or
just equality?  If the latter, test_string_equal (or even
string_equal) might be a better name for it.

By the way, test_cmp() is a replacement for the "cmp" command and
that is why it does not have "file" in its name.
