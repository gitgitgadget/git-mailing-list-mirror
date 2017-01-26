Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302041F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 18:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbdAZSyx (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:54:53 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38070 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbdAZSyv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:54:51 -0500
Received: by mail-wm0-f54.google.com with SMTP id r144so99993193wme.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 10:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=33IVJCf6QP/DQ1A1twUYoik25raapk8TNEUdFuf7kj0=;
        b=uYY8B8UPooXUWGoXP2axJdIuRdH4QbSq7QAIlf4Fka9xkyyuYDm829TFsawrcqhTYD
         e8oI2QOWgPGdDnuRBo+NOJPXnTcDoSKyxrtn8/z5+ciilt4m5wtNW/o9FAUey2ZIe99d
         Pie7T8SzRaZ1ON80Ar1aYYQc1EOe+8s79aOYxefjhWuZnjHu0Tbp7/5tRYIWmQZAvNLZ
         0jk1sxWbVlgalo2EeOB2JlZHlxS5BspoJ5zsOJ+s/eWDTfTT9b9yD6wnlnZHv7aLOjAG
         A9UcOms/3c+AbvjVxEbu+RJte6gj9ybZA5NU7xr7sKxHsbYBCf/0F5nTTEiSEK1viiWd
         uGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=33IVJCf6QP/DQ1A1twUYoik25raapk8TNEUdFuf7kj0=;
        b=AQr+l/18OJj1HMx+XJUBe7MyDVO7HeGd14Vc0gHoQzOU1uE8mgJgum0EShkEUJTuGA
         p/naFUd/h9dkgxVk7zV/cIjRMlDh5B2TmBLDuymYDDj+e0EwSSE3JYWms0k6MuHadexS
         IBCqgn3MnGsk9NDwXhy1LurCNcUaKY+Pi9PWaKQrOdXJorhENWHRz8IMMTxsnVQe84qL
         UH4S5obiMZKWFbTwvOBn4DlxnRcNPFxnDF+iLqm+8alkrfBNS7MN+juTLRkru7MfjeS1
         0ov5BrtAWy2G+Mr8nAMG2Ob2f3Az6d1OaFO/AEuofeij3AXT9GDkN2HFfL+0TmDEkmMq
         onEQ==
X-Gm-Message-State: AIkVDXKTnujc6WvBZbkrsvVNTfFgCcVNwOJ6S+E24NWMcCDjyVO14AwelGoX43zJkXOOef2A6kQoSlmrDz7Etw==
X-Received: by 10.223.139.29 with SMTP id n29mr3866916wra.67.1485454732622;
 Thu, 26 Jan 2017 10:18:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.145.193 with HTTP; Thu, 26 Jan 2017 10:18:31 -0800 (PST)
In-Reply-To: <CAOxFTcyuLkvgPOxQuzaDUVuDRu_KJg=JrYtU84pQyjLstChbLg@mail.gmail.com>
References: <20170121104904.15132-1-giuseppe.bilotta@gmail.com>
 <xmqqh94ptzke.fsf@gitster.mtv.corp.google.com> <CAOxFTcyuLkvgPOxQuzaDUVuDRu_KJg=JrYtU84pQyjLstChbLg@mail.gmail.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Thu, 26 Jan 2017 19:18:31 +0100
Message-ID: <CAOxFTcx1NsBfiSqQgomE5USsd0DBKtQZPQEJgnpphTRWrUn=ow@mail.gmail.com>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2017 at 9:03 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> On Mon, Jan 23, 2017 at 7:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Should we plan to extend this to the interactive backend that is
>> shared between rebase -i and rebase -m, too?  Or is this patch
>> already sufficient to cover them?
>
> AFAIK this is sufficient for both, in the sense that I've used it with
> git rebase -i and it works.

Hm, something very strange is going on, I've just tested the patch on
top of current next and for some reason the signoff line does not get
added. The command-line option gets passed to git am, but I get no
signoff for some reason, so something is failing down the line, I'll
have to investigate.

-- 
Giuseppe "Oblomov" Bilotta
