Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9303F1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbeFFHjt (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:39:49 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:43528 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932214AbeFFHjq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:39:46 -0400
Received: by mail-lf0-f51.google.com with SMTP id n15-v6so7540453lfn.10
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L332VTrnguNRWJBGhfGFO92Iw8pRUTSzYMMIxIRTGM0=;
        b=naTVLJFITcGFXFTQQZHDYHBwgThwwtgHJCtPZrfm4PB3XkpImmevqJrWu4YwueHa7A
         W6xc+NUXK6kzDQn8dUKDibCAF7qpOKl0aRhAejeOwzHcdw5x2ELuVup7yIadMQV0eaJJ
         /moB5/8TyannEJWSuUx6C79q9D31ov+0mZX0Sw6o4E5HIy79HhJSY+j2GeypvgSsFfze
         Gtzsu3LqDeBttEppKeY9jdQbKZRXudcxdpVvpGw3j49yTVjgDLcAuDuHmdVmKvTFHkBV
         iTvxhyLUER6efq8/gafEfLUCjQKdFfYIjiYqIt6G/37OAv0ajW6p3jy3aEZugnUw9k0E
         pxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L332VTrnguNRWJBGhfGFO92Iw8pRUTSzYMMIxIRTGM0=;
        b=jWG9AuzN7DqyxDhi5VhiBql+4M+X0K6HQc+nuXoA4tPKzlmSKNmLaIc/FChdpLxeUb
         92AG4DbSf2Ce5/cNXMT5gcOwKkcWq5SQ2KJdrFyAEAqkTdIdK9rp0yP/geBF4tEeNdmK
         zKwWEZSTEi9w/Sa5cU0gE5+iQjbykvK4XPvyJfLfOMDhSNK0ULqcrc23dV/1Vzq3tPut
         InvZtT6hILgJ+5phszqtrsY6rqnGyt3PVRym61aS6LmPuQMRL6YjQQiGAO9A1L+d0l/d
         7WtZpcn/SkWmyQ0iwGFv69aeaUrWglvjpQ6+3yNCYpELCMKNZQMldiYct0rzTLaTlFCB
         K6wg==
X-Gm-Message-State: APt69E3516VMQNBulM3ttbjkw4XZXWoTF0SDIiFVLETWCVN59tINC7FS
        q7/nZfit4+w66ajL74KMhjk=
X-Google-Smtp-Source: ADUXVKLAPEmQuzHaiHa0pWUKMcY3Iub8QeQaQ3ocVoS+oAqRrqVKK3Nbh136zgeBIaYia7j81Kqr8Q==
X-Received: by 2002:a2e:61a:: with SMTP id 26-v6mr1211401ljg.91.1528270785510;
        Wed, 06 Jun 2018 00:39:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:39:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 01/20] unpack-trees: remove 'extern' on function declaration
Date:   Wed,  6 Jun 2018 09:39:14 +0200
Message-Id: <20180606073933.14755-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..534358fcc5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -82,8 +82,8 @@ struct unpack_trees_options {
 	struct exclude_list *el; /* for internal use */
 };
 
-extern int unpack_trees(unsigned n, struct tree_desc *t,
-		struct unpack_trees_options *options);
+int unpack_trees(unsigned n, struct tree_desc *t,
+		 struct unpack_trees_options *options);
 
 int verify_uptodate(const struct cache_entry *ce,
 		    struct unpack_trees_options *o);
-- 
2.18.0.rc0.333.g22e6ee6cdf

