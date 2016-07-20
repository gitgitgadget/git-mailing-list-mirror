Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6E3202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 14:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbcGTOzj (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 10:55:39 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36750 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbcGTOzh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 10:55:37 -0400
Received: by mail-io0-f181.google.com with SMTP id b62so49659755iod.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 07:55:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+frzwJogDiP2ch2FgxohFtcA0kHqpWHkJX0oB/GgZSQ=;
        b=Etd+KgF6pH8q2IOB1eZHL0PM6QO97rfNzupTPYPQy4QR5GMsn+bZH+p2x0mxPmlSev
         bfdKTosLvv2S8XhtZffM6a3ky6ZEokofr66YV3Xylct/2UlxGb1tuGKn5n8uoCAL/puJ
         2iEfi33SLJZQGOcPLoNPebY5hnTqZ62a6gqxLKUqr4x3JQvjDn9cYJKz999quChlXMBA
         Tub7BUa1Fet1M+GA8Z76wN9bfi5FeaSZRfNmjzWZ2pEJAc+xNlSAp+6Cdft5T8lVZp/B
         LnsJMuqV6/kStWAhWzl9OGS5vjclWDhHy0SFch6u/U3u3FzZHXqz/o5gFwkO0Ry15aq+
         kj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+frzwJogDiP2ch2FgxohFtcA0kHqpWHkJX0oB/GgZSQ=;
        b=IOmKCsO53CKjH4aeGTjeI5YPJgfSJz2H57KfBx3/nJV959C46irpST5Sq94zxUet+y
         8sd5iKAPP0ILmZttt4mN/0R8vevXlmnZj2F+DqnY7WiozAe+7Ed1rXq0tx13EexB6sbd
         E6zLPcB2JSrxT6jEDyihVeAlHFNqwPJxTvq/QDvsla5eTCrUv3T+4ATL4XDDCA/KfOR+
         VLL8Pxpeb/eqi+bpuZ6XihOttkk6V6XUEtGkD3I63Ovy31EsXPlRdMVlPawscOaGYmZR
         98H/c3sBmqEGQIYCEhUJfDEp9KRVH51rbGJ+sE85OUxxnePVsm9LwvuoImWGsPmY7QQx
         X5mQ==
X-Gm-Message-State: ALyK8tLykfTRli9Vdf8jNawat+9Rx7gdxv/cAbf4q8CMyHJmgmCSTeNf8GwVT83NzL6NafRsIydNn/tu3wdNhg==
X-Received: by 10.107.8.140 with SMTP id h12mr47018822ioi.95.1469026509937;
 Wed, 20 Jul 2016 07:55:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 20 Jul 2016 07:54:40 -0700 (PDT)
In-Reply-To: <20160719193523.GD28551@kwain>
References: <20160719144701.571-1-antoine.tenart@ack.tf> <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BDRPK2UKxoMat3i2HL38+KFqw2Qfet2Bev26HXRM-BWA@mail.gmail.com>
 <20160719185452.GB28551@kwain> <CACsJy8AkpBmNS0nOoKX7PUYhp9kKgvH=K2gpCnq+sR++ZmDAgQ@mail.gmail.com>
 <20160719193523.GD28551@kwain>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 20 Jul 2016 16:54:40 +0200
Message-ID: <CACsJy8AatsjV7L6u6oA5xx+=K9hc9pjYTm_-XxxHHQ8aG9HyeQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: add: introduce the --name option
To:	Antoine Tenart <antoine.tenart@ack.tf>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 9:35 PM, Antoine Tenart <antoine.tenart@ack.tf> wrote:
> On Tue, Jul 19, 2016 at 09:04:11PM +0200, Duy Nguyen wrote:
>> On Tue, Jul 19, 2016 at 8:54 PM, Antoine Tenart <antoine.tenart@ack.tf> wrote:
>> > On Tue, Jul 19, 2016 at 08:23:58PM +0200, Duy Nguyen wrote:
>> >> On Tue, Jul 19, 2016 at 8:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> >>
>> >> 080739b (worktree.c: find_worktree() search by path suffix -
>> >> 2016-06-13) from 'next' should help identify worktrees in this case by
>> >> specifying 'project0/foo', 'project1/foo'... Granted it's not fun to
>> >> type all that when 'project0/foo' is something long, and bash
>> >> completion probably does not help much either.
>> >
>> > So with this I'll be able to create new worktrees, using paths having
>> > the same basename, but in different let's say "project directories"?
>>
>> Well, internal name is still out of your control, but if you want to
>> do something to a worktree you can say "do project0/foo". With 'next'
>> those verbs can be lock and unlock. We probably can make 'worktree
>> list' take filter and show just one worktree (and just add "git
>> worktree show" for that).
>
> Hmm, so if I understand correctly my use case still won't be supported,
> as adding a new worktree with the same basename will fail. Or did I miss
> something?

Hm... _what_ fails? If you create two worktrees project0/foo and
project1/foo, you'll get .git/worktrees/foo and .git/worktrees/foo1
but worktree creation should succeed both times. As long as you don't
have to look into .git/worktrees/ everything should be fine, you won't
see foo vs foo1.

If you absolutely have to, I'm thinking of "git --rev-parse
--worktree=<xxx> --git-dir" (or something similar) that will give you
$GIT_DIR to a specific worktree (e.g. .git/worktrees/foo or
.git/worktrees/foo1). Then you can specify "git rev-parse
--worktree=project0/foo --git-dir" and still don't have to see foo vs
foo1.
-- 
Duy
