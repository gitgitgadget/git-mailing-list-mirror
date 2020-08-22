Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDD5C433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFA42075E
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 19:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mR/Yu4J2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgHVTNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 15:13:30 -0400
Received: from mout.web.de ([212.227.17.12]:55467 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbgHVTN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 15:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1598123580;
        bh=oOQrfKxfVMmJnYwhqZWsX2YL6wVbNxySwGu3RIgHcbw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=mR/Yu4J2RNFiE9fScuxlg5v/c4LLphqPffnRM1ik3nmtXRlRkpXAR+PTkm+zIg7/O
         5iQQ8K+mTUl+Y66VpekRLyua13aFm+EEyGdpHRhHWRlFHz7cf/x89kkKTX/jMONNb+
         6947VRL2y8blwX3x5tmw+anib7aZFhx6lsCXXfMk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.124]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lnF-1kgsUx01jH-01790A; Sat, 22
 Aug 2020 21:13:00 +0200
Date:   Sat, 22 Aug 2020 21:12:50 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200822211250.59a8b351@luklap>
In-Reply-To: <20200822185307.GZ8085@camp.crustytoothpaste.net>
References: <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
        <xmqqimdetpuw.fsf@gitster.c.googlers.com>
        <20200819201736.GA2511157@coredump.intra.peff.net>
        <xmqqa6yqtm03.fsf@gitster.c.googlers.com>
        <20200819203825.GA2511902@coredump.intra.peff.net>
        <20200820133445.2bd162a3@luklap>
        <20200820130125.GB2522289@coredump.intra.peff.net>
        <20200821143941.28f71287@luklap>
        <20200821225237.GW8085@camp.crustytoothpaste.net>
        <20200822162152.2be1d024@luklap>
        <20200822185307.GZ8085@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wxYmihNgcAM_3RU=cAFtNdH";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:yktY+1miMv2uWQposqYxOqwWApCyyBfOKhp/yX7ZWSYnrM/YRM1
 SCBFBHLgllcSGaX903sGYKMeJcKQQQGxoozFI5JVYgY5TB1s6FaR9wz3jEQ4FnoYNKnzPW0
 M4BRpphe6IWOzqHxUwTYy7f15B/LWIw5ssKjVZxNv0Ve46ARfeeaF413Ii7sdWm/cqn2PbX
 p/p3cg1aVIlCVSJP75Ngg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z7IEeW+t93k=:OR4GN+R4RztkzPDCgzozgM
 6kMjLjOHOq9iaFCxoExWavyli45uYuePbSrA29K9JtBdmXuXjyThkGw96svD6I2BDyEPMcy8z
 UONgFzvvxUPfzi+PUWVZFnSzIsCWZpZ29ekAFztDrjLK4+lEofh9vjHZFIw+giHw2TALXDabs
 /gej9aSP3cHS3c6lG8noC6g8B3xh46EYCvbwc1SCTl8vk9TYrslOqrsW0OfZcHjItVhaAAQxU
 +8yqGH5v8IOIuuQQW2R7Y94lcBt1+3e5kzJROr5V4RqtVfK466OSlS32qwRc9c/aEYaFi8Zss
 yvXQSv6nU56WbWs9MlhjmjPTbtf9GvcpX8SPsiHm8HWFRuqzT8oWQdRgSL6wemAJRXdabTEEy
 i2YXNmgU/77/ZYMRJVbtUtp5cnkH1vDSLZva9zIiDVOI4PRCRsUBQ2yhOg2UQNj0GJyEsZHyR
 DE2xkvrQfEehL0Rk+T2Y4ESak5t5tmzpjsX7t/tQUtJicArDZrCPD8oKlCITrhL565IkQ4WBQ
 n1DknQ+oyI2mVkfyvrdIJoZ6RVlSrSxvgf6oSWV8o6fJiak1aBZ/EUpst9ZO/k6cSeg4hQNyS
 +55dYUJsSVhJB9g3ctfCP6wVDlwgqjBQi/MUTvZfNcwEiX3tgdK/i/T2i/Fc88YYVME/681dG
 ehOMbtslZkOBtTp4ttTTL8Yf50dnN1+a1Mxav/PO5vbV8l76OcObNrKUO1i+iC/AyfDLJR/LV
 Z3upzb5z4mO3X9G66mJbpeLA2VgTDepY3/42UubVNyJQj1oGLagwko4bBuoA6uruqoBDnZRT4
 Qx3w5WHtJHw+zYuPq15f72eC5S7y7yPOxjz3UzqX5K+3tjJQcUsgtrK6qSOP/4wmlNifUOnmd
 RIHlYMI3gL60pJBIBjJRzqe1EnipihiG7flUal7Y0K9kHOJNo+HHLAl9PHgp1NSiOt5qdYD+b
 o4yQyYCbf0yB1luREo0fyIJ5BREvVqXWHirkR8GBxwhReYxfzhw/DZPmiAxDqr3W4PiPA/7tB
 I6xWFW19purqQLwMuW9hVobnQdQSKESsP08vaoIbUKasoGqNbUYVDbWTzo66DybK5BzElKB+S
 gHvUbbbEQqJLnAOHroTLzr22h478ViIv34dfc5xjsAPxoUaDeosa8ogmdOK6dnPDWzOB7svVW
 ABFDnlzyE+GX3/1K5RTKmywLh/q9HwcKDip5PDlznNVAnFED8yYZci5Uvj+MBQJJYMi1d7zpo
 HKNVEl0XW1+jHBFgow0QoQXmTzJEavFhtIZeVyb7Z/R0D1yLwVRW9GCrfWip2ITPEv2eZNgDR
 jHgBWZ7UrdNvXopqgVgZF4QPDozG4HwyWo2DQf4ex2eKkjDyVom7MU3qdSW9BPhTeDpoYOJnf
 1bGSGqS3jRIOYfKj+ceH6LMNLVoNEz/KgSIqX+mQ0SVRjUY+8WaMvQD71FGsKOgip3MEB01nS
 2DN5eArYnBio0+2BpFJxXqiSYvf4ScyIhWikbsTyEK+sgHZGE1uJepFNAxr8Oa0JpCqoWSVoz
 iAccNXFG8nUKBv5lQzdHqzjwG16gyJP062RGOEdc4shLaToQRTXSMQUn1ahgz6enoPDkQ0Jpi
 UJAoW4zEG1GFXVp50Rrz0BJQyeOWR4yK243PyVw4fXgkYuTXwflEg1HYFkOmlATeScX/mLscp
 6oB9QM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/wxYmihNgcAM_3RU=cAFtNdH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Aug 2020 18:53:07 +0000
"brian m. carlson" <sandals@crustytoothpaste.net> wrote:

> On 2020-08-22 at 14:21:52, Lukas Straub wrote:
> > On Fri, 21 Aug 2020 22:52:37 +0000
> > "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> >  =20
> > > On 2020-08-21 at 12:39:41, Lukas Straub wrote: =20
> > > > The downsides we discussed don't apply in this usecase. These are m=
ostly
> > > > personal files, so I wont upload them to any hosting site (not even=
 private
> > > > ones). There is no security impact as I only sync with trusted devi=
ces.   =20
> > >=20
> > > I realize this works for you, but in general Git's security model does
> > > not permit untrusted configuration files or hooks.  Configuration can
> > > have numerous different commands that Git may execute and it is not, =
in
> > > general, safe to share across users.  This is why Git does not provid=
e a
> > > way to sync whole repositories, only the objects within them.
> > >=20
> > > Adding the ability to transport configuration through a repository is=
 a
> > > security problem because it allows an attacker to potentially execute
> > > arbitrary code on the user's machine, and I can tell you that many, m=
any
> > > people do clone untrusted repositories.  Just because you are aware of
> > > the risks, are comfortable with them, and are the only user in this
> > > scenario does not mean that this feature is a prudent one to add to G=
it.
> > > It violates our own security model, and as such, isn't a feature we're
> > > going to want to add. =20
> >=20
> > I don't understand. If the attacker gets the user to set git config opt=
ions,
> > then all hope is lost anyways, no? =20
>=20
> When you can embed repositories in other repositories like you're
> proposing, those embedded repositories can have configuration files in
> them (e.g., .git/config), which leads to the security problem.

Yes, I understand that, but the user has to actively allow this via the
allowDotGit config option, which I'll implement in the next patch version.
So the attacker has to get the user to set the option. If the user does thi=
s,
the attacker could get the user to set any other option (like core.gitProxy)
anyway and gain remote execution regardless of this patch.

Regards,
Lukas Straub

--Sig_/wxYmihNgcAM_3RU=cAFtNdH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9BbjIACgkQNasLKJxd
slgAAA//QNMraKLgsxItUdVUKwihfEJM7/7Kui07JvQRBzkP8r8h95khSyBcEq21
q80rJhUnkgD+CW3y0J3UaXXc+q3bEUUnGmtLWR5umFd/PLVKzI1T0NnK3Ds3tz+W
rq6QzCln2ktnHHe8IWdlPuyqrNPd23HEPGtjwqISWIQyLpYO/VjAuGXqXgZ+4vok
Fslhbo/Uuc4aLtEhCgYc9kH3MefpO90h61+iYfqXLrsZd9bYSnAwXb4JlcribZ7y
31nl+xj1UUFEiKBe5+3y0/qzm2ZLKRaLpD4S/OF4EkFC0EebWvZ71RzuYcY9qV6S
a1OU9QkTWc1r+FwfmXgHFtFA9BRlru4FVrnENQBl0lyVm2EY2JfNSTZwLyF8Mph9
IjMgsu5BcWKA8dFRHBxj1ODhK2W8rWJDtGYyOaLnmuIODmSKiXGuACWFcTnQgh2F
mZH6ykOragWIT66wqzOZGe/Z1nV7nsno7qP4a4hWjN8LcIX94dvTlPR/Y3sGt9uP
/um7F8xAP0yofA+SH3ULw780NhPp+alo+q78wn1oCqsS7Q+lDHquDFrQkZZLJ952
/oDGdiqveW9wqhnPU0R3zFB6/V7SiO0U/b0I0twqamKBlN+MZGZhtyJ1z2s13K+6
ENC0oGZvpKMQqMyCeaObH1l/lUBRCqt5Kh92qBLt00iLQO3z7Ig=
=tiax
-----END PGP SIGNATURE-----

--Sig_/wxYmihNgcAM_3RU=cAFtNdH--
