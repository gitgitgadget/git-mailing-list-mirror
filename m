From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/27] nd/shallow-deepen updates
Date: Sun, 12 Jun 2016 17:53:42 +0700
Message-ID: <20160612105409.22156-1-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:54:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC32c-0002tf-21
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbcFLKys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 06:54:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36265 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcFLKyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:54:47 -0400
Received: by mail-pf0-f194.google.com with SMTP id 62so8488709pfd.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCZ3Ji8Knvg8SWbsSAREpkHDoJssZ/EjCJvO0mvReMw=;
        b=Gbvq9g1hSUpyabXVaOuK/FWNIn1aVMGOefsdtjYjlFPzkhcFNaHx3NHNlPIX0TIArj
         AH0+VIsHTLfnmwnCCHfPxQYqcNVGYQ5Y2jblCAFYmsDi0qF4rm+Q+cALbvngDhGO8y/P
         Mnb1DlMRlP9DuvldCcKeTuGbbvQZ4iQkTZGy1WNgZKJBKJ68+HG16piPqoex4Zw/SNrQ
         ACx0wh/pvGM0gMorD0JJXiMUCbwUmISUeZYg6G07dXEuEzyQSaMQAabuE6Cf3XO/7dud
         hsEQAJCcJvtZU40ysxlBuq7pWCjddUhOAC4PfXNSAONkkhcUnMEJJj1DrTg+jS9ZGO+l
         ZWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCZ3Ji8Knvg8SWbsSAREpkHDoJssZ/EjCJvO0mvReMw=;
        b=juJde3I+OwCFcn7s/fobjfmwqRlQcqp1HYjB17wRlowanCR3FFLly/N7FRP3wi6JJl
         y6+vZcnkABEUYVE3lNnwkkyxMAndi5mv07b7OWj+4O6Yf6TWy1uo4C6yTm8GJxAW2YpG
         qrH48WWfZv14/+7dklpsybJ4wiQVY4uCkcdstZLVEa3kBgiuMQ4ihiGVWcP0uMfko5iG
         jXiWdJVNFxvPwMysXgqJQ8mPHAjbtQr98mkVS0gw6mV1FZo44OYcpn3MmB3TiZprvh2W
         ZQ3limYlSMy+cSOtny5fmp1yzeMWw5OSgaWgFCX+P4Yw6W2QYph6ZReD9lXzhGNVxrMF
         r4XQ==
X-Gm-Message-State: ALyK8tIwChM8xw/7OdJYFqAt8kkuCZbvwRJ5HJ0wHpSa1fcSO/3Cf0Zd9tEzifwFC8Z3IQ==
X-Received: by 10.98.196.18 with SMTP id y18mr12701614pff.163.1465728886216;
        Sun, 12 Jun 2016 03:54:46 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id bw1sm22204462pab.17.2016.06.12.03.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:54:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:54:41 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297107>

Second update to address Junio comments. Interdiff

diff --git a/upload-pack.c b/upload-pack.c
index ef693bd..e40d15a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -453,6 +453,9 @@ static int is_our_ref(struct object *o)
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
 
+/*
+ * on successful case, it's up to the caller to close cmd->out
+ */
 static int do_reachable_revlist(struct child_process *cmd,
 				struct object_array *src,
 				struct object_array *reachable)
@@ -470,16 +473,16 @@ static int do_reachable_revlist(struct child_process *cmd,
 	cmd->in = -1;
 	cmd->out = -1;
 
-	if (start_command(cmd))
-		goto error;
-
 	/*
-	 * If rev-list --stdin encounters an unknown commit, it
-	 * terminates, which will cause SIGPIPE in the write loop
+	 * If the next rev-list --stdin encounters an unknown commit,
+	 * it terminates, which will cause SIGPIPE in the write loop
 	 * below.
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
 
+	if (start_command(cmd))
+		goto error;
+
 	namebuf[0] = '^';
 	namebuf[41] = '\n';
 	for (i = get_max_object_index(); 0 < i; ) {
@@ -491,10 +494,8 @@ static int do_reachable_revlist(struct child_process *cmd,
 		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd->in, namebuf, 42) < 0) {
-			sigchain_pop(SIGPIPE);
+		if (write_in_full(cmd->in, namebuf, 42) < 0)
 			goto error;
-		}
 	}
 	namebuf[40] = '\n';
 	for (i = 0; i < src->nr; i++) {
@@ -507,18 +508,18 @@ static int do_reachable_revlist(struct child_process *cmd,
 		if (reachable && o->type == OBJ_COMMIT)
 			o->flags |= TMP_MARK;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd->in, namebuf, 41) < 0) {
-			sigchain_pop(SIGPIPE);
+		if (write_in_full(cmd->in, namebuf, 41) < 0)
 			goto error;
-		}
 	}
 	close(cmd->in);
 	cmd->in = -1;
-
 	sigchain_pop(SIGPIPE);
+
 	return 0;
 
 error:
+	sigchain_pop(SIGPIPE);
+
 	if (cmd->in >= 0)
 		close(cmd->in);
 	if (cmd->out >= 0)
@@ -530,11 +531,11 @@ static int get_reachable_list(struct object_array *src,
 			      struct object_array *reachable)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	int i, ret = do_reachable_revlist(&cmd, src, reachable);
+	int i;
 	struct object *o;
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 
-	if (ret < 0)
+	if (do_reachable_revlist(&cmd, src, reachable) < 0)
 		return -1;
 
 	while ((i = read_in_full(cmd.out, namebuf, 41)) == 41) {
@@ -564,14 +565,14 @@ static int get_reachable_list(struct object_array *src,
 	return 0;
 }
 
-static int check_unreachable(struct object_array *src)
+static int has_unreachable(struct object_array *src)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	char buf[1];
 	int i;
 
 	if (do_reachable_revlist(&cmd, src, NULL) < 0)
-		return 0;
+		return 1;
 
 	/*
 	 * The commits out of the rev-list are not ancestors of
@@ -592,14 +593,13 @@ static int check_unreachable(struct object_array *src)
 		goto error;
 
 	/* All the non-tip ones are ancestors of what we advertised */
-	return 1;
+	return 0;
 
 error:
-	if (cmd.in >= 0)
-		close(cmd.in);
+	sigchain_pop(SIGPIPE);
 	if (cmd.out >= 0)
 		close(cmd.out);
-	return 0;
+	return 1;
 }
 
 static void check_non_tip(void)
@@ -613,7 +613,7 @@ static void check_non_tip(void)
 	 */
 	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
 		goto error;
-	if (check_unreachable(&want_obj))
+	if (!has_unreachable(&want_obj))
 		/* All the non-tip ones are ancestors of what we advertised */
 		return;
 
@@ -678,25 +678,33 @@ static void send_unshallow(const struct object_array *shallows)
 static void deepen(int depth, int deepen_relative,
 		   struct object_array *shallows)
 {
-	struct commit_list *result = NULL;
-	int i;
-	if (depth == INFINITE_DEPTH && !is_repository_shallow())
+	if (depth == INFINITE_DEPTH && !is_repository_shallow()) {
+		int i;
+
 		for (i = 0; i < shallows->nr; i++) {
 			struct object *object = shallows->objects[i].item;
 			object->flags |= NOT_SHALLOW;
 		}
-	else if (deepen_relative) {
+	} else if (deepen_relative) {
 		struct object_array reachable_shallows = OBJECT_ARRAY_INIT;
+		struct commit_list *result;
+
 		get_reachable_list(shallows, &reachable_shallows);
 		result = get_shallow_commits(&reachable_shallows,
 					     depth + 1,
 					     SHALLOW, NOT_SHALLOW);
+		send_shallow(result);
+		free_commit_list(result);
 		object_array_clear(&reachable_shallows);
-	} else
+	} else {
+		struct commit_list *result;
+
 		result = get_shallow_commits(&want_obj, depth,
 					     SHALLOW, NOT_SHALLOW);
-	send_shallow(result);
-	free_commit_list(result);
+		send_shallow(result);
+		free_commit_list(result);
+	}
+
 	send_unshallow(shallows);
 	packet_flush(1);
 }
-- 
2.8.2.524.g6ff3d78
