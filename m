Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B458208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 13:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbeHGQJB (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 12:09:01 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:33885 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeHGQJA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 12:09:00 -0400
Received: by mail-lf1-f50.google.com with SMTP id n96-v6so11714560lfi.1
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VvcuEBgUNA8SivFBMmn+Bhna+ln1EKMTGYUbtyZkzvs=;
        b=TsyKxr5LB67TJ05cnHxmPutvOjJDwBERYqEjTVvYih57ryqXVK7kZsP+2G6fitOzga
         AtkDfU+aUE4+7ePDOMy04RoRmeJWk+uO0cRuD4FdJQxSYbVjwmbVYfBoUFsZLXCZWDdE
         vTQa+Kerq6pV3m3XLkkS5PAmw2hEfoTNNpaTkthZB55KsYPDiay72w/TgvgkQynC7s+3
         kqVdNjBgVBHQ3pJkM8o9RLomJGx1VVhfAKzlacHwVi1yhzIQjY2IA5Vmv/qGz5Hj75c3
         ZFQ5m2IZbMdNYvl5PQc97C2QobzNA254UzPSmy5ID5Ia6ZkG2aCRTxoeWqErDMfxSjd1
         H79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VvcuEBgUNA8SivFBMmn+Bhna+ln1EKMTGYUbtyZkzvs=;
        b=Nfrx+ZBvcYjUTNGzt9i/8DyKHMALdXjhAJDbMp/7WkiFj6k/RfKBovVlIOv5seidtm
         FhgnGDxK60uE4cUICsnXtLMZCBLKP8Zta+NKMjkbhMDpGv+3u/FHMos/4kmKuTfcJ3O/
         TrkhZRh3bV5GPpHQZOUbZPaeBFbIGao2Hjs17WOxL+VuhKlnYTJgBlK7stgpeviDnIZY
         b0/1jusG5Zlvbcnpmefax3y/ghyOPGbueZRG0W1nn7rhBWRwscqF9mUS83ERNzxhcJXO
         mx5d0jD2UhtnqWyaXv5/bi2RHDPDEUA8Y4eknVa8oMMD0LWLqBfyeEex/yPGsh7cB/VQ
         Vpag==
X-Gm-Message-State: AOUpUlHbr7MY22Vp/0S3u+QGKn7gKY9QprLn91n3mENtozVfwN2sKMBE
        ON77eZN7aq+cZLNzWX9XqEXY+LhAD6Y=
X-Google-Smtp-Source: AAOMgpdYNWr1SxwqNh2B9PY/xfyad7sONautZT7lLaSUecPu1fxftk+FE0uyTPPUoP0szlnuv4QQIw==
X-Received: by 2002:a19:c64c:: with SMTP id w73-v6mr14926718lff.2.1533650072368;
        Tue, 07 Aug 2018 06:54:32 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id t67-v6sm299338lff.90.2018.08.07.06.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 06:54:31 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: [RFC PATCH] line-log: clarify [a,b) notation for ranges
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <be1dd423-f9de-a436-6127-02cce4ab1977@gmail.com>
Date:   Tue, 7 Aug 2018 15:54:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

line-log.[ch] use left-closed, right-open interval logic. Change comment
and debug output to square brackets+parentheses notation to help
developers avoid off-by-one errors.
---

Original idea for this change in recent thread about line-log changes:

  https://public-inbox.org/git/9776862d-18b2-43ec-cfeb-829418d4d967@gmail.com/

line-log.c also uses ASCII graphics |---| in some comments, like:

	/*
	 * a:         |-------
	 * b: ------|
	 */

But I'm not sure if replacing them with

	/*
	 * a:         [-------
	 * b: ------)
	 */

will be helpful.  Another possibility is to update comment for
range_set_append_unsafe to read

  /* tack on a _new_ range [a,b) _at the end_ */
  void range_set_append_unsafe(struct range_set *rs, long a, long b)

 line-log.c | 4 ++--
 line-log.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/line-log.c b/line-log.c
index fa9cfd5bd..60f3174ac 100644
--- a/line-log.c
+++ b/line-log.c
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

