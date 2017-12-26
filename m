Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB4B1F404
	for <e@80x24.org>; Tue, 26 Dec 2017 23:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbdLZXbK (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 18:31:10 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34633 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdLZXbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 18:31:09 -0500
Received: by mail-wr0-f181.google.com with SMTP id 36so2245469wrh.1
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 15:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WOFg0coOvZT3k/8rYyK3/YCQ+Ly+TVIfQc+nzEQv2m8=;
        b=bzi717qsRBAbcCv0JzbZNQy7xz1Q5dIlg4gjsBAr+nzhnenkxhZaXiTnC3jKe81wcr
         AotFdAj7g48kZ/BVNkVdJiKUFh70G9DzNdClGKxjLRfdps64z4I4az5LX2RihdkPWgqU
         xsvgba/TdvCUl7FVSrzkNX/3s0r0XJQ79KbnLm0E0csiRRSZVUQ4+pUiBb1vDVbIrDqM
         Objp4PKezfoRqOagITHqQG3cUfqB84N/KFI9dNlzBqnOIhMeTrLk02bXOo7kYbhlJA9e
         gzsqhp5UOIqbXCGNi5ov4sXwgEGruDlDcXpUbip7BSM5I+OgspjrdxGIKFavyCVrutOr
         VsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WOFg0coOvZT3k/8rYyK3/YCQ+Ly+TVIfQc+nzEQv2m8=;
        b=t5vZ/ijlYWNxcalcgtZKJzFmP+Fa1vXoWlZhTCSEDY8oFi8DkKj6TIFTgR9eZyIzQz
         gs6Zn2IbzqNrmIkN6UNPUd6sZz3pYs3yJ2tZkjxnuVcMLf+lrsg+tyT40YzSfAq7TomQ
         PsdQjP8gLbGgJvBHCXJS+4U5Hk+ogGXfTswdw4AyI86g3y15ogQRswi4Zv5Svw676OfE
         nndMZWHlzmVvqTfZs2ChQFb4VvZDBCzzxLAakaAE9IVBGjSh4nVdycEP4WgUwfg/N4mE
         CqtcR5K0lbZ8Ewu3eilysBj3LWu8P4zqkTnjh9XLuwte3YMJpeqvoQ/66pWdEu38n5MP
         g/EQ==
X-Gm-Message-State: AKGB3mIs4ohhihrIYhWBCrMkTnDEOwysuKCSHPFVNmPS9icT/3j26CAx
        hkz11Mkalq+uR2Ts35pv9XSBpRbLtPE=
X-Google-Smtp-Source: ACJfBouzlgpnABZ3UE+ZM01Xnj6rzl+7ZfDN4m9B0p8tq5Eo+DX1aY8hfEEKqkcaM7iavjggDhJ/Cg==
X-Received: by 10.223.161.208 with SMTP id v16mr24273780wrv.103.1514331067514;
        Tue, 26 Dec 2017 15:31:07 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id f19sm7832760wmf.5.2017.12.26.15.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 15:31:06 -0800 (PST)
Subject: Re: Bring together merge and rebase
To:     Jacob Keller <jacob.keller@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <877etds220.fsf@evledraar.gmail.com>
 <20171223210141.GA24715@hpz.ecbaldwin.net>
 <87608xrt8o.fsf@evledraar.gmail.com>
 <20171226001622.GA16219@Carl-MBP.ecbaldwin.net>
 <CA+P7+xp9v8adrbF7JUYa3X+PvurHiW1QNTnodJt6-vyB3_dWAQ@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <c03c67f2-7d2c-da94-08f8-48c41c2a55ed@gmail.com>
Date:   Wed, 27 Dec 2017 00:30:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xp9v8adrbF7JUYa3X+PvurHiW1QNTnodJt6-vyB3_dWAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Very interesting topic, just this one part I wanted to comment on:

On 26/12/2017 02:28, Jacob Keller wrote:
> 
> What about some way to take the reflog and turn it into a commit-based
> linkage and export that? Rather than tying it into the individual
> commit history, keep track of it outside the commit, possibly via
> something like notes, or some other mechanism.

This seems like the most useful approach, might be not touching reflog 
per se, but having some kind of "cherry-picked commits source" log 
(where rebasing is a subset of cherry-picking). What Johannes 
mentioned, a mapping between "old" and "new" commits. Might be notes 
could fit in nicely, but I`m not competent to comment on that at the 
moment.

For me, the most interesting use case is not even tied to code review 
(thus no review comments to think about), but a situation where one 
might be rebasing a set of downstream patches on top of updating 
upstream - it might be possible for a bug to slip through due to some 
upstream changes, even where there are no conflicts and test suite is 
executed regularly (might be test reveling the bug is yet to be added).

In that situation, instead of just going back in "regular" history 
(single dimension) and eventually finding the offending (rebased) 
commit (its N-th rebased version, that is), it might be great to 
actually keep drilling down the "rebase history" now (second 
dimension), finding the exact rebase iteration / rebased commit 
version where the error first appeared.

Carl, you described this well in your document[1], and Johannes 
provided a valuable first-hand experience[2] from working around the 
very same native Git limitation for years, mentioning using (fragile, 
costly and not very automatible) rebased commits message search to 
drill down the second dimension (rebase iterations), which seems to 
be the only possible approach at the moment, with "vanilla" Git, at 
least.

So this might be much more interesting case, if code review one is 
less appropriate because of review comments being also relevant to 
commit rebase iterations (which should be then stored somewhere, too, 
relating to corresponding commits, not to lose context).

Regards, Buga

p.s. "Merging rebase" and "shears.sh" script[3] seem to be orthogonal 
to this - really great on their own in improving rebase itself and 
making it smarter and much more powerful and useful, where I guess 
they would benefit from native Git "cherry-picked (rebased) commits 
iterations tracking" (old/source <> new/destination commit mapping), 
too, as would other Git tools.

[1] http://blog.episodicgenius.com/post/merge-or-rebase--neither/
[2] https://public-inbox.org/git/20171226040843.h7o6txkrp6zlv7u5@glandium.org/T/#m2e5079488bed2968d4ea52a10051a06c06ff61e0
[3] https://github.com/git-for-windows/build-extra/blob/af9cff5005/shears.sh#L12-L18
