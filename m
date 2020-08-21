Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A214C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 12:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA8920656
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 12:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bab6+Get"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgHUMka (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:40:30 -0400
Received: from mout.web.de ([212.227.15.3]:49835 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgHUMk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 08:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1598013599;
        bh=G1aqM2R8sH5BKZBTDID9xkltQBjJLhxU8JOdWQ4ssvA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=bab6+Get/V+r+d5MLr/IMYSgtfVSIpcJ9S4gSyYmmdauS7ERYcf1Wr1eHWYFtGUqM
         k7Ib8jYzlZzn8Y3WBJDW4+Os0C2Ly0indcORcEiox6NVTFmv5Vf5mhgEN3ida/Jng/
         iVReTCs8TeOFVFEdbVNORv7uDNwxM3Hl4z5k56GI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.96]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mbydi-1kOzKD1uII-00JKvk; Fri, 21
 Aug 2020 14:39:59 +0200
Date:   Fri, 21 Aug 2020 14:39:41 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200821143941.28f71287@luklap>
In-Reply-To: <20200820130125.GB2522289@coredump.intra.peff.net>
References: <cover.1597853634.git.lukasstraub2@web.de>
 <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
 <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
 <xmqqimdetpuw.fsf@gitster.c.googlers.com>
 <20200819201736.GA2511157@coredump.intra.peff.net>
 <xmqqa6yqtm03.fsf@gitster.c.googlers.com>
 <20200819203825.GA2511902@coredump.intra.peff.net>
 <20200820133445.2bd162a3@luklap>
 <20200820130125.GB2522289@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j8oFKosZgbZA=+Z7lxa6r8i";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:uo/rFbSlL0YxhAbsHXleJRz3MUPPhI4+PXtS8SRuoWvjvMomXZw
 +LrAAH9yM+Q1lsFeJmERTeqVj4kBlq2Jjz0RY9/oC6I5E6YTpbY+iDgEs5DLgKriqwTH5lm
 795BDFO1uTzNZ6eEldEXqyTKnQqWjMnnLcd+ahjzN6HVE0R+RWUkLF2vBCj6wKu62X6KllX
 DalmcuxjX7g1tZGde8t0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PRrskIq+y1o=:MnsyA2gLARkym/Os5c+HUa
 plUWd3Ksp4Xao/yr/gRTVxG03ObNQTQKMbaKkYMPkN27VrJNXrqpJCp6JPvnrJbAMoMUk5NWt
 /3mXsjUBjyFoRLDj6hHnJZYuymjK3/SFjMuymJi1HiObVLNXhahrOwuqJix5jrjpKQHOoYBER
 y1kKrhkfOPHIDW0LQlG8XV4EmOzYOLondmk3CVj9FxkPh4F3XKeTT69CHF3D+dS8b3lqNPgCO
 gUOr58rbhr6x4VjErvV9coD7248nBoGvGUrBIxd/go6zSrRHlcAGfrOf9gZzNA8LKMcNt83DT
 BaxW0WrNUv8MnSpSopPCtXGBGz0hIuSvKuMbLiyRVCUoqSD44EDkDJ2vpEHc/sb4FRStS/zbv
 R/opl+Q+SH61rmHgsnCOOaco9x9GDkeO3BBbNi7WaAbL/5caux+GS0PivCW5aYaYHYef9Lkez
 K0T/q8wZE6WA5G5k8I4wBYZHg9a9muc5xkcJ/0MFt4+CNUS/wyaNHq64BSLtB0tnWq4NOwEeP
 +N8ZZIqOq5MHCh6J9yA+gD8vaAk6LzQO0HOxV+UZDhysIJYai1EqdWz+W9iWBaE9D2R9ejUQh
 7ee8bGdazFtPEm5uQzkKQQdJL14IILrbzPQAkPjMTwqNxbRslpFShMBVdf0iD2jQk0SWuyHG1
 ZtWLTU9aabFlNQT5zG17rRbefLKkXu2NMp9oFmiYQmvS1u5ewW4Dl2InHXWLkWdBl+30/dCjl
 Tiltf9b5aR3n40J2wlh5Hg7HVUcPJC8sqBm7IYeoXAlwTyzT/onQT1gkMK5CENfRpERDC9pW9
 MsZnUCUWi5jJn1M5miIuk3eSKaRbt6O23DCJFOJYrGJWKTyTrZGj0kxOy4QY13CNdzGlFycmo
 /88xqcXHo/dqLOyI+wdXKXWIXJQ+kS052cGlKFQKoTgyvtLXoyhQ0BWWxPaD0ehEBAbcs5MWS
 28xj8rqDuMrT95ipP9Ivn5VZMQHDo9KpcidIDwudIiA2ubCu3kAJs/PeOp/G64YYPwhQqJzpI
 lXZ+G4IGtehAsyUEJqsh0zBv9H//Qv+IsaZ697ZVAs7ASalM58zUUfNJ0AdG3875+tjMRhtzm
 47OQkIuRvZ9Mi8P2YJIEs/Esh0hauq10z1+qpbGarN4AM4BeqwwVqlGyFvqHyTqRvke+VLHVX
 a7x4+BXQASWJC1U4cIzIcxXfuw4umYRn/Pu81S3aTyiX9q/8BF0AJOB7tC/YQQ0IP4waN79Lu
 RX+lXFuk/n95klX+TGHxZ9ePYMZagVZ7LcPjkUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/j8oFKosZgbZA=+Z7lxa6r8i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Aug 2020 09:01:25 -0400
Jeff King <peff@peff.net> wrote:

> On Thu, Aug 20, 2020 at 01:34:45PM +0200, Lukas Straub wrote:
>=20
> > Yes, there are many workarounds and they work well in the CI usecase. H=
owever,
> > for the arbitrary files usecase there is no good workaround. I currentl=
y use
> > a script which iterates over the tree and renames .git -> dotgit before=
 running
> > any git command and back again afterwards, but it is slow and brittle. =
I toyed
> > with the idea of writing a FUSE filesystem to do the renaming, but it is
> > needlessly complex and hurts performance.
> >=20
> > Really, this problem should be solved in git itself. =20
>=20
> It is unclear to me why need to hold many sub-repositories within the
> parent one, nor what Git operations you expect to perform over them. And
> what disadvantages your script solution has.
>=20
> Perhaps you can give a more concrete use-case (but before you spend a
> lot of time doing so, I'll warn you that I find it pretty unlikely that
> it will cross the bar necessary to counter the downsides we've discussed
> so far).
>=20
> -Peff

I store all my files in several git(-annex) repositories. By "files" I mean
anything you might find in your home directory across your devices, anything
on usb thumbdrives, sd cards and maybe your home NAS. And anything you would
usually use google photos, iCloud, dropbox, etc. for.
Concrete examples:
I store the home directories (containing git repos) of two retired machines
in such a repository. I don't store the homes in a archive file as I want to
use git-annex's ability to only have the contents of files I need on my
laptop.
I store my development directory containing several(130) git/svn/unversioned
projects in another repo. This allows me to version and sync everything
(including WIPs) across my machines. I tried alternative workflows and they
didn't work out.

In both cases, the script introduces a delay of ~10 seconds to every git
command I run in the outer repository and I have to remember to use the scr=
ipt
on these repos.
Moreover, I can't use the git-annex assistant, which watches the repo and
automatically commits and syncs file changes.
In my opinion, I want to be able to set the allow-dotgit config and it'll
just work without the delay and without having to remember the script.

The downsides we discussed don't apply in this usecase. These are mostly
personal files, so I wont upload them to any hosting site (not even private
ones). There is no security impact as I only sync with trusted devices.

Regards,
Lukas Straub

--Sig_/j8oFKosZgbZA=+Z7lxa6r8i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8/wI0ACgkQNasLKJxd
slhupg/+KF8PH03d997JvMBe8+TMi5ey/GrpxlRjg1SUyzgOIbqnbbVHyTdq4yCG
RQPGC3IgQmwkmflz603PZw2cfoWSGc7tu4oXmdUooDD/7HCnyD2cG5q/UBDgLmvQ
zxzJv2cM1aLXjb5p6KlUqs/DPr0XH9kEZIUL1WJyqbAUCWqbN2HY5g0al6ogFWYA
ZjbTirxaDARuHUnmJY3xd6ncVAjeqciCUscGYBpdHKi1qWSnoNHMzJV7j/iWWMrX
QbJQu6/Qvl5bJ4N0OLDeaPvecCQUkgH5BJwyKrG9+6DUtCxeq2jv61rQUqosphIV
T7lx+GFdK+q/p4YKQzvAGxVLIjiFipwIBDoPjLvTLAIoDg4P+ihc5cMJaYOUyoIT
OlH4m3n2/zQR+FNg321K+Ficztr/HcUYl6acRbUpVl9Di3XWGXrqZTRFbU869F3V
QaU7fPfPRf3wFI9TnuNTkL83Y9tjDSZ4uO3/PNRjM3UX/44jpZF3NWapn2EMFYpe
XHomvDryuPiqdWEMCQX6LVy3QuDv54tCKxk/Z92qEIJlMBN9spqIqLmA1XHEsBZd
5ewuTCshqCK4z8E74IB8CFm+2vfbhqM7sZAP6JBxpN/mFC+uz5kcVGebbDRMoH9X
JOwqte/QgDDjAn4O806aLhKixdzFug4eGpRKw0hcMTeYuRl2dos=
=7k/O
-----END PGP SIGNATURE-----

--Sig_/j8oFKosZgbZA=+Z7lxa6r8i--
