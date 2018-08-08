Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 832D5208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeHHSqx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:46:53 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:34470 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHSqw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:46:52 -0400
Received: by mail-lf1-f44.google.com with SMTP id n96-v6so2032792lfi.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XFU2BOEcZ9H+luFJiCtp+tLnxp4oXvEKjAo12MqKKgA=;
        b=kKck8IWPt7QhflypIMTPZtkIUO+qFc7w67wMfPtUiXfb2q7bB/00SK1v/Q0Ehsyo+B
         w20vPqdCqjfdVWDMxoxQFtfWlw6/YarPdzkFhC1Vo2jb+9IYuCl0G+Di+25dNvVqjWqP
         dLL9feEwcas2Ux8xahAot9x/k2c1ODJWLpBIsOWLuJDM/dY7KYj8fSqTIWhfuoB/CHuB
         1IKRbOgCW3S0ExgHoSa/cQrXlBvWi3kGMzl8JXVma/I0aGM09P/hWxM7BZqsPO38iSYb
         Y1rgtBiVR2OO4FJfAmCwM57pOVYUHBrkcxAQ8x2HLkplT5HtJMMc7gTaXYzflnMabeJI
         A9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XFU2BOEcZ9H+luFJiCtp+tLnxp4oXvEKjAo12MqKKgA=;
        b=GfIsTkgPD5ElT7yL8kVuNL7ykTgX9LTfv6acjxY75DbrrhADU9xTY760JuYb+ufmZs
         LOSghjp0EPswyMhrH+GTTC35h5CXQU3WXPLPdyj25wzMmWOZl+4wNGaaC2u65GiL9psy
         i0UqGb0Z37dsda3NnVHD+MwSw5lnLHOOuKVOkIYTH03Ly83T3T7E4wKJmb/oNkKKtu3J
         V1j1WjPoQX06hpAnuSLr656ukbIGZwQ0zhoFgbO64BFiXBa1rvFxPJaS0lJgggWAqayJ
         NschohSdeAwIlN6tzm58iy0gviVqvogiDFkhNLcutj+bE1Y0SEUdiF0EkUpy94ODJDBd
         4QuQ==
X-Gm-Message-State: AOUpUlFmVmF1flNNF+zyQAYOOYqCiUbl/RETKLFYehEyNYgqeGU/tT3v
        oTZGM0m/LvELJpnV7V42XrE=
X-Google-Smtp-Source: AA+uWPxCXVCSVEflxmNDHD8l+mW440zMvN2vLDpF1eMEW9ah3GTHbBWtAORq1KMUtTxI3kXRQcS2Ow==
X-Received: by 2002:a19:1190:: with SMTP id 16-v6mr2568311lfr.122.1533745585573;
        Wed, 08 Aug 2018 09:26:25 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id i75-v6sm891606lfh.29.2018.08.08.09.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 09:26:24 -0700 (PDT)
Subject: [PATCH v2] line-log: clarify [a,b) notation for ranges
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <be1dd423-f9de-a436-6127-02cce4ab1977@gmail.com>
Message-ID: <b80df985-03ef-ddb0-37aa-10fd411a1f11@gmail.com>
Date:   Wed, 8 Aug 2018 18:26:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <be1dd423-f9de-a436-6127-02cce4ab1977@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

line-log.[ch] use left-closed, right-open interval logic. Update
comments and debug output to use square brackets+parentheses notation
to help developers avoid off-by-one errors.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

Applies on top of c0babbe69 (range-set: publish API for re-use by
git-blame -L, 2013-08-06). When applied on the original commit 12da1d1f6
(Implement line-history search (git log -L), 2013-03-28), the conflict
is in removal of "static" from some functions.

Changes since v1:

 - reword commit message a bit
 - sign-off
 - add [a,b) to comment of range_set_append_unsafe

I decided not to remove "_at the end_", as

  /* tack on a _new_ range [a,b) */

seems a bit less readable to me.

 line-log.c | 6 +++---
 line-log.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/line-log.c b/line-log.c
index fa9cfd5bd..9ab6d51cc 100644
--- a/line-log.c
+++ b/line-log.c
@@ -56,7 +56,7 @@ static void range_set_move(struct range_set *dst, struct range_set *src)
 	src->alloc = src->nr = 0;
 }
 
-/* tack on a _new_ range _at the end_ */
+/* tack on a _new_ range [a,b) _at the end_ */
 void range_set_append_unsafe(struct range_set *rs, long a, long b)
 {
 	assert(a <= b);
@@ -353,7 +353,7 @@ static void dump_range_set(struct range_set *rs, const char *desc)
 	int i;
 	printf("range set %s (%d items):\n", desc, rs->nr);
 	for (i = 0; i < rs->nr; i++)
-		printf("\t[%ld,%ld]\n", rs->ranges[i].start, rs->ranges[i].end);
+		printf("\t[%ld,%ld)\n", rs->ranges[i].start, rs->ranges[i].end);
 }
 
 static void dump_line_log_data(struct line_log_data *r)
@@ -373,7 +373,7 @@ static void dump_diff_ranges(struct diff_ranges *diff, const char *desc)
 	printf("diff ranges %s (%d items):\n", desc, diff->parent.nr);
 	printf("\tparent\ttarget\n");
 	for (i = 0; i < diff->parent.nr; i++) {
-		printf("\t[%ld,%ld]\t[%ld,%ld]\n",
+		printf("\t[%ld,%ld)\t[%ld,%ld)\n",
 		       diff->parent.ranges[i].start,
 		       diff->parent.ranges[i].end,
 		       diff->target.ranges[i].start,
diff --git a/line-log.h b/line-log.h
index e2a5ee7c6..488c86409 100644
--- a/line-log.h
+++ b/line-log.h
@@ -6,7 +6,7 @@
 struct rev_info;
 struct commit;
 
-/* A range [start,end].  Lines are numbered starting at 0, and the
+/* A range [start,end).  Lines are numbered starting at 0, and the
  * ranges include start but exclude end. */
 struct range {
 	long start, end;
-- 
2.18.0

