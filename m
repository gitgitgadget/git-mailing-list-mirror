Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3477C1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 17:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbeISX3K (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 19:29:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39500 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732194AbeISX3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 19:29:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85-v6so27845pge.6
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wra3M8qVwji/0nHNbjjVzd56UrVCGyVZkuByi0OLX4=;
        b=ofJNAczbU4+8kKe/FvBZqsyWBc+Yf0tLFpn6Wg0S9YLT41vWrvaehhhWhWp5139jNs
         WR+/HSCnDUIm1brrC53awUKCvmuKr/oMzxb7RX4nGIBqOC4NcytG0S4snGvs5dLENEdn
         +wLoT70YvaY7fv+IhklSwdKgMKBw8bW8mflkA0/bKRyqFmPa2qt6LKFariSYL2/vd5Uk
         INbuOKyEhJ0Os5wW1mbP9JzlMi6+Y2mfYXWiUSc5SWIrJPQ2G+zD63CKa2TBRaW4HGVR
         keCDLHEcvxJeMuOw5JD76uD+aZupqUbsWOPntkNv6x0hEEeMVwTrkMs/8wJ9teUXU2rW
         11zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wra3M8qVwji/0nHNbjjVzd56UrVCGyVZkuByi0OLX4=;
        b=i1tYbhWhWhzrFKetZMQ1Zb/MmsRDKlhxDZFcC5ERylGJBCG+mqcGIJu/HK0DvIDWiB
         3iwOkg1MS9m/dFMl3XiI77WZBWxSjC9iUVyHNSPU68A24znoijPV+HERRDdj8cajT7rN
         qegIZrtVEZH1o1xf4i8IMR3/tv3C+4xvbipnd/4eiforoH+qKZWF4RdDWV/Iw/ez68T8
         EfZUcXCdmYxD31yuROkGA87jjQleG+7x128BYhzHhf5nvVsK7sAmr8Xww2107MH6mcFX
         o3o0p3U1E+wOudEqgTccbtYgf7Td8IO4CzZ7iEx6YNwY070FFUAuwXAlIIkqSZjff//A
         zFhA==
X-Gm-Message-State: APzg51CmOZfzbOHD0xsqTry7PRF+F8GD2yjlUs0W8dl/fh7RDNj0d431
        15MtcSKspAr3knO+MnPmeUpUTAr52Xa/toJICB8=
X-Google-Smtp-Source: ANB0VdYPQzrDhQ5qxNLkCx5UKqaUkdFqJEY3fwxKRyjMTPt0ZFmRpIVjLnVdKR21ZfGL2PrgnVCU+enEGgmM/2uGbUk=
X-Received: by 2002:a63:b95e:: with SMTP id v30-v6mr33022496pgo.221.1537379409509;
 Wed, 19 Sep 2018 10:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <d24df21a-7ab2-84f6-8b18-83fd9c8c2b30@ramsayjones.plus.com>
In-Reply-To: <d24df21a-7ab2-84f6-8b18-83fd9c8c2b30@ramsayjones.plus.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 19 Sep 2018 19:49:57 +0200
Message-ID: <CAN0heSpNT25PrNwdbQKZo=Q8kpSfwnzuOz34xKHtfF+Fq9ZXmg@mail.gmail.com>
Subject: Re: [PATCH 1/9] Makefile: add a hdr-check target
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Wed, 19 Sep 2018 at 02:07, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> @@ -2675,6 +2676,17 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>
> +GEN_HDRS := command-list.h unicode-width.h

Most of the things happening around here are obvious steps towards the
end-goal and seem to logically belong here, together. This one though,
"generated headers"(?) seems like it is more general in nature, so could
perhaps live somewhere else.

Actually, we have a variable `GENERATED_H` which seems to try to do more
or less the same thing. It lists just one file, though, command-list.h.
And unicode-width.h seems to be tracked in git.git.

Maybe use `GENERATED_H` instead, and list unicode-width.h on the next
line instead? Or am I completely misreading "GEN_HDRS"?

> +EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
> +CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
> +HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
> +
> +$(HCO): %.hco: %.h FORCE
> +       $(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
> +
> +.PHONY: hdr-check $(HCO)
> +hdr-check: $(HCO)
> +
>  .PHONY: style
>  style:
>         git clang-format --style file --diff --extensions c,h
