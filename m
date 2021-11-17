Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3956AC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 16:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143A8608FB
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 16:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhKQQPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 11:15:33 -0500
Received: from mout.web.de ([212.227.17.11]:48797 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232707AbhKQQP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 11:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637165547;
        bh=tt7djQILoZAgS1vlsxtpPjuF4ilx0VYLK64atOFlbAc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=k9Dg92ogt3aBsQDfMo2504WrZtrLpulvwwcLDwFyZw7vNb4A0UahMtMNlopcdx4cm
         h81+Xwe6mdA2In4YZ7GlgR/LieiJgEzXHG0Wgx11VPlRqXSMcEGMhWHvJqeXwfcYgb
         /9eEcXMlbJFSw0HD3Mi1/zm08FIgCqHgyRIahkl0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwR0J-1mUc6o0BIz-00ryqL; Wed, 17
 Nov 2021 17:12:27 +0100
Date:   Wed, 17 Nov 2021 17:12:26 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [Question] Unicode weirdness breaking tests on ZFS?
Message-ID: <20211117161226.xcat77ewhf5inaif@tb-raspi4>
References: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:cPVMx4WIu5s2rH3Jxb0N6qjX3eSALzCwgyUxhaB/hepp/VbJOrc
 FeBoMnM6ZfgugDs6cjQSRsJLb31/FSUCoE43QgM++XqJ2fCrjCPJ32Yn4BIMbA0DudgeJhQ
 te8DALJc5sT5bpL/gyHwho6XHLMKTlFLm2tz457uQY+0oTBCDtMKkjjM5ZWA0l6NuZ+uTdJ
 TGNeMOGiZEInXYq81OHzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TWZE0ylcFYA=:WFw602IozYrEiqP/CEFyeE
 UHIja/cA1qpqOSmp71+q/LNmgCLuFFsj5WI1WWmRbzw5bPHtZwzVUIfU08eGk6de3JQ4j2YG9
 FmzpHWPs8AQPY/w1DJWUOcjmPOX183kXCW5moVEO5Qfrp5ARQQjAh/ZF8J/LaVfIWwqg7v8Yb
 NjDwZJvpPamlTa/5DxLEZmhFeprGLJyZ22hwCKv713GzYiyJaGwBsLkP2yjx63hckxVqV9vlP
 zaaUCUSpFY0QtaUXMCwNW6Ehl1yp/StEqR27uoxaQBKXOzvwNq6NI7DIOoF6oFfQhCbpe4iwh
 DKw7bDpMMngy/I+EC6HSikFtQdNAnQ+zr4PW3EBGVDXh8tB7VMF4Yrm7vUhGxF9Q/u/H+ZhY2
 nsasfAysaPHFiEgOcmIi+GmhyraDnpBlXv/MaouZg7xo67kJfB8VA7MMM/Kr16WXrhOe0RAMF
 5Me/8x5NtuarIIkw1svlq1Qt4JQ4hcd4oJUQJ+WyY0tCZq6gm6t6xe+RPoIak6HdNvmQX6+Fo
 6lvDtDO59rcBW6W7B2/GZq8QhkD+aM+iVjkYPyAJqj8UaRhEQT7PHDWsYfISu/2FEagZwW9vh
 yD1SisT+X3AOWrSn/9ULgCCHYuCRX/tfp/2WB7RbBOgIpTtnEpG+OAkhckVTFzLmKEa0RZICD
 UAuG9xVmw1U8x8CKJQdLgiHvfo5nIs1Te3AhEEPK4o06yQtkTpQvxb4Jy9y/Z/T+WAc/RxnZj
 z4P1wnB/7G5c3UprtqMSaSMNkmcAOIzjxX+Jr5sgY0fk+zzLmWVsXW25DRyG02Qz6BnzHv1MZ
 4UYcrRyya5bnhH0/KdXnDLmLowrw6yao12weWS8JAcXq6Y2RT/XSqRaav4MqJEtd/WyutXPDn
 yIORkwpeSFedGyk3cLhQHcFnKFfGfctJTWVE8Y/LeBB2hg8pDoxFAYEvgMChGB/vzY+3D9eNU
 it/r6K9xeX9FfPGq1tDM57eKMEYjqMEV+03qAIuRkr3BmAEnTY7wcvXGq3DjGbS7T8PGJz44Z
 PGL9Ml3v5722wTPeJH2CZIudyXey7+njFXFDAI1M/vD9uAayMIe0DAVgOIPIr8u85w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 10:17:53AM -0500, Derrick Stolee wrote:
> I recently had to pave my Linux machine, so I updated it to Ubuntu
> 21.10 and had the choice to start using the ZFS filesystem. I thought,
> "Why not?" but now I maybe see why.
>
> Running the Git test suite at the v2.34.0 tag on my machine results in
> these failures:
>
> t0050-filesystem.sh                   (Wstat: 0 Tests: 11 Failed: 0)
>   TODO passed:   9-10
> t0021-conversion.sh                   (Wstat: 256 Tests: 41 Failed: 1)
>   Failed test:  31
>   Non-zero exit status: 1
> t3910-mac-os-precompose.sh            (Wstat: 256 Tests: 25 Failed: 10)
>   Failed tests:  1, 4, 6, 8, 11-16
>   TODO passed:   23
>   Non-zero exit status: 1
>
> These are all related to the UTF8_NFD_TO_NFC prereq.
>
> Zooming in on t0050, these tests are marked as "test_expect_failure" due
> to an assignment of $test_unicode using the UTF8_NFD_TO_NFC prereq:
>
>
> $test_unicode 'rename (silent unicode normalization)' '
> 	git mv "$aumlcdiar" "$auml" &&
> 	git commit -m rename
> '
>
> $test_unicode 'merge (silent unicode normalization)' '
> 	git reset --hard initial &&
> 	git merge topic
> '
>
>
> The prereq creates two files using unicode characters that could
> collapse to equivalent meanings:
>
>
> test_lazy_prereq UTF8_NFD_TO_NFC '
> 	# check whether FS converts nfd unicode to nfc
> 	auml=3D$(printf "\303\244")
> 	aumlcdiar=3D$(printf "\141\314\210")
> 	>"$auml" &&
> 	test -f "$aumlcdiar"
> '
>
>
> What I see in that first test, the 'git mv' does change the
> index, but the filesystem thinks the files are the same. This
> may mean that our 'git add "$aumlcdiar"' from an earlier test
> is providing a non-equivalence in the index, and the 'git mv'
> changes the index without causing any issues in the filesystem.
>
> It reminds me as if we used 'git mv README readme' on a case-
> insensitive filesystem. Is this not a similar situation?
>
> What I'm trying to gather is that maybe this test is flawed?
> Or maybe something broke (or never worked?) in how we use
> 'git add' to not get the canonical unicode from the filesystem?
>
> The other tests all have similar interactions with 'git add'.
> I'm hoping that these are just test bugs, and not actually a
> functionality issue in Git. Yes, it is confusing that we can
> change the unicode of a file in the index without the filesystem
> understanding the difference, but that is very similar to how
> case-insensitive filesystems work and I don't know what else we
> would do here.
>
> These filesystem/unicode things are out of my expertise, so
> hopefully someone else has a clearer idea of what is going on.
> I'm happy to be a test bed, or even attempt producing patches
> to fix the issue once we have that clarity.
>
> Thanks,
> -Stolee

Interesting.
The tests have always been working on HFS+, then we got
APFS (and needed a small fix) and now ZFS.

I'll can have a look - just installing in a virtual machine.
