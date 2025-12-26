Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAC126BF1
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766751893; cv=pass; b=LVe7zFAOURVNAzh/2e9QlvPmq9lnR+HkBz+gQ9Hk0yiaopV5VVyV2iAyAEzYYq6aGA3fW3s4srDbuZT7PwPB2TtngEPtwymwCEYZVsz8KocIY4Psatvrx6jhYSOCOk7GwaBFdiAbdeOoDmYBiQBi+snvZkUmTHbdYMPW85KqBrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766751893; c=relaxed/simple;
	bh=/R+bidkCr4WSSvSj7+F8C/gH8ThTQY80MnxRJ3XHTUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fdr5sQgA7nkh2NMFE7QiwckxM2WI9pHR84oseP5/Bx/Wz2k5Y0T42meTe5vlbr+P+yKJ6GQnNS/Dt5DNzbksi1mBXc+/8ijzzXE63IIt76r8Fc10wUvCfNg7LLM3iM4H7yZO17AsULIKB5OF8nwXhWZ3SX54dIXAidq/LC5dzsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=UCYruuDb; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="UCYruuDb"
ARC-Seal: i=1; a=rsa-sha256; t=1766751879; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RzAZ55Ju2ZE/Sw7/+T3w2Pr4Y2v4I8YH3fOCjguS5ncCJsMZ3pwJsKVewNnLhYHTwMcxtIOlj91ut51A4Z8W3YHAbTfiB+zF7DUGAM8U3Lp9z4Iaj+8O2kB/7N4IBN0ZnoUQCTqeYNz69HMZLl6FVgSfEcPRP1b9TExFp4zE4EA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766751879; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iLzQ0+mthnCdVYlPrrvaI5aKgawkHzOF8aR3SVME+aQ=; 
	b=CmOyZtfKOpDC9fg2zU+eCEBFwyce3jPFuxaqMUsIEbr44Jf9Y4ODyTimeGazek474aiHVB2N3KbTjsTwDUquveGDaKWIdkiuLxMnMNsdPtxFMoc2ldtUws5jxLt+fXt8BHEWIj4HAxQUu41CYW2WcvwxndotIrCxBWJieIMFmnc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766751879;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iLzQ0+mthnCdVYlPrrvaI5aKgawkHzOF8aR3SVME+aQ=;
	b=UCYruuDbDrNk2Ld9OKhiZKmQ0lp8jaGGN0sv5SS037SQ81FTu9nN/TzT7vyBtVUb
	vaX3uFRMzxLuGBiyUNY2so4au8lokhd/z0yWpc1euzqr1/a8RrlvnxZ1Yx+fuqyh3Sd
	2KpMyLlWTRBrK050gAkiqD2rKF/cP+Qhm3OtdbpU=
Received: by mx.zohomail.com with SMTPS id 1766751876634699.1913293382237;
	Fri, 26 Dec 2025 04:24:36 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v6 01/11] run-command: add first helper for pp child states
Date: Fri, 26 Dec 2025 14:23:24 +0200
Message-ID: <20251226122334.16687-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251226122334.16687-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251226122334.16687-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

There is a recurring pattern of testing parallel process child states
and file descriptors to determine if a child is running, receiving any
input or if it's ready for cleanup.

Name the pp_child structure and introduce a first helper to make these
checks more readable. Next commits will add more helpers and checks.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 run-command.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..3989673569 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1478,15 +1478,22 @@ enum child_state {
 	GIT_CP_WAIT_CLEANUP,
 };
 
+struct parallel_child {
+	enum child_state state;
+	struct child_process process;
+	struct strbuf err;
+	void *data;
+};
+
+static int child_is_working(const struct parallel_child *pp_child)
+{
+	return pp_child->state == GIT_CP_WORKING;
+}
+
 struct parallel_processes {
 	size_t nr_processes;
 
-	struct {
-		enum child_state state;
-		struct child_process process;
-		struct strbuf err;
-		void *data;
-	} *children;
+	struct parallel_child *children;
 	/*
 	 * The struct pollfd is logically part of *children,
 	 * but the system call expects it as its own array.
@@ -1509,7 +1516,7 @@ static void kill_children(const struct parallel_processes *pp,
 			  int signo)
 {
 	for (size_t i = 0; i < opts->processes; i++)
-		if (pp->children[i].state == GIT_CP_WORKING)
+		if (child_is_working(&pp->children[i]))
 			kill(pp->children[i].process.pid, signo);
 }
 
@@ -1665,7 +1672,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 
 	/* Buffer output from all pipes. */
 	for (size_t i = 0; i < opts->processes; i++) {
-		if (pp->children[i].state == GIT_CP_WORKING &&
+		if (child_is_working(&pp->children[i]) &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
 			int n = strbuf_read_once(&pp->children[i].err,
 						 pp->children[i].process.err, 0);
@@ -1683,7 +1690,7 @@ static void pp_output(const struct parallel_processes *pp)
 {
 	size_t i = pp->output_owner;
 
-	if (pp->children[i].state == GIT_CP_WORKING &&
+	if (child_is_working(&pp->children[i]) &&
 	    pp->children[i].err.len) {
 		strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
@@ -1748,7 +1755,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 			 * running process time.
 			 */
 			for (i = 0; i < n; i++)
-				if (pp->children[(pp->output_owner + i) % n].state == GIT_CP_WORKING)
+				if (child_is_working(&pp->children[(pp->output_owner + i) % n]))
 					break;
 			pp->output_owner = (pp->output_owner + i) % n;
 		}
-- 
2.51.2

