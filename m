Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FFA91F407
	for <e@80x24.org>; Mon, 11 Dec 2017 01:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbdLKBNX (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 20:13:23 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46618 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdLKBNW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 20:13:22 -0500
Received: by mail-lf0-f68.google.com with SMTP id r143so17355070lfe.13
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 17:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2kTZpHPlhy+oLQGGUEpXuhDMSh3EKrtKwLNcAU1883E=;
        b=YivMKq4uqyO3ExomRccXlCAVViHBj8SsOstrqbyrtFJj6aSUMftsrmbaxHJDXF13JG
         4UYJ8EXj+4JfJWX8ye4BmVrT4nZjOl82hTArEakDnn7ZgW8utwDcFFPGGx+uQXtAFkUx
         pPysYzjSQtxDQW+LMi8fnlh2WiU9rpZwWvj9L8iz5AoTvp1hr0isuH0kMLPiLXn3FhLQ
         SlWHmL/sj7LRjGIuJc1HhHmrXn7oniv8SlaHZ80PRZ9F6xeCRF4KTRgbw3n4LAbVs+Oc
         qOI3NRsS3BDBA+8Uipsnn8M2jJXnEaEmNdoyABbTIQ4ujvzfw7Bx9FlvIANPE5zyBdwG
         a6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2kTZpHPlhy+oLQGGUEpXuhDMSh3EKrtKwLNcAU1883E=;
        b=BTq8MSQxjwnBWVs+duuT7yBHBRNwCAjs/Nj5fFj33DCHOZB/oD3QDQxvOkmyz33/xh
         OYvJ9WuhCfUdB0PNlY6gjg2U38deS80JqSJpWphD4ktXLDcaZnP5yasE9uQY3k0K2NnQ
         cUgrFO4lkRfWQt2fC73Kv30MJfd5ZlfQUBxvaKHe+tBO6OsrHyrz0qpDVbhm/E6seqx0
         FfDtvPn0YNnhhZNyL6LeWE2N2vZdNOumdV904OahjUYNrxwV7VH2Hpxlpz4ZvW0MUuKC
         oa/6tFSuQ0L5SJoG6Pt5W939AjtmNiEjsyq0dEbyg10J+fMWF2vUVSn4oQUx8yYg1ywy
         L5Zw==
X-Gm-Message-State: AJaThX5HWN8lB1CDzCE8ZEhofFeKgdMZGFXFu2QomRKJhhbKKf4yyLhi
        L/mTnHLEvUzX1HLakQnnCRo=
X-Google-Smtp-Source: AGs4zMYacLPDVO9U77mVSOKTVO6R93+LLAqrdoigqEH7usG09cC94ap8JD1PL6imZsWEhs3yFezl3w==
X-Received: by 10.25.234.143 with SMTP id y15mr17248565lfi.12.1512954801300;
        Sun, 10 Dec 2017 17:13:21 -0800 (PST)
Received: from [192.168.0.102] ([46.98.114.168])
        by smtp.gmail.com with ESMTPSA id y3sm2538303ljd.62.2017.12.10.17.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Dec 2017 17:13:20 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way
 merge,noworking tree file changes)
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
In-Reply-To: <36d2b05b-8b68-a157-99ed-44050ac34ab6@gmail.com>
Date:   Mon, 11 Dec 2017 03:13:19 +0200
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <1BA66B37-0BD2-417F-AAD5-3F3FA83A3A5E@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
 <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
 <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
 <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
 <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org>
 <7ae3ffd5-147d-55d2-9630-da12c429d631@gmail.com>
 <39323748-282c-5881-2bfa-de622bb8b765@kdbg.org>
 <CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com>
 <f9a94a62-9541-e019-8ab3-9fc9cfe2c43f@gmail.com>
 <xmqqo9n99ohc.fsf@gitster.mtv.corp.google.com>
 <a3510c14-23e9-d1d9-0847-b60451f8e15d@gmail.com>
 <D842B04A-9331-4F26-8F19-B61F6F13FC79@gmail.com>
 <92643df4-f54e-cd31-da4a-138ec314655a@gmail.com>
 <4a92e34c-d713-25d3-e1ac-100525011d3f@talktalk.net>
 <da74fb2c-c452-4716-91d2-182f945b4254@gmail.com>
 <82da4317-6b50-f60d-6d8f-50fc47579c56@talktalk.net>
 <36d2b05b-8b68-a157-99ed-44050ac34ab6@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 11, 2017, at 01:17, Igor Djordjevic wrote:
> On 10/12/2017 13:22, Phillip Wood wrote:
>> I understood Alexei to mean that it was merging the f!A into A that 
>> caused conflicts due to the fact that f!A has conflicting context
>> that was introduced in B. After all B' the rebased B is merge A A' B
>> whether it is created by 'rebase --autosquash' or 'rebase --onto'. A'
>> must be the same in both cases or one is applying a different fix.
> 
> Yes, I understand and agree you might be right, what you are talking 
> about being what he actually _meant_, but because that is not what he 
> _wrote_, I wanted to see an example of it, (still?) hoping that he 
> really did mean what he wrote (commit B being the problematic one), 
> as then there would be a possibility for improvement.

I'm not really good at remembering the exact details, so if you ask
for a testimony then I'm not sure whether it's the conflicts in the
fixups or the later commits that I was annoyed by :) I'm also not
really versed in the technical details of rebasing, so I cannot give
an educated guess on which one is more likely to cause conflicts.

> Still, I hope for that example...! :D

I keep this thread pinned, so I hope to provide a more concrete example
as soon as I encounter the conflicting situation again in the wild. I'm
not sure that I am able to construct a relevant example artificially.
