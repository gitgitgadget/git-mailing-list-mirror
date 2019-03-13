Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54BCF20248
	for <e@80x24.org>; Wed, 13 Mar 2019 03:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfCMDRy (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 23:17:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40819 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfCMDRx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 23:17:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id f11so332923qti.7
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SKRMg1TIiVgjaHsaAjyKRv7AnFrdH+hmNXyMxrXRFb8=;
        b=u0BcD2bstzam10ksI9nkhtxd2ifCX1fNrFZreWaG+Bz8NCIhE9j8qizYKIZsZK80to
         KpeP6HgWfJX4RJtOcwsQhvVjY+p2HjPhYF5atM7kUPj3DOy8SCLPvITFwGtHaTv4ExNp
         varZR4tSh3SMZavV19PxHeMXVlHYicwoBhF0sljezNCKPzERRNDS0Mu7hwUhoxelRkJn
         qne5AvDKaFqZTRmH0JG/ceLZ5wQlorLtLYgbcYHkU43i6Rs/HaOHwU4XHZyxjt0DhOMl
         XjKmgJ22VS9D106ujUhfXttQFdkEUEBAye6AmkFNDpj1+Fn2GtRBeno02F1nqnQ6AS58
         t+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SKRMg1TIiVgjaHsaAjyKRv7AnFrdH+hmNXyMxrXRFb8=;
        b=WWU8oCX8w6U0PAgvqmR3EVUKP0RbvUZ6t8lhthkje21hNWnSfn4NCVNLItfkXOaZaJ
         zTw3x5b5XmlqkBUVPUyBdPx3yuhiy/RhLkNojT2pl/WwjdYAZG746jdLN2EsNfpBESTQ
         Qw7nB0ZhFKEte8S/vqs99uaEKWNZ+ZpHsH4pS7DXaNqbBlvRkuD4CVhHeFFcYK73dCJS
         5eyvlH6/dCZVzfvD8ApXc6M7U7cz8gRaYkGTwEQLIayXasB7afIfZ94pvSnezjIB50Rl
         3SuFmr3GqicHfxSUq9eMIiGcA7ip5Kx0132TEzjfTC6IAuDLDE3pMw2aSEhl4Kcq8S5Z
         U2Og==
X-Gm-Message-State: APjAAAUsOjtZRVHalt8firrpq5JBr8Xetw8wk38WXTX3HGyXytqRWMFz
        bYyMC2xvab4mpIpP1YbA5gaQwA==
X-Google-Smtp-Source: APXvYqyGHzdhN2qB9nHELgRZSo2tJR08X4sujokjc5vqgT14bIe5081EV22XTbu9Ri0QNaO9saeYBQ==
X-Received: by 2002:ac8:2ed4:: with SMTP id i20mr4384013qta.52.1552447071804;
        Tue, 12 Mar 2019 20:17:51 -0700 (PDT)
Received: from ?IPv6:2804:14c:81:942d::1? ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id e85sm257211qkj.58.2019.03.12.20.17.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 20:17:51 -0700 (PDT)
Subject: Re: [RFC PATCH v3 1/5] clone: test for our behavior on odd objects/*
 content
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
 <20190226122829.19178-2-avarab@gmail.com>
 <CAHd-oW71N94vBvN4wYQVzXyUZjvVs3Ca9tM3VUEuqB66YNGDtA@mail.gmail.com>
 <87o96uvh4x.fsf@evledraar.gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Message-ID: <2e2b8ac6-86e8-1820-89fa-2b04a9ce8151@usp.br>
Date:   Wed, 13 Mar 2019 00:17:47 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87o96uvh4x.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Ævar

First of all, I must apologize for my very late reply. I just got back 
from a trip and only now have been able to look again at this series.

On Fri, Mar 1, 2019 at 10:49 AM Ævar Arnfjörð Bjarmason 
<avarab@gmail.com> wrote:
 >
 >
 > On Thu, Feb 28 2019, Matheus Tavares Bernardino wrote:
 >
 > > Hi, Ævar
 > >
 > > I'm finishing the required changes in this series to send a v4, but
 > > when submitting to travis ci, I got some errors on the
 > > t5604-clone-reference test:
 > > https://travis-ci.org/MatheusBernardino/git/builds/500007587
 >
 > I don't have access to an OSX box, but could reproduce the failure on
 > NetBSD.
 >
 > It's because there link() when faced with a symlink behaves
 > differently. On GNU/Linux link()-ing a symlink will produce another
 > symlink like it, on NetBSD (and presumably OSX) doing that will produce
 > a hardlink to the file the existing symlink points to.

Hm, interesting. I installed NetBSD here and played with it a little: It 
seems that the inconsistency comes from the fact that link() follows 
symlinks on NetBSD but not on Linux. i.e., if you have a file "C" 
link()-ed to a file "B" which, in turn, is a symlink to a file "A", 
running "ls -li A B C" we can see that:
- On linux, C points to B's inode
- On NetBSD, C points to A's inode

 > I've pushed out a version of mine here which you might want to pull in:
 > https://github.com/git/git/compare/master...avar:clone-dir-iterator-3
 >
 > I.e. this whole thing is silly, but just preserving the notion that
 > we're not going to introduce behavior changes as we're refactoring.
 >
 > So it adds a commit right after the tests I added to detect this case,
 > and use symlink() or link() as appropriate instead of link().

I think this still modifies [a little] the current behaviour, since 
symlink() will make dest->buf point to a new inode (which will be a 
symlink just as src->buf, but on a different inode) while the current 
behaviour, on Linux, is to have dest->buf being a hardlink to src->buf 
(same inode). I don't know if this sentence got too confuse, but what I 
meant is that symlink() will make a symlink at dest->buf while link(), 
on linux, will make a hardlink to the given symlink.

 > There's then a commit at the end you might want to squash in that
 > reproduces this behavior on top of your iterator refactoring.
 >
 > Of course the DIR_ITERATOR_FOLLOW_SYMLINKS flag at this point is rather
 > silly. We're telling it to stat(), and then end up needing both stat()
 > and lstat() data.
 >
 > I'm starting to think that this interface which previously only had one
 > caller, but now has two exists at the wrong abstraction level. I.e. it
 > itself needs to call lstat(). Seems sensible to always do that and leave
 > it to the caller to call stat() if they need, as I believe Duy pointed
 > out.

I see what you mean, but if the caller needs to call stat() itself, in 
the occurrence of a symlink to a directory, it would have to start a new 
directory iteration upon the symlinked dir and its subdirectories (if it 
wants to follow symlinks). This approach could became a little messy, 
IMHO. And just by calling stat() at dir-iterator we already get the 
symlinked directories iterated "for free", without having to modify 
anything else in the code. So I still think it is a good idea to have 
the DIR_ITERATOR_FOLLOW_SYMLINKS flag at dir-iterator, making it call 
stat() instead of lstat().

 > Also noticed that dir-iterator.h still has a comment to the effect
 > that it'll call "lstat()", even though we now have a "stat() or
 > lstat()?" flag.

Thanks for noticing it, I will fix it in v4.

 > > On Tue, Feb 26, 2019 at 9:28 AM Ævar Arnfjörð Bjarmason
 > > <avarab@gmail.com> wrote:
 > >>
 > >> Add tests for what happens when we locally clone .git/objects
 > >> directories where some of the loose objects or packs are symlinked, or
 > >> when when there's unknown files there.
 > >>
 > >> I'm bending over backwards here to avoid a SHA1 dependency. See [1]
 > >> for an earlier and simpler version that hardcoded a SHA-1s.
 > >>
 > >> This behavior has been the same for a *long* time, but hasn't been
 > >> tested for.
 > >>
 > >> There's a good post-hoc argument to be made for copying over unknown
 > >> things, e.g. I'd like a git version that doesn't know about the
 > >> commit-graph to copy it under "clone --local" so a newer git version
 > >> can make use of it.
 > >>
 > >> But the behavior showed where with symlinks seems pretty
 > >> random. E.g. if "pack" is a symlink we end up with two copies of the
 > >> contents, and only transfer some symlinks as-is.
 > >>
 > >> In follow-up commits we'll look at changing some of this behavior, but
 > >> for now let's just assert it as-is so we'll notice what we'll change
 > >> later.
 > >>
 > >> 1. 
https://public-inbox.org/git/20190226002625.13022-5-avarab@gmail.com/
 > >>
 > >> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
 > >> ---
 > >>  t/t5604-clone-reference.sh | 142 
+++++++++++++++++++++++++++++++++++++
 > >>  1 file changed, 142 insertions(+)
 > >>
 > >> diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
 > >> index 4320082b1b..cb0dc22d14 100755
 > >> --- a/t/t5604-clone-reference.sh
 > >> +++ b/t/t5604-clone-reference.sh
 > >> @@ -221,4 +221,146 @@ test_expect_success 'clone, dissociate from 
alternates' '
 > >>         ( cd C && git fsck )
 > >>  '
 > >>
 > >> +test_expect_success 'setup repo with garbage in objects/*' '
 > >> +       git init S &&
 > >> +       (
 > >> +               cd S &&
 > >> +               test_commit A &&
 > >> +
 > >> +               cd .git/objects &&
 > >> +               >.some-hidden-file &&
 > >> +               >some-file &&
 > >> +               mkdir .some-hidden-dir &&
 > >> +               >.some-hidden-dir/some-file &&
 > >> +               >.some-hidden-dir/.some-dot-file &&
 > >> +               mkdir some-dir &&
 > >> +               >some-dir/some-file &&
 > >> +               >some-dir/.some-dot-file
 > >> +       )
 > >> +'
 > >> +
 > >> +test_expect_success 'clone a repo with garbage in objects/*' '
 > >> +       for option in --local --no-hardlinks --shared --dissociate
 > >> +       do
 > >> +               git clone $option S S$option || return 1 &&
 > >> +               git -C S$option fsck || return 1
 > >> +       done &&
 > >> +       find S-* -name "*some*" | sort >actual &&
 > >> +       cat >expected <<-EOF &&
 > >> +       S--dissociate/.git/objects/.some-hidden-file
 > >> +       S--dissociate/.git/objects/some-dir
 > >> +       S--dissociate/.git/objects/some-dir/.some-dot-file
 > >> +       S--dissociate/.git/objects/some-dir/some-file
 > >> +       S--dissociate/.git/objects/some-file
 > >> +       S--local/.git/objects/.some-hidden-file
 > >> +       S--local/.git/objects/some-dir
 > >> +       S--local/.git/objects/some-dir/.some-dot-file
 > >> +       S--local/.git/objects/some-dir/some-file
 > >> +       S--local/.git/objects/some-file
 > >> +       S--no-hardlinks/.git/objects/.some-hidden-file
 > >> +       S--no-hardlinks/.git/objects/some-dir
 > >> +       S--no-hardlinks/.git/objects/some-dir/.some-dot-file
 > >> +       S--no-hardlinks/.git/objects/some-dir/some-file
 > >> +       S--no-hardlinks/.git/objects/some-file
 > >> +       EOF
 > >> +       test_cmp expected actual
 > >> +'
 > >> +
 > >> +test_expect_success SYMLINKS 'setup repo with manually symlinked 
objects/*' '
 > >> +       git init T &&
 > >> +       (
 > >> +               cd T &&
 > >> +               test_commit A &&
 > >> +               git gc &&
 > >> +               (
 > >> +                       cd .git/objects &&
 > >> +                       mv pack packs &&
 > >> +                       ln -s packs pack
 > >> +               ) &&
 > >> +               test_commit B &&
 > >> +               (
 > >> +                       cd .git/objects &&
 > >> +                       find ?? -type d >loose-dirs &&
 > >> +                       last_loose=$(tail -n 1 loose-dirs) &&
 > >> +                       mv $last_loose a-loose-dir &&
 > >> +                       ln -s a-loose-dir $last_loose &&
 > >> +                       first_loose=$(head -n 1 loose-dirs) &&
 > >> +                       (
 > >> +                               cd $first_loose &&
 > >> +                               obj=$(ls *) &&
 > >> +                               mv $obj ../an-object &&
 > >> +                               ln -s ../an-object $obj
 > >> +                       ) &&
 > >> +                       find . -type f | sort 
 >../../../T.objects-files.raw &&
 > >> +                       find . -type l | sort 
 >../../../T.objects-links.raw
 > >> +               )
 > >> +       ) &&
 > >> +       git -C T fsck &&
 > >> +       git -C T rev-list --all --objects >T.objects
 > >> +'
 > >> +
 > >> +
 > >> +test_expect_success SYMLINKS 'clone repo with symlinked objects/*' '
 > >> +       for option in --local --no-hardlinks --shared --dissociate
 > >> +       do
 > >> +               git clone $option T T$option || return 1 &&
 > >> +               git -C T$option fsck || return 1 &&
 > >> +               git -C T$option rev-list --all --objects 
 >T$option.objects &&
 > >> +               test_cmp T.objects T$option.objects &&
 > >> +               (
 > >> +                       cd T$option/.git/objects &&
 > >> +                       find . -type f | sort 
 >../../../T$option.objects-files.raw &&
 > >> +                       find . -type l | sort 
 >../../../T$option.objects-links.raw
 > >> +               )
 > >> +       done &&
 > >> +
 > >> +       for raw in $(ls T*.raw)
 > >> +       do
 > >> +               sed -e "s!/..\$!/X!; s!/../!/Y/!; 
s![0-9a-f]\{38,\}!Z!" <$raw >$raw.de-sha || return 1
 > >> +       done &&
 > >> +
 > >> +       cat >expected-files <<-EOF &&
 > >> +       ./Y/Z
 > >> +       ./a-loose-dir/Z
 > >> +       ./an-object
 > >> +       ./Y/Z
 > >> +       ./info/packs
 > >> +       ./loose-dirs
 > >> +       ./pack/pack-Z.idx
 > >> +       ./pack/pack-Z.pack
 > >> +       ./packs/pack-Z.idx
 > >> +       ./packs/pack-Z.pack
 > >> +       EOF
 > >> +       cat >expected-links <<-EOF &&
 > >> +       ./Y/Z
 > >> +       EOF
 > >> +       for option in --local --dissociate
 > >> +       do
 > >> +               test_cmp expected-files 
T$option.objects-files.raw.de-sha || return 1 &&
 > >> +               test_cmp expected-links 
T$option.objects-links.raw.de-sha || return 1
 > >> +       done &&
 > >> +
 > >> +       cat >expected-files <<-EOF &&
 > >> +       ./Y/Z
 > >> +       ./Y/Z
 > >> +       ./a-loose-dir/Z
 > >> +       ./an-object
 > >> +       ./Y/Z
 > >> +       ./info/packs
 > >> +       ./loose-dirs
 > >> +       ./pack/pack-Z.idx
 > >> +       ./pack/pack-Z.pack
 > >> +       ./packs/pack-Z.idx
 > >> +       ./packs/pack-Z.pack
 > >> +       EOF
 > >> +       test_cmp expected-files 
T--no-hardlinks.objects-files.raw.de-sha &&
 > >> +       test_must_be_empty T--no-hardlinks.objects-links.raw.de-sha &&
 > >> +
 > >> +       cat >expected-files <<-EOF &&
 > >> +       ./info/alternates
 > >> +       EOF
 > >> +       test_cmp expected-files T--shared.objects-files.raw &&
 > >> +       test_must_be_empty T--shared.objects-links.raw
 > >> +'
 > >> +
 > >>  test_done
 > >> --
 > >> 2.21.0.rc2.261.ga7da99ff1b
 > >>
