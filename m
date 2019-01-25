Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0281F453
	for <e@80x24.org>; Fri, 25 Jan 2019 19:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAYTNf (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 14:13:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36001 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYTNf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 14:13:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so11476115wrp.3
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 11:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gExK3rnXKjv2FchIbfQL+8GziJ6VaPfXReAbVsieA7Y=;
        b=aNwMEkHTK349NkA83I8h0aPLE8rt8d8AZkeapH3/JYOlk6DvCT6gtqWW5TDKH8YmWv
         L/3LMRi7tfJ7S375BS5GuRhletSwg2+W2THkIQ5c5w3v79sOOsLV/sbvT4AdCFCFxnVq
         yWTiTeyB5JTDbgrmQpTEDfpP/lWH8Wz0rht89+Cu+A/VsLlJgFQ/yWXx0a83kiRVLifU
         KZj7ZOeuTnp/sIjO6YFjPnmm+GDMu1dUiIUgZMXlAT2bX0hd4d2/SMpweIzHd9r5MPuV
         AIthzv3icDOLMt43HaZUA9D1CtyaRmrr2TGXA2BK/nlAZjFZDc3tE78X47hzb9iO8awn
         j1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gExK3rnXKjv2FchIbfQL+8GziJ6VaPfXReAbVsieA7Y=;
        b=P8VF+ghZJ4J8esP7g1zu+iQ3eFGGe+Ez3DVjEiDIajcWW/GBLBHTnSq1dd668fNsHA
         Qfw8bAl/u7mXDoKI1JTipRxPooA2SdGat6YB/BEQjfTa0SSGz9c3O4gCOwf9WfIXOlSV
         XlW7vW+5Ai/Qnnh2mvyJw+FZh4NLIvG38CYBu3aLJJ3g0txiUATz+aX5JKrQ47pZhM9a
         qTsykrXc7AZvS74L16WFdJwRDt2jCZsuDrDsVPZ1wPeO7lXaeH5dAryCn9ut1wlcTecG
         eTKWCA4Z3Gp3zC2gLcmtFYcRcOHULzKoMuegpHgfZJ6XTJfw4D3p2/YrDSkBOC0aGmxe
         FXTQ==
X-Gm-Message-State: AJcUukfZl7WAo2zhx87WdjsKix0ENjJp2aoWMnvQ6JFZogbCx+vEODwC
        5daTUMe8UZ9JOzFPGHvIoVA=
X-Google-Smtp-Source: ALg8bN7WbPWOUpButndxHz56rRU39kX5l7C6ej+urpSJmAygpoVR8uL+WD5rnAWn7T/MNzyLZduUhg==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr12376267wru.291.1548443613178;
        Fri, 25 Jan 2019 11:13:33 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k3sm140739577wrm.7.2019.01.25.11.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 11:13:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH 02/14] trace2: create new combined trace facility
References: <pull.108.git.gitgitgadget@gmail.com>
        <4aaf4834bfa9f2169e2c00f7cdc6c75281567c15.1548192131.git.gitgitgadget@gmail.com>
        <20190125112203.GB6702@szeder.dev>
Date:   Fri, 25 Jan 2019 11:13:32 -0800
In-Reply-To: <20190125112203.GB6702@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 25 Jan 2019 12:22:03 +0100")
Message-ID: <xmqqr2d0ft43.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> +	if (ctx->nr_open_regions > 0) {
>> +		int len_indent = TR2_INDENT_LENGTH(ctx);
>> +		while (len_indent > dots.len) {
>> +			strbuf_addf(buf, "%s", dots.buf);
>
> Please use the much simpler are more idiomatic strbuf_addbuf()
> function instead.

Ahh, contrib/coccinelle/strbuf.cocci would help ;-)
