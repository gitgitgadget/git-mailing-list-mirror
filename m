Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 926401F597
	for <e@80x24.org>; Mon, 23 Jul 2018 19:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbeGWUnG (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 16:43:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42069 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeGWUnG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 16:43:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so1824045wrs.9
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7Gvlk654jxji71D45cwdu5/odGb+72JeVCflXVqvC00=;
        b=Jy76RRpR2edxD/nDWQixkF8/WsDYazTIq2qS8TGa6lo4ndhcci55QTNe3p0aXYELbS
         M1pPCLPeo6U/49X9Bt542QwLIYWHYs7eAQzhHf5tX4+rL6aPAT+XMqrEzfQeY8Sdf76D
         EGSDtNVlK9XrppzoNws0gLRvFhw7mJ4K6CUcUPbpNrIdYt5jh8kXavkrCPMHbjIdklSK
         tvczX9AIGmu8Z4qj69OwsErFkGNC/TgA+IfXiU/Yzca6mJfa5tStvQrP5GlyHD/2vLMJ
         b8BThv//wMgoah26cxNXScoavyAJHaQT2u/wjQrRpVlALDYa9QLht6h9xJvPQDTaEPGJ
         Yg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7Gvlk654jxji71D45cwdu5/odGb+72JeVCflXVqvC00=;
        b=Uy9cqqpJGSiq4OLqxa0m8hUMxu+GPvQSpTJjIoZsU2csI4y3j7BsIKK0SGzkPw924r
         AcOBvrA0NQlYBbnFAFMU2dsXyNgueJ/WjbM8jnf7LzvbnVMeyDvRN4YGX1dAwGGenAkl
         85fBvVl3unkXn68qcGIW6BrjdwA3VBSDbEkcA3vcyfamUs8I/cbDrVGyRECFsVwEtPEZ
         I/Tk4dK4s02hMRbY5fFz64QsKpU9clHYCf93uS+YFIL2eMIDXH7LUFy/ICwsQoB2VgJc
         D9j/3qGnWARV2504e9mO3BviGApXSbQR/2UE027tTrE2RMPaiUM90+MvLK3jAx2ObXgt
         zANg==
X-Gm-Message-State: AOUpUlGkHxdZkK6eYvc6TVmtnOpl6uDJ+ZPXTPcYq8bEI3qzooqs2r//
        rFjRsYUbtNxbcYqADVI5JfI=
X-Google-Smtp-Source: AAOMgpcn/OVnH+sLyEQWv65zdpw9ujf2cCZS8N9CCGqmlWxWmqaoYC27ABstaS1w/N1urjt87zQ76A==
X-Received: by 2002:adf:ab14:: with SMTP id q20-v6mr9215899wrc.239.1532374822430;
        Mon, 23 Jul 2018 12:40:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 127-v6sm8838168wmd.18.2018.07.23.12.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 12:40:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] Misc Coccinelle-related improvements
References: <20180723135100.24288-1-szeder.dev@gmail.com>
Date:   Mon, 23 Jul 2018 12:40:21 -0700
In-Reply-To: <20180723135100.24288-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 23 Jul 2018 15:50:55 +0200")
Message-ID: <xmqq601568re.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Just a couple of minor Coccinelle-related improvements:
>
>   - The first two patches are small cleanups.
>
>   - The last three could make life perhaps just a tad bit easier for
>     devs running 'make coccicheck'.

Thanks.  All 5 patches make sense.

Queued.
