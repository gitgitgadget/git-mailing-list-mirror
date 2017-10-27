Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E95D1FBF4
	for <e@80x24.org>; Fri, 27 Oct 2017 23:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932334AbdJ0X1C (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 19:27:02 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:56491 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbdJ0X1C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 19:27:02 -0400
Received: by mail-pf0-f173.google.com with SMTP id b85so5943963pfj.13
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 16:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id;
        bh=W9rlzYPEFatGyaTbgqUwEwuUAJezphfppO4NA2mCXpA=;
        b=W/n1K1fyqPVcvqr5oF7bSmroMKsqYInYWK/4s+CbWglEqUWwJ07W6V3fJdMJprjHRu
         hv0JOo1m1/TK4k2jutm/k5FpAryawdw9nenQMwDQ0XHuwf/OnI6ktVy9kiykGs4/IMDn
         NZqU/pNIfVfCvnrVpcbAbGxCDFiOJ7gNS7Ds8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W9rlzYPEFatGyaTbgqUwEwuUAJezphfppO4NA2mCXpA=;
        b=VqKgmy5rEU7yzVepHMCxywUNapiHk7lCaGTul3C5Hhez0Z3oezupTSrHW4MJGDc3jp
         uokQd4uTQPmEOrvHk5ncC8r+zqBDQePgUWy1wgQrzAKV9d5HX/TWErNXT7st98823KB3
         TWN0DWaogjsP+iXH5YaSpJKUeXz80kSqVJjq89hT4h1CEaZejNWupsY9ULFdYkzo46NV
         Sp/aKPKL1cNWYEmC2u1v3U8Ru/osbj4ZxsEMJ4kmCwxTONmdJXQHF10UgfguBPlp2V3k
         nvF5zXrg5EkFFDI4rlrAxSOxFz+ON7Zv4TvCzkrKRVR2EjCx9ZfAsj6f6mm2T0U0V7kI
         qN+g==
X-Gm-Message-State: AMCzsaWnokBcJUmKYSspDgxisI/izHKlSbTHZC0UFKHYip6RWdIGz7d8
        TCUmNRJZHco7ddXxiahYMAUC13uLN8E=
X-Google-Smtp-Source: ABhQp+QK4f3ZUvQEEgarR8ttg7D+m9yIxuOYKv4/68G+vtm0Roa2tPuZMzEkNb5/P5yjk4uacaECrw==
X-Received: by 10.99.142.196 with SMTP id k187mr1521647pge.384.1509146821224;
        Fri, 27 Oct 2017 16:27:01 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW2.corp.dropbox.com. [205.189.0.166])
        by smtp.gmail.com with ESMTPSA id i129sm15442806pgd.21.2017.10.27.16.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 16:27:00 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v3] 0/4 fsmonitor fixes
Date:   Fri, 27 Oct 2017 16:26:33 -0700
Message-Id: <20171027232637.30395-1-alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updates since v2:

 - Fix tab which crept into 1/4

 - Fixed the benchmarking code in the commit message in 2/4 to just
   always load JSON::XS -- the previous version was the version where
   I'd broken that to force loading of JSON::PP.

 - Remove the --no-pretty from the t/ version of query-watchman in
   2/4; I don't know how I messed up diff'ing the file previously, but
   if there are already differences, it makes sense to let them slide.

