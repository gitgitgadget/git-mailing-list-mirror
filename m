Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25848200B9
	for <e@80x24.org>; Mon,  7 May 2018 21:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeEGVdZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 17:33:25 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35428 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbeEGVdY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 17:33:24 -0400
Received: by mail-wr0-f174.google.com with SMTP id i14-v6so27010049wre.2
        for <git@vger.kernel.org>; Mon, 07 May 2018 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ThU/RY8ctFkADlnMdy1FIyZGxYfXmhLiAULCp3Nxzyo=;
        b=tydiJ/hhoPgUozwkjkWKD6ghKkSAQHUUXrSbRI1LUuGS6y//vF0bhh5UzIhPlJeUCt
         JMlhEOYdwq3ijcTqAZIkf5kyYTd0Uo7gSi3UujFt3HPOpoOv3XKR/K1IvNijcBuzism0
         z5ZFHEl68vjnZaG+cERIefUeylqQRtyTZIDSxxjOI246bg9OaJqFrUvxNa4KHdIP9Lmk
         V03Tbqh9r8Xf6OQcSipWYf/BlAL23QOQ2LRHbRLxtmgVyJELXRGvIlwyTnr9/+ofQhJo
         CeavLbxgBR/yKYPVFpvwDsn8iJ7CaqxIUbpbERnL9VZWM1Ekb9Hgxav8MO4jc/zylnc0
         HbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ThU/RY8ctFkADlnMdy1FIyZGxYfXmhLiAULCp3Nxzyo=;
        b=Xu92OmLrqD9iC7lLOh09FK8JvTQyQgZmcqKMN470dDSQghtAjNd0iCAoIajADJviJE
         BV4JGzS1ttbmx48I+A4wKVaT5VbyAar1m8DH8HisSK2hbn4ps7RdHtK/CRxj8z+J3A/k
         cLlEuVMVzUDA+U3l+Jv8Em8tDxi8mVjudRCZ3Q5hl0jIFaobDvpf5H6b/tVlqoKuolj/
         yaSVefKfaitsaPzrpD+FaKyowd/ZCss4rTJO7S3R4/6MyG0SjhThU3Bx2Wr8X5dKl49C
         dC744ozUT+oJX8FoIFk415KVcKLcARzyxzNPTsKPcLlQc5IO0ksau/Ee3ZY7nPaRYq+L
         vE0Q==
X-Gm-Message-State: ALQs6tD/WL6hEJ9GYw/ovh88Xt6Xa64/lJ6h7R/xsLJWX3vpVn+xW8Eo
        YM/MCeJd2NC8y8lBhiRqvkw=
X-Google-Smtp-Source: AB8JxZpa3niW3lcHvPZK/T8YerVX8Sn17WN0gYIgQJjEwb+PNWH+eDvxWJicXl8hzopr1m8R2Nxvlg==
X-Received: by 2002:adf:c188:: with SMTP id x8-v6mr22195190wre.84.1525728803112;
        Mon, 07 May 2018 14:33:23 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.177.115])
        by smtp.gmail.com with ESMTPSA id c50-v6sm33056126wrc.11.2018.05.07.14.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 14:33:22 -0700 (PDT)
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
 <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet>
 <20180507074843.GC31170@sigill.intra.peff.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <3cefc6b3-3dbd-9cb1-20d0-193116191726@gmail.com>
Date:   Mon, 7 May 2018 23:33:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507074843.GC31170@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/05/2018 09:48, Jeff King wrote:
> 
> > > Let's, please, not fall into the trap of polluting git-branch with
> > > utterly unrelated functionality, as has happened a few times with
> > > other Git commands. Let's especially not do so merely for the sake of
> > > tab-completion. git-branch is for branch management; it's not for
> > > diff'ing.
> >
> > I totally disagree. `git branch` is *the* command to work with branches.
> > Yes, you can manage branches. But you can also list them. And now you can
> > also compare them.
> 
> One of the things I don't like about "git branch --diff" is that this
> feature is not _just_ about branches at all. E.g., I could do:
> 
>   git tbdiff HEAD~10 HEAD~5 foo
> 
> Or even:
> 
>   git tbdiff v2.16.0 v2.17.0 my-rewritten-v2.17.0
> 
> Those arguments really are just commitishes, not necessarily branches.
> One of the current interface rules for "git branch" is that the branch
> names we hand it are interpreted _exactly_ as branch names. You cannot
> "git branch -m v2.16.0", and there is no ambiguity in "git branch -d
> foo" if "foo" is both a tag and a branch.
> 
> But this new mode does not fit the pattern at all.
> 
> If we were to attach this to an existing command, I think it has more to
> do with "diff" than "branch". But I'm not sure we want to overload
> "diff" either (which has traditionally been about two endpoints, and
> does not really traverse at all, though arguably "foo...bar" is a bit of
> a cheat :) ).
> 
> > > Of the suggestions thus far, Junio's git-topic-diff seems the least
> > > worse, and doesn't suffer from tab-completion problems.
> >
> > Except that this is too limited a view.
> 
> Right, I agree with you. Topic branches are the intended use, but that's
> not what it _does_, and obviously it can be applied in other cases. So
> since "branch" is too specific, I think "topic branch" is even more so.
> 
> It's really "diff-history" or something, I think. That's not very
> catchy, but I think the best name would imply that it was diffing a set
> of commits (so even "diff-commit" would not be right, because that again
> sounds like endpoints).

This is exactly what I feel as well, thanks for concise and 
to-the-point spelling out.

From user interface perspective, I would expect something like this 
to be possible (and natural):

(1) git diff topic-v1...topic-v2
(2) git diff --branch topic-v1...topic-v2

(1) is what we are all familiar with, providing a diff between two 
revisions with focus on file changes, where (2) shifts focus to 
history changes.

It`s all still a comparison between two revisions (pointed to by 
"topic-v1" and "topic-v2" branch heads in this specific example), but 
it differs in what we are comparing - (1) set of files contained in 
endpoints, or (2) set of revisions contained in (or "leading to") 
endpoints.

Hmm... what about `git diff --history`? :/ It does seem more "true" 
to what it does, though I still like `git diff --branch` more 
(catchier, indeed).

Regards, Buga
