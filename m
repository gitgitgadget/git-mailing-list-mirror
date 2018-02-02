Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963571F404
	for <e@80x24.org>; Fri,  2 Feb 2018 00:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBBAxn (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 19:53:43 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35289 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbeBBAxl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 19:53:41 -0500
Received: by mail-wr0-f196.google.com with SMTP id w50so20968963wrc.2
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 16:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hcwMH4lWc5T+QWXNFG0Y5aE8x0rd1lza3ukHyk6Yf0U=;
        b=IgRRRPbp9ruk3JyDdkqYfyzemyVKn6OUnrBtyv+uM95tQAew8EF8E7Mj6NA3hKFxmi
         0xy0Q/TAJ3xMEyBlHUpRX2Gzgj/3XNFtKY7lWR93p2XaU+E5pUrRm0juUtxDzXiO0JZJ
         PYUrDYSu+H/FAkF508e+F4Ingp4Zc3weqvCaifqjq5JobUsVfgQ9nctyY/ijlkv+hzkV
         h63INxXiDoO293+GarZpfKO4NZbLpx6waAyjtHdA05Du7TP0QB90tlokkWZLoOsjh7BD
         bclePp8cCBYOJ74A3E79sny/kF1teUPWrbSEE+1BJc58/GfxiiJewVxgzYM2STFJi9kv
         Jn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hcwMH4lWc5T+QWXNFG0Y5aE8x0rd1lza3ukHyk6Yf0U=;
        b=CGKIUfSu/OsE9DAmfENPamsT2xtedhmUS0Os8Bq37ZA8Ce2hIsI7Prfar0Hmv+sZuJ
         giz37/W9sAz0x7B5igSMihNWoqXrqqDcV+jhDbQLRrvUilB/ZKAq8WK1X4oSqViwIGKZ
         DPUrWAvGRm/Z9AAGqeJlkWvUgTNRoY5sTKOwyafxacpL9RuHX1NrJWAc3YvlZ4eCmX+Z
         5Ht7W4m3/htkCdHXr3A+7mHcs/1L/2gU7qjcKqmvvEqOePsnbfAZqYrIMfMEHysiW5jU
         KLfOkVDGvFY6iDXj/FkMPm1iNg/WR1Ae7DXPnwi9G3oO5yksi785/ja5hY+2Q3ZXUnWi
         JsnQ==
X-Gm-Message-State: AKwxytcO5qIMhOkhAb39VG0MbhLzisPop4GydjPDz6dyWjvFTCL4/jfc
        sApNZy+SfZ/+KluJYuE7D7o=
X-Google-Smtp-Source: AH8x224R21wSDFiHh0w/KiaThXMLmigSD8pK2l662zBq44X4Znrv2lI/Zn1e1sstB5Nlvp7O6TTZWg==
X-Received: by 10.223.175.196 with SMTP id y4mr26663078wrd.195.1517532820711;
        Thu, 01 Feb 2018 16:53:40 -0800 (PST)
Received: from localhost.localdomain (x4db049fc.dyn.telefonica.de. [77.176.73.252])
        by smtp.gmail.com with ESMTPSA id y6sm274529wmy.14.2018.02.01.16.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 16:53:40 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 03/14] commit-graph: create git-commit-graph builtin
Date:   Fri,  2 Feb 2018 01:53:35 +0100
Message-Id: <20180202005335.23410-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <1517348383-112294-4-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-4-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> new file mode 100644
> index 0000000000..c8ea548dfb
> --- /dev/null
> +++ b/Documentation/git-commit-graph.txt
> @@ -0,0 +1,7 @@
> +git-commit-graph(1)
> +============

Here the length of the '====' must match the length of the title line
above, or AsciiDoc will complain about missing document title.

