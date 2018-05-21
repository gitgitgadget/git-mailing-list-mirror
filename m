Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555851F51C
	for <e@80x24.org>; Mon, 21 May 2018 17:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeEURWo (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 13:22:44 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:44464 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752928AbeEURWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 13:22:42 -0400
Received: by mail-vk0-f66.google.com with SMTP id x66-v6so9205434vka.11
        for <git@vger.kernel.org>; Mon, 21 May 2018 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HMDFVov7WYtTkqdDqV5RzNXj0TPpFZJ5DCc/5ClozyI=;
        b=uE2QuqTavJiSshBUX8zKEFvW6AjB965t3dSCoEZSf0UNCAw6Clp+aCbDh6vucvQ6J9
         lc7ndL1Soar+s5oq6oZDjgfPkJOubpu08v8g2krsiq1OV9h230dm5+W7vxHEQ4sS8T/r
         hZ7QGEeM/tIWrnZ0bUeDHWsdqg7qzQvjOJS03HMZJ5FqRahJEX5NsBovDQ4IiDN4Kj+q
         jN0rB+K6R53o7PuV+TKV3YhKjIWoWYwvt8krPGTkqqv2kFIGJ6UzrA2zik0oYz0WC2zs
         b3hHicateYPpbz+q81cw7QpM4qOTuWIwVhTaiQRW1/KLghopMc+MHu621aguEvhBUA4z
         rs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HMDFVov7WYtTkqdDqV5RzNXj0TPpFZJ5DCc/5ClozyI=;
        b=bvyaWAg8bEUF69tkfQZgrdu3X+sszPsc3+AxX223zghD/lo/A20x+AlCMMRCzuJxJ/
         5rCWH97zBGlVc0a0DyId9FDyZgFDAazN43uEiGVmFM2cVbzQgwbPKPyxdoR90LDvjoVV
         RcyvSNQSYmSTnQQbZlaLBIvuton7hCFyVNsRd7WabpPSaDicvrDAtFiQy83T5Kb/JESX
         qRB28MibSPaK+Ez699x35hWBqBLWAD0mMOu3mPwPo8WdCZsCFAqDt9CN3ONYSk/IDZrS
         B302IF7I2HmrnF7rgMRuM7ObXLn+R9CSXM5r5bvaCZpDxWKYDIm64a/rMCmH9udw7EuJ
         +NEg==
X-Gm-Message-State: ALKqPwfylABP3UFqhxsNJUt9Hs8NmQy8rvS9o+TRighvmXMhpLJLd603
        U45QqAT9wG0BNjWbirr0mFUNF6+MY37YVFuyPVI=
X-Google-Smtp-Source: AB8JxZon+hC/AdUIaZGbAQ0QEjU0ZM7qRYFu29tn2bauI9Kpv6bcadIxAoMxj5d+1B+lmaKmH1GBbQbTy8UqLGNm/ww=
X-Received: by 2002:a1f:824a:: with SMTP id e71-v6mr13666526vkd.7.1526923361444;
 Mon, 21 May 2018 10:22:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 21 May 2018 10:22:40 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805211540120.77@tvgsbejvaqbjf.bet>
References: <20180519020700.2241-1-newren@gmail.com> <20180519020700.2241-6-newren@gmail.com>
 <3b05f4b1-e236-989d-afe0-e85b28c2e278@kdbg.org> <CABPp-BFjF7ZAjqi79aRbT+0M+stPnrcEXwYoV75qCHTb2oLiXg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805211540120.77@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 May 2018 10:22:40 -0700
Message-ID: <CABPp-BFHb+=1tWDH3GsiyYWCcbr83we46stjuU0D_Z_-H=Jx9A@mail.gmail.com>
Subject: Re: [PATCH 5/5] merge-recursive: simplify handle_change_delete
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, May 21, 2018 at 6:41 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sat, 19 May 2018, Elijah Newren wrote:
>> On Sat, May 19, 2018 at 12:32 AM, Johannes Sixt <j6t@kdbg.org> wrote:

>> >
>> > Oh, there is a reason for the repeated message text: translations! Please do
>> > not play sentence Lego with translated strings. The original code is
>> > preferable.
>>
>> Ah, translations; that makes sense now.  I'm still annoyed by the
>> code, but I retract patch 5 then.
>
> Maybe you can remove the temptation for others, too, my replacing your
> patch 5 with one that adds the code comment "No sentence Lego! Think of
> our poor translators and refrain from making their life miserable!" or
> some more appropriate one?

That sounds reasonable.  I'll make that change (plus your other
suggested changes on other patches; thanks for all the reviews) in the
next round.

I'm also considering adopting a setup_unpack_trees_porcelain() style
of handling (from unpack-trees.c) for all these messages in
merge-recursive.c, but that's a bigger change that I'd probably put in
a separate series if I decide to go with it.

Elijah
