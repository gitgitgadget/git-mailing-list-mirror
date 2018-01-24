Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B86381F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932696AbeAXJjC (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:39:02 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:41726 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbeAXJjA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:39:00 -0500
Received: by mail-io0-f194.google.com with SMTP id f4so4166326ioh.8
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kmq6tTqhUcLixplcKSBLGoj/zaa1TXa6J3Y86bwIs8Y=;
        b=obvFlIa083HFGv33kYdSahRJDBZ68scnP2IOoLyfMs0dGL6UKnLRux7+0YRBNOLoJz
         rlnOeVJaIJXDeLuPoXnkYvmCoGR4c3vQdfJVxDGatlLtQluY697mKfTUEltEIkLj/IUV
         Hxe4cOtEpQSN0VSkoBqBoRMXtOY4F3uLa643XM6ulfUhgaMrXbgwJt5v0rSOnjtHwSWL
         qIn19dwBitqDXgsQzOESSezA1j8jIkjYsH8OT4oRW5xR3nP+AoMuoVF8+6zNE5KfrnvW
         f77WEcFLkYCJTcgktlrJ8ZKgnU2ixlwjSB5XBdqgJ8r5V6sZMutiHN4XaVBPCG86wKX6
         rw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kmq6tTqhUcLixplcKSBLGoj/zaa1TXa6J3Y86bwIs8Y=;
        b=cL3NpKYtzHinka/J+TOgd++8SX93xPm+SDIHnDvGWhoQHN1JXjTaHgM2C7jsQAwm4m
         NFoqJ/8kXDA+7DJda9hZHgLj7TrKf0PNOCj6HEmsMABwlB8vkAUSBTmvZ1yc1H1nDFOm
         vDbnOZLpmrmx9g8K1GEvwEKPvd/1+cyPsq+A6V20UJaB5HLuC5yELZAm5Nhne4+7B66d
         /9oz09O9nmkIFHk0qtlx4Y7Bl47ZvoXVJrPMxZRQ3Kv6ojDgS8ASwb/8rbLcV8xDOVJI
         aOS6d0eo4NABaWNoEsXbm8wNIvDCSqJCAOW7ZsevYo4k08OwhVcsSQmmSZ+Yh4JjCzod
         CpiA==
X-Gm-Message-State: AKwxytcT2+0JGEDGrCHM9GMCEMwuNpQgWBxhRghky2zoCjEGY3VZHIwE
        T/xJPp6i1BggfRuW7ecRdPmTVw==
X-Google-Smtp-Source: AH8x224LUwYi/e/Fek6+KxIcYNfnybrxNHKmbo6vXPOvUkOyxXu8vGMAnG+yDi6P6Xte5/RaOTZx1w==
X-Received: by 10.107.205.203 with SMTP id d194mr7434156iog.42.1516786740186;
        Wed, 24 Jan 2018 01:39:00 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id e84sm11135199iod.76.2018.01.24.01.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:38:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:38:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/3] nd/shared-index-fix updates
Date:   Wed, 24 Jan 2018 16:38:26 +0700
Message-Id: <20180124093829.12966-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <xmqqfu6xjxrx.fsf@gitster.mtv.corp.google.com>
References: <xmqqfu6xjxrx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the new test need both prerequisites SANITY and POSIXPERM
instead of just SANITY (on 'pu').  This is how most other tests do it
so we do the same to be safe.

Nguyễn Thái Ngọc Duy (3):
  read-cache.c: change type of "temp" in write_shared_index()
  read-cache.c: move tempfile creation/cleanup out of write_shared_index
  read-cache: don't write index twice if we can't write shared index

 read-cache.c           | 40 ++++++++++++++++++++++------------------
 t/t1700-split-index.sh | 19 +++++++++++++++++++
 2 files changed, 41 insertions(+), 18 deletions(-)

-- 
2.16.0.47.g3d9b0fac3a

