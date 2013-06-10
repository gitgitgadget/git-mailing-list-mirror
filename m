From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Mon, 10 Jun 2013 21:07:06 +0200
Message-ID: <51B623DA.4050802@kdbg.org>
References: <1370637143-21336-3-git-send-email-felipe.contreras@gmail.com> <CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com> <7vd2rvqgra.fsf@alter.siamese.dyndns.org> <CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com> <7vy5ajozuj.fsf@alter.siamese.dyndns.org> <CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com> <7vfvwrowd0.fsf@alter.siamese.dyndns.org> <CAMP44s0Qr54+8hbkZ+jmXB628SCPwg1zZo80UBhFe2PCrgQP4Q@mail.gmail.com> <20130610093904.GG2091@goldbirke> <7vppvuj6wl.fsf@alter.siamese.dyndns.org> <20130610172708.GH2091@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 10 21:07:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um7RB-0001SS-AJ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 21:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429Ab3FJTHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 15:07:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:63805 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab3FJTHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 15:07:12 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E2F7213004E;
	Mon, 10 Jun 2013 21:06:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EF25C19F5E5;
	Mon, 10 Jun 2013 21:07:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130610172708.GH2091@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227361>

Am 10.06.2013 19:27, schrieb SZEDER G=E1bor:
> My main motivation is that, like in your example, in the bash prompt
> tests I only have to check a single line of output, but because of
> debuggability I always did:
>=20
>   echo "(master)" >expected
>   __git_ps1 >actual
>   test_cmp expected actual

Chained by &&, I presume.

> With such a helper function this could be reduced to a single line:
>=20
>   test_string_equal "(master)" "$(__git_ps1)"
>=20
> without loss of functionality

Not quite: A non-zero exit code of the $(__git_ps1) is lost. (It
probably doesn't matter here, but it certainly does if the command is
$(git rev-parse foo) or similar.)

-- Hannes
