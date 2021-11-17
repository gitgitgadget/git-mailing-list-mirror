Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1694C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 17:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C4E61BE6
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 17:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhKQRm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 12:42:26 -0500
Received: from mout.web.de ([212.227.17.11]:37371 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhKQRm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 12:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637170765;
        bh=cIsvzK3KZ/tC0ymjjDiav3am73ZPRoWNT2fdoJloasI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=qzcRVRsx89k8k7cwuIVlg6c1gMj74FBgAqpOaVeqQZxmk4O7/xQO4huuKX+aiF7mN
         XwavDpawDeMrWjawUPN09kCfJRBTpDYV60ww2fCiNUXwfqgMAwxdRXmficOL9umwDj
         xV1RbjvQRtLLoUJViccmsJVmLVPB3UpqJlhA1NNg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xnl-1mf30A2SEV-01097Y; Wed, 17
 Nov 2021 18:39:25 +0100
Date:   Wed, 17 Nov 2021 18:39:25 +0100
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [Question] Unicode weirdness breaking tests on ZFS?
Message-ID: <20211117173924.maporsti5cz2ixsu@tb-raspi4>
References: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
 <20211117161226.xcat77ewhf5inaif@tb-raspi4>
 <20211117170613.kyoe6ov2m5wi2i56@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211117170613.kyoe6ov2m5wi2i56@tb-raspi4>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:hXXg1X0RrL4H5Wvkosm/Vc7PkvmwHbGPIXcb7cmh+dQ0LDw5mrs
 tUyu237gU6TAK9IRGO2r1D7t9QlOMKWfbgdHDZzC/Z5x87IyIkBw61njhkTOldTPjEc3gLC
 V3ydMu2djHtz9sult4GimuThvwB3B5CkamU0hsIjCOcV0j8jGThi1bcMc7CW1l2ljQk4HJx
 D9WqKRTd2FzZmUaxHvDyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K/nMFUS88rc=:MTCSjYL1uuCd44er9fMwdX
 fQiyOSUe4nyBzjjibbBdwOd2yO2qNu7j/Ug+h8Lehtbdcg3nShBHThjdzN7f20CUO9oJ3Teu/
 WZ/mJc5jG/rlGFRFF84HtfSHQ7IYeRSACiUWKL0FYfZVR1xmUmkxhqv2ZuS7p6AXZ6nzhkn3b
 vS8efbCqmh6LuLTULkbyKWZUeM9aBwjeFdbTTVpU85oZJt15znjKyVzSNngWjthzKaOyexVaz
 mGu4sgv72bkipfz/PwfQZAyQaVDlOL1XtdJOPse1cBICkwEHa/4DvdDeLx9G566fz7x11ju40
 tTsuzjlrNd2wUth7Ek3jUDcTzgwiEu1yB4S4xjPuMiuQCge+7eEBhUmCfdSpdjLL2VjUEHSAl
 v7/cFZ+379fX8NOTsBxLNqDDQr7paeKJEq52/8SDq0ofxTstWalbozY6zDrntrj0rR6pFB7qj
 anDgDXJoQGdq6sd/J4Q5H3nedBXngds4J+0+23AMMpysifb/5ZSqLzqP37mRzr6BcsNX9KDka
 Fv62Sm6tWrfhSSOvW9DfE5mn8BnZg+mjcFkkhtBH6eHn/vjrgKEpLNSVx4R9PCJFihrZvu38S
 qNFq+iSHktlLWFxddOFslp2Njvq9mjRPMoSXcvxlqZtdjKsWNulnUOkHn5ysobxSluWo57zGH
 A2+ld8zAJu6t4bTEi1z1TN/GQeXrkbwP76dQqs0Ug0t6KxcJx7zb4n0H4FdrUcZvl0hJtIrPT
 pEnxblFMXL3yBc+n9nFqSkZycds6z5LMJrDww3b5ceIUrC6pKligLzJvh7eJ08z/uiQJc42j4
 eXtQrnqHF7A/Fr85OJecuAQFWmfWYqRPdbFEXAnQv7I5bUAHSQdFlARjtHM4t9t7pM99InRZQ
 cC85OPdolM7deP2JHKOWQ0w+XRgxBg3tQ6rgX+Et3qZdYAndIMQdzezFGBcX8YVAiZy5Nuc+W
 /ALmxeJOBB9dFWpcJwSw87/GFUyhkkJfGfCjBX0GM8iSem+6nJhw+cSDKIhe1VCB75FQzwHZf
 8DVmFurXh47VNveDgTrawExYzrFnaO5QvQJMizmaVtTJsgxystoxXBgTFRkWBIHI1+LXuciRK
 Z7ia7AkY4O+59U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 06:06:13PM +0100, Torsten B??gershausen wrote:
> On Wed, Nov 17, 2021 at 05:12:26PM +0100, Torsten B??gershausen wrote:
> > On Wed, Nov 17, 2021 at 10:17:53AM -0500, Derrick Stolee wrote:
> > > I recently had to pave my Linux machine, so I updated it to Ubuntu
> > > 21.10 and had the choice to start using the ZFS filesystem. I though=
t,
> > > "Why not?" but now I maybe see why.
> > >
> > > Running the Git test suite at the v2.34.0 tag on my machine results =
in
> > > these failures:
> > >
> > > t0050-filesystem.sh                   (Wstat: 0 Tests: 11 Failed: 0)
> > >   TODO passed:   9-10
> > > t0021-conversion.sh                   (Wstat: 256 Tests: 41 Failed: =
1)
> > >   Failed test:  31
> > >   Non-zero exit status: 1
> > > t3910-mac-os-precompose.sh            (Wstat: 256 Tests: 25 Failed: =
10)
> > >   Failed tests:  1, 4, 6, 8, 11-16
> > >   TODO passed:   23
> > >   Non-zero exit status: 1
> > >
> > > These are all related to the UTF8_NFD_TO_NFC prereq.
> > >
> > > Zooming in on t0050, these tests are marked as "test_expect_failure"=
 due
> > > to an assignment of $test_unicode using the UTF8_NFD_TO_NFC prereq:
> > >
> > >
> > > $test_unicode 'rename (silent unicode normalization)' '
> > > 	git mv "$aumlcdiar" "$auml" &&
> > > 	git commit -m rename
> > > '
> > >
> > > $test_unicode 'merge (silent unicode normalization)' '
> > > 	git reset --hard initial &&
> > > 	git merge topic
> > > '
> > >
> > >
> > > The prereq creates two files using unicode characters that could
> > > collapse to equivalent meanings:
> > >
> > >
> > > test_lazy_prereq UTF8_NFD_TO_NFC '
> > > 	# check whether FS converts nfd unicode to nfc
> > > 	auml=3D$(printf "\303\244")
> > > 	aumlcdiar=3D$(printf "\141\314\210")
> > > 	>"$auml" &&
> > > 	test -f "$aumlcdiar"
> > > '
> > >
> > >
> > > What I see in that first test, the 'git mv' does change the
> > > index, but the filesystem thinks the files are the same. This
> > > may mean that our 'git add "$aumlcdiar"' from an earlier test
> > > is providing a non-equivalence in the index, and the 'git mv'
> > > changes the index without causing any issues in the filesystem.
> > >
> > > It reminds me as if we used 'git mv README readme' on a case-
> > > insensitive filesystem. Is this not a similar situation?
> > >
> > > What I'm trying to gather is that maybe this test is flawed?
> > > Or maybe something broke (or never worked?) in how we use
> > > 'git add' to not get the canonical unicode from the filesystem?
> > >
> > > The other tests all have similar interactions with 'git add'.
> > > I'm hoping that these are just test bugs, and not actually a
> > > functionality issue in Git. Yes, it is confusing that we can
> > > change the unicode of a file in the index without the filesystem
> > > understanding the difference, but that is very similar to how
> > > case-insensitive filesystems work and I don't know what else we
> > > would do here.
> > >
> > > These filesystem/unicode things are out of my expertise, so
> > > hopefully someone else has a clearer idea of what is going on.
> > > I'm happy to be a test bed, or even attempt producing patches
> > > to fix the issue once we have that clarity.
> > >
> > > Thanks,
> > > -Stolee
> >
> > Interesting.
> > The tests have always been working on HFS+, then we got
> > APFS (and needed a small fix) and now ZFS.
> >
> > I'll can have a look - just installing in a virtual machine.
>
> So, the virtual machine is up-and-running.
>
> I got 2 messages:
>
> ok 9 - rename (silent unicode normalization) # TODO known breakage vanis=
hed
> ok 10 - merge (silent unicode normalization) # TODO known breakage vanis=
hed
>
> Do you get the same ?


Now I am even more puzzled.
running t0050 with -x gives this:

 Author: A U Thor <author@example.com>
  1 file changed, 0 insertions(+), 0 deletions(-)
   rename "a\314\210" =3D> "\303\244" (100%)
   ok 9 - rename (silent unicode normalization) # TODO known breakage vani=
shed


=2D---------------
When I create a test Git, with one file in =C3=A4-decomposed,
and rename into =C3=A4-precomposed, Git gives me:

tb@Ubuntu2021:~/ttt$ git mv "$aumlcdiar" "$auml"
fatal: destination exists, source=3Da=CC=88, destination=3D=C3=A4

and in hex form:

tb@Ubuntu2021:~/ttt$ git mv "$aumlcdiar" "$auml" 2>&1 | xxd
00000000: 6661 7461 6c3a 2064 6573 7469 6e61 7469  fatal: destinati
00000010: 6f6e 2065 7869 7374 732c 2073 6f75 7263  on exists, sourc
00000020: 653d 61cc 882c 2064 6573 7469 6e61 7469  e=3Da.., destinati
00000030: 6f6e 3dc3 a40a                           on=3D...

