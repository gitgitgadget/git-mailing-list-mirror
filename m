From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] SQUASH???
Date: Thu, 24 Sep 2015 14:13:07 -0700
Message-ID: <1443129187-18572-3-git-send-email-sbeller@google.com>
References: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
 <1443129187-18572-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 24 23:13:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDpd-00083d-SM
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbbIXVN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:13:28 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35670 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbbIXVNT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:13:19 -0400
Received: by pacfv12 with SMTP id fv12so84820173pac.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cO+J96Iug1966LOJbHexwNXQkIbzGD710ryXffyQZ1I=;
        b=fzMkEUyOSdPNiIyXEPPG8Tf641LG91yb2mHIACya4a9DG/p6fLFQ+zX2tqa9NIpVcv
         0ZAUf+92BgW+dZ8JwIcOUuDu17FBenDqL+ETifxoP7FevfM1EEOCg9SMv/jyd43GWlaP
         zmMKMxUnT4GDtTMDUkkQIGLdVLZEQnMk1KiAJjNCRe7J54nJXhn/gUmU6AyhK2QMNsN2
         3nyGhFGTKveaA8HOWmoTveIp5oRqNOAHvbX8YiFsUueIttp6aeafRjJcqjTtZazV/DpS
         lfnlhznnd/BnbkslacJGXSKY4Gux4y6MOHq6sfM1auVrUeJrqvQ/TOdMoXZp/qJnaJX/
         pmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cO+J96Iug1966LOJbHexwNXQkIbzGD710ryXffyQZ1I=;
        b=LiO6JF9JLUYSlYSSca2yP9h7jPfqGbcpzZoLC5nd64RHCs6A108vwa/bHbmL+PYkaV
         IkKHpa3LYJExEeifEdy2evUTckZSRJWT+wJjD6veu+Vwx4H/g+un2oubS6KlyHghavJd
         g1mkfPPctds2ODOKsawp74N+Qf8+sJ9X5Csch5GQ0qG3dD6VApmegAHhFaJNgfmSeCou
         u+GPa6HN8wAR6qhw10wibeviQ33jWx6mh/9kVeX611ZZxfClhWeIbRIuhZl6Rc8taE4Q
         klDf+JqvM/fskmJYg2PPDbxtYs5r8ix5bC/WZYbUTykD8wv9hsXsPSI8AdqNo+wBq31Q
         4ywA==
X-Gm-Message-State: ALoCoQnEb7fEUbOe1iy+4eJWer7v6boGTPo7aRkYG2/Np18RanaKg3OV7+GzZxLTXzrJjLiTpLNe
X-Received: by 10.66.102.7 with SMTP id fk7mr2160323pab.119.1443129198453;
        Thu, 24 Sep 2015 14:13:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:85b5:1b05:2b7d:c74a])
        by smtp.gmail.com with ESMTPSA id rw8sm154445pac.11.2015.09.24.14.13.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Sep 2015 14:13:18 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <1443129187-18572-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278632>

This is a mixed bag of squashes.

 * pp_start_one() stuffed unborn child to the list of children when
   start_command() failed and start_failure() did not die(); return
   to the caller without corrupting children[] list in this case.

 * make poll(2) timeout used in pp_buffer_stderr() configurable by
   the scheduling loop.

 * allow slow-start of the whole process, so that we do not spawn
   tons of processes before starting to read from any of them, to
   give a better first-byte latency.

 * fix the semantics of the value returned from pp_start_one() and
   adjust the scheduling loop for it.

[added by sb:]
 * If you do not die() in start_failure_fn or return_value_fn, you
   don't want to write to stderr directly as you would destroy the fine
   ordering of the processes output. So make the err strbuf available in
   both these functions, and make sure the strbuf is appended to the
   buffered output in both cases

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 43 ++++++++++++++++++++++++++++++-------------
 run-command.h |  1 +
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/run-command.c b/run-command.c
index 494e1f8..0d22291 100644
--- a/run-command.c
+++ b/run-command.c
@@ -907,6 +907,7 @@ void default_start_failure(void *data,
 
 void default_return_value(void *data,
 			  struct child_process *cp,
+			  struct strbuf *err,
 			  int result)
 {
 	int i;
@@ -977,7 +978,7 @@ static void set_nonblocking(int fd)
 			"output will be degraded");
 }
 
-/* returns 1 if a process was started, 0 otherwise */
+/* return 0 if get_next_task() ran out of things to do, non-zero otherwise */
 static int pp_start_one(struct parallel_processes *pp)
 {
 	int i;
@@ -991,26 +992,30 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (!pp->get_next_task(pp->data,
 			       &pp->children[i].process,
 			       &pp->children[i].err))
-		return 1;
+		return 0;
 
-	if (start_command(&pp->children[i].process))
+	if (start_command(&pp->children[i].process)) {
 		pp->start_failure(pp->data,
 				  &pp->children[i].process,
 				  &pp->children[i].err);
+		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
+		strbuf_reset(&pp->children[i].err);
+		return -1;
+	}
 
 	set_nonblocking(pp->children[i].process.err);
 
 	pp->nr_processes++;
 	pp->children[i].in_use = 1;
 	pp->pfd[i].fd = pp->children[i].process.err;
-	return 0;
+	return 1;
 }
 
-static void pp_buffer_stderr(struct parallel_processes *pp)
+static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 {
 	int i;
 
-	while ((i = poll(pp->pfd, pp->max_processes, 100)) < 0) {
+	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
 		if (errno == EINTR)
 			continue;
 		pp_cleanup(pp);
@@ -1069,7 +1074,8 @@ static void pp_collect_finished(struct parallel_processes *pp)
 			error("waitpid is confused (%s)",
 			      pp->children[i].process.argv[0]);
 
-		pp->return_value(pp->data, &pp->children[i].process, code);
+		pp->return_value(pp->data, &pp->children[i].process,
+				 &pp->children[i].err, code);
 
 		argv_array_clear(&pp->children[i].process.args);
 		argv_array_clear(&pp->children[i].process.env_array);
@@ -1111,15 +1117,26 @@ int run_processes_parallel(int n, void *data,
 			   return_value_fn return_value)
 {
 	struct parallel_processes pp;
-	pp_init(&pp, n, data, get_next_task, start_failure, return_value);
 
+	pp_init(&pp, n, data, get_next_task, start_failure, return_value);
 	while (1) {
-		while (pp.nr_processes < pp.max_processes &&
-		       !pp_start_one(&pp))
-			; /* nothing */
-		if (!pp.nr_processes)
+		int no_more_task, cnt;
+		int output_timeout = 100;
+		int spawn_cap = 4;
+
+		for (cnt = spawn_cap, no_more_task = 0;
+		     cnt && pp.nr_processes < pp.max_processes;
+		     cnt--) {
+			if (!pp_start_one(&pp)) {
+				no_more_task = 1;
+				break;
+			}
+		}
+
+		if (no_more_task && !pp.nr_processes)
 			break;
-		pp_buffer_stderr(&pp);
+		pp_buffer_stderr(&pp, output_timeout);
+
 		pp_output(&pp);
 		pp_collect_finished(&pp);
 	}
diff --git a/run-command.h b/run-command.h
index 3807fd1..f7035cb 100644
--- a/run-command.h
+++ b/run-command.h
@@ -138,6 +138,7 @@ typedef void (*start_failure_fn)(void *data,
 
 typedef void (*return_value_fn)(void *data,
 				struct child_process *cp,
+				struct strbuf *err,
 				int result);
 
 /**
-- 
2.5.0.273.g6fa2560.dirty
