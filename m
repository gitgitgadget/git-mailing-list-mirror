From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 03/12] ref-filter: bump 'used_atom' and related code to the top
Date: Sun, 31 Jan 2016 23:12:47 +0530
Message-ID: <1454262176-6594-4-git-send-email-Karthik.188@gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 18:43:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPw20-0000Q7-It
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbcAaRm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 12:42:59 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33407 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbcAaRm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 12:42:26 -0500
Received: by mail-pf0-f196.google.com with SMTP id x125so6457432pfb.0
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8woBKQDaCWnZBVaAGGKelRdJb5o2F+EWz18iBslip7Y=;
        b=DsGVcDJjm5voMmp8qX6AWQdzPAgHTJO9HrgU2ZYRm+mOi044lFuZ4orjjIimsl3bC/
         prlg0e7X2x771/2jdKlm9g1+vwGSDdg/waobomUZO/6molUBKWdZCHbKXCjwdrFGlxfN
         rAXIin4aww8oeG39Uxhwx5f/u2GgUmNMchmJewUTogdJXzLLG6LVOGD24zB/JSra5w75
         v21DHULNQUYvEPnPttu3erxuNyvKPsxIF6uwGew29+tMfoFbINddG5KgtbWTXD+KwkkY
         yYzn2MHbc596LAsAZy6OgLHt4OK7p8RhK2rMcK4twNuHJjU7zEvNKqqC+S/uAfFT7JLD
         YWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8woBKQDaCWnZBVaAGGKelRdJb5o2F+EWz18iBslip7Y=;
        b=j5cxEaTAN69UHtW5g6/pr/86WKWOheOUkANGmp2Bpw+x0sPDy3QWxjRbkkz6oRDjLM
         UIpuEaDNNeKXVAEPGNo7K0ebHZM3SodRqS4uc9Vid7DwW0IBn263ovy3Nfpv/VLqcRX6
         3+shHldLcKrARHjPNeDyaVk+SZbv0eZ+0orT3lpqd+JCgTn6ZZB21hH7ivo9dw7Tr9sS
         vNu9dDD+FiOGU43NuFkFIcjHNiwKC2t+/0BLmXnibWijVZ9cGTjlGUMeo3JLjDl+jUHw
         bTlTmWbADRPOGOXgnviy9zIr5sz0xbIHn5rojsZZh5prOa/60gn4vMBZdPTyLoX8EklE
         56IA==
X-Gm-Message-State: AG10YOSu/EMLu7SeZwC1JStVksNj3YIU/asv9jCfzOBVO6LAe/+/NrfTs/l5LFWwqWl82A==
X-Received: by 10.98.79.28 with SMTP id d28mr14988153pfb.77.1454262145971;
        Sun, 31 Jan 2016 09:42:25 -0800 (PST)
Received: from ashley.localdomain ([106.51.132.212])
        by smtp.gmail.com with ESMTPSA id v26sm37274012pfi.56.2016.01.31.09.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 09:42:25 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285164>

Bump code to the top for usage in further patches.
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
2.7.0
