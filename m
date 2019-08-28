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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A77F1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 22:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfH1W5S (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 18:57:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46314 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfH1W5S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 18:57:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so691857pfc.13
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qV1+l1fk+sjRmlrle4f85WaFDMOueAz4NHUlWFbd+PY=;
        b=G27SrbNwZvgmEG1lw03V35vrCQnBBu+TVeBq9G4gK8sLwVU+FVEMJEzmxjTndYeID9
         99KtmDAagRYbt5Fbg1Bt+z8HpPGTuVgZpjFjZt1mn+wsNn09ix74iDmg+JXim16auX3R
         1+RDHpMl3UuAQb5EbzawsNliGZ109G+uU/swZyZpXRycoQxis3E5arp/Bn4TfhR9EC4u
         DlwJY1tZf5VufKTFQAFmetSuzWXGJFeEA6AL7yx32LvPn6OYUgaLiQZeatgd8FkvngWY
         EqKcQyVkBq+46K3QN3xUOy6B11t9lWm+O3fgjAyMSYVlkecqmlTJSB0kgQcmes2d9FTL
         ArzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qV1+l1fk+sjRmlrle4f85WaFDMOueAz4NHUlWFbd+PY=;
        b=fHHve3ffB/t1bdAkj/86jUD6v+dHy9CqJ3xNVBF7u41rKbvbWQNnsJrnx/GrUisdID
         xaKK+R3mTmMQropeIwuXMLF+KnlbN7cuUOfX5K0rr9XggiRwLpIjpAPlomlI92eDu9Rm
         z++YcNrT5s7esmjgt921wVdhXMToA176N5fOc6AUx3cTri0WaVzV7vAItmABDqau0dLH
         xB81X2lPrAK1p8XOH1diaGnI4jxcsIxvn3bwdYZfDZzvaJkGa7UoG6YV9zpTxgik0zvx
         2D4mGs9fDDonrdLFMkhPQtz/0RnW0phKeITozawJ16EVxDhEWpblysD+Qj49FUm4GieG
         fIeQ==
X-Gm-Message-State: APjAAAXjGetg3QPWuy5bUAE/AL+e4PcYERHOVr+EqBlCiMTxgtqcyCqp
        FGwsfiJGKd8e+bTDTDMYll4=
X-Google-Smtp-Source: APXvYqybnRyguTCqwK8maiGMXNqRB1t3WpUbntR+REHVO8+1PAOuJNTeAIo0o9vipmGVuS0UfSVtHw==
X-Received: by 2002:a63:6888:: with SMTP id d130mr5286701pgc.197.1567033037322;
        Wed, 28 Aug 2019 15:57:17 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y188sm466162pfy.57.2019.08.28.15.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 15:57:16 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3] merge-options.txt: clarify meaning of various ff-related options
Date:   Wed, 28 Aug 2019 15:57:12 -0700
Message-Id: <20190828225712.20041-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.3.g93492fb5e6.dirty
In-Reply-To: <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
References: <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discovered on the mailing list, some of the descriptions of the
ff-related options were unclear.  Try to be more precise with what these
options do.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v2:
  * reordered the options
  * typeset the option flags differently to ensure they are monospace in
    the rendered documentation

 Documentation/merge-options.txt | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 79a00d2a4a..ed3804650b 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -40,20 +40,26 @@ set to `no` at the beginning of them.
 	case of a merge conflict.
 
 --ff::
-	When the merge resolves as a fast-forward, only update the branch
-	pointer, without creating a merge commit.  This is the default
-	behavior.
-
 --no-ff::
-	Create a merge commit even when the merge resolves as a
-	fast-forward.  This is the default behaviour when merging an
-	annotated (and possibly signed) tag that is not stored in
-	its natural place in 'refs/tags/' hierarchy.
-
 --ff-only::
-	Refuse to merge and exit with a non-zero status unless the
-	current `HEAD` is already up to date or the merge can be
-	resolved as a fast-forward.
+	Whether to prefer resolving the merge as a fast forward (only
+	updating the branch pointer to match the merged branch and not
+	creating a merge commit), to never allow it (always creating a
+	merge commit), or to only allow fast forward updates.  The
+	default is `--ff`, except when merging an annotated (and
+	possibly signed) tag that is not stored in its natural place
+	in the `refs/tags/` hierarchy (in which case `--no-ff` is
+	assumed).
++
+With `--ff`, resolve the merge as a fast-forward when possible (when the
+merged branch contains the current branch in its history).  When not
+possible, create a merge commit.
++
+With `--no-ff`, create a merge commit in all cases, even when the merge
+could instead be resolved as a fast-forward.
++
+With `--ff-only`, resolve the merge as a fast-forward when possible.
+When not possible, refuse to merge and exit with a non-zero status.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-- 
2.23.0.3.g93492fb5e6.dirty

