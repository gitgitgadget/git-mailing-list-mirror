From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Make some strings const
Date: Wed, 28 Jun 2006 12:04:39 +0300
Message-ID: <20060628120439.e60d7e15.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 11:04:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvVyZ-0000xe-6x
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423234AbWF1JEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423235AbWF1JEo
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:04:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:21482 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423234AbWF1JEn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 05:04:43 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3035894ugf
        for <git@vger.kernel.org>; Wed, 28 Jun 2006 02:04:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=HjsJ9lDa0RVLiREf1E8e/HfVapI0QIZkR+qKquNelNv2nwA/MIjbDHIQNN0Qghbs8QFO1MG9dr91WiE5hJIYYLv1qUfjZh4nr1fd2gdzS4fGULChlw9KaVQ/h1fMcHvAJRAACXhlOZoUTYM1gKZa3jKhA5aVhLqTbQ8+A/QKTWs=
Received: by 10.78.156.6 with SMTP id d6mr89880hue;
        Wed, 28 Jun 2006 02:04:41 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id 30sm2436686hue.2006.06.28.02.04.41;
        Wed, 28 Jun 2006 02:04:41 -0700 (PDT)
To: junkio@cox.net
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22783>

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-mailinfo.c  |    2 +-
 builtin-rev-parse.c |    2 +-
 commit.c            |    2 +-
 connect.c           |    4 ++--
 daemon.c            |    4 ++--
 describe.c          |    2 +-
 git.c               |    3 ++-
 http-push.c         |    4 ++--
 imap-send.c         |    2 +-
 sha1_file.c         |    2 +-
 upload-pack.c       |    4 ++--
 11 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 821642a..3e40747 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -165,7 +165,7 @@ static int handle_subject(char *line)
 
 static int slurp_attr(const char *line, const char *name, char *attr)
 {
-	char *ends, *ap = strcasestr(line, name);
+	const char *ends, *ap = strcasestr(line, name);
 	size_t sz;
 
 	if (!ap) {
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index b27a6d3..5f5ade4 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -329,7 +329,7 @@ int cmd_rev_parse(int argc, const char *
 		dotdot = strstr(arg, "..");
 		if (dotdot) {
 			unsigned char end[20];
-			char *next = dotdot + 2;
+			const char *next = dotdot + 2;
 			const char *this = arg;
 			*dotdot = 0;
 			if (!*next)
diff --git a/commit.c b/commit.c
index 946615d..0327df1 100644
--- a/commit.c
+++ b/commit.c
@@ -543,7 +543,7 @@ static int add_merge_info(enum cmit_fmt 
 		const char *hex = abbrev
 			? find_unique_abbrev(p->object.sha1, abbrev)
 			: sha1_to_hex(p->object.sha1);
-		char *dots = (abbrev && strlen(hex) != 40) ? "..." : "";
+		const char *dots = (abbrev && strlen(hex) != 40) ? "..." : "";
 		parent = parent->next;
 
 		offset += sprintf(buf + offset, " %s%s", hex, dots);
diff --git a/connect.c b/connect.c
index 66e78a2..f9d9202 100644
--- a/connect.c
+++ b/connect.c
@@ -330,7 +330,7 @@ static int git_tcp_connect_sock(char *ho
 {
 	int sockfd = -1;
 	char *colon, *end;
-	char *port = STR(DEFAULT_GIT_PORT);
+	const char *port = STR(DEFAULT_GIT_PORT);
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
 
@@ -525,7 +525,7 @@ static int git_use_proxy(const char *hos
 static void git_proxy_connect(int fd[2],
 			      const char *prog, char *host, char *path)
 {
-	char *port = STR(DEFAULT_GIT_PORT);
+	const char *port = STR(DEFAULT_GIT_PORT);
 	char *colon, *end;
 	int pipefd[2][2];
 	pid_t pid;
diff --git a/daemon.c b/daemon.c
index 1ba4d66..e096bd7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -35,7 +35,7 @@ static char *base_path = NULL;
  * after ~user/.  E.g. a request to git://host/~alice/frotz would
  * go to /home/alice/pub_git/frotz with --user-path=pub_git.
  */
-static char *user_path = NULL;
+static const char *user_path = NULL;
 
 /* Timeout, and initial timeout */
 static unsigned int timeout = 0;
@@ -472,7 +472,7 @@ static void child_handler(int signo)
 			children_reaped = reaped + 1;
 			/* XXX: Custom logging, since we don't wanna getpid() */
 			if (verbose) {
-				char *dead = "";
+				const char *dead = "";
 				if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
 					dead = " (with error)";
 				if (log_syslog)
diff --git a/describe.c b/describe.c
index aa3434a..8e68d5d 100644
--- a/describe.c
+++ b/describe.c
@@ -97,7 +97,7 @@ static int compare_names(const void *_a,
 	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
 }
 
-static void describe(char *arg, int last_one)
+static void describe(const char *arg, int last_one)
 {
 	unsigned char sha1[20];
 	struct commit *cmit;
diff --git a/git.c b/git.c
index 8b060e8..90b86a6 100644
--- a/git.c
+++ b/git.c
@@ -17,7 +17,8 @@ #include "builtin.h"
 
 static void prepend_to_path(const char *dir, int len)
 {
-	char *path, *old_path = getenv("PATH");
+	const char *old_path = getenv("PATH");
+	char *path;
 	int path_len = len;
 
 	if (!old_path)
diff --git a/http-push.c b/http-push.c
index 3c89a17..e281f70 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1274,7 +1274,7 @@ xml_cdata(void *userData, const XML_Char
 	strlcpy(ctx->cdata, s, len + 1);
 }
 
-static struct remote_lock *lock_remote(char *path, long timeout)
+static struct remote_lock *lock_remote(const char *path, long timeout)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
@@ -2130,7 +2130,7 @@ static int remote_exists(const char *pat
 	return -1;
 }
 
-static void fetch_symref(char *path, char **symref, unsigned char *sha1)
+static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 {
 	char *url;
 	struct buffer buffer;
diff --git a/imap-send.c b/imap-send.c
index 94e39cd..65c71c6 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -242,7 +242,7 @@ socket_read( Socket_t *sock, char *buf, 
 }
 
 static int
-socket_write( Socket_t *sock, char *buf, int len )
+socket_write( Socket_t *sock, const char *buf, int len )
 {
 	int n = write( sock->fd, buf, len );
 	if (n != len) {
diff --git a/sha1_file.c b/sha1_file.c
index c80528b..8179630 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -343,7 +343,7 @@ static void read_info_alternates(const c
 
 void prepare_alt_odb(void)
 {
-	char *alt;
+	const char *alt;
 
 	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
 	if (!alt) alt = "";
diff --git a/upload-pack.c b/upload-pack.c
index 7b86f69..2b70c3d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -95,8 +95,8 @@ static void create_pack_file(void)
 		int i;
 		int args;
 		const char **argv;
+		const char **p;
 		char *buf;
-		char **p;
 
 		if (create_full_pack) {
 			args = 10;
@@ -441,7 +441,7 @@ static int receive_needs(void)
 
 static int send_ref(const char *refname, const unsigned char *sha1)
 {
-	static char *capabilities = "multi_ack thin-pack side-band";
+	static const char *capabilities = "multi_ack thin-pack side-band";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
-- 
1.4.1.rc1.g1ef9
