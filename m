Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8DB1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 22:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbcHSWCe (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 18:02:34 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34946 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754127AbcHSWCe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 18:02:34 -0400
Received: by mail-yw0-f195.google.com with SMTP id r9so1319405ywg.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9on/4MbhPomdTWd8LrsGNotfVnZKHT6jnQP5wUnOFHQ=;
        b=jCUcyKaYpK6U/hjD8sG4rr0vQkCcifvisxmj2/Xih12U+EVANtdWvmyLcMBILwlHKf
         zWyOsrUf934bEH2G7YKU+OfKNHZqjy4lJKk8lC+BY5IGvebPIiqZXL0VyLsf6KNXvkVZ
         x+2NLHBxFWS+S3Cb9tMY+xB/CzZ4ts6NY6lHbm6E8Uxti6HPS2PEdSbRO0EJfVpNGU9s
         +thOu4rAzPIVX4TvCFTUmRxC31B6sxjrqKeIymwGO8CI6XyAMK+x1bEdb5JWSnf4bsNN
         53GxeMPRwoR+Rg5MA6JAhSJQkibsZpNYuX6gBwPidPRcz++LhSoiAgP3l837pa2nvi9g
         baSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9on/4MbhPomdTWd8LrsGNotfVnZKHT6jnQP5wUnOFHQ=;
        b=ULS0/38XaJG+ouvROfhR3Tw6SPLB8J8WjRnCS9k8Bm4C0Pr5Fb4yZWSpRALUIGYDR3
         EvG+RxcrlHzLq60gociaZ/AiR2NJfEfjUHOJ4lzPu7Ovr5ft+GDRq9Pmgdp0n/0VAmmh
         JDImCr1XAqV0ZFV/lNGlY5cLTRHhGDMiCn9UVGgVkv47NffRzqAO0fgM0x67aef7rkmK
         fUTi98BqVcSbZHw5wQZgQHcCeRmXjoI3OtzyvIUJKNP5C1YmTPW44UDj3PF2Z4Nhmrov
         g5lFN2SD+RDYRnp1qdy6RBRKkXmDk1k7+DlNb/VUDo6R6IvQ7PCmmoxA9OB5lMaPYznX
         hEJA==
X-Gm-Message-State: AEkoouuC7Yru0VBHq46yqH8QotleLVfwfOfmP8yHeYdRlCyBj6fuMwF3EEi9EMMEUOlgtElN1vbrF1l8sehnqA==
X-Received: by 10.129.135.2 with SMTP id x2mr7921075ywf.310.1471644153373;
 Fri, 19 Aug 2016 15:02:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Fri, 19 Aug 2016 15:02:12 -0700 (PDT)
In-Reply-To: <xmqqtwegzckf.fsf@gitster.mtv.corp.google.com>
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
 <20160819000031.24854-8-jacob.e.keller@intel.com> <xmqqfuq01oww.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xp6VDdMnh-srDzToSwh3mZrQei+B8DjpB2N6OkqAuARkw@mail.gmail.com>
 <xmqq7fbc1o1f.fsf@gitster.mtv.corp.google.com> <xmqqtwegzckf.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 19 Aug 2016 15:02:12 -0700
Message-ID: <CA+P7+xparEBHc-nrqYQoadg+dedD90qjLUBWiekhOYst_+0fsA@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] cache: add empty_tree_oid object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 2:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>> Is there a reason for that? I've found that .field = value is safer
>>> because it ensures that you don't end up initializing the wrong
>>> values? Or is it a compatibility thing?
>>
>> Yes.
>
> That was a bit too terse.  The answers to all three questions are
> "Yes", "Yes", and "Yes".
>
> Together with enum ... = { A, B, C, }; we may want to consider not
> worrying about ancient compilers at some point, and it might be this
> year or next year, but I do not think we want to do that as part of
> this series.

Thanks, it makes sense. It is hard to remember when some feature got added.

Regards,
Jake
