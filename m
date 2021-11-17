Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D01C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 17:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FB1615A4
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 17:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhKQRJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 12:09:16 -0500
Received: from mout.web.de ([212.227.17.11]:59069 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhKQRJO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 12:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637168774;
        bh=k53C2TRTv4e+4n53TJU57ZtTKX3gtxgWnFoNTpW200E=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=D8EzYC2gh3W221082nw0SIoi6rGGHXjLyuR8C+PWGQTQBY+ijW/PWCcEcdjTM/3b7
         sMcBA0SUMB4WTOxJ4J4r7LPOsp1atttGdgvVGdUXp7zZQu7fAeo1Zlr3hILk7BRMUN
         ff8YAxAt3ISXuxuAEB41Q7jb3SyzdmXiLE1t0er0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1msHwq0ucU-00EDpJ; Wed, 17
 Nov 2021 18:06:14 +0100
Date:   Wed, 17 Nov 2021 18:06:13 +0100
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [Question] Unicode weirdness breaking tests on ZFS?
Message-ID: <20211117170613.kyoe6ov2m5wi2i56@tb-raspi4>
References: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
 <20211117161226.xcat77ewhf5inaif@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117161226.xcat77ewhf5inaif@tb-raspi4>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:b6+6O1q1rpdDo2OPzAiDrgFZuEkj198mxBaoHMukDnFF6mqAYky
 kaJdQ+LoJzTjKemQyNB7E+bPjxa1/iD56FIs4Ms15ANyf0HZRC8VbJRgadYivEJU+hmRNvL
 XnDsVoqUt9t1Ow66AiTgTaxs0ACUdqCRjAN+iOpaFqKq4yTTTSTF0q/OAIFAKCOrpggZR5E
 FD4iJQDd8pcY0vQ/I2q8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3PSNbVBMUz4=:OZyylhbKXOJd6jRvL7Ld2/
 rpWBsFiMyTAl1oVFTDn5MwZ+5u9Ez5BWZwkYrHZxVBgJyGJu+IBnPOMdU1wTU0KV/69CeMmQ0
 9vSUYKGOWgwSF9hgF7lpaj7UX60Dm54C++WfPs2sikJ2RFLTHk8FTUIYsgqEnJuMxTAzKXk9O
 wd9DjxqxJjVOLdVZDDHetbgpEEqrcryvojBcEuQkx5Tv3FoZCrcie0heFxjnUHEphuXdppPJe
 OaT5kniWN86CoVpBVoWPaZsxwVJXGlGLL8polY34U+sngbAzfVh0f4Rxb7qMllndFU91kLClO
 4ekQQwy+aiPeYbuHxtKcWQ8q+Ll2f9RVk7makW8BijK0oTLgU72m4EDkpDSU0JYOSbdH6WIH2
 P9Zos20aMJqwu9f7htC2yuqcX9FOh2fhBvHv8182C6duA0Kp+Kp6Olnm7cquK2nd01fWnZl1O
 JfFnHs9dZvsrIoqVXKy/dYDFmB0J0JzNJGfJMeUFtUDHVLqKCJIB1kBwqgw7kIsUJLohwjeev
 P1knpnkVruclaJAaxZIuvAhqql/K1Rvef3V2r9lbaM0pPa7Wu5ECCHboo4GGS1DiZqb4QiUpt
 eAGA1CIgIUkYz9XW14ZT3m0bfmHxD3Hlw93PlQx3jxVgaRcZ+59BjHGexzbAk+irXLN/a7t8G
 Eq2Ed9jIqV1UufmDHpLYP6Gzt+MXQRkxBDlDYhr1OtKEcEue6vUh4Fdb16ZOUosBwYpKQwKo5
 Groree4h+lbNqPz3Jb5m1XbZFbb7dVEDgL6RWEJI06Ccr8gCx7nsnXfW2Ryzh+fxzoM/+Nlvi
 lfhMQReEuIwcao9ZfTC4/+2wtP+0/WZxX/v5tjPcAj65Lyq8lh5ZPHKcFf/rYWj1wPAJAHTyz
 PdmzaxwrkTlwrkJwHAlajGTCaL15PHaTQrUb+KQ1laUXkcw6Jn/aem8HzsoIHfZL8MpNodQ09
 sGTqOO+RKlcKL58NbsSPstDH0FeLgIeDLdhDWWSxiLCanb8YVlNGFqvfHnCrl87Y+sGaorxDE
 Tp2J5en7Iqv0+wxkeEWilTPYSWF6r2mOqzJYcwNA34RftAx1cRZfjA92QCZYxNWHkw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 05:12:26PM +0100, Torsten B??gershausen wrote:
> On Wed, Nov 17, 2021 at 10:17:53AM -0500, Derrick Stolee wrote:
> > I recently had to pave my Linux machine, so I updated it to Ubuntu
> > 21.10 and had the choice to start using the ZFS filesystem. I thought,
> > "Why not?" but now I maybe see why.
> >
> > Running the Git test suite at the v2.34.0 tag on my machine results in
> > these failures:
> >
> > t0050-filesystem.sh                   (Wstat: 0 Tests: 11 Failed: 0)
> >   TODO passed:   9-10
> > t0021-conversion.sh                   (Wstat: 256 Tests: 41 Failed: 1)
> >   Failed test:  31
> >   Non-zero exit status: 1
> > t3910-mac-os-precompose.sh            (Wstat: 256 Tests: 25 Failed: 10=
)
> >   Failed tests:  1, 4, 6, 8, 11-16
> >   TODO passed:   23
> >   Non-zero exit status: 1
> >
> > These are all related to the UTF8_NFD_TO_NFC prereq.
> >
> > Zooming in on t0050, these tests are marked as "test_expect_failure" d=
ue
> > to an assignment of $test_unicode using the UTF8_NFD_TO_NFC prereq:
> >
> >
> > $test_unicode 'rename (silent unicode normalization)' '
> > 	git mv "$aumlcdiar" "$auml" &&
> > 	git commit -m rename
> > '
> >
> > $test_unicode 'merge (silent unicode normalization)' '
> > 	git reset --hard initial &&
> > 	git merge topic
> > '
> >
> >
> > The prereq creates two files using unicode characters that could
> > collapse to equivalent meanings:
> >
> >
> > test_lazy_prereq UTF8_NFD_TO_NFC '
> > 	# check whether FS converts nfd unicode to nfc
> > 	auml=3D$(printf "\303\244")
> > 	aumlcdiar=3D$(printf "\141\314\210")
> > 	>"$auml" &&
> > 	test -f "$aumlcdiar"
> > '
> >
> >
> > What I see in that first test, the 'git mv' does change the
> > index, but the filesystem thinks the files are the same. This
> > may mean that our 'git add "$aumlcdiar"' from an earlier test
> > is providing a non-equivalence in the index, and the 'git mv'
> > changes the index without causing any issues in the filesystem.
> >
> > It reminds me as if we used 'git mv README readme' on a case-
> > insensitive filesystem. Is this not a similar situation?
> >
> > What I'm trying to gather is that maybe this test is flawed?
> > Or maybe something broke (or never worked?) in how we use
> > 'git add' to not get the canonical unicode from the filesystem?
> >
> > The other tests all have similar interactions with 'git add'.
> > I'm hoping that these are just test bugs, and not actually a
> > functionality issue in Git. Yes, it is confusing that we can
> > change the unicode of a file in the index without the filesystem
> > understanding the difference, but that is very similar to how
> > case-insensitive filesystems work and I don't know what else we
> > would do here.
> >
> > These filesystem/unicode things are out of my expertise, so
> > hopefully someone else has a clearer idea of what is going on.
> > I'm happy to be a test bed, or even attempt producing patches
> > to fix the issue once we have that clarity.
> >
> > Thanks,
> > -Stolee
>
> Interesting.
> The tests have always been working on HFS+, then we got
> APFS (and needed a small fix) and now ZFS.
>
> I'll can have a look - just installing in a virtual machine.

So, the virtual machine is up-and-running.

I got 2 messages:

ok 9 - rename (silent unicode normalization) # TODO known breakage vanishe=
d
ok 10 - merge (silent unicode normalization) # TODO known breakage vanishe=
d

Do you get the same ?
