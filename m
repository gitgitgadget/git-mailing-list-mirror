Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D3B1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 04:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfHTEAo (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 00:00:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44848 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTEAo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 00:00:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so2389944pgl.11
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 21:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61OydYBJ1wEDo3GAJCLLxHriAc5EhWCHra8pfNSUT8o=;
        b=uOADV9r89s0DobVh4SCPYSjYWxCi0PNFkSbeMRhwiRqlkrtL0oT8LnKoG9PmW2f/eM
         VnNKLj1qd0NoLchCpcbVMTtM55nSku9LJuRXKvKqnD6fhd+B1gtf8a7Mg1M0R7jbRO3C
         WAIi5x/XOVvGdwI45MqKW3wGeSr0NdbHGuMcslLvc97f9WTZcPVf5Nm/2K3YtJbZmkWV
         7aou+TRC5WxltKDIefPDa4J7eQzvvYBR3w7822c9IUOrpfSTrnZbmTFOqZOhpsoKfOd6
         +tG6Hfak9/Eg5MkPqDY9q0CY8OvYJrEHBWGEFKmnC306dZk4+3on2ya6OtNKsjxtHwpz
         NnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61OydYBJ1wEDo3GAJCLLxHriAc5EhWCHra8pfNSUT8o=;
        b=OIrOV8tTQv2jlRdzx0fJhENtMBjjoGXKVyEhbn4v92zckPL4oy6ztWr18SBTCVAi5a
         7LlS78Q1fqhtJjx5luAWFcREoB/YCHCxIxSZIC7SqBURpoYhCeRTxZ5fSBh+xQ7JKoVj
         ofw+JacpkMeCr23+yB2YAHRqPW3PcoQtNb33x6M5nFaARQHa8BKSAt3/z6yPITpLmvgH
         1oUFgpcbg/T3WGcQlVzjYf0CLDiJ7+usUZIe2BVLWsuBbGENPC/zLZU39oqfnnaJ1P5n
         1d7wVJhxAUaNVW9dGnfbwHgc2SzhAG8l8xZHW4uyM/0v2MYCyYFg8pSfiGsGlryAUOw9
         DvPA==
X-Gm-Message-State: APjAAAUqBvoB+ey5+++Z5lkdQ8ivAETlfqiYynYhVrbTx8rJkDmvQhW9
        YlcUIYleF6XAHK6JTvzoibA=
X-Google-Smtp-Source: APXvYqyq/7KGqB5Ro+joTaWGfC6Ex38XxhoHMEpPAxtLK/UUEJg3hppqaY504is9m22DNGsZqFyhwg==
X-Received: by 2002:a62:1444:: with SMTP id 65mr27466841pfu.145.1566273643574;
        Mon, 19 Aug 2019 21:00:43 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.227])
        by smtp.gmail.com with ESMTPSA id a5sm13172263pjs.31.2019.08.19.21.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 21:00:42 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v2 6/6] rebase: add --author-date-is-committer-date
Date:   Tue, 20 Aug 2019 09:30:36 +0530
Message-Id: <20190820040036.14798-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820034536.13071-7-rohit.ashiwal265@gmail.com>
References: <20190820034536.13071-7-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone

Please ignore this patch. I forgot to clean the output dir before
sending this iteration.

Thanks
Rohit

