Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B69C1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 15:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeKUBe3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 20:34:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35903 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeKUBe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 20:34:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so2335770wrr.3
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 07:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFnBGSjgTElHMhs6yjaHhdVnDeQroIhQrVY1YilVAEY=;
        b=PGf4N5zdRc7P/l2dTLEg48z/lBgyscDsaK9wUOkwj2j6HsdWezdCZe5fcNpxeGtF2l
         opZfOIEWcYCQpKdLanpxDr2MvL4GG+yNWm2V8xO9w4aZpskX8d5QxKzbMarVnajp9DxA
         +QYcE1XPRpM4I1xYaRdCJGX+Bek4bLYNh0oIatEPkc+/rH4jZvIry/xJsQLIIAEwOFSC
         37AOJYOVJhIGrOU+1zIbC59nW8z/gBhY51nItBr8nAvhJvQImI4WS8QJPuPi9n5beN82
         bYlMGqChjyDpr5Llu8JjMV8WAJ1+LRhgj52RUJE0J0reSA72ogScuQEx8QCpiHsDqdwi
         f8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFnBGSjgTElHMhs6yjaHhdVnDeQroIhQrVY1YilVAEY=;
        b=teEmAuX6R1DQGUZ86rB4Vr3ZFSIUTEnLeQCS/XR8GrJJ3eManUK6bPJALx6oh+m6CJ
         GKfATl00n4JMgAwE2mOmMsI6XijkKHrkoo0drpVx6AtymAIsmQrruWCybYpQGU1XN7QK
         EcXAEZw2QMKdwGasuwfyZAA/ow1y5XqXvn6YFm06eZOb2x6pN+34SOQa0p2mra2O0lOC
         f84JyLN3xA3JMSLflZmaHxj/mKiyykoLJTd1ZiR4QldhAY3Bl3bTogpy5a8gEerrfjtB
         kURrsqmbYILUAXuAOTJ+IEezG+YqalHXXIn/4lRUh7hAnG+IZaLaALUxaxelHSQhJbH9
         pNtA==
X-Gm-Message-State: AA+aEWYwrW0bT8kcKghNbR8QR7WpHbV7ZCYCKv8P9cq0O1uywPfayFoN
        qzkhZhTB+g7eC0uIwFjvRW0oU63XeeE=
X-Google-Smtp-Source: AFSGD/XPBKAgqw1/hw7ITAE79JLMIbmW0V6EsExVBMQxg1kg4Av1DSNjK4XvPthrMc9ksNDPDttWsQ==
X-Received: by 2002:a5d:4b42:: with SMTP id w2mr2329777wrs.156.1542726292722;
        Tue, 20 Nov 2018 07:04:52 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j13sm26378460wrx.5.2018.11.20.07.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:04:51 -0800 (PST)
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
Subject: [PATCH 0/6] commit-graph write: progress output improvements
Date:   Tue, 20 Nov 2018 15:04:37 +0000
Message-Id: <20181120150443.12997-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181119225720.GV30222@szeder.dev>
References: <20181119225720.GV30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This replaces my "commit-graph: split up close_reachable() progress
output". We could still do something like that, but I think this makes
more sense, and also plugs some missing holes in the progress
output. See 6/6 for what the end-state is.

I believe this addresses SZEDER Gábor's concerns (thanks
b.t.w.!). I.e. now it should be clear to the user at each step if
we're counting objects, or just as in the case of close_reachable()
doing some X amount of work without any particular relation to the
number of objects or commits.

Ævar Arnfjörð Bjarmason (6):
  commit-graph write: rephrase confusing progress output
  commit-graph write: add more progress output
  commit-graph write: show progress for object search
  commit-graph write: add more describing progress output
  commit-graph write: remove empty line for readability
  commit-graph write: add even more progress output

 commit-graph.c | 98 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 19 deletions(-)

-- 
2.20.0.rc0.387.gc7a69e6b6c

