From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH/RFC] get_sha1: prefer 40-hex ref name over 40-hex SHA-1
Date: Thu, 2 May 2013 10:55:39 +0200
Message-ID: <87r4hpu5f8.fsf@linux-k42r.v.cablecom.net>
References: <1367377282-9862-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 10:55:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXpIo-00086x-N4
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 10:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab3EBIzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 04:55:42 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:20090 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906Ab3EBIzl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 May 2013 04:55:41 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 2 May
 2013 10:55:37 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 2 May 2013 10:55:39 +0200
In-Reply-To: <1367377282-9862-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 1 May
 2013 10:01:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223182>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +test_expect_success 'rev-parse 20-hex ref' '
> +	REF=3D`git rev-parse HEAD` &&
> +	VAL=3D`echo| git commit-tree 4b825dc642cb6eb9a060e54bf8d69288fbee49=
04` &&
> +	git update-ref refs/heads/$REF $VAL &&
> +	test `git rev-parse $REF` =3D $VAL
> +'
> +
> +test_expect_success 'rev-parse ambiguous 20-hex ref' '
> +	REF=3D`git rev-parse HEAD` &&
> +	VAL=3D`echo| git commit-tree -p HEAD 4b825dc642cb6eb9a060e54bf8d692=
88fbee4904` &&
> +	git update-ref refs/tags/$REF $VAL &&
> +	test `git rev-parse $REF 2>err` =3D $VAL &&
> +	grep "refname.*ambiguous" err
> +'

Shouldn't these say s/20-hex/40-hex/?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
