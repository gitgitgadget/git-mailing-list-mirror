Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F0A1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 14:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeHUSMp (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 14:12:45 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50597 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeHUSMp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 14:12:45 -0400
Received: by mail-it0-f67.google.com with SMTP id j81-v6so4516136ite.0
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hrhv2VxzGxOCaigYXhloqHFood4XYZJ7Z0e+wd0cqAg=;
        b=EfDtrQQ1GN1OkoqVXUURscLgf4kMZpQi5EcSY3EoekOG/mQpV1+KQdJSbWJjwxctz6
         YBoj0lsqmCTyCp4XwZbB8mezOUF81VMutoEKwPHe5lx1n64Xw3WikngeG6smaPmh0/Ed
         2292loX8ZJuRCUvl4wMydEq17qfFYvpVWs4jcXJGuInCc8g0WkLC0ZiwBLirhrwOZiJl
         W7vpFojJfxl7cpKj0XWlhCzfKUoXewRQZb7Tpw5tir2Wo+gnU4g0llWmiGp0VejoeJ7u
         v7HupJGCoK7Ip7D3WDk+8Kxsq1fZ5qZi0S+z9I+cqE8pSu/OHz8dRX116SWE59kO+4ez
         x9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hrhv2VxzGxOCaigYXhloqHFood4XYZJ7Z0e+wd0cqAg=;
        b=jFrKFwT+Vm/hL0ePqfgF+MupxTSgdNpeQYo1QiBRFJCWUkg7DGAzCsaS1w+w60LSXd
         l7o9/lVxE4p4xEst2hWVhH72QYRE8eU5s2E+Hs25DKCqiQhcBHPFeGwSht3DiIXkjaOC
         aeLlRFoQ4XTWXEgynsvpelkSSHMsFnZ1uraZbCTl6b6J6QdF0Om1DPEfbVKSBIlpDl2e
         cuNCh2w9e7qYJrliBq0xbbyfENJMdnQezRpYtHYT7Ia/FoR2qWIFIZU0o6RWc1BfPhtq
         kSHFQOaFZ5EMx4Q8I1gnWLnGMYvFJNJo5ntylXoXBqSCc2JdlEGVKwfmMBid0qRcoYC7
         uEJA==
X-Gm-Message-State: AOUpUlEAfVYEY4tB+3OHA1IB5uSVKglejY/MlWMHiLnzVTyr0fPzaYkp
        HEtioIVdOw8ZYgrqZC9Nf2bFHcQO3XbRPOTAdTmEaw==
X-Google-Smtp-Source: AA+uWPznZQOINto1s7MfFAi20XgP/q/EQC2AoQHb57queWkAJma2k6ISpEh4s7LQwIm9Zwv9ON4W7GIXJw3fhOqst9E=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr15966687itk.62.1534863136569;
 Tue, 21 Aug 2018 07:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180816182653.15580-1-benpeart@microsoft.com> <CACsJy8B84T9HSJKAErNAyoMwbBpu6Gwgyz3RsvmqD0+o=bg3Ng@mail.gmail.com>
 <448bd740-73fb-aa3a-ded0-e4012cf6ec21@gmail.com> <CABPp-BGir_5xyqEfwytDog0rZDydPHXjuqXCpNKk67dVPXjUjA@mail.gmail.com>
 <f88299c5-1697-a7ef-87d6-69f5c19d5a68@gmail.com> <CABPp-BFKf2N6TYzCCneRwWUektMzRMnHLZ8JT64q=MGj5WQZkA@mail.gmail.com>
In-Reply-To: <CABPp-BFKf2N6TYzCCneRwWUektMzRMnHLZ8JT64q=MGj5WQZkA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 Aug 2018 16:51:49 +0200
Message-ID: <CACsJy8ArUXD0cF2vQAVnzM_AGto2k2yQTFuTO7PhP4ffHM8dVQ@mail.gmail.com>
Subject: Re: [PATCH v3] checkout: optimize "git checkout -b <new_branch>"
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 8:16 PM Elijah Newren <newren@gmail.com> wrote:
> Playing with sparse-checkout, it feels to me like a half-baked
> feature.  It seems like it required too much manual work, and it was
> sometimes hard to tell if I was misunderstanding configuration rules
> or I was just running into bugs in the code.  I think I hit both but I
> didn't really want to get side-tracked further, yet.  (I do want to
> eventually come back to it.)  The only reason someone would go through
> that pain is if it provided massive performance benefits.

In my defense it was one of my first contribution when I was naiver
and basically an evolution of "git update-index --assume-unchanged". I
have something in the queue to improve/complement sparse-checkout but
my last update on that branch was 2.5 years ago, so it's not coming
soon.

I'd love to year how sparse checkout could be improved, or even
replaced. I think we still have to have some configuration rules, and
yes the flexibility of sparse checkout (or gitignore to be precise)
rules is a double-edged sword.
-- 
Duy
