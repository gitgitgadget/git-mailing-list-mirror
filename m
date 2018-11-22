Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726391F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 13:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436853AbeKWAIB (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 19:08:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39184 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436841AbeKWAIA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 19:08:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so9149920wmc.4
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 05:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sW0q4dxvjWqTu5oModp82GaBkhs4Vx9uSJ36sGQO/bc=;
        b=neYJz+eN/UgDw9l/3A7beY1KX/l6N4dv8iBXMOer/6rFd4wLd3YIr+IvpuuwrqtCLe
         MWqn0px8hHq3x+xhAQkc1M1vuRMUVDE11zYLS23Y+I8xjm99NivF/I1oD3kX2sWG2s6f
         NBR3hLkOR2JDb6ETEkd4u30TFqNdn2YB3pzF8qehp0dA7KEEdJ5C178raYXGayGnBoN+
         ye8sSVl1wWH7P26jwRdJzXytP2sAxZLa5XZHTS4UDMPXltJ9Vv38JL54uKCpJJvZUHjj
         S+K6QLdxO7TKSN5Ao9OOIacTfxlcX/NPkVMsIlJM8O6GJI6OIIOvz1kCUEcZTNoxfXwW
         0g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sW0q4dxvjWqTu5oModp82GaBkhs4Vx9uSJ36sGQO/bc=;
        b=b/ww5y7TGCDFjNDcb6rXLgGDvGyK7OP/VN5wDYAMhL3hqhhhIMIRcrmCgMZ9bJrvdZ
         WR/MlxyzYlHP/8hXBovMyqxiVl1VDLAdB8GAqFOSX5V/8x06UOfIf1LLJmxsbUFPW8/l
         bG6NVFHv9iz2HuEY8oDG3QAoPmVS1SEsSp4RoSTrLNH6zXuZWHkQl1KWPOxYWM7fiWXd
         sceqAtwyLE5xm+v61A1eCGohntDkgycfuIr5+HKTwH1SIHqvQHomaQ2cqtP9OKhWHCI1
         kxiV2RUBt2HxsQEAILWgF/Um6nkEa5jg8FpZcNlYEbjT7VAe8vMll+K0uNg5BRcUB6sx
         vbvw==
X-Gm-Message-State: AGRZ1gJR9vOxickSVnw8BeIma/61pQDWCifI/EUtIV/vdFpG9Zd6LnkM
        u5WK6lpsiij0nQfRUDRyNcc2F6in
X-Google-Smtp-Source: AJdET5d7jSC9K77o6hvuRke5eec8FGw31PYdqKStF8i5vU8AxWQoW8PijWhgqbrVrjcSB6D1KIxTlw==
X-Received: by 2002:a1c:7a03:: with SMTP id v3-v6mr9514620wmc.108.1542893317019;
        Thu, 22 Nov 2018 05:28:37 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm5418165wme.30.2018.11.22.05.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:28:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/10] commit-graph write: rephrase confusing progress output
Date:   Thu, 22 Nov 2018 13:28:16 +0000
Message-Id: <20181122132823.9883-4-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181121012600.26951-1-szeder.dev@gmail.com>
References: <20181121012600.26951-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rephrase the title shown for the progress output emitted by
close_reachable(). The message I added in 7b0f229222 ("commit-graph
write: add progress output", 2018-09-17) gave the impression that it
would count up to the number of commit objects.

But that's not what the number means. It just represents the work
we're doing in several for-loops to do various work before the graph
is written out. So let's just say "Annotating commit graph", that
title makes no such promises, and we can add other loops here in the
future and still consistently show progress output.

See [1] for the initial bug report & subsequent discussion about other
approaching to solving this.

1. https://public-inbox.org/git/20181015165447.GH19800@szeder.dev/

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 965eb23a7b..d11370a2b3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -648,7 +648,7 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Annotating commits in commit graph"), 0);
+			_("Annotating commit graph"), 0);
 	for (i = 0; i < oids->nr; i++) {
 		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
-- 
2.20.0.rc0.387.gc7a69e6b6c

