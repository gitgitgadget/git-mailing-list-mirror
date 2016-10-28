Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B9E2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936477AbcJ1StB (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:49:01 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35283 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936701AbcJ1Ss5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:48:57 -0400
Received: by mail-yw0-f176.google.com with SMTP id h14so99991304ywa.2
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wS9/++EKxO4VboovQKlJCyPVHfC3rog7cIA9LO12+q8=;
        b=GjiUQynxqlJ96bI3v9j5pM3IvohlKAIVqtYhPGrXmV7k0rmEMP3g7Trl/Rm61p2YW0
         DIW0QHyvpuZWf8UoKBCpRUPP7g/z2A0ZXGC32FZUqKMS3SFqyko0upjxJyZbY8LcmUXK
         PTAp6w/FI16FJc580BoteVAd2joMC89HKWhsW6nW9jgFhDcRofEYvpkdI/e37xPeFU9P
         iRxyUL/+xteIw6WPyw5Jw3yTjDEUsUZv0zDGyXRUKcUBS3/McLgRnGwq8bsAKlSkUWGM
         7UhQeFKT6lED9xfFM7Wp/xlwg+qU6y9lxf/KC1oDHMBW7plA/ODke05H+3OeoKwyQw3Q
         t7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wS9/++EKxO4VboovQKlJCyPVHfC3rog7cIA9LO12+q8=;
        b=mq63CdyhDpyhCj7f6gHwf2vhCMOcJLx0kCy2RvKeHWpgzvZCTyXYj3xEqdnwLhUmlI
         bgpywblqdYmYEFS+gTtDu6DI88GnYgbBk7y7QoCBNNhF/W0KDFIAKx3qdaWB04LoWzpl
         XNKtaXIAPeRdobR0XM+0WUDzjCO689/dJ0lqtPQ4yvjeXgWZdtCWhr1CDqdfW6XACoDq
         yBCfWcV69HtXBUbQuCTbruIH5r/DOn26s/dXfip2EdETbMTMOmt62RtAlOiWwh/OzwV0
         AGnNw/Y7ux8MckemP4yEO2lpMv+xrfEzUR0POIsjtsUkqyjAF5FEf4K0sXFKfbygpkfy
         h3XA==
X-Gm-Message-State: ABUngvf84AMo72hz08cHXiLhO4aTFl0GEckanzqM+1MR+O3Wc4WpSAH5bVr16RnK5Yo+hQxYbnUQ7N67AJ/0tw==
X-Received: by 10.129.130.193 with SMTP id s184mr13147804ywf.276.1477680536782;
 Fri, 28 Oct 2016 11:48:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Fri, 28 Oct 2016 11:48:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610281356310.3264@virtualbox>
References: <20161026215732.16411-1-sbeller@google.com> <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com> <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com> <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
 <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org> <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
 <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org> <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
 <alpine.DEB.2.20.1610281356310.3264@virtualbox>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 28 Oct 2016 11:48:36 -0700
Message-ID: <CA+P7+xoyF8EG079eC-dfTSj+YrbxhPWx356-jZ90gDs6SwyppA@mail.gmail.com>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 4:58 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jake,
>
> On Thu, 27 Oct 2016, Jacob Keller wrote:
>
>> I agree with Stefan that there isn't really a great place to put a
>> dynamic initialization.
>
> Ummm. Wait. What???
>
> https://github.com/git/git/blob/v2.10.1/common-main.c#L25-L41
>
> Ciao,
> Johannes

I think Stefan has since provided a better suggestion of isolating the
dynamic initialization into the MINGW startup section. However, you
are right either place works, though I think platforms which support
static initialization should use it.

Thanks,
Jake
