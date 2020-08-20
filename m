Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F5EC433DF
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 11:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D934207BB
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 11:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JXmJ/uc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgHTLgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:36:47 -0400
Received: from mout.web.de ([212.227.15.3]:37041 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730855AbgHTLfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 07:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597923294;
        bh=AwhKKkc7bHoMJ77FG9X5YKeb85UNqKdKTEXcoTKqzsQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=JXmJ/uc1S5IeAdKwC5q894FBr0UxAM+p4Saij4veHUC+KWlF1ugfh7VjgVL/JFv2l
         ahIGFj0v8VPpEDlmbtirKtcZulBzBEoxdSC83bB1nRZ2hv9Do6k9MvPSITOnbiSYN5
         Mrts/tDmgpdVtM2lNsw58M/4pW/r7vHCUZUX8YjM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdO56-1ki3aw2F5U-00ZFb0; Thu, 20
 Aug 2020 13:34:54 +0200
Date:   Thu, 20 Aug 2020 13:34:45 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200820133445.2bd162a3@luklap>
In-Reply-To: <20200819203825.GA2511902@coredump.intra.peff.net>
References: <cover.1597853634.git.lukasstraub2@web.de>
        <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
        <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
        <xmqqimdetpuw.fsf@gitster.c.googlers.com>
        <20200819201736.GA2511157@coredump.intra.peff.net>
        <xmqqa6yqtm03.fsf@gitster.c.googlers.com>
        <20200819203825.GA2511902@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ioE37.zWU6HzbvjSjJLMxQT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:TmUmhDY8CSH+hvh62vV6hYJtBh9HYa3ANBamkzWqKEBAd51+K4d
 Ssfu3g6YDLgnZbUZFJGU8KWHYte8a/y+h4CtB968gi6omtzG7T/CohVW1+mzOadIzd0oO/c
 o36pIMIOmiYC7v2mHooBAK7VMSbCiLOaXMcsJ+rIcDy7UmSQQtY1hQqmiPpY/mrsVGvDCVt
 OAsOiT1NHs7SDC8srlrOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7IefBfRp9HA=:01KKAVzkRxQhmxW9rIlDTn
 ybsDe2T2sr5cGDUKj5keDIyp+alZdwHbMWV5hLJg3FZGdC3LhkH0M6xBkIzBku9cx9zFdgBlm
 Y+f0a6VGbgc/Im+YqnNGzYyQ1zo3I45BRUjn+ic+oKvy4r7PzaQcpUDdPEGuwlmwGhsvhyZw4
 uV0NgtWkVavk68m9inaqeCZ69LHQB/qjUK1sPVLmlvaYHVXfq9Y43wLfzAQtYaswWNhyJ4qqQ
 pFed4dk8NRw8XQ+A0hs8Zrz6oDLxA5BtJyVQLl5kGrxvSUsD7JWS8AxfNFOBML0L7nW4rnD17
 3cxwsawwvX/Xkredb2ZCVuiy28XDdR4a2Ra37RSYjjvolmHy4IIBVJIhQb7+6UiBfSzKhIFOK
 IoVqhg/hcpjqf4yVl/Sm30xFa0PxI6IWH9+ZWWGZDo63E+wd8emklL5nClYsJCsP/YiuUi55G
 7vBwSjLoXgEXY7cVFJXQ5ltVGrJepNXpJ9JZna4kewBE+oA69hqkIe4Ehh1hM7Oigy4pAD+uS
 5b2bWuidYS0k9yfYT37A4K7lvk0sycwm3d7rYPGmjBHm53HmE2p4f1y7ShvQke8Tc+Sa7aYH2
 Ol7d0Fu9MdLk9OcieIO8S456RPd4fnI5Tt82HtPpxDnQTJQ1hazZERs+Oc4w9+gJdRUTOTA0J
 DKefwNfZXQOinTsd3x0yDyNIGMXdHUibn4GGwv/tW/Wj7zbduZXl3WmRW26f0pIbUdKcg6xGu
 XXY1nD3V8asGB0+1kYu6dS+ps21Zk+uH9KZLeTzlMSeK3k6AdxmqkLazxd+8RxxL3RODA3FUL
 GyqCT7F7wmwBaqzbECG1wiOsrpj+0hdmstrfO9KKLA2gaku9i7RMrno82Oe3Bte7P2Rmpcp5d
 yszzXc14FpeD+73DneLUGEM4wccnZytVDjtFTgofdWXQW1yjHM/80Ou/v34d6El2bpuJIMiZt
 OamsI0Fq4cjRua3P21yztRG9j5VPyMG3mCK4a+5ZKFuh++ezW1XZpg1JDoz7Yl0zNq8c3Ugas
 shtEU/m9kptUk7nNKgEXUoZuM4xvKAmczvstKzD6krsP7czdlzx/Un0Qpy3QGy1WM+NPI1xJc
 xOmGSgs340UdSVR5tnze3qPaXwOFqnxvf9b5PobtTRKjSevld0ftEW2K53OyOBbQ4Ee1pB53Q
 D/XBjz9heWmKy201vCKWo8LNkC8KrnNLYzA17Vp1/FuW40JpzmPGQYWkrRQr+WJkPYaOAFnhI
 hAqpDTKjOQESkQ2umOcNEIG7FQuy6Sje+48jOPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/ioE37.zWU6HzbvjSjJLMxQT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Aug 2020 16:38:25 -0400
Jeff King <peff@peff.net> wrote:

> On Wed, Aug 19, 2020 at 01:32:28PM -0700, Junio C Hamano wrote:
>=20
> > Jeff King <peff@peff.net> writes:
> >  =20
> > > It _could_ still be useful in a more isolated environment (e.g., your
> > > company server that is serving only internal repos to employees). But=
 I
> > > have misgivings about a feature that lets people intentionally create
> > > repositories whose history cannot ever interact with other users who
> > > haven't set a special config flag. It's one thing to say "to take
> > > advantage of this feature, we must all agree to have version X, or set
> > > flag Y". But it's another to bake that restriction into the repository
> > > history for all time. =20
> >=20
> > If people want a pre-prepared repository propagated to CI
> > environment and keep trakc of the state of such repository over
> > time, for example, they can use (versioned) tarballs.  Such a
> > tarball won't automatically get extracted after "git pull" (which
> > is a feature), but those who want such a pre-prepared repository
> > for CI can make the extraction step as a part of their CI build
> > procedure. =20
>=20
> Yeah, I almost went into more detail there. There are lots of solutions
> that make accessing an embedded sub-repository only one command away for
> the person who clones. :)  Some others are:
>=20
>   - just call it "foo.git", and "mv foo.git .git" solves it (you'd
>     probably want to "git checkout -f" after that, but even if it were
>     embedded it seems silly to hold the data in two separate formats
>     anyway
>=20
>   - just hold a bare repository ("foo.git") and then clone it
>=20
> etc. I think this is really a solution in search of a problem.
>=20
> -Peff

Yes, there are many workarounds and they work well in the CI usecase. Howev=
er,
for the arbitrary files usecase there is no good workaround. I currently use
a script which iterates over the tree and renames .git -> dotgit before run=
ning
any git command and back again afterwards, but it is slow and brittle. I to=
yed
with the idea of writing a FUSE filesystem to do the renaming, but it is
needlessly complex and hurts performance.

Really, this problem should be solved in git itself.

Regards,
Lukas Straub

--Sig_/ioE37.zWU6HzbvjSjJLMxQT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8+X9UACgkQNasLKJxd
sljSgw//b45Szbd2rTrJpgWzDxzNUd1jNP1RDWdWXXrhTE7UmT68IXJCWrURe3Vu
Lcg+FrsfrCn/JJY4tKAJWs5x7nH3ALuwxzrQo2Cf5AKEshaQKgq0r0nA3GT3Ft3O
ySqqOjpoqakVnHqYgMhotYhSELFi+wRPz2hijzba2qfJuUyYFl1LF1AaPGn03QOf
uyCID+Iyfxu7xiAojMTzgUrw4bgRzonQKzyY3v56NJLlGRIEyopKyh24cJ19C3JI
1r+XXLeRrehd3jS1Qr+ndDZECCgJM7EAGkIKxxSlG0aGTEsbEzEVazmqtdjXP2aW
Lp07h5QcWW25TDpca1iYJkP20N/FqlEv7/3T+i0Yiah1q6wI7oPqQ+/ixSInG3zR
RQX/RRxS27jKl/Pdka0R0TyIW/fHrFbVtqCdD0PA7OvCoae9mhiDqawYcQR+A04K
lUsQbMND/hgDcm7hG5HlNvlag2RC8WrYbbbUudMn0KSU8z6Fz+RkbcQU936hcP4h
/c1/AMThoAsmvHbxsBQnJWpUe25M9GUF/C4rGn76pNdFvK7qmDnyOk9Y/BEt/Ze3
+6exqwQzXcOuB0ta5XqivmeRiF94/9pds6Ax5uloIi2Cju/AcLpJ5FU0FKtlP1Fl
w2JslpLlgUQ/hNwYSajCchml7Udu/IpiKLal402fGcD8nW87EYE=
=5VUh
-----END PGP SIGNATURE-----

--Sig_/ioE37.zWU6HzbvjSjJLMxQT--
