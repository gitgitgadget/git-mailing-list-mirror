Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC161F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 08:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfJ3IfB (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 04:35:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:43805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3IfB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 04:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572424494;
        bh=o9yI53A2WVVxyiUwP/SYNu28/RxEoG/cfImNua/1cI4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AZg3aV8B4hMLnsflFXdYovwT+1yln1u7P7T5FyJhfUtJtODKngVgPqfVDKv346Hu6
         UGzhiP1JAXfX8lcecEZQwWxBrqPBm/zCmT7giVHc2FLaRDMhyY1vsnjfmaUj3rcDUQ
         F4v5RhTbc0f9Amni2EHaPwveaNHz0K92llwNX0Gc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1iL4c31Fr7-004m1X; Wed, 30
 Oct 2019 09:34:54 +0100
Date:   Wed, 30 Oct 2019 09:34:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] update-index: optionally leave skip-worktree
 entries alone
In-Reply-To: <xmqq5zk7593d.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910300930440.46@tvgsbejvaqbjf.bet>
References: <pull.355.git.gitgitgadget@gmail.com>        <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>        <86dbb11f159375da281acd6266df019106abeadb.1572261615.git.gitgitgadget@gmail.com> <xmqq5zk7593d.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R173uEe4wEJ79Xtbxd1J3qV67Hda191RL2zMNjpXy+5Of+W8vM6
 QWMKP0kAzHhDPeoviqdfT4H2oeZOSA9Cx3XaqP/pi9byGynYbwEK6RvyosAk0QVBtUqNGUO
 Jwm85uWw4yPpZD+eWOb+gs2T8Sgu+/OkoxvAAvQ+lSCXFaFS1EuEiJsy/yI9M4XhdI0HbU1
 52gOp2WzLNhbTDUcazBzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w8I7vKqcaZA=:iKKRgVeRZz8VFX0Zk52ejz
 5HLhvPDb4aovLYoeT9EF/Lzz8l3vSG/mFHDEyF1jR8wTEDNtwc8tGKvcamKG6yeOWNQao0NeV
 czqmfMT+pXIvbqJTW9KMOjPbexKHyoe6hsj+yWLIAbXFT/U0fOgLyAc1YQHhkS1NiAG2B2Sn6
 SqNsrhZxm/Y3Lry7czOtjODMaiDPXRNFNBTfBZ740A7REOpvD6yPb4OvKfZ5Q4/Ts4aRmzOEO
 V12HBCbV326wjfJIm/1wZg+iqlnnozhhzhkE295qZI8aSLRTG70KMAXaMElwIppXNxlzDs92s
 kV08iLUd4I8VAuNxzoFT4RXQJ9KE7WlWB+Mu7rJ++1lnfrzu39OJHatMCkEw4SUJ+xi88UjYg
 ZAqrXgLgf3ZH4ngA7X7f9/7U/p5ldPuO05ggUBCoMD1QRyoDlQBN+I/yt/BRwhuAwowXxXhpl
 J3DVFNa9e7Q1e/L5C3P7pLb9dubF22aeXphsuQpUc5mbYwhwn81f42zb1d4P2gDmmkzKHOarC
 Q4/dfKHBdcxjh3veYaB8w6VZ07jEwBrVPE3bRBqMpirEy1gRqIWt4YARQjlZF9G8THaMFz9Fs
 CHIz8ML9ePDTZu87W1A3gn4CA1H0Gtpj/Fel39sYZMe0yWz/+ud1HqSXNDlYHzT6UeJJQG59/
 0zbr+YeMO+MZDj9v1Cm6U5Hkf6+FFBdm3/AKCEcsEZ1wY6X+FKggR9Q/zKWisqczVezxJdqjQ
 V+TiXx5CcT6cJ127QjEej5bRmHk0sct+dwH3e7tvQ+hjMfxgKBWGGfd5FlKoOszsFaDEvXLSU
 v2YUPIoHkSONew1YpIJHJil+ezunvktl5zVzBihMABwv5qJzth9P8PiM3C7BvGSyKL9dK48Xc
 tbUWyyrc7fv6Gr+EE6rkTLGmCGzoyUB9mWaI6zRV6KgBsOfrovYv4yCZbINSaOL1xnh4UdG77
 0G+Cm6pmca3A57YhNVuM2WDNiTN2QfimlZe2YsOyaVNzqOqiNDF568SK6YRSJBzfkp4Kwrwdy
 GOaqrv4cYv58uwpbTWD2ATw3ga1QFI5hNZS/2uSchwDeWs8ym8nrW5/7GqcTIotE1A76ULfcp
 B0j+8Usqhq1tup6/0hizwqAKK8ovAh+68Uii5qhNSJKC8aiDVaQPtO43v8xTjQG6md+1Alvfc
 fnyc2k8Arl5pXyRKRnJbNf2REazJ/GUb/pxeTLlgNJ34Apg7Qd65U+18weMiIAZ7G+31faVGX
 7hUX3EX5KfEkOpxxemmLP+KnvhdNC3o3oAQAS5CRRMeLhweS8HfhR+mFvbG0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 30 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > While `git update-index` mostly ignores paths referring to index entri=
es
> > whose skip-worktree bit is set, in b4d1690df11 (Teach Git to respect
> > skip-worktree bit (reading part), 2009-08-20), for reasons that are no=
t
> > entirely obvious, the `--remove` option was made special: it _does_
> > remove index entries even if their skip-worktree bit is set.
> >
> > Seeing as this behavior has been in place for a decade now, it does no=
t
> > make sense to change it.
>
> If this were end-user facing Porcelain behaviour, even it is a
> decade old, the story would have been different, but given that it
> is in an obscure corner in a plumbing command, I agree that it does
> not make sense to even transition the default over releases.
>
> > +test_expect_success '--ignore-skip-worktree-entries leaves worktree a=
lone' '
> > +	test_commit geroff-me &&
> > +	git update-index --skip-worktree geroff-me.t &&
> > +	rm geroff-me.t &&
>
> I do not see a need to swear with a sample file name.  It may make
> sense to use words that relate to what the test is checking (e.g.
> skip-me or something like that), but otherwise meaningless filenames
> used in other tests (like 1, 2, etc) would be more in line with the
> existing tests.

I changed this locally to `keep-me`. But then I saw that you merged this
patch pair to `next` already... Do you want an add-on patch, or revert
it out of `next`, or leave as-is?

I'd like to know because I still want to merge this into Git for Windows
v2.24.0-rc2, and I would love to deviate as little as possible from
git.git there.

> > +
> > +	: ignoring the worktree &&
> > +	git update-index --remove --ignore-skip-worktree-entries geroff-me.t=
 &&
> > +	git diff-index --cached --exit-code HEAD &&
>
> HEAD has it, working tree does not, and the one in the index should
> have been kept thanks to the new option added by this patch.  Makes
> sense.
>
> > +	: not ignoring the worktree, a deletion is staged &&
> > +	git update-index --remove geroff-me.t &&
> > +	test_must_fail git diff-index --cached --exit-code HEAD
>
> Testing the other side of the coin (i.e. adding the new feature did
> not accidentally stop the command from removing by default) is good;
> "should have no difference" was a good test for the other side, but
> in contrast, "should have some difference" is a very loose test when
> the difference we want to see is that the particular path gets removed
> and no other changes.

True. I changed it to `test_must_fail git rev-parse :keep-me` locally
(to test for the staged deletion, although it just occurred to me that I
would rather want to add the `--diff-filter=3DD` option and filter by the
file name to really verify that a deletion was staged), but again, I
noticed that you already merged this to `next`...

So: revert out of `next`, add-on patch, or leave as-is?

Thanks,
Dscho

>
> > +'
> > +
> >  #TODO test_expect_failure 'git-apply adds file' false
> >  #TODO test_expect_failure 'git-apply updates file' false
> >  #TODO test_expect_failure 'git-apply removes file' false
>
>
