Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B855B1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 01:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeCNBMs (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 21:12:48 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41283 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932634AbeCNBMr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 21:12:47 -0400
Received: by mail-wr0-f194.google.com with SMTP id f14so3064704wre.8
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 18:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QJdig1DXN8MZ2bPu86aQGNED4HG7oU6RHW0wDpUgva0=;
        b=YgeirpFJZsHQYGl7i+WL6t+Y+gXXyuk80JJRgeOFk9B0nTYT4n5/n7dUzMs/Vs+3S2
         8mtfOrZ2at+YK4xzikkscSdat1xX4yW6Z+TmOteWk+oyi7kaQ2pSTlYHt4OKh1sqwqIw
         xVqdsorVO2gRuLH1ypJYwaKTd2MtmgLzAlHtabhNwzqmBWMXLQHprO30tv9CXvZYiqSC
         pmQvSaUX5Qo5l6qq3XLjW33dRHMWLy2cheUTSjXsl7LN8Db0+1lFHwE85JNPTIWWVyiK
         ckOQyv5D3yMzMNmj9Wkb9JFwsvRIIHzMsUchHmL91z/6YXqxtO9/4puyZCwY6YBnDd02
         zrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QJdig1DXN8MZ2bPu86aQGNED4HG7oU6RHW0wDpUgva0=;
        b=MAri5TS4/6bW/b6YCsaNnhk5WgrNphJmqyHW+tGsYnxnCLHsGfP9WUB+TApv36SmeE
         upe7Pz8ItZGJvQlO5LGNUqT11kYurFYGzFQJLYCsQio6+fyEejzKFT4TPSSBPbTmBwla
         CI+TDRECzihg/QYxN0ej2ZNRDT41W9TQFcPZBtlrcBKAK7ZeNUIHEsm9YZ7zFFHu0VRy
         CdG17vDbu/vat6RSrvq681QYqmCww4ajIrgT05RHKXKx2uk+GJG2LFWf6+Ggqf4IaKH5
         kZihL4PPmcsoygR8bh6XPiyB+yIPrXV9wFym0uXZwAbR2FY8c6mCPkiiEVG9vjxEBI/X
         aQiA==
X-Gm-Message-State: AElRT7ENEO05EhkW9rcWEwZhyAKwPQx6Wp9tiNARn7NuPp1+yxI7o7CK
        ILa/SqQZYhjwN4n0u5afKhs=
X-Google-Smtp-Source: AG47ELtMVwEkApU2hf6EYQBJ/9huvpRsiS8ibCGwj0mnVuELy3hQOOw7sZKKToRwrnshTT4S0rMxeg==
X-Received: by 10.223.171.247 with SMTP id s110mr2249510wrc.106.1520989966381;
        Tue, 13 Mar 2018 18:12:46 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id m62sm35616wmi.19.2018.03.13.18.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 18:12:45 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Cc:     phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
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
 <877eqgardi.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <3f2209e0-c560-5384-c589-3aa83615d688@gmail.com>
Date:   Wed, 14 Mar 2018 02:12:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <877eqgardi.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 13/03/2018 17:10, Sergey Organov wrote:
> 
> > Hi Sergey, I've been following this discussion from the sidelines,
> > though I haven't had time to study all the posts in this thread in
> > detail. I wonder if it would be helpful to think of rebasing a merge as
> > merging the changes in the parents due to the rebase back into the
> > original merge. So for a merge M with parents A B C that are rebased to
> > A' B' C' the rebased merge M' would be constructed by (ignoring shell
> > quoting issues)
> >
> > git checkout --detach M
> > git merge-recursive A -- M A'
> > tree=$(git write-tree)
> > git merge-recursive B -- $tree B'
> > tree=$(git write-tree)
> > git merge-recursive C -- $tree C'
> > tree=$(git write-tree)
> > M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB' -pC')
> 
> I wonder if it's OK to exchange the order of heads in the first merge
> (also dropped C for brevity):

It should be, being "left" or "right" hand side ("theirs" or "ours") 
of the three-way merge shouldn`t matter, they`re still both equally 
compared to the merge-base.

> git checkout --detach A'
> git merge-recursive A -- A' M
> tree=$(git write-tree)
> git merge-recursive B -- $tree B'
> tree=$(git write-tree)
> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')
> 
> If so, don't the first 2 lines now read: "rebase (first parent of) M on
> top of A'"?

Hmm, lol, yes...? :) So basically, this:

(1)	git checkout --detach M
	git merge-recursive A -- M A'
	tree=$(git write-tree)
	...

... is equivalent to this:

(2)	git checkout --detach A'
	git merge-recursive A -- A' M
	tree=$(git write-tree)
	...

..., being equivalent to this:

(3)	git checkout --detach A'
	git cherry-pick -m 1 M
	tree=$(git write-tree)
	...

..., where in all three cases that `$tree` is equivalent to U1' we 
discussed about so much already :)

I tested it like this as well, slightly modifying previously sent out 
script (like this one[1]), and it still seems to be working ;) Nice!

> If so, then it could be implemented so that it reduces back to regular
> rebase of non-merges when applied to a single-parent commit, similar to
> the method in the RFC, striking out one of advantages of the RFC.

I guess so, but I think it now boils down only to what one finds 
easier to reason about even more.

I`m just glad we got to U1' from this perspective as well, hopefully 
adding even more faith in the overall concept, being beaten from both 
ends and dropping out to be the same (minus minor implementation details).

Regards, Buga

[1] https://public-inbox.org/git/872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com/
