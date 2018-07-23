Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6281F597
	for <e@80x24.org>; Mon, 23 Jul 2018 17:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbeGWS7C (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 14:59:02 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:40330 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388105AbeGWS7B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 14:59:01 -0400
Received: by mail-io0-f202.google.com with SMTP id j18-v6so893287iog.7
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=4CPFd1f7ioHJEgUO+8tjFpdOyDL5LEN1Kd1egMHqIbQ=;
        b=DRvY5U+77JMRJi7b/fw69097s/dQEdtxerhfINgoHI/A/raUKVJDB48unfrtuGwqS1
         YezwGk3RHok5f1LzFvILliv+jQ9wKOvSF7HekQZKnB7qAHdnVSwdUqM9rcrLGISJDay7
         776+eYr6TD6y+BKsgvGDldDzNjVHJD+buUG53K/YOP0Dkt1w6P8a0a6RcvvbN9nMZFS5
         Daoql/Z6VKli6kPhjf6iP0cLjhgoG51x5kA3n9F2jWFC3NlLNFg27dogV6Z8LHhpYX08
         Wne8jSKlW6SJiN4tAibXT82GeNpzMj6FKZwrlX6X7IU5khtpisTBCguJY1XxGyGVcrUB
         axHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=4CPFd1f7ioHJEgUO+8tjFpdOyDL5LEN1Kd1egMHqIbQ=;
        b=S+enhdg+QP62JnleWgkqH0k8mBoLLC0hi/1WUQsGWwY3q/bAHxLQ0pZHLSKl4O7rA0
         ZJ2L/fsUp2vHUv5DDAOwcrYnRpjS2JOMOMjHGQ+ekcjzCI/mFdDiczoe1tsmGP68Neq2
         O/Gw97iXCl30z1sdV+MtjNOCZPVz9srxcDZzkrYHZFj13ApempzHU6p/X3MrFrVl5TjT
         WND1pxSpFDBK/WU6zq+WH/GVVOTClUebrJT6J1V+NWLNzFNKqZUI4qfm0RevI3AbUrrq
         rzADAeLA8Hwh31f3WPY/3YM+67RpMdvFZsTZlbj+VbtHpTbMT1NZUEFTectGeWNNKMY0
         BLyg==
X-Gm-Message-State: AOUpUlHEIwt996hnPGn+Y0DAbIQltCq4qXQYTo5971tlgxitJoXXrnaw
        iYs/QsMwXdGkp3N1/aIG8ozO3U/OVLFQGi9M6+fXX40Q3IQdlPOzXqxmA7xA9hbETpN8Nn9bxgH
        WnumCN5OEeABYYOsUat+vGBsdr29M62825HyeIle2CkN6KknmpD4m3zkXnQ==
X-Google-Smtp-Source: AAOMgpddZ297ZWHw6nkhwvdjnPAw7f2OLkgFnkeB+bCDyzg5IHKegVol6UnHSGAT9hv1y4KD6PT6X6tFgwU=
MIME-Version: 1.0
X-Received: by 2002:a24:b30f:: with SMTP id e15-v6mr6517itf.48.1532368599848;
 Mon, 23 Jul 2018 10:56:39 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:56:35 -0700
In-Reply-To: <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
Message-Id: <20180723175635.31323-1-bmwill@google.com>
References: <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH] fetch-pack: mark die strings for translation
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 fetch-pack.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 0b4a9f288f..51abee6181 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1245,13 +1245,13 @@ static int process_section_header(struct packet_reader *reader,
 	int ret;
 
 	if (packet_reader_peek(reader) != PACKET_READ_NORMAL)
-		die("error reading section header '%s'", section);
+		die(_("error reading section header '%s'"), section);
 
 	ret = !strcmp(reader->line, section);
 
 	if (!peek) {
 		if (!ret)
-			die("expected '%s', received '%s'",
+			die(_("expected '%s', received '%s'"),
 			    section, reader->line);
 		packet_reader_read(reader);
 	}
@@ -1289,12 +1289,12 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
 			continue;
 		}
 
-		die("unexpected acknowledgment line: '%s'", reader->line);
+		die(_("unexpected acknowledgment line: '%s'"), reader->line);
 	}
 
 	if (reader->status != PACKET_READ_FLUSH &&
 	    reader->status != PACKET_READ_DELIM)
-		die("error processing acks: %d", reader->status);
+		die(_("error processing acks: %d"), reader->status);
 
 	/* return 0 if no common, 1 if there are common, or 2 if ready */
 	return received_ready ? 2 : (received_ack ? 1 : 0);
@@ -1331,7 +1331,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 
 	if (reader->status != PACKET_READ_FLUSH &&
 	    reader->status != PACKET_READ_DELIM)
-		die("error processing shallow info: %d", reader->status);
+		die(_("error processing shallow info: %d"), reader->status);
 
 	setup_alternate_shallow(&shallow_lock, &alternate_shallow_file, NULL);
 	args->deepen = 1;
@@ -1346,7 +1346,7 @@ static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
 		struct ref *r = NULL;
 
 		if (parse_oid_hex(reader->line, &oid, &end) || *end++ != ' ')
-			die("expected wanted-ref, got '%s'", reader->line);
+			die(_("expected wanted-ref, got '%s'"), reader->line);
 
 		for (r = refs; r; r = r->next) {
 			if (!strcmp(end, r->name)) {
@@ -1356,11 +1356,11 @@ static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
 		}
 
 		if (!r)
-			die("unexpected wanted-ref: '%s'", reader->line);
+			die(_("unexpected wanted-ref: '%s'"), reader->line);
 	}
 
 	if (reader->status != PACKET_READ_DELIM)
-		die("error processing wanted refs: %d", reader->status);
+		die(_("error processing wanted refs: %d"), reader->status);
 }
 
 enum fetch_state {
-- 
2.18.0.233.g985f88cf7e-goog

