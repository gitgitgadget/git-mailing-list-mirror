Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2231F453
	for <e@80x24.org>; Tue, 12 Feb 2019 21:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfBLVyg (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 16:54:36 -0500
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:47416 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbfBLVyg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Feb 2019 16:54:36 -0500
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CLr3VL031732
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 16:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=1mat0sdy4ZcPRfySu94uaxz0dbL+8OMT8JSj4p0qDmY=;
 b=z2J5p05CK+eVFO4/8gqEkrm8rRJO9T/uMvGlaz04bpbOg94l03ePxAvbk8sHKyTeK5rX
 9rKM11Gk6zDyXiD5K9l5jD3dLtJLcOuwzFaTF0RjDrfi+SYb5RNWD1Cz7gXWbB3pfic0
 8iipzNpIu2STM8adwVvKoob3Lv/BWlGPnAxpxE1UujnL0/YZSxXG0IWbuWFAmw/eLW/s
 /o0g98+deo/CbEJBeNGNkXGLM+uCVtAqyQoIHGbu5kKgEhQ4jZlgLinp8XS3LSP4fDg9
 sgs12i8XEjWrwV4Noh3heh4hyBu4CqHBc3BbIfl0kz856isunyuj2at0Q+T+xJFOFzfv jw== 
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mx0b-00256a01.pphosted.com with ESMTP id 2qm1d8epge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 16:54:35 -0500
Received: by mail-qk1-f198.google.com with SMTP id i66so201404qke.21
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 13:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1mat0sdy4ZcPRfySu94uaxz0dbL+8OMT8JSj4p0qDmY=;
        b=zpZDehqXV8eyHe2b6SgiXZOhG2ftNDLzaZFmNHXF4zN0+ZL6KwjeBHGL2Pzv8dSCpH
         goQkO2tS5p0F/LicFcT/2wD2G9ZcGPvI6s2fgygkxBcTOqJu05J6xKKumRUAt/0a3lm9
         OofnDvdSRc29KlvoluAq5ONG9376DBnmzxO3h/x4+C2zGCYpbaoH+jE+FNuWdPNzEklU
         1+ciLmQPGr6Q5DWFFcpEc+UiTk8AY6oRvgTIzW4Q40l1vO6jo89eTN8E6CYj6KpdHbae
         c39SvTsdyRrL36BOIo2xDEZTatVSV/t5orFu+pcv1ymMWbdogvYR/dagpsK9725t9Y7N
         /aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1mat0sdy4ZcPRfySu94uaxz0dbL+8OMT8JSj4p0qDmY=;
        b=g1Q36lr8EYUL9Xne6maokhi1bjy0AFPyTZAAuwKjnTtZzSajs5bOxg+l7TXgWZQEr9
         GTvqdV+2sgzi9vlbu6o521GAsTZe8FLfeamTaDaJjHrC4l3lhqON1RVq2+WZR9PL/e1G
         7siKwokkxBFarirCe0BnW+us1KtJ8tq7sNbxp+8pH0Jp+W5nhJUqcUiGN0InkV6FPdHI
         846jCTEM4UNQtSbMrcFhYrOsjZ13mrf8i2JJitVQL1sRAO0UK2uRiW6ZVA3fs7yrJaf5
         TmwmbqpDdPukzF0AtsZ8YEQryRvltkHpTa4ywI3g/8FH2utP2n/uN2gCSK/wdOI+lU2L
         aqGg==
X-Gm-Message-State: AHQUAuaaaZJPtDgra7GNn710YzFtnJSBi55l82bbEtFhp5+EffiyOEGF
        sypHNZOP0qN6y/p4OSpaO8SSXAWVaHwJ+mGg42elDL3OkX4FovdzrogzhzSKr8OoSNXWY7x+n87
        vQNiIwySW6Ag=
X-Received: by 2002:a0c:9a4a:: with SMTP id q10mr4352353qvd.150.1550008473644;
        Tue, 12 Feb 2019 13:54:33 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZ2zG7OXby9d2Snwfh02XsOgyTUkBc/+WbZrhjkCOcHxYOyOOf/YQNPBp6WzSdeVgLLbIPjzg==
X-Received: by 2002:a0c:9a4a:: with SMTP id q10mr4352338qvd.150.1550008473459;
        Tue, 12 Feb 2019 13:54:33 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-149.NATPOOL.NYU.EDU. [216.165.95.149])
        by smtp.gmail.com with ESMTPSA id a3sm20955416qta.21.2019.02.12.13.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 13:54:33 -0800 (PST)
Date:   Tue, 12 Feb 2019 16:54:32 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     git@vger.kernel.org
Subject: Re: Am a newby and I cannot compile git
Message-ID: <20190212215431.btbvugcaqfdqnigo@LykOS.localdomain>
References: <1549835814.5977.11.camel@libero.it>
 <20190210224812.wtn2qqm7lmsiarrh@LykOS.localdomain>
 <1549912081.1754.1.camel@libero.it>
 <1550007793.1750.1.camel@libero.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xkqxl5it2ixknhhz"
Content-Disposition: inline
In-Reply-To: <1550007793.1750.1.camel@libero.it>
X-Orig-IP: 209.85.222.198
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120150
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xkqxl5it2ixknhhz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Awesome,

Do consider reading the files under Documentation (as other people
suggested) to make it easier to contribute. There's CodingGuidelines
and SubmittingPatches that are super useful :)

Good luck!
-Santiago.

On Tue, Feb 12, 2019 at 10:43:13PM +0100, Fabio Aiuto wrote:
> Ok I typed make install from the terminal, then I attached the the
> project to the executable generated in the local bin directory. So I
> can happily trace in the code. Thank you, hope I will be able to fix
> things in git very soon!!!
> Fabio.
> Il giorno lun, 11/02/2019 alle 20.08 +0100, Fabio Aiuto ha scritto:
> > Hello Santiago,
> > I'm running debian Stretch on my machine, and using Eclipse. I'm new
> > in
> > linux world so I don't know how could I let you know all packages
> > I've
> > installed in a single screenshot.
> > However I got the git sources with the following command:
> >=20
> > $ git clone git://git.kernel.org/pub/scm/git/git.git
> >=20
> > then I've opened the project inside Eclipse by importing a makefile
> > project from existing code. I tried to build several time beacuse of
> > some compilation errors that I fixed by installing the following
> > packages:
> >=20
> > $ sudo apt-get install zlib1g-dev
> > $ sudo apt-get install libcurl-dev
> > $ sudo apt-get install libcurl4-openssl-dev
> > $ sudo apt-get install libexpat1-dev
> >=20
> > At last no building errors detected but when I try to run adebug
> > session, the IDE says tat 'Program file does not exist'. And there
> > are
> > more errors spread over the project wich are not detected.When i do
> > the
> > rebuild by clicking the 'hammer' icon, the message in the console
> > window says:
> > 20:04:07 **** Incremental Build of configuration Default for project
> > git ****
> > make all=A0
> > =A0=A0=A0=A0SUBDIR git-gui
> > =A0=A0=A0=A0SUBDIR gitk-git
> > =A0=A0=A0=A0SUBDIR templates
> >=20
> > 20:04:08 Build Finished (took 866ms)
> >=20
> > Please ask me for more informations!!!!
> > Thank you
> > Il giorno dom, 10/02/2019 alle 17.48 -0500, Santiago Torres ha
> > scritto:
> > > It'd be difficult to debug without more context:
> > >=20
> > > Do you mind sharing your build log and more informationa about your
> > > setup? (e.g., what OS are you running, what packages are installed,
> > > how
> > > did you get the git sources, etc.)
> > >=20
> > > Thanks,
> > > -Santiago.
> > >=20
> > > On Sun, Feb 10, 2019 at 10:56:54PM +0100, Fabio Aiuto wrote:
> > > > Hello again my problem is that I cannot compile git.
> > > > The error message says:
> > > >=20
> > > > 	Type'z_stream' could not be resolved
> > > >=20
> > > > I don't know why, because I installed the package zlib1g-dev and
> > > > in
> > > > the
> > > > header file zlib.h this structure is declared. Help me!!!
> > > > Fabio.

--xkqxl5it2ixknhhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlxjQJcACgkQRo8SLOgW
IpXkMQ/7BScdp8Z8CfX19Hd7hEfJY3CH6LsECECeU3mAjy7E+8fCAJ9bnPrLm4yt
QDxA6YkaQhQmM1MHeidBZF3kl/ArNm7Et8yz7ewIPalzi/DoFeen0CRI25JG6soh
Z+/AfdI+ZflwPLUSXLY3UFPT1BrUV99wX1iyMCr6LVbvyZslijqUT875QZ+g68hE
1IcX2GiHC5v7wO5hXqdEzvv3JNoZW+hY6Dg/wdFChZqkc9kGJvCtCTT4MtbQqZWN
+vc4UtpT7ytJ4xczfpsB+ogXr1aaXAZuNdk3tLcB4zAAH3WvbfujnpekILeGRm2h
P942yjorOkJTacm6gKFhIGVSBWvTylaZlnEE9/YPnWRmBtLJtNCLSW1wzenUCCe8
rxQC4KIguIoJKlND0JTrzlwJM6A3//Tnvxt9vDZS4TgeAdLs8OjgPII6t5DBfPJ4
YyNI5gcQ0PaC/fDskVL/Gyy3vsYqtwyeolGyV9U3/UrmiTwFEq5ckOCZW3DSn8HS
SzUS/ifgedOR3ehHxuK6YK3AEdzMpQbg7L7NbAo1JeSP0GbRq8CmkvOj5VNNdOhM
GFYuMBJc4h9V9SDjgXLFQvIitr4orw0Ua5vmPmzzLeYcKoedDPUfGMsFmcccWtQN
2h+erMcJauYDrq8T6Y7EE/6bld7wGjoOGqF16TQ8xpr2K72nzWE=
=X0RZ
-----END PGP SIGNATURE-----

--xkqxl5it2ixknhhz--
