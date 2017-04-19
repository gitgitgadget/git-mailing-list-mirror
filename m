Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E251FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762471AbdDSLCI (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:02:08 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35061 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762467AbdDSLCI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:02:08 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so3585664pge.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+ZNOkLTmaoxZ3bP+4kCMF07sjLMGmwIsvxCTeaggP0=;
        b=Vx1ACRjS6LvUwAr0GyTVPqpOElXxoorCsQ/vvfea7LYTfgwjCRUUKxUZIbQDweb2gg
         xYZwMXQ+0gjAJ0b1NZ8TG3MaS/vKGCwQG0qKf33iYkY5LDSz9KscIlDeSZCwThRtmPK+
         trRMfr8ozPHRTR5TPvdJ0tC2lA8rve+ruUiVFsolRJioIMQDUSNuh4O6ZmLOO0Y5Zqox
         ZdK3RfG5tlsIogBtjLWk9kv86IZAAk7y4ZiipVbweMNFs57eFt2RjjbywEOAtbvNgq+3
         KbbnLIFJWMEo9cZj39NXt/8y8/sWW8LZeAsBFDSo/tsPta9a5+v/vLiWxt5YvBhQTNou
         xhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+ZNOkLTmaoxZ3bP+4kCMF07sjLMGmwIsvxCTeaggP0=;
        b=VKCzOyJYIVKBDXgmUP6NiQY+lF6duzhha8cfZB2bXn8Nn7/FuCftbXndgL4RX/EFWx
         WFZn80LTs4eNUmOYoyUwYhLlVUpo7e74+Eo2ZYPx0IQqg2igsEKfr31pEzIAVMNCa9c3
         NoJtwAa497X5hpZfvKBj/zjDZ1uoLpFPHOT+M5Z7u5RQyd2qbu44jjOP2r2vYk1AXd87
         oTNoAe+lgRsHhCyCDpUKPSQ1UVR5GayrAT9nO4y5MhmqaNld4H8u+Bx/yh3uR2Szgvus
         meF6FQRDMGKuroZLbu3ttVbSPJ9q39vfiKafMzvgcqxtEG93l9Yl1JLKpY/7bo7+vvyT
         0syw==
X-Gm-Message-State: AN3rC/65kXrhNzi4SRugKIHI0UM17iueustvivA3RB9FMQp9sEB/FpNI
        EqJSyv7Iq6uD9Rvg
X-Received: by 10.84.196.164 with SMTP id l33mr3350902pld.0.1492599727166;
        Wed, 19 Apr 2017 04:02:07 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id m3sm4012858pgn.30.2017.04.19.04.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:02:06 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:01:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 01/12] revision.h: new flag in struct rev_info wrt. worktree-related refs
Date:   Wed, 19 Apr 2017 18:01:34 +0700
Message-Id: <20170419110145.5086-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170419110145.5086-1-pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The revision walker can walk through per-worktree refs like HEAD or
SHA-1 references in the index. These currently are from the current
worktree only. This new flag is added to change rev-list behavior in
this regard:

When single_worktree is set, only current worktree is considered. When
it is not set (which is the default), all worktrees are considered.

The default is chosen so because the two big components that rev-list
works with are object database (entirely shared between worktrees) and
refs (mostly shared). It makes sense that default behavior goes per-repo
too instead of per-worktree.

The flag will eventually be exposed as a rev-list argument with
documents. For now it stays internal until the new behavior is fully
implemented.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.h b/revision.h
index 9fac1a607d..c851b94ad8 100644
--- a/revision.h
+++ b/revision.h
@@ -88,6 +88,7 @@ struct rev_info {
 			topo_order:1,
 			simplify_merges:1,
 			simplify_by_decoration:1,
+			single_worktree:1,
 			tag_objects:1,
 			tree_objects:1,
 			blob_objects:1,
-- 
2.11.0.157.gd943d85

