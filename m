Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B8F1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 02:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeCQCJR (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 22:09:17 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45525 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbeCQCJP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 22:09:15 -0400
Received: by mail-wr0-f195.google.com with SMTP id h2so13261529wre.12
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 19:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wssibOZ6SVVHaVUhGUo0sib0bWlLQ1NOXk5vy8ACAd4=;
        b=Xm5SbxiGKnoNcy+GB0iRnqpcaa36y8loerHLKKGIyMlNNOQksOlOvYeYnZIKHpRtzQ
         uFyWIZi8Tm5Ama5MBxEwVmBuIdbRwjpTvAp4A/jhllmqiuIT/xrbUQRj0FuFIf9qN59T
         8ihcHDr14dowsjbdatpw2wRCKBwsx8oxoeONQkhmrzmdek/HVI/rxaE3UN+fezWxqOtC
         C2Eefyuvma9LTQgW83bifDANaf15b1JWYm76/aWdnymPYR5jnKXTDc+iHTxx3S3J8w8w
         IPjwsblV3T4/1UjO9vRJe5HERPrv5j1qaQXyPaDcCo4+Bzx0qxcewYOMpabOseYKVZ3u
         Stzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wssibOZ6SVVHaVUhGUo0sib0bWlLQ1NOXk5vy8ACAd4=;
        b=Rxq+upHyMhrXinyT+iVPBpsR4LbtObQoe8v7r6MUkK1qmKtpoyROahZTrD/i77Slnm
         3BCYirq28s3fqefzhMymj+J41WKZZFlz0nV1RqgDjzuqtveOM+6Ms7L+3fHvsOhT3GOK
         Yva3TQCQQXk5PqX+YpvuxCXe7V1ZG90oqeH6klkApMLvGXUJlAHJEiv2X7FbGb/ZYYSj
         36qvlSQWAukmCW+owR9sGaQnaBl3JoKZ/DE53QCyAeVP2Woss9aY36gHNkJ2ses/sdLP
         J20YWAaVSvK0vxo1YWVeqju9qaX0v0IRsSoEixGXWl4D8gHUemYCD6+00OqBLSSFt8sg
         VODg==
X-Gm-Message-State: AElRT7H001pGsV7E+fi8Od6lkCnEMaGFPg+l52Si5WHPPXlVTza/yJgq
        7qVEejUSpTx4a2cJw3B33VY=
X-Google-Smtp-Source: AG47ELuMYLrK21uWU2dngL/BFTT6CTzKe89+MybA3QqSUtqzhvhB8Mk4BFHe/iZ3LRsZAZBFCecnLA==
X-Received: by 10.223.135.148 with SMTP id b20mr3259372wrb.100.1521252554438;
        Fri, 16 Mar 2018 19:09:14 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id m190sm9000626wmb.6.2018.03.16.19.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 19:09:13 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com> <87vadyd9az.fsf@javad.com>
 <d5e68db4-8006-2c0e-bc21-0b136503edd9@gmail.com>
Message-ID: <d50a4099-9b3a-5aa9-c304-160c62330056@gmail.com>
Date:   Sat, 17 Mar 2018 03:08:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d5e68db4-8006-2c0e-bc21-0b136503edd9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/03/2018 00:11, Igor Djordjevic wrote:
> 
> > > > Second side note: if we can fast-forward, currently we prefer
> > > > that, and I think we should keep that behavior with -R, too.
> > >
> > > I agree.
> > 
> > I'm admittedly somewhat lost in the discussion, but are you
> > talking fast-forward on _rebasing_ existing merge? Where would it
> > go in any of the suggested algorithms of rebasing and why?
> > 
> > I readily see how it can break merges. E.g., any "git merge
> > --ff-only --no-ff" merge will magically disappear. So, even if
> > somehow supported, fast-forward should not be performed by default
> > during _rebasing_ of a merge.
> 
> Hmm, now that you brought this up, I can only agree, of course.
> 
> What I had in my mind was more similar to "no-rebase-cousins", like 
> if we can get away without actually rebasing the merge but still 
> using the original one, do it. But I guess that`s not what Johannes 
> originally asked about.
> 
> This is another definitive difference between rebasing (`pick`?) and 
> recreating (`merge`) a merge commit - in the case where we`re rebasing, 
> of course it doesn`t make sense to drop commit this time (due to 
> fast-forward). This does make sense in recreating the merge (only).

Eh, I might take this back. I think my original interpretation (and 
agreement) to fast-forwarding is correct.

But the confusion here comes from `--no-ff` as used for merging, as 
opposed to `--no-ff` as used for rebasing. I _think_ Johannes meant 
the latter one.

In rebasing, `--no-ff` means that even if a commit inside todo list 
isn`t to be changed, do not reuse it but create a new one. Here`s 
excerpt from the docs[1]:

  --no-ff
    With --interactive, cherry-pick all rebased commits instead of 
    fast-forwarding over the unchanged ones. This ensures that the 
    entire history of the rebased branch is composed of new commits.

    Without --interactive, this is a synonym for --force-rebase.


So fast-forwarding in case of rebasing (merge commits as well) is 
something you would want by default, as it wouldn`t drop/lose 
anything, but merely reuse existing commit (if unchanged), instead of 
cherry-picking (rebasing) it into a new (merge) commit anyway.

The same goes for this part:

> > > > If the user wants to force a new merge, they simply remove that
> > > > -R flag.

This means that using `-R` flag is sensitive to `--no-ff` rebase 
option, original merge commit _reused_ (fast-forwarded) when possible 
(unchanged, and `--no-ff` not provided), or original merge commit 
_rebased_ (when changed, or `--no-ff` provided).

If `-R` flag is removed, then merge commit is always _recreated_, no 
matter if `--no-ff` option is used or not.

p.s. I`m still a bit opposed to `-R` flag in the first place, as 
discussed elsewhere[2][3], but that`s unrelated to this fast-forward 
discussion.

Related to it, though, if `pick` command would be used instead of 
`merge -R` to signal merge commit _rebasing_, it would fit into 
existing logic nicely, where `pick` is already sensitive to `--no-ff` 
option (for rebasing regular commits). Then `merge` alone could be 
naturally (and only) used for _recreating_ merge commits, as 
originally intended (and intuitively expected).

Regards, Buga

[1] https://git-scm.com/docs/git-rebase#git-rebase---no-ff
[2] https://public-inbox.org/git/77b695d0-7564-80d7-d9e6-70a531e66eda@gmail.com/
[3] https://public-inbox.org/git/a3d40dca-f508-5853-89bc-1f9ab393416b@gmail.com/
