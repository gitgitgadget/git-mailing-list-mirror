Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46D420C11
	for <e@80x24.org>; Sun,  3 Dec 2017 23:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbdLCXBf (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 18:01:35 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42012 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdLCXBe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 18:01:34 -0500
Received: by mail-wm0-f66.google.com with SMTP id l141so2807511wmg.1
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 15:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=basY/uTRCxlNSo06ATv8mWMMoMwhsAyQu11/srJTfas=;
        b=A37N5ElXhEU77rRitkwjtno/d1k2EZwKF5mVj+0Sn7P39PhcAtqQa4MUz5DvAYG5QK
         BtgeN/ngUknkNL7JZaDI39xIbiZGSAR5Qjs6aUobuZvVVjqXGb37ksguF1Dt3G1KmW4i
         em8aU90E7YCPR/0YARN+5DPGFir4T19bxlKHFLpy9JDv+d3W4tAWNTntp6wODV9yr9tx
         6pw+9YbyVrSVAZKkbTuJu5sVRuH0IIodk4Zuj7ReItsWOmNCM23Uk+0Mis/YaVQSvftc
         O5cZYxVBxjDtFlHG6tigkW83dBe5QhTqjJ0M+gd+p59eWZoOXibWYBbqojXAkEHXK20A
         bWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=basY/uTRCxlNSo06ATv8mWMMoMwhsAyQu11/srJTfas=;
        b=r9pnjS+jwcf1dX1flotLRVLFL7I38AgA3pIrqVOvtLFQ4Hpnva0mHeMYt7Ht7htVyk
         Ir6s13hwfmu73vXSSfppVJjZroxoIgsC4JYzvLjvfV4vQipEwhZQSkjduPJVqX0vyqk+
         ZlPgPAW8PoBNKLfoQNGVc5M8pxzVD3zgMe9YNS5oEE6oPjS3sylJ6QDRZqiQkRosM+O2
         dnMrh7WH9bXzy+G3Fuiu1tpA5t/0HesWp6kI9HAJpixv/He5UecKxGIV0qbNrxTT58PR
         yUmg8ayIFpT3WXOmeOM8LQKYQCc06FIypdwPFskGUtFbTY1uLSYL/jl+9EF0AB55lqa7
         H/rA==
X-Gm-Message-State: AKGB3mIgERa8A5Goqy5O+FmqVlFfjePox9/1NUDyzmjuFbf2Gt1yUOlS
        E1DPjar4gvOwRbB4bL9kCGE=
X-Google-Smtp-Source: AGs4zMYgTPZvjlxqxYp1oVz90WpplOOsNpRvIO3Hg7Ndf9f5WLVBZKBvdLys0m2W6HxuWmPOVxeR4w==
X-Received: by 10.28.127.22 with SMTP id a22mr1615704wmd.12.1512342093078;
        Sun, 03 Dec 2017 15:01:33 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id e132sm2228773wmd.40.2017.12.03.15.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 15:01:31 -0800 (PST)
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
To:     Chris Nerwert <a.lozovsky@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <0F30BEF8-A9F7-43B9-BC89-4B9CD7AF3E16@gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <bfc4df2c-2e31-bb83-832d-92e41d09b976@gmail.com>
Date:   Mon, 4 Dec 2017 00:01:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0F30BEF8-A9F7-43B9-BC89-4B9CD7AF3E16@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On 30/11/2017 23:40, Chris Nerwert wrote:
> 
> I'm actually doing the described workflow quite often with git rebase
> when working on a topic. Given the following structure:
> 
>   ---o               (master)
>       \
>        o---A---B---C (topic)
> 
> When I want to make changes to commit A one option is to make them
> directly on topic, then do "git commit --fixup A", and then eventual
> interactive rebase onto master will clean them up:
> 
>   ---o                     (master)
>       \
>        o---A---B---C---f!A (topic)
> 
> However, sometimes this breaks when changes in B or C conflict
> somehow with A (which may happen quite a lot during development of a
> topic), so the rebase will not apply cleanly. So sometimes I make a
> temporary branch from A, commit the fixup there:
> 
>   ---o               (master)
>       \
>        o---A---B---C (topic)
>             \
>              f!A     (temp)
> 
> and then use "git rebase --onto temp A topic" to move the topic back
> on track:
> 
>   ---o                     (master)
>       \
>        o---A---f!A         (temp)
>                   \
>                    B'---C' (topic)
> 
> after which the final cleanup rebase is much easier to do.
> 
> Obviously, all the branch switching and rebasing does take its tall
> on file modifications.

From use case you described (and which I often experience myself), it 
seems plain "git commit --onto A" would be of help here, committing 
fixup onto A directly, without a need to switch to it (branch or 
not), a case I`m discussing with Hannes in that other sub-thread[1] of 
this e-mail, too.

But from there, your flow takes a different direction, using rebase, 
while this whole thread started around some merge-like functionality.

I can imagine a user interface doing what you (and I) would like, 
something like:

(1) git commit --onto A --rebase

..., where your changes would first be committed onto commit A, and 
then commits from A (excluded) to HEAD (included) rebased onto this 
new commit.

BUT, as far as it seems to me, rebase currently touches working tree 
for each operation (am I wrong here?), so once the rebase sequence is 
initiated, it would internally still need to checkout to your new 
fixup commit (on top of A), and then proceed applying changes and 
changing working tree with each commit being rebased, overall failing 
to address your main concern - needless (untouched) file 
modifications, even in case of no conflicts.

I find this scenario quite interesting as well, but I`m afraid it may 
currently be out of scope of what I`m trying to accomplish with "git 
commit --onto[-parent]", for the most part because it looks like it 
would need "index only rebase" first (not touching working tree, that 
is)...?

If we had that, it would/should be pretty easy to add it into the mix 
with "git commit --onto" here, ending up with something as imagined 
in command line (1) above :) I`ll make a note of it, thanks.

Any further help appreciated, of course :)

Regards, Buga

[1] https://public-inbox.org/git/0F30BEF8-A9F7-43B9-BC89-4B9CD7AF3E16@gmail.com/T/#me830a80d745df60ae8bd6a2e67eee4bd4dabf56c
