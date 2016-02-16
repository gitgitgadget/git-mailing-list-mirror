From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 03/12] ref-filter: bump 'used_atom' and related code to the top
Date: Wed, 17 Feb 2016 00:30:06 +0530
Message-ID: <1455649215-23260-4-git-send-email-Karthik.188@gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 19:59:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkqn-00086Y-1p
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 19:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528AbcBPS7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 13:59:48 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33985 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbcBPS7r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 13:59:47 -0500
Received: by mail-pf0-f173.google.com with SMTP id x65so109753213pfb.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 10:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F6hBaQ6a1weOVjWMrapEEbHJajZxisBHjcUJiSnzhEo=;
        b=jlQDF8RtwPI7XJgrPR1dvWcSUxOkCYtuBqkRE4GXI2Qqt8PTlBI9Y6wZJ20w5Yj3cX
         mvkjkKTYE3FRa3nHRzyCZBThkjY+teyFo44If1j2w3RGXcttgwdMizxS09+5jKEpPzwL
         WV9tEPNLQIlmdfwJuBQOM8PHqx+PctgpExhTXO/93MKHj1igETChXSQPAJA79d9llhcl
         cN2qI8Kv5AEUHikQ6fbLhe41/yZSdiDk09Qw8QfxJiBo395zZOD9ucezUAPskJeS/YhD
         HJ04EzH8SO67n7mjJlgAbIjZmY9IWSJ33dnCkslfIx2pm71VNqqt/ThkrsoGVYPVzsbY
         8UZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F6hBaQ6a1weOVjWMrapEEbHJajZxisBHjcUJiSnzhEo=;
        b=jLShXgLohytRAICimQLDFSCyBkOPYJa/BYWL+2rQt7wyS8xthNauwjF1EkApN9ZYU+
         HOWP+xgnjXbGRkRrcsR3OqUNf2IbiXqucBkBvyZg5XdGHxy0fBA7o7Em2xPiBcZCA6JV
         eDSLEu9tpvJvtos6a2Z6eyuMLE+oMK/N3bJ+X7Kft685O0HdjFrasVb1s8GVxHnoFzxe
         uMPx3MP9bqfcTP6+xz+/FDp4Ew7efQrahGQGnQ8X/ZzFJq1WsJjYSkJeAZk014FwmMCZ
         +fOFn29PaeyoEfmScZRH/R+5MmPwHpVJFzVYFsAGTew21wShchUOK/AqgxJ3RhmylxKp
         KAlQ==
X-Gm-Message-State: AG10YOT0t1KYAaLxJYHw1dviPtfkGQEdvkJjIKKhMkDPB7U7+LzuhFVFylrhhVnJ8C419g==
X-Received: by 10.98.31.221 with SMTP id l90mr33372818pfj.92.1455649186580;
        Tue, 16 Feb 2016 10:59:46 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id 27sm47469677pfh.48.2016.02.16.10.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 10:59:46 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286417>

Bump code to the top for usage in further patches.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 38f38d4..c3a8372 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -16,6 +16,21 @@
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
+/*
+ * An atom is a valid field atom listed below, possibly prefixed with
+ * a "*" to denote deref_tag().
+ *
+ * We parse given format string and sort specifiers, and make a list
+ * of properties that we need to extract out of objects.  ref_array_item
+ * structure will hold an array of values extracted that can be
+ * indexed with the "atom number", which is an index into this
+ * array.
+ */
+static const char **used_atom;
+static cmp_type *used_atom_type;
+static int used_atom_cnt, need_tagged, need_symref;
+static int need_color_reset_at_eol;
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -92,21 +107,6 @@ struct atom_value {
 };
 
 /*
- * An atom is a valid field atom listed above, possibly prefixed with
- * a "*" to denote deref_tag().
- *
- * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  ref_array_item
- * structure will hold an array of values extracted that can be
- * indexed with the "atom number", which is an index into this
- * array.
- */
-static const char **used_atom;
-static cmp_type *used_atom_type;
-static int used_atom_cnt, need_tagged, need_symref;
-static int need_color_reset_at_eol;
-
-/*
  * Used to parse format string and sort specifiers
  */
 int parse_ref_filter_atom(const char *atom, const char *ep)
-- 
2.7.1
