Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5961F406
	for <e@80x24.org>; Mon, 14 May 2018 13:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeENN1Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 09:27:24 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42628 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbeENN1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 09:27:23 -0400
Received: by mail-qk0-f196.google.com with SMTP id b22-v6so4061560qkj.9
        for <git@vger.kernel.org>; Mon, 14 May 2018 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nfCPcWTqyse5kImaLYcjzA6VSHLNJgU2AIcL4M9raE0=;
        b=rf71nPaGe8ZRGShBRkgoCplrk4UoR+68Os1mGhrFXISdCsGp9vrvIQH7GK+llGfVkL
         pV0Q5Th+reaSRpVUDLs8ypqdl2OX199Fd1oUyLl7pBC65xM+TGto6Nns6nkncS9dze/B
         lYXDBHPfkMRfl/CWvBAKgG/KlwCJlyk+44f9Eq9egxpkdkSKl5CAJ4K7iXvN8oZ1E9Z/
         X5BIkBcTcnpqPKOHP+6crmZXjMF2myzWEELTXYC9hEy3Zs2wx8tKgONsCUkU7D+hRmNS
         pmaQSjlEjit4A8wHme8827i+GXLTZRK8pVfadBzqazd+rKXoR8KOaJ6GnBS6qxVfAV+6
         p+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nfCPcWTqyse5kImaLYcjzA6VSHLNJgU2AIcL4M9raE0=;
        b=dlrm1itHZYaSLNBou3ZjVzNghGoXpyBiF3aSEHhoDlC2K0c49aTTncTjesYo6tHq+M
         RHiHMBmdClcx95Qd98/meuHxbwmYKf9rJtKCS45xAsQ52qEV9Zn/g4vBKA5vUvxb7wZD
         trT2GQonFwwHoTOTAFZmHRekhROQlqQD6eaH/kEMHUl9K2bC6SI9A3RFmCZFwb16ufbN
         P3HgegABJEXtwNuo+yCs0UAJ8UIBEt602GoxKuamoK/9TtrDUp6b5FcUVSWVeAIcMvxv
         2jG5r60hNKYt4L49xt5v4D0e6sZhesxqKJdTAa7NPugn8hmzwKNkaY1UGYJ2wEFjLGQ0
         OrZQ==
X-Gm-Message-State: ALKqPwccSdftmb4phhLsvEXu8f0UKqTiE3c5dk1AbNs2dNm/4PocyR70
        MmrZ+dMYProHglTd3BWmQx4=
X-Google-Smtp-Source: AB8JxZooi2EPcOwhFKm2cbSK8wMDcDdjRRgHj+9oH5mhCq7quadeEy3S1wLFmICeLfg83C54DAK6Ow==
X-Received: by 2002:a37:2c46:: with SMTP id s67-v6mr8073314qkh.120.1526304443156;
        Mon, 14 May 2018 06:27:23 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id n14-v6sm7969633qkh.14.2018.05.14.06.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 06:27:22 -0700 (PDT)
Subject: Re: [PATCH v2 01/12] commit-graph: add 'verify' subcommand
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180510173345.40577-1-dstolee@microsoft.com>
 <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-2-dstolee@microsoft.com>
 <CAN0heSotYYgrwMLT1yyFVk4VEZ4OQKF_Xwm9-wZosJ6_-gAVBg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3cd99f4e-82cb-43e8-53eb-e8d38d449e57@gmail.com>
Date:   Mon, 14 May 2018 09:27:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSotYYgrwMLT1yyFVk4VEZ4OQKF_Xwm9-wZosJ6_-gAVBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2018 9:31 AM, Martin Ågren wrote:
> On 11 May 2018 at 23:15, Derrick Stolee <dstolee@microsoft.com> wrote:
>
>>          graph_name = get_commit_graph_filename(opts.obj_dir);
>>          graph = load_commit_graph_one(graph_name);
>> +       FREE_AND_NULL(graph_name);
>>
>>          if (!graph)
>>                  die("graph file %s does not exist", graph_name);
>> -       FREE_AND_NULL(graph_name);
> This is probably because of something I said, but this does not look
> correct. The `die()` would typically print "(null)" or segfault. If the
> `die()` means we don't free `graph_name`, that should be fine.
>
> You're still leaking `graph` here (possibly nothing this patch should
> worry about) and in `graph_verify()`. UNLEAK-ing it immediately before
> calling `verify_commit_graph()` should be ok. I also think punting on
> this UNLEAK-business entirely would be ok; I was just a bit surprised to
> see one variable getting freed and the other one ignored.

Thanks, Martin. I was just blindly searching for FREE_AND_NULL() and 
shouldn't have been so careless.

-Stolee
