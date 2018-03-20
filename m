Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A0A1F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 09:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeCTJEu (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 05:04:50 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:37384 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752245AbeCTJEs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 05:04:48 -0400
Received: by mail-io0-f179.google.com with SMTP id y128so1405876iod.4
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y8UpaJoT9AuStfqGhf2NQtbviL+anNLYvGM8dIakaKU=;
        b=TlpiIeYIAwtJvGXLcZxuObG2dLOlMHjuxiAgEaYyh0rHRdsY3O4B5GZ8Bb7uX8gs67
         BMxTP5eK7cZdpuOaQaDNX0veHlJkRMyWewcOY+eJp2ukJWxs7KdzZ+nf4y+/ZeFq1Yej
         zAwYp1dTvIDHVZQ+A9FMo2iQhJr9j8kSStQUygIVqvztlhcIycV/UTSYS+mmOpvyN9o/
         V8DhCFntd29xhEtOrvxWsQ8zg+qUtsJVTxeYOOVrwWqo91uhP0RwpZZowKUX4X1dczjt
         fL6k0KkdsZG01SqgFVJedDM/57hvTDgei3er9i5seoviHoVqfhDrkziRMENQtNsYX8o4
         eD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y8UpaJoT9AuStfqGhf2NQtbviL+anNLYvGM8dIakaKU=;
        b=Wos0opkHDoZYWagIkIMNcnoQ96ZOeuyyPUBT1a4Z8UQJ7UEHH4K4cqZTV/iuZSOoir
         ZqkFnpc+ZbsAFNlNUefRU6sSdWcR6WGhkFQ2JYODHwChrIHoq8T2qwkICItetHc2t6AJ
         pgVIX5E+8l1J9UcVmRdPzVjYlA2iCi/L1G2eehJyQqoUUgV2kyvvu06+b1bOT1QOik4c
         hAn/w0u8RUYtztPUYcwRhecRf/4TNy14pT8qQokZ5F1HHPgulEZczoZQvGz/W9XOwwzg
         140OIT81cRJ3YgHBJgi54QZguDAdGAKr3rVGLZ5e9z8qxIiWd1jMHrWmzJB8c3q7MwAx
         3bJg==
X-Gm-Message-State: AElRT7GVcKvRmbkFF25I6lXPERbz+PPo9Bd60jJdmd2w3Qa0P0enDFyz
        YHnYt6fhLDtDd9B1aeW720iKNsCJ
X-Google-Smtp-Source: AG47ELs9n8dhsxudLDuuMyvnwuAuH1zdGxssH+frZer2KMmLjGi9CO4V7ofldmNoT17vMrwj4cC7QA==
X-Received: by 10.107.43.203 with SMTP id r194mr15481433ior.221.1521536688117;
        Tue, 20 Mar 2018 02:04:48 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.81])
        by smtp.gmail.com with ESMTPSA id 199-v6sm1038514itl.1.2018.03.20.02.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Mar 2018 02:04:47 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC] [GSoC] Project proposal: convert scripts to builtins
Date:   Tue, 20 Mar 2018 14:45:13 +0545
Message-Id: <20180320090013.26512-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
This is my draft for my proposal on "Convert Scripts to builtin" for GSoC.
Please review and provide feedbacks.

https://gist.github.com/prertik/daaa73a39d3ce30811d9a208043dc235

Cheers,
Pratik Karki
