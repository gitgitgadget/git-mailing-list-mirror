Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3FD1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 00:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeCOAJx (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 20:09:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35536 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCOAJw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 20:09:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id x7so7247863wmc.0
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 17:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nm70vkHWgiRCmgHDd8SZbm8/SkR7dvDCTZbVLv1+mak=;
        b=cJSHMDWPfz9YegilkeKzrgfZJgHjalMBF93VmeHgvE7iKDNxzLyIggRrRjbhZ+v1NE
         wHpmgCB1Jl8aJZUR451oK01E4HfNKgJSPB1aAgYkiHF5ceUmo1QOuIV3Bm7BDKYgESLU
         nqo8+9mlV9ufsnxC1ZPx9EXaOILj7/0avGA40DPtc+05cbeUbhJkYxamVGCVKKLuOHO7
         mMkWFkVWMhZQkdBlbHGrIf5rkrIHtpFzBpzJVUm2Q+gaV4eVWdD4eitrH8G2JrcPmTLF
         9gj7shVtBAsN9Ywzn2jOBe9PMdxlKwtueZc3g1aInP0StlBw0ZmE0JYrJfWNEQpIUzro
         EILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nm70vkHWgiRCmgHDd8SZbm8/SkR7dvDCTZbVLv1+mak=;
        b=ivqDnrKx7yFTTlCV8EP1Kb4ew6YMNAnFutlUbyn7HyUi444OrgIXDcF/uLi20KE3XB
         C6g7ZWvzqoHTbmNmH+B0H6+tsOqhDI6tJValZkxojy/VOaSp2Id5BgOy2j+sTJQPNn+/
         ATf8eiQwfEusncujmNEipaoVf2eJzJ7Xx+KjuLAw4Xu2e+Aw4BuVD0RLsJNk0Gfs8py1
         z4YZyXap/PpHFR/Yglu/5Wo0cwfJSJ2apkp0VEFdT7+HjceEeFGCQkUarUePA4d7e0um
         lF6rj1j2fxAh4tuswmf7awMO4jfA/9nu4EP4OhFJR9R9CUufJK3nqdfnX8btxQRCCIso
         pA2w==
X-Gm-Message-State: AElRT7FZ0Ti7sMHUlOyf1eJ3UeFB91urN78WGS82x6aK1LYSwq9UD9gN
        Rt3XhxAeGMaZ6COBaEBpI7g=
X-Google-Smtp-Source: AG47ELs/t0R+MNLXPvk90nqvrLsV9A5pNQBxUT/GnYaq0qlTUbNnA9eXrC4x9ycHWif8HTUYlV/OYg==
X-Received: by 10.28.59.130 with SMTP id i124mr2924592wma.23.1521072591194;
        Wed, 14 Mar 2018 17:09:51 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 198sm4431898wmg.8.2018.03.14.17.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 17:09:50 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
 <877eqgardi.fsf@javad.com> <3f2209e0-c560-5384-c589-3aa83615d688@gmail.com>
 <87efkn6s1h.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <de063fba-2882-6194-a889-ad3e9b6b02b9@gmail.com>
Date:   Thu, 15 Mar 2018 01:09:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87efkn6s1h.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 14/03/2018 08:21, Sergey Organov wrote:
> 
> There are still 2 issues about the implementation that need to be
> discussed though:
> 
> 1. Still inverted order of the second merge compared to RFC.
> 
> It'd be simple to "fix" again, except I'm not sure it'd be better, and
> as there is no existing experiences with this step to follow, it
> probably should be left as in the original, where it means "merge the
> changes made in B' (w.r.t B) into our intermediate version of the
> resulting merge".
> 
> The original Phillip's version seems to better fit the asymmetry between
> mainline and side-branch handling.
> 
> The actual difference will be only in the order of ours vs theirs in
> conflicts though, and thus it's not that critical.

Shouldn`t this be easy to solve just by changing the order of <head> 
and <remote>, on passing to `git merge-recursive`, if needed? (or 
that`s what you meant by "simple to fix"?)

> 2. The U1' == U2' consistency check in RFC that I still think is worth
> to be implemented.

At the moment, I think we`d appreciate test cases where it actually 
proves useful, as the general consensus seems to be leaning towards 
it possibly being annoying (over-paranoid).

> In application to the method being discussed, we only need the check if
> the final merge went without conflicts, so the user was not already
> involved, and the check itself is then pretty simple:
> 
>  "proceed without stop only if $tree = $tree_U1'"
> 
> Its equivalence to the U1' == U2' test in the RFC follows from the fact
> that if M' is non-conflicting merge of U1' and U2', then M' == U1' if
> and only if U2' == U1'.

Nicely spot! I`m glad there`s still (kind of) former U1' == U2' check 
in this approach, too, in case it proves useful :)

> Finally, here is a sketch of the implementation that I'd suggest to
> use:
> 
> git-rebase-first-parent --onto A' M
> tree_U1'=$(git write-tree)
> git merge-recursive B -- $tree_U1' B'
> tree=$(git write-tree)
> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')
> [ $conflicted_last_merge = "yes" ] ||
>   trees-match $tree_U1' $tree || 
>   stop-for-user-amendment

Yes, in case where we would want the "no-op merge" check (equivalent 
to U1' == U2' with original approach), this aligns with something I 
would expect.

Note that all the "rebase merge commit" steps leading to the check 
will/should probably be observed as a single one from user`s perspective 
(in worst case ending with nested conflicts we discussed), thus 
`$conflicted_last_merge` is not related to `merge-recursive` step(s) 
only, but `rebase-first-parent`, too (just in case this isn`t implied).

Might be easier to reason about simply as `[ $conflicts = "yes" ] || `

> where 'git-rebase-first-parent' denotes whatever machinery is currently
> being used to rebase simple non-merge commit. Handy approximation of
> which for stand-alone scripting is:
> 
> git checkout --detach A' && git cherry-pick -m 1 M
> 
> [As an interesting note, observe how, after all, that original Johannes
> Sixt's idea of rebasing of merge commit by cherry-picking its first
> parent is back there.]

Heh ;) It`s always a bit enlightening when people start from different 
positions, opposing ones, even (or so it may seem, at least), but 
eventually end up in the same place, through means of open (minded) 
discussion.

Regards, Buga
