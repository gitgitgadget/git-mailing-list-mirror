Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0193EC433F5
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 13:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiAANvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 08:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiAANvD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 08:51:03 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BC2C06173F
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 05:51:03 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id x194so2859107pgx.4
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 05:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0rrIqFOKIp4y6IioSd37COY9Fb8tOnPbzYmS/OSpbyE=;
        b=MrNlwdvbRkIvtwd3HOU+PALdMV281Xfri7RpV5Uu7j427CyIEMqVW7nG+kqg1aPSrq
         lHs1oUdC4zzU7IZknVYm3YXdLqEWal8UPkMfDxPripiWIhIBIkS7DcX+748x7R/Y30Br
         hsQonMs2olTkXwoCz35USY0wIF/3cgDkpaRgtHzQjfH9srImFWPoIJdMvGxgmlaGlz6Y
         eC8AEzI0TTcpYkJu6VEIMjg/0gJvxrdO9YW936oDbQo9oKbXSMx0Y7cnRxbtPn4yyapF
         HNrdulUemxlUXWR0D1wJWwKKic7jZ9gnatfTWXzuv8Tn7bVX5tcIVZJIyQUNwC+YL0SC
         CYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0rrIqFOKIp4y6IioSd37COY9Fb8tOnPbzYmS/OSpbyE=;
        b=hnF+czGyFn7zbwEBwcewBF+awBLGPnRHwb7/Ue680KvolSqsVJtfOyNkjKZLviClYh
         kA0fFl5CMV+nBMzWrqTINGDDYS/VYYeb2HU1vUK7vp1jLWCkGVw2qwmZl0dJYD5591Vo
         DQLzPMf1XmQ4Pt4L1chsF/eBfV5E7BAY49LAo0NPNriuCqWAwYlxwW6ot3TKeBljmZgV
         ippYqfEuIv6+76k0QVKlS8yrRf8wET+6+CFdabhnZr3t25i/yAabRSX4ig7IvFe5uQcM
         j9O1/RaP+2CH63RuPZdmTQAYg6XaQBRXBLYcfm73x0kbk3bAJ47ZtQ0ZQ/Chclgyetmc
         H/sA==
X-Gm-Message-State: AOAM533CdweRpUjaxdPg120pEdfbOY08Pmv1lFmw3XrMS3gJwSf/i24H
        lydymonL3evhTh59ZEqzi4vgGmg20j4iGpiAcoc=
X-Google-Smtp-Source: ABdhPJyvn0qU2dmr9nETYw/ClOBv52xJv0CVuIkH7emIbkcH9aBBEz2D79AEUeatSfRfmG2zWD6HXg==
X-Received: by 2002:a63:8f50:: with SMTP id r16mr29633100pgn.478.1641045062456;
        Sat, 01 Jan 2022 05:51:02 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id o11sm34022039pfu.150.2022.01.01.05.50.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jan 2022 05:51:02 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 2/8] ls-tree: add missing braces to "else" arms
Date:   Sat,  1 Jan 2022 21:50:25 +0800
Message-Id: <6fd1dd938303192d5b0a4cdc2914b2ff72cf5a3d.1641043500.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1802.gbb1c3936fb.dirty
In-Reply-To: <cover.1641043500.git.dyroneteng@gmail.com>
References: <cover.1641043500.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Add missing {} to the "else" arms in show_tree() per the
CodingGuidelines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 5f7c84950c..0a28f32ccb 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -92,14 +92,16 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 				else
 					xsnprintf(size_text, sizeof(size_text),
 						  "%"PRIuMAX, (uintmax_t)size);
-			} else
+			} else {
 				xsnprintf(size_text, sizeof(size_text), "-");
+			}
 			printf("%06o %s %s %7s\t", mode, type,
 			       find_unique_abbrev(oid, abbrev),
 			       size_text);
-		} else
+		} else {
 			printf("%06o %s %s\t", mode, type,
 			       find_unique_abbrev(oid, abbrev));
+		}
 	}
 	baselen = base->len;
 	strbuf_addstr(base, pathname);
-- 
2.33.0.rc1.1802.gbb1c3936fb.dirty

