Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14671FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbdCJTto (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:49:44 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:32984 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932697AbdCJTtm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:49:42 -0500
Received: by mail-pg0-f48.google.com with SMTP id 25so42385576pgy.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 11:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nLwKfZdXrAEs36VQrgsV1s2kd15F1jOcKCl2bmvHq34=;
        b=HQZZRgrtzEVGKrb1CIqHXXd9fSNA0Udx0KZl6YzQNMpHPsNy58LqhXlM2wpkBbXHQj
         kWcRzjqFfOXh30hsXMhbpSUO7iJuXoghr1DyzvqkDbeAxdAUJQLgCwLeVZWqCRylMc7/
         CrfkaqWLyPmBigMd4k8UTe4nvx1lLsiUGVg0jWu6qVK4bHnbqrw8SOraFMi2xCRCOAp4
         3zCLBqwUHFbT2eXy+mvSwluw2cn2TRd1Ke6ZFq40ge0AVI8egdBNrlaCv4zo6rBQomBf
         RnKM2YcVhhrvB3ytPTI1jejhM71QtqkTlpGjv30v5tHuWrLpqvpDb45BnlQKAmESWZtP
         z4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nLwKfZdXrAEs36VQrgsV1s2kd15F1jOcKCl2bmvHq34=;
        b=Sj+CBA4XrFkzx4rKJ7DOxMYrYf6O7/ib741nxAS8l6VJbUrajfU58umOkBzPETeXmb
         yQ8++D22Ht4se+X1qZKCv0YWjxm+UMEMdH3se4xoIVPznpKq52r223ITDlVrlkHuxxXs
         cgYyduaoSI5q8wCUAQHHyZGT1y5XTwddS6zQGV1pwh/vQGaxtijWdygv92L3VpknzHwi
         NIS3B9LA8t/us9WSo5TCVgvHJSk3ASeavtp9anqtKubSNvR8CsO30dtNd/qk+E3o//5j
         r01Q9eTj6zW7GHa411uWKGE9jO1KJVmpq+6iY2D/HuODigM6V8zaIdnpivvrZx+mR6kj
         WvUg==
X-Gm-Message-State: AMke39m3j3u1+xF2/1otjELAqO+ECxcRu+28lt+hNK69w0F9qhVn8RSKRi0YjLM73bAM7AXGZCIrNbkWolkyXzcr
X-Received: by 10.84.128.74 with SMTP id 68mr28267625pla.111.1489175381266;
 Fri, 10 Mar 2017 11:49:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 10 Mar 2017 11:49:40 -0800 (PST)
In-Reply-To: <xmqqvargyl39.fsf@gitster.mtv.corp.google.com>
References: <20170309003858.GB153031@google.com> <20170309012734.21541-1-me@vtolstov.org>
 <20170309012734.21541-3-me@vtolstov.org> <20170309181837.GF153031@google.com> <xmqqvargyl39.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Mar 2017 11:49:40 -0800
Message-ID: <CAGZ79kbhG9XhRccqA555Zp-FENJ5Q6Nd+LnNTZno1J_=cGQctQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] submodule--helper.c: remove duplicate code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Valery Tolstov <me@vtolstov.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 11:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> On 03/09, Valery Tolstov wrote:
>>> Remove code fragment from module_clone that duplicates functionality
>>> of connect_work_tree_and_git_dir in dir.c
>>>
>>> Signed-off-by: Valery Tolstov <me@vtolstov.org>
>>
>> Looks good.
>
> I'll queue with your Reviewed-by: added.
>
> If sb/checkout-recurse-submodules is going to be rerolled, I'd
> appreciate if it includes this patch inserted at an appropriate
> place in the series, instead of me having to remember re-applying
> this patch every time it happens.

Instead of mixing these two series, can you just take Valerys series as is,
and sb/checkout-recurse-submodules builds on top of that when rerolled?

Thanks,
Stefan

>
> Thanks.
