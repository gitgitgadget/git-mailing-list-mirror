Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4F81F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeBIUcj (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:32:39 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40406 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBIUci (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:38 -0500
Received: by mail-wm0-f65.google.com with SMTP id v123so18517367wmd.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RKN65ooo5gutB0sQuSX2FykC2fQ62KXX0bl+YKym8gY=;
        b=ZyCQ6aFDEDe0K9lIiYsdDlMQwT3qMpeiWatHRLF2nM01t4HcV6hL3LI7bg7XZ8C69R
         y/pLbkyBJRwwdZhZRhqvGFcBCLkg0cRNiHwNz721ZGtO64kWs6dNBuOW5/i9cdKwphpM
         qz5xarxQwJ5zxIItiroO7j8LMuxF16O8Tv8RyGV8rJxwHG+yLNobNCkWfy2bCAZC6al3
         xomazSSt+/N+nG+8gHu05utx5cEycuLH7SmB6N37gingQBc+cc5t/0ArNWVw3efSjjHU
         ygSFFdPcEqSBvxXooYoaQjR13JlsAz2TBRbjII4S9osUb+o9ZaR6dbMM6+LSpgbJ8+LN
         ZbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RKN65ooo5gutB0sQuSX2FykC2fQ62KXX0bl+YKym8gY=;
        b=ieTLfwKHrFhucbTaB+Oo+fYUFdwbu8OkjcMVa+FMJpRO08pA8ChAUeJ5wPcWmt3pYj
         Xq9PGHVkmNWj5d5T0lgXoajugAU0PQtS+yowT8a7PkTNOAo5Npecpo5gnJsBuSVqzdZg
         XKYRFRNudqLeZTrJF5Y3HMRHhaXqH7vTZuJrTJwkr25R+IH+KKbHv4PESw3UU5J8WVOt
         gLeDBeUc17EuIvf07t7kYhSwVvubZkvRD3sz4jVJrq8nbqcDc9gdaW16GTZY11c1CIrD
         NCbI+DDQ9ep6Uvs8x3qGAt0uY2grpUCwjo7QOzf751nwR1JmBU/ZGJmkqnJXdAdrbftR
         iJsA==
X-Gm-Message-State: APf1xPBudOhft1pCasgJjUavDeSsD4MpmX5hfobseaX8LSpeFHxLCa3E
        cS6C91ctG0MOEDAAnuSPp549ihGf
X-Google-Smtp-Source: AH8x2278+IjeaxhfTAM1/LyXlZ7IqqUSkRC7MTJwHiGOCvu8idNTTB4bNKnCzM2+3DyP/ULl0nimeA==
X-Received: by 10.28.28.139 with SMTP id c133mr2906230wmc.144.1518208357041;
        Fri, 09 Feb 2018 12:32:37 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/17] fetch: trivially refactor assignment to ref_nr
Date:   Fri,  9 Feb 2018 20:32:01 +0000
Message-Id: <20180209203216.11560-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trivially refactor an assignment to make a subsequent patch
smaller. The "ref_nr" variable is initialized to 0 earlier, just as
"j" is, and "j" is only incremented in that loop, so this change isn't
a logic error.

This change simplifies a subsequent change, which will split the
incrementing of "ref_nr" into two blocks.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b34665db9e..72085e30b9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1301,8 +1301,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 						    argv[i], argv[i]);
 			} else
 				refs[j++] = argv[i];
+			ref_nr++;
 		}
-		ref_nr = j;
 	}
 
 	sigchain_push_common(unlock_pack_on_signal);
-- 
2.15.1.424.g9478a66081

