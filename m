Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3C01F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390670AbfFJXfb (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:35:31 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:43930 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390655AbfFJXfa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:35:30 -0400
Received: by mail-ed1-f54.google.com with SMTP id w33so16961605edb.10
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U8L2yvKWeo5aSk9NjQTKZ/6SYIVvl2Xzu82SuSIL7jE=;
        b=Y4g32xDqKYJTK1+b7gmYcyfzwC93Y992evgMnyhZVrk92Ad8IuWA/XDhrlPqi1ikge
         5lbEVgPoRwAy7yVrfO3T8m4SYxSfdrPiAOW6zxOP5vHXfnIZbqddJoNSRFqa97fQhyLr
         AybvgPJ/JGuLVPx2CGO8Whr4jMkd9olmnfz/epwRndIm6I6HWtefpN/kqZ+TsNTjc7HY
         ZB8uEa5UZcd7ezfRSkomD4kLjVz72wgySu6nxNmQK66XMsuwnpeSWasP0E3wNTaRIUFS
         v90CPK8fEsc9d9EdhbxO/zga8+UrJ5uYYAqct5qJgAjsfXy6hPeBW+KItEN9A7QzUCiw
         9JJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U8L2yvKWeo5aSk9NjQTKZ/6SYIVvl2Xzu82SuSIL7jE=;
        b=RwbiQh+bPVaolF64LkzRFfTIwHCqRs6loehblorlnjWDLTUcYMF6Ax2pZ8qApxtE0B
         QgPO7ADXgfgRBGezHHP61er/TWB21c9LNaueepqvF8zlIWbQ8hWVBN5XQzJ522xwwP7c
         Xi1EVveVz8Q9IVEXQBNEF8d2P59KE2tR/ePoydyyvOhULlt4twyZpcSbaNhYdqXjpCqo
         5N+oumAfTPlx67VNDUbpbxMXX0ra3CAfF3WhnJk/M0g9AbLxrsh5R5htk1JfLiU1+VzD
         P9Aw7syYqglO6Do40CTIZS8qzdyS4Jh3mffkyU3o+h2MyfaAmz503cUA43JxswbVGCOm
         ceOQ==
X-Gm-Message-State: APjAAAVFZJrIoMx18/u2CsUf2rulJD+iG8HwAQA9SH9+Aqdh/7UCB0E+
        7unxDFt5nqQzidmrlOiD8BvI/nAD
X-Google-Smtp-Source: APXvYqxyU2xrFWznv7bcV0MNakgJotgoqrSVqWdhteYk4NwJU5OooZ7O1IliYerzZNlRa2gQgup7OQ==
X-Received: by 2002:a17:906:604e:: with SMTP id p14mr17270806ejj.192.1560209728962;
        Mon, 10 Jun 2019 16:35:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm3184487edi.33.2019.06.10.16.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:35:28 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:35:28 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jun 2019 23:35:19 GMT
Message-Id: <8e243939efc9131dd4f765e7931e4ad55f7e6b29.1560209720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.261.git.gitgitgadget@gmail.com>
References: <pull.261.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 10/11] midx: add test that 'expire' respects .keep files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git multi-pack-index expire' subcommand may delete packs that
are not needed from the perspective of the multi-pack-index. If
a pack has a .keep file, then we should not delete that pack. Add
a test that ensures we preserve a pack that would otherwise be
expired. First, create a new pack that contains every object in
the repo, then add it to the multi-pack-index. Then create a .keep
file for a pack starting with "a-pack" that was added in the
previous test. Finally, expire and verify that the pack remains
and the other packs were expired.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 8e04ce2821..c288901401 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -510,4 +510,22 @@ test_expect_success 'expire works when adding new packs' '
 	)
 '
 
+test_expect_success 'expire respects .keep files' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-all <<-EOF &&
+		refs/heads/A
+		EOF
+		git multi-pack-index write &&
+		PACKA=$(ls .git/objects/pack/a-pack*\.pack | sed s/\.pack\$//) &&
+		touch $PACKA.keep &&
+		git multi-pack-index expire &&
+		ls -S .git/objects/pack/a-pack* | grep $PACKA >a-pack-files &&
+		test_line_count = 3 a-pack-files &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 2 midx-list
+	)
+'
+
+
 test_done
-- 
gitgitgadget

