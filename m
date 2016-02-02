From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 03/12] ref-filter: bump 'used_atom' and related code to the top
Date: Wed,  3 Feb 2016 00:26:10 +0530
Message-ID: <1454439370-2904-1-git-send-email-Karthik.188@gmail.com>
References: <xmqqvb68t6j6.fsf@gitster.mtv.corp.google.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 19:55:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQg75-00060N-IP
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 19:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756909AbcBBSzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 13:55:38 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33532 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583AbcBBSze (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 13:55:34 -0500
Received: by mail-pa0-f53.google.com with SMTP id cy9so103569408pac.0
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 10:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=24n/sOCRe4dzN9P7Ik+SNo7OrY+j6ugaGv7GBqEqNIw=;
        b=jymFGgGN8RcAZZFv4LxapsVXuFIjsGhSVeqXDF4gGUapPCbxFCt7gBxLk4GVl6p9d4
         pc+atAtjoKuPt/WmoCIh7Tgc/yDuiPgdKkdLvl7bZ6oFKXQUUATgCjuhP8qGw5B5rrZM
         d78c7CvN99R8Dafv2qSeRXkd1fqn7HbrU0mH51GYCGskaUegqerlo4Tzgdfn1G4Hn9O3
         x0makSGhtjreLAvNHKpXY6ER7T6j/aZv8LNiY7B8V3dQ+hg6mLl73516Qza8/ZFNP+C/
         3RDaj8ygmqJ8P788vAzW2slF3LH3XFkMscKUbKFDmRVDw57MTo7e4yPR6hfBbq9J6hZ9
         Fd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=24n/sOCRe4dzN9P7Ik+SNo7OrY+j6ugaGv7GBqEqNIw=;
        b=fyWdyeYKQo6bKi66YT4mb3H7vFmM1UNONWcllVspXoKv6HnbG0RKfGDbj+d8sWV1Am
         Uulxjefegu3L6gWBcbzBHPoCZtqfga/IXLckafz9mGuejLOQSvIUcUg6f+opMYtQywQh
         izLXX5QH81DcK/XVfa+8aRxDk4qT7CwE2DRddJiQp0cc+aReqJwvTkWF3ygssBqcoFyw
         oMuEMun3fqcOHpGk7KgXl/LqGQLLFOe5kjDHE0LyAH6HjwIfUAbqhO5POXChLhw9xyYj
         so6wWuwl73n78QXyaTG7x8pmOtmWTHKizYTaMuMTash5riZ1f+Z0YdWTa9FR9CClNdAS
         BBiA==
X-Gm-Message-State: AG10YORRRoE7IX/IBF/kUG8baWwEhsM/n2KOpPsqXLFJr5vS/I9TOteaoRPut5Ne5P9Pbw==
X-Received: by 10.66.122.97 with SMTP id lr1mr49149696pab.68.1454439334207;
        Tue, 02 Feb 2016 10:55:34 -0800 (PST)
Received: from ashley.localdomain ([106.51.240.0])
        by smtp.gmail.com with ESMTPSA id s197sm4318991pfs.62.2016.02.02.10.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Feb 2016 10:55:33 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <xmqqvb68t6j6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285298>

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
2.7.0
