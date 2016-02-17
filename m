From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 02/11] ref-filter: bump 'used_atom' and related code to the top
Date: Wed, 17 Feb 2016 23:36:10 +0530
Message-ID: <1455732379-22479-3-git-send-email-Karthik.188@gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:05:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6Tz-0006i0-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423471AbcBQSFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:05:44 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36142 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423438AbcBQSFm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:05:42 -0500
Received: by mail-pf0-f173.google.com with SMTP id e127so15346052pfe.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XuqeVcMLffA7e+FZNnpX8HDgVU4Ud89vZR56XwFM90o=;
        b=uQH7k3/pQEzWihdX6Jz5si7gvI3AZiU5AC8yiWEKjHZMV+eWFHh7LRr+ceZqK5Y32R
         DzWkGZogeI6yX5lXA2abVq5IJkcheIoFgsy59ShNjYnX7WrY0DafnDzi7cTwo3KRvwsV
         n3TuzQ/PJy4ZYTlCZzyO1pH4Eln2RBy+uHNdoBE4JZ/UiNgAmHDSAviKK7jbnpJt2w/h
         KGsYh0lXezHs074VKQR85McQn8zl/Lh0S5r8NoFRbnYHU3pXnK8YT38RjgrHxS6b7o0J
         XQVvhFTIjHh5xGzgYrbplqcZpjWymHlLlyqafRx3FvSVbwDGFbaKfNC/qgD0aweRlWOE
         QpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XuqeVcMLffA7e+FZNnpX8HDgVU4Ud89vZR56XwFM90o=;
        b=HFT9R7XMiPzG/8l/nBbyyzTSXuLsqTs+E1VsqVEX6Y0azldACOL3L+aI7A8JxVfEUb
         p1dzeEtawRukwCEvok8DJINXbeYb+Zo5Tcd0OT1z+Gl93/8+5vlYCJa+VHbJNpQxN843
         5dXjTpJyu+ZfiuHWzXLqV8HKsGlfCvRrk6A55SDiJyAnxzJWarWeiWqsi6g1uduck2Xh
         DNz292fh3nBk6RgltMre1dNLPUvIQm3sGtWUXU6VySjTl+aBg/cqQ53MCOC/OmIyS8CT
         0BMN6M0PjipWmqPslhnQ0GEcr29IiaGCD9i50EWPtXDd1f+6zUXFA6IkUPNhb99db7up
         yi8w==
X-Gm-Message-State: AG10YOSnDloq/31c6KYuPzDAYslxPBZHbt6Gol+u0OBsGNTVPhm+QFhf2/asYGPvUcEWrg==
X-Received: by 10.98.72.24 with SMTP id v24mr3953008pfa.15.1455732341918;
        Wed, 17 Feb 2016 10:05:41 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:05:41 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286519>

Bump code to the top for usage in further patches.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 19367ce..6a73c5b 100644
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
