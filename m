From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/3] git-remote-fd & git-remote-ext
Date: Wed, 17 Nov 2010 09:15:34 -0800
Message-ID: <7vy68rg9c9.fsf@alter.siamese.dyndns.org>
References: <1289878454-17192-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Nov 17 18:15:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIlbp-0001u1-30
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 18:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935026Ab0KQRPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 12:15:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934928Ab0KQRPn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 12:15:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECB673798;
	Wed, 17 Nov 2010 12:15:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=sLEAHvHKceb3QpL2tvuqje7mBrI=; b=n7qCihIVWwgznW67QV0hRpn
	wiLgHFi7CgM0fOBz2v4BGQ3zdgpSJqCCSV0ZdPpUmR0MPDV0empMqmn6MvQSk2q5
	eIWytbIzNpqUsBx2NnAOquajHui7WQWimxLqbLwwkm2oLQzmwO17rHW/9NRLSnOk
	sutext7/FEBtfC/pRKe8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kbgTl8qISsDLiFvDRb0rkByG8CKVHC3h9UZ/9h2fcwN5P/v8L
	JkPiTNBxHaw1s+2fun6jkmvlnIeMxt10czS4k5U9ypsNCz1FVfT76aAZ/HIosL3S
	91Nweoojh9vM6l1u66uWtqQq8W5DnTpVMooaatWAAUMWX7Uryl3KbiprzA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD06E3796;
	Wed, 17 Nov 2010 12:15:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 97BE53795; Wed, 17 Nov 2010
 12:15:45 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 52736524-F26E-11DF-BE7F-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161626>

Thanks; the changes from the last round all look sensible to me, but did
you know that the last round has already been in 'next' for a few weeks by
now already?

If you don't mind I'll turn these three into the following and queue as
4/3 on top of what is already merged, as reverting the merge with the old
series and merging the new round to 'next' makes it messier than it
already is.

-- >8 --
From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: remote-fd/ext: finishing touches after code review

When compiling with pthread support, transport-helper.c needs to include
necessary header files.  Also fix a few error messages in remote-ext and
remote-fd programs, and a potential buffer underrun in remote-fd.

In the documentation, clarify how %G and %V are used; the old description
looked as if they take repository/vhost parameters, which was wrong.

Also fix AsciiDoc markup for the page title of remote-fd/remote-ext manpages,
and tweak the way how section headers are shown.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-remote-ext.txt |   10 +++++-----
 Documentation/git-remote-fd.txt  |   10 +++++-----
 builtin/remote-ext.c             |    8 +++-----
 builtin/remote-fd.c              |    6 +++---
 transport-helper.c               |    5 +++++
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 8fb260b..f4fbf67 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -39,20 +39,20 @@ The following sequences have a special meaning:
 	git-upload-pack, or git-upload-archive) of the service
 	git wants to invoke.
 
-'%G<repository>' (as argument)::
+'%G' (must be first characters in argument)::
 	This argument will not be passed to 'program'. Instead, it
 	will cause helper to start by sending git:// service request to
 	remote side with service field set to approiate value and
-	repository field set to <repository>. Default is not to send
+	repository field set to rest of the argument. Default is not to send
 	such request.
 +
 This is useful if remote side is git:// server accessed over
 some tunnel.
 
-'%V<host>' (as argument)::
+'%V' (must be first characters in argument)::
 	This argument will not be passed to 'program'. Instead it sets
-	the vhost field in git:// service request. Default is not to
-	send vhost in such request (if sent).
+	the vhost field in git:// service request (to rest of the argument).
+	Default is not to send vhost in such request (if sent).
 
 ENVIRONMENT VARIABLES:
 ----------------------
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index 1c1a179..abc4944 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -1,5 +1,5 @@
 git-remote-fd(1)
-=================
+================
 
 NAME
 ----
@@ -28,13 +28,13 @@ It is assumed that any handshaking procedures have already been completed
 information to user in the URL in case that URL is displayed in some
 context.
 
-ENVIRONMENT VARIABLES:
-----------------------
+ENVIRONMENT VARIABLES
+---------------------
 GIT_TRANSLOOP_DEBUG::
 	If set, prints debugging information about various reads/writes.
 
-EXAMPLES:
----------
+EXAMPLES
+--------
 git fetch fd::17 master::
 	Fetch master, using file descriptor #17 to communicate with
 	git-upload-pack.
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 1d3f1cf..1f77317 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -142,7 +142,7 @@ static const char **parse_argv(const char *arg, const char *service)
 	for (i = 0; i < arguments; i++)
 		ret[i] = temparray[i];
 	ret[arguments] = NULL;
-	return (const char **)ret;
+	return ret;
 }
 
 static void send_git_request(int stdin_fd, const char *serv, const char *repo,
@@ -239,10 +239,8 @@ static int command_loop(const char *child)
 
 int cmd_remote_ext(int argc, const char **argv, const char *prefix)
 {
-	if (argc < 3) {
-		fprintf(stderr, "Error: URL missing");
-		exit(1);
-	}
+	if (argc != 3)
+		die("Expected two arguments");
 
 	return command_loop(argv[2]);
 }
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index 7517f24..1f2467b 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -31,7 +31,7 @@ static void command_loop(int input_fd, int output_fd)
 		}
 		/* Strip end of line characters. */
 		i = strlen(buffer);
-		while (isspace(buffer[i - 1]))
+		while (i > 0 && isspace(buffer[i - 1]))
 			buffer[--i] = 0;
 
 		if (!strcmp(buffer, "capabilities")) {
@@ -56,8 +56,8 @@ int cmd_remote_fd(int argc, const char **argv, const char *prefix)
 	int output_fd = -1;
 	char *end;
 
-	if (argc < 3)
-		die("URL missing");
+	if (argc != 3)
+		die("Expected two arguments");
 
 	input_fd = (int)strtoul(argv[2], &end, 10);
 
diff --git a/transport-helper.c b/transport-helper.c
index 0c094d6..3a50856 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -9,6 +9,11 @@
 #include "remote.h"
 #include "string-list.h"
 
+#ifndef NO_PTHREADS
+#include <pthread.h>
+#include "thread-utils.h"
+#endif
+
 static int debug;
 
 struct helper_data
