Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F011FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 07:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbcIAHqJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 03:46:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34901 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754408AbcIAHqI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 03:46:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id c133so2456468wmd.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BfvmeqQCoXD6ot0u3mlVv2ZkM2wTrAYF5VfvTG7R3MI=;
        b=cDpv10N2mmlFP4YnXZ20qvzlyJrFGUfdAfqFkR7fTgD0So2z2Lgyar5LvEJmmYyrS0
         IzouNuZVJvi+87ANLBpqtvTxB8lu26mBcKUYVDjmcKnIN1wVEPJALSUN5oGbWNFcJwLi
         6HXwyI8uFewdNbEGR0+gfyAPTt6jPrA7TgDerWNXET0DaqOn9/fKcUiaxgc5+r5Mm7xA
         t49XIx5s9tbI5sTFWpBUSYhyR9qOhjNjykvsIavZdMrN0m8n+7GxkU8c0E5RspIl0rwB
         V9uoN0QBcPCK2WyvO5syL4p3pUdpEWCnt9EZ9KzLwftI7jjaAXzSHbrN/TIuDoztK+/m
         M+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BfvmeqQCoXD6ot0u3mlVv2ZkM2wTrAYF5VfvTG7R3MI=;
        b=BQQNYZDJUeQR0D5ssIkoKyJBsXJmT1NrLsDb0Yz2CVUhhK67HuQodQc1xDZR6GdYNP
         UmM72pv6OWENIclB1AjOr9Fl+gI+w6x4vwmwqxaXofgXZc8KwB7FONle1BULHK+asxvF
         yYfs/ZotUPpb2qO6HyEKO1xsWCOZm/c9ECk5xRZiLlKQ9VdxsgYCtNsCG1ghJ/K8M2DJ
         zebpZ9LUgTvHeYvwgHxTrnHd+jQgZtPs2RaD/9aX1r8og6s4HrbdSk2KCkYBFtyrnI5m
         nMQxDe7AElUli2nLHabcf2HGNIKPo1r4w1OECkJHx+j171rhLMdS6Ne6Ea2ezFvWuHH0
         MX/A==
X-Gm-Message-State: AE9vXwN5g+rbUIfeVR99gFMG0muBvezsMJPaq4VUxkXJuc2n31HdQ69rTXzcVrXL1YY8+B07m/cOCAfxNX34Fg==
X-Received: by 10.28.35.193 with SMTP id j184mr25959388wmj.33.1472715966880;
 Thu, 01 Sep 2016 00:46:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.222.132 with HTTP; Thu, 1 Sep 2016 00:46:06 -0700 (PDT)
In-Reply-To: <CAGZ79kb0gao2KJFi9X3V2ME+1-xnbuSNhjC14Vnn3oP-1ac35A@mail.gmail.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
 <20160827184547.4365-4-chriscool@tuxfamily.org> <CAGZ79kb0gao2KJFi9X3V2ME+1-xnbuSNhjC14Vnn3oP-1ac35A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Sep 2016 09:46:06 +0200
Message-ID: <CAP8UFD1pKfCdX84P4iAyZdPdzWQMaNdb0Vaq5UpWy3fXJzFeWg@mail.gmail.com>
Subject: Re: [PATCH v13 03/14] Move libified code from builtin/apply.c to apply.{c,h}
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 11:57 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> As most of the apply code in builtin/apply.c has been libified by a numb=
er of
>> previous commits, it can now be moved to apply.{c,h}, so that more code =
can
>> use it.
>>
>> Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  apply.c         | 4731 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>>  apply.h         |   19 +
>>  builtin/apply.c | 4733 +-----------------------------------------------=
-------
>
> I deduce by roughly the same line count in the .c files, it is just
> moving files over.
> (On my todo list I have an idea how to make reviewing patches like this e=
asier.)

Yeah, at one point I used some special options to try to get a smaller
diff, but it got lost along the way.

>>  3 files changed, 4751 insertions(+), 4732 deletions(-)
>>
>> diff --git a/apply.c b/apply.c
>> index 2eac3e3..7b96130 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -1,5 +1,23 @@
>> +/*
>> + * apply.c
>> + *
>> + * Copyright (C) Linus Torvalds, 2005
>
> We're very inconsistent with the intellectual property log.
> Sometimes we have that at the top of a file, sometimes we don't
> and rather point at the git history to find out who touched the code.
> I'd rather use the history instead of having a bunch of copyright lines.
> So maybe consider to drop this introductory comment as a
> {preparatory, follow up} cleanup?
>
> (This is also a nit that doesn't require a reroll on its own)

Yeah, if people are ok with it I may od it in a follow up patch.
