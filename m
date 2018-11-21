Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF9A1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 01:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeKUL4D (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 06:56:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45641 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUL4D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 06:56:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so3894870wrr.12
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 17:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lsmFdJolrk/nfeb41BA0i7Qd4OXos1tWpA/DB7xYsyE=;
        b=ApmUSqEdFtSFoaBJ0w9eX8g55bVYNg4SSgtcLfULTHkbMOu2e3Nwg0LdhfxzcXqZhk
         FUPttsupQTF0suFR1t4lkaWNIG5m4D8Nfdkpd7zfPbnv//sAg72cp4V0zOYYg3Q3+nKB
         WLUph8bftSIsmeJeQNuO4uqzNoySqIhnI5mM3SKKia6pWy1MfNtHPCBjSSkx+YxjWvCB
         rlEYfC4ZCu9vSut5omL5VWJJ42keJJsa2mM/FjmtTN6czsahtJq8HAK7n15xOwb+ajVh
         ISkWCUx198IIgHJZb5SSyaKkYirs50hS0Th4zkRQDVE8bWyV4CKjAC2CHSUxjzQUsWxv
         1l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lsmFdJolrk/nfeb41BA0i7Qd4OXos1tWpA/DB7xYsyE=;
        b=q1YMUmlsdGF11AUg5McvrSBMTDV2XpOnQujwWSL59gTdU3sO6ltERqroJQJU+Sg54l
         pNycJalFLsD8T0yOxQmIrBmgX81zYiNVjYgsWYefZ4hRrEbda+6asCSWis9ePwrnZfuf
         XQGlbGaoOV/cw9jVDxfe2d3mMD4IvnlQXqjvJftH9dlU9pvrPBNicuAJc3CarYFAjJwE
         Sj938srj49HtpqBBE4j7tBnyOv0Jaynx+Bev+srOP6IRFsvT2Zj0TgwK56GYPjG16zOq
         rF7dirTJHuNJ6p8S6NpBXYI0CumDceWX2FUo3XrQAX7piQIxouPhoJj8FVYRJwmOnx4J
         bgqg==
X-Gm-Message-State: AA+aEWZc8N34McF99mPdoGbJ1FXntoqQ0OdMw+4k1ub9LoDtAKkcQM1h
        pj1nwMj3IoNmJDK6FJOMO7cmGbab
X-Google-Smtp-Source: AFSGD/Xfr3JsCLcO5G3rQYeiWd12ZFl5FGbpSo114bGjDHjuwqRkKEzJ0FFuvDgPgLkmd/stJ8iwSg==
X-Received: by 2002:a5d:628a:: with SMTP id k10mr3765434wru.254.1542763435570;
        Tue, 20 Nov 2018 17:23:55 -0800 (PST)
Received: from localhost.localdomain (x4db92154.dyn.telefonica.de. [77.185.33.84])
        by smtp.gmail.com with ESMTPSA id t187-v6sm29377423wmt.45.2018.11.20.17.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 17:23:54 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: 
Date:   Wed, 21 Nov 2018 02:23:42 +0100
Message-Id: <20181121012344.26711-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.134.gf0022f8e60
In-Reply-To: <20181120165800.GB30222@szeder.dev>
References: <20181120165800.GB30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 05:58:00PM +0100, SZEDER Gábor wrote:
> I saw a
> bit of weirdness while at it, and want to look into it, but now I've
> got to go...

So here are two simple patches that address the "Huh?!" moments I had
while looking at the progress output during writing the commit graph
file.  The first is a small cleanup to avoid confusion, but see the
notes attaches, while the second is a bit of an optimization.

SZEDER Gábor (2):
  commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
  commit-graph: don't call write_graph_chunk_large_edges() unnecessarily

 commit-graph.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.20.0.rc0.134.gf0022f8e60

