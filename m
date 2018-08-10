Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACE1E1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeHKAqO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45447 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeHKAqO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so5111891pfo.12
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X/Ch9Yev45nb9yis0KTBwp7WPeVzcYHPDSuOGbRo9cE=;
        b=mo8NSmYqPVmSl4rQR6csyNm3K2zJE5ub23mTvrdyA9NCxjZTmhFPLqs4txezg3s7tV
         aQLJ2K3t8TUwSoldV78vNZGZrFhYi2+RFaxnZhC4Rpq1W7RdqOE/4qGf0ffPmRSKdo6a
         6xGGtu8CVoGW5KLVJpsFdd7sYgT4+mciM2oPXvEVlxsAh4K1G2mrx+KacPfYUhMPIoa4
         q4poRxbmQN6rU7wNAs33h9vKG6SVcddAHGm0HIJtNxbax8fZHtqase8Jv37+s0nrwBvf
         CbPCjAMilsvEVfL9lhDxqeLPTRAQC2ja9QdI7OZ86uvBC+CpLFQMZNwQnKAc68pImFBj
         31oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X/Ch9Yev45nb9yis0KTBwp7WPeVzcYHPDSuOGbRo9cE=;
        b=Dle1HnO9iaYQHcXXXwDh2WAd+iL4578ohn7+I2kQuBBoT3878Qxjtaia3qAl5bG4Ic
         F0ZUSmNui1iAKm+man8fNaPmbojwajIstFF9eIfrFH6IunbSvOGuqWtqKHg/RyvOxV4z
         sGKpM0is+6OCeQXZWM/NYGuYONKCfugkeLrn3JccIKWt7RQnTwmImdrHIqSkArfLSlVW
         Cy0dliJNoy21USf0KdtjbOKg0xyfKVwg7Os0XdoYW9xsCF3jE1pd7J4SSEqWBn8JWXqg
         RuRVQlwep4UmT29w4rOAkZB+xsAPWkVH4pcDN5fVolXDBfEiVdoIz+9YPCSavmvhycI7
         J93A==
X-Gm-Message-State: AOUpUlHyN5XSuu6MqfCk6uFgdTtjq7p4fqDL6JBM4hYSsRL8oRXCu+di
        t3IUBbemvAluNjiA+HcI9I1H+C1F
X-Google-Smtp-Source: AA+uWPzCqgDxqvIN16UIAn5hCXSSQbZzlYbe23yOkx1nYO2GqXxtLV7qkpFBGUnaFosaE7b/F06bSw==
X-Received: by 2002:a63:2013:: with SMTP id g19-v6mr8128887pgg.68.1533939267974;
        Fri, 10 Aug 2018 15:14:27 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id r81-v6sm16244982pfa.18.2018.08.10.15.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:27 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:27 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:03 GMT
Message-Id: <f168da3a3c5d6ce9b7c1ea036ca184c20729153e.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 01/21] linear-assignment: a function to solve least-cost
 assignment problems
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The problem solved by the code introduced in this commit goes like this:
given two sets of items, and a cost matrix which says how much it
"costs" to assign any given item of the first set to any given item of
the second, assign all items (except when the sets have different size)
in the cheapest way.

We use the Jonker-Volgenant algorithm to solve the assignment problem to
answer questions such as: given two different versions of a topic branch
(or iterations of a patch series), what is the best pairing of
commits/patches between the different versions?

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile            |   1 +
 linear-assignment.c | 201 ++++++++++++++++++++++++++++++++++++++++++++
 linear-assignment.h |  22 +++++
 3 files changed, 224 insertions(+)
 create mode 100644 linear-assignment.c
 create mode 100644 linear-assignment.h

diff --git a/Makefile b/Makefile
index bc4fc8eea..1af719b44 100644
--- a/Makefile
+++ b/Makefile
@@ -870,6 +870,7 @@ LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hashmap.o
+LIB_OBJS += linear-assignment.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
diff --git a/linear-assignment.c b/linear-assignment.c
new file mode 100644
index 000000000..9b3e56e28
--- /dev/null
+++ b/linear-assignment.c
@@ -0,0 +1,201 @@
+/*
+ * Based on: Jonker, R., & Volgenant, A. (1987). <i>A shortest augmenting path
+ * algorithm for dense and sparse linear assignment problems</i>. Computing,
+ * 38(4), 325-340.
+ */
+#include "cache.h"
+#include "linear-assignment.h"
+
+#define COST(column, row) cost[(column) + column_count * (row)]
+
+/*
+ * The parameter `cost` is the cost matrix: the cost to assign column j to row
+ * i is `cost[j + column_count * i].
+ */
+void compute_assignment(int column_count, int row_count, int *cost,
+			int *column2row, int *row2column)
+{
+	int *v, *d;
+	int *free_row, free_count = 0, saved_free_count, *pred, *col;
+	int i, j, phase;
+
+	memset(column2row, -1, sizeof(int) * column_count);
+	memset(row2column, -1, sizeof(int) * row_count);
+	ALLOC_ARRAY(v, column_count);
+
+	/* column reduction */
+	for (j = column_count - 1; j >= 0; j--) {
+		int i1 = 0;
+
+		for (i = 1; i < row_count; i++)
+			if (COST(j, i1) > COST(j, i))
+				i1 = i;
+		v[j] = COST(j, i1);
+		if (row2column[i1] == -1) {
+			/* row i1 unassigned */
+			row2column[i1] = j;
+			column2row[j] = i1;
+		} else {
+			if (row2column[i1] >= 0)
+				row2column[i1] = -2 - row2column[i1];
+			column2row[j] = -1;
+		}
+	}
+
+	/* reduction transfer */
+	ALLOC_ARRAY(free_row, row_count);
+	for (i = 0; i < row_count; i++) {
+		int j1 = row2column[i];
+		if (j1 == -1)
+			free_row[free_count++] = i;
+		else if (j1 < -1)
+			row2column[i] = -2 - j1;
+		else {
+			int min = COST(!j1, i) - v[!j1];
+			for (j = 1; j < column_count; j++)
+				if (j != j1 && min > COST(j, i) - v[j])
+					min = COST(j, i) - v[j];
+			v[j1] -= min;
+		}
+	}
+
+	if (free_count ==
+	    (column_count < row_count ? row_count - column_count : 0)) {
+		free(v);
+		free(free_row);
+		return;
+	}
+
+	/* augmenting row reduction */
+	for (phase = 0; phase < 2; phase++) {
+		int k = 0;
+
+		saved_free_count = free_count;
+		free_count = 0;
+		while (k < saved_free_count) {
+			int u1, u2;
+			int j1 = 0, j2, i0;
+
+			i = free_row[k++];
+			u1 = COST(j1, i) - v[j1];
+			j2 = -1;
+			u2 = INT_MAX;
+			for (j = 1; j < column_count; j++) {
+				int c = COST(j, i) - v[j];
+				if (u2 > c) {
+					if (u1 < c) {
+						u2 = c;
+						j2 = j;
+					} else {
+						u2 = u1;
+						u1 = c;
+						j2 = j1;
+						j1 = j;
+					}
+				}
+			}
+			if (j2 < 0) {
+				j2 = j1;
+				u2 = u1;
+			}
+
+			i0 = column2row[j1];
+			if (u1 < u2)
+				v[j1] -= u2 - u1;
+			else if (i0 >= 0) {
+				j1 = j2;
+				i0 = column2row[j1];
+			}
+
+			if (i0 >= 0) {
+				if (u1 < u2)
+					free_row[--k] = i0;
+				else
+					free_row[free_count++] = i0;
+			}
+			row2column[i] = j1;
+			column2row[j1] = i;
+		}
+	}
+
+	/* augmentation */
+	saved_free_count = free_count;
+	ALLOC_ARRAY(d, column_count);
+	ALLOC_ARRAY(pred, column_count);
+	ALLOC_ARRAY(col, column_count);
+	for (free_count = 0; free_count < saved_free_count; free_count++) {
+		int i1 = free_row[free_count], low = 0, up = 0, last, k;
+		int min, c, u1;
+
+		for (j = 0; j < column_count; j++) {
+			d[j] = COST(j, i1) - v[j];
+			pred[j] = i1;
+			col[j] = j;
+		}
+
+		j = -1;
+		do {
+			last = low;
+			min = d[col[up++]];
+			for (k = up; k < column_count; k++) {
+				j = col[k];
+				c = d[j];
+				if (c <= min) {
+					if (c < min) {
+						up = low;
+						min = c;
+					}
+					col[k] = col[up];
+					col[up++] = j;
+				}
+			}
+			for (k = low; k < up; k++)
+				if (column2row[col[k]] == -1)
+					goto update;
+
+			/* scan a row */
+			do {
+				int j1 = col[low++];
+
+				i = column2row[j1];
+				u1 = COST(j1, i) - v[j1] - min;
+				for (k = up; k < column_count; k++) {
+					j = col[k];
+					c = COST(j, i) - v[j] - u1;
+					if (c < d[j]) {
+						d[j] = c;
+						pred[j] = i;
+						if (c == min) {
+							if (column2row[j] == -1)
+								goto update;
+							col[k] = col[up];
+							col[up++] = j;
+						}
+					}
+				}
+			} while (low != up);
+		} while (low == up);
+
+update:
+		/* updating of the column pieces */
+		for (k = 0; k < last; k++) {
+			int j1 = col[k];
+			v[j1] += d[j1] - min;
+		}
+
+		/* augmentation */
+		do {
+			if (j < 0)
+				BUG("negative j: %d", j);
+			i = pred[j];
+			column2row[j] = i;
+			SWAP(j, row2column[i]);
+		} while (i1 != i);
+	}
+
+	free(col);
+	free(pred);
+	free(d);
+	free(v);
+	free(free_row);
+}
diff --git a/linear-assignment.h b/linear-assignment.h
new file mode 100644
index 000000000..1dfea7662
--- /dev/null
+++ b/linear-assignment.h
@@ -0,0 +1,22 @@
+#ifndef LINEAR_ASSIGNMENT_H
+#define LINEAR_ASSIGNMENT_H
+
+/*
+ * Compute an assignment of columns -> rows (and vice versa) such that every
+ * column is assigned to at most one row (and vice versa) minimizing the
+ * overall cost.
+ *
+ * The parameter `cost` is the cost matrix: the cost to assign column j to row
+ * i is `cost[j + column_count * i].
+ *
+ * The arrays column2row and row2column will be populated with the respective
+ * assignments (-1 for unassigned, which can happen only if column_count !=
+ * row_count).
+ */
+void compute_assignment(int column_count, int row_count, int *cost,
+			int *column2row, int *row2column);
+
+/* The maximal cost in the cost matrix (to prevent integer overflows). */
+#define COST_MAX (1<<16)
+
+#endif
-- 
gitgitgadget

