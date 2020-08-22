Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320DAC433E1
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 14:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F207F2072D
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 14:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="PLoon5qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHVOWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 10:22:51 -0400
Received: from mout.web.de ([217.72.192.78]:57555 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbgHVOWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 10:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1598106143;
        bh=N5LGWkEZjyxWdpiCGbKUPggq/d5pB4YRm2j5PtF6fkY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=PLoon5qoRomVEk2/m+lvHM51052A6BoPCyqV/s8MYmgexSCtlCxPnagJm2QqLPFIV
         1J06bJizsjCy6zpJi6BH92dEZPJ8a9iEzcfL92JwvjBhcnPBYuTCRpnWokQcYvjr6n
         w+9ICsytyZcPFUo+UnzhHScHquL2bv4pSkoHmODg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.28]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8iLA-1kLYAd15LA-00CB7I; Sat, 22
 Aug 2020 16:22:23 +0200
Date:   Sat, 22 Aug 2020 16:21:52 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200822162152.2be1d024@luklap>
In-Reply-To: <20200821225237.GW8085@camp.crustytoothpaste.net>
References: <cover.1597853634.git.lukasstraub2@web.de>
        <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
        <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
        <xmqqimdetpuw.fsf@gitster.c.googlers.com>
        <20200819201736.GA2511157@coredump.intra.peff.net>
        <xmqqa6yqtm03.fsf@gitster.c.googlers.com>
        <20200819203825.GA2511902@coredump.intra.peff.net>
        <20200820133445.2bd162a3@luklap>
        <20200820130125.GB2522289@coredump.intra.peff.net>
        <20200821143941.28f71287@luklap>
        <20200821225237.GW8085@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cV7w668_g9QMyGy+ewvTThT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:PtkO/sGkf/NkH5mktQi2LLRIxfb3cJQ8k7d8Pmg8rFwtn2nJu7F
 ps8fUuqqEVMtTmWh8GG3Xt1hDpnNWIgrzkFcIGQ9QloLT1PbboZxJNTp8FtUFH3bvibVO8o
 VpfMvPNw1MvbTfMIqmXs8sGh7FfqEZS8Px/FFoAkLLyaGMi96uTk/PyLhC2TzNDJ5pAnJrQ
 Zn6W1T72xJlFnYqkAt7KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kdc9p3PYnwg=:k+7OTjyt5gmm2H/1+y30bT
 k7xBH6YPaEwHsEqOdvD1a6X2c4aAj6tfRszJnk3wA2JSHiq5Quf4u3wkC8qEBCso7z9vvh33Q
 sa7LxP0iTjDJxukEku3D7Kx0EOVbFnTOzxuqACPcdWQp5F/hNHWcfiWYklnVxq1ezEL9NwMsI
 Py2/ZHxoIt0HvDfh53G+j/pfRWEV8ej6rehWR0Pw51USrSgwZemXwyDRqSrnjmRIEL0wZU3VG
 6GTno7f3toGg5n/F137zXW9nnmAzrCyUFCPfncBMMCUu9glWV1KeqTnBM9XTDVUwqw74ykmpQ
 bVzi/NG3SlxfB9yPnxWRZ7O4/SRM8UHhHPN38uDnoU7hR3G2l6tCXoRSnJEE7J2T1f526cO8k
 /D6dnwbeGC+F8aJS+Ep+QUyMrBrwjHBf2JkU+HAdSYfvlDBO78COCDCtJ4GgLxNQ2/DPuWNeS
 YZhd7mrQRKw7btK7PSeu/2WebbI4ajP3bEEATa924b3WDg8jl0JW8mNfTyGD73MQdnoQT0Obo
 uYBKXcQibF+CQZTDzFBYMZjmaC7eecpk9GPd3fWCW9onvigq45SQHuxkep4VBQqs+WF1CoV3z
 7BcrXZHmX4ub34kYAJvJ7jIi3sb6aJYnzLhRQA1Z1w3frDrV0DA1uDLqy7S04GVLEqLNPXERN
 GE71TNze9nq6y4Sh3D0f8+WW717ipmltiX0reruL2sOaBogsUiOWPbR2AivVMZOJjNYMdIvh2
 8JSu/Tkkzhz8SkGJxCupAzZaR6bChK3UIW51Yo9Dh27EzgYbOkSZ593xax+BXHZ+SmKbW2wyq
 pVHuNudYgVVWiafk+tVj/Fc4EDonnr2dMISCDzJm/qxB1TA4TQv9kKDp59olGNksDyEPjSqRy
 1MFazqWItkowgzsA+AUj2KcsYrgM8BEo9xf9Yko2yZdR2T9vDwNj4H3Q1YAEqIvtWtaity4n1
 FK78qjkTYuHY29Zew2pGBZQy8Oydfxu1s3Ug5lT6YdKW0BKXwGq0t4lwXtHIQ1nVjFOq2Cq7p
 5wDMEaGiFnHTFTZFlladyh3WCfLDf9SDvh4vZNJflIN44I4zGgukQY7y7SDAqJe2OWNUirON+
 xBC3m1ZjregL2UkFdGer6gLxumlfvQDRt1GHt17JH3Rlbdhhug2jkfK/3IeKJC9tGj0z3TuH8
 3+rH8iIzXWDBOad/KjTtfKzIUZVlsDVyDuHGUjzCvx4B2BBr4kkMSr/JMDgNC9s7hEyeMXe/6
 QOEWG1KjDneu3U6AXFvLks8RbpOm9QyesJ0NVmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/cV7w668_g9QMyGy+ewvTThT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Aug 2020 22:52:37 +0000
"brian m. carlson" <sandals@crustytoothpaste.net> wrote:

> On 2020-08-21 at 12:39:41, Lukas Straub wrote:
> > The downsides we discussed don't apply in this usecase. These are mostly
> > personal files, so I wont upload them to any hosting site (not even pri=
vate
> > ones). There is no security impact as I only sync with trusted devices.=
 =20
>=20
> I realize this works for you, but in general Git's security model does
> not permit untrusted configuration files or hooks.  Configuration can
> have numerous different commands that Git may execute and it is not, in
> general, safe to share across users.  This is why Git does not provide a
> way to sync whole repositories, only the objects within them.
>=20
> Adding the ability to transport configuration through a repository is a
> security problem because it allows an attacker to potentially execute
> arbitrary code on the user's machine, and I can tell you that many, many
> people do clone untrusted repositories.  Just because you are aware of
> the risks, are comfortable with them, and are the only user in this
> scenario does not mean that this feature is a prudent one to add to Git.
> It violates our own security model, and as such, isn't a feature we're
> going to want to add.

I don't understand. If the attacker gets the user to set git config options,
then all hope is lost anyways, no?

Regards,
Lukas Straub

> I want to be clear that it is not that we don't see your use case as
> valuable or important, only that we can't see a way to implement it
> securely as proposed.  Warning users unfortunately isn't sufficient
> because users tend not to read documentation.
>=20
> Multiple core contributors representing various aspects of the Git
> community have weighed in, and it looks like the answer is unanimous.
>=20
> Sorry for the bad news.


--Sig_/cV7w668_g9QMyGy+ewvTThT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9BKgAACgkQNasLKJxd
slha0BAAuWmxiJ+xStDV0+gNBWWOLSHDA3dKbLBTK9ZB9ZR83LyogMq1WiWrkEIG
27kQe6EHLrLX94nV6XC2w5qnZHROZ0E6cMmY40hmurRLPtV2GUizwYIoLm9MbLd5
uPWI+NQO9TvmkxlF800Id5SuCouAQq3HmWlWMMyhVwjkhq/etbDo4RuCqvNN6LY9
awVhM4EbzVYrMb8nGayTl1mVqbErTSOb4f6ObxkOHcOd1Bxbu1b447D5/MAEz9oX
fhJjPrkDXXtfb+VeBvNAst/jAUQYb0DRiVOam4ZTi/qFrGxrQE+3a6HiMGN58Y76
wabfMwjo8If0WDKrG34WeCax9V904NUxHN8fAnjEzEn2N+4Bh7GJ4Ps4OQUsv7NQ
6MCNP+pH94KPMFKNWc1ecD9ySM/Jl9XPIPyNehZXq4WBzJjOZMSQRDHLVsPcmE45
08mcvvBjHaqAUtmJbbYvk/bX1ivvc13IB//p5OPxUFJeGdzLRnA0LHspKvuXwxFS
gQxu+GG8k1cYEdt76CpWMKgCW9dWQmpUm7wrixvxBv8Btzhr3giSvQ+zWEhO96rG
Grd09OcyfzZenAH74RyULeMNK8JOBfmOu3IyDBlHGazB5O09W/OYzdBHYIPtNmbz
BhCfmjd0s+OOz4v3im61faq+lvJrcz25DGokOQH5ELEA6SWmx+o=
=AO6v
-----END PGP SIGNATURE-----

--Sig_/cV7w668_g9QMyGy+ewvTThT--
