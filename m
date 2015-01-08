From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 09/10] push.c: add an --atomic argument
Date: Wed,  7 Jan 2015 19:23:23 -0800
Message-ID: <1420687404-13997-10-git-send-email-sbeller@google.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 04:24:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y93hg-0007hc-Tb
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 04:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787AbbAHDYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 22:24:03 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:48594 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869AbbAHDX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 22:23:56 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so889645igd.2
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 19:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oK/CGbRpjoGZUpeEC9PAkRpydKIOW/bJGWe3ae2sASQ=;
        b=gRgbRVM6b+su+hv195hsGQ/61pWktMlE4UPtoxbw02jUwrF5/SISl5C8DqLgguBF3y
         lbVMEZ8GEtj4ywtVcP0LtmSj5TX3amOqTOr2rIgsoQA1w0HcFy9bB41bLImU+GiQ7LM2
         BPoKy/rtSu5+aiK44+ETF+0O2JmWU8inVuIxEA/YUlhCsyGV4yjsvK2hng5TVZTxslvE
         /EOL76YNeQWUsNmAVeyVg69TDjzmkvc0vL/VGWgDetPlarDGVJqNGxOAeEu3end2cKym
         q5PmuOYOOzOTHljn/mN9i0DsDBqPl0XxpCC9pIBqBfOPXbZ0WHMDnJJy9k0I9XHd5eW0
         16Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oK/CGbRpjoGZUpeEC9PAkRpydKIOW/bJGWe3ae2sASQ=;
        b=MdsIUGGVbKrKM+mmuMSgiz6KbH8l5agDn7xpYvjgGB8tdN78WIhDbxQx6ogXXFmRO+
         f9ESOsg9Kfqr4BwXffOn27SB4clCSUMGjS71FNpktAQ5bCOKKtj0/i6R93j3Q9ijbQ3g
         0xRwEcQkm7IjucoER/aoiJg6box9ByZPetgqXPs5puQa3WkpWom4UmOIRfVW+hBjiAwp
         031h8lDOWSq7GPBAg3IH/y0Cusjr6u+JFyyWGcH7ygc6/0gQMcfi5t51p//qyKNHr5rV
         MwDyCI1opqEpxeKtJag54jA2RBCIGFM5EcaQ2moDLBEYFmRlnmSVQtfal8vqmPIwr7LF
         R/bg==
X-Gm-Message-State: ALoCoQkFD4BUxhd2wtp7Fl3Y2y71dERKDGOf8/bXgtvOviQolsNkSMWuaE7mueLoabju/6F3rrau
X-Received: by 10.107.18.208 with SMTP id 77mr6824185ios.57.1420687436122;
        Wed, 07 Jan 2015 19:23:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:948f:12c6:eb26:9b9c])
        by mx.google.com with ESMTPSA id p7sm7451674iga.17.2015.01.07.19.23.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Jan 2015 19:23:55 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1420687404-13997-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262175>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a command line argument to the git push command to request atomic
pushes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v10, v11, v12:
    * no changes
    
    v8, v9:
    no changes
    
    v7:
    	Use OPT_BOOL instead of OPT_BIT.
    	This allows for --no-atomic option on the command line.
    v6:
    -		OPT_BIT(0, "atomic", &flags, N_("use an atomic transaction remote"),
    +		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"),
    
    skipped v4 v5
    
    v2->v3:
    	* s/atomic-push/atomic/
    	* s/the an/an/
    	* no serverside, but just remote instead
    	* TRANSPORT_PUSH_ATOMIC instead of TRANSPORT_ATOMIC_PUSH
    
    Changes v1 -> v2
    	It's --atomic now! (dropping the -push)

 Documentation/git-push.txt | 7 ++++++-
 builtin/push.c             | 5 +++++
 transport.c                | 1 +
 transport.h                | 1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21b3f29..4764fcf 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
 	   [-u | --set-upstream] [--signed]
 	   [--force-with-lease[=<refname>[:<expect>]]]
@@ -136,6 +136,11 @@ already exists on the remote side.
 	logged.  See linkgit:git-receive-pack[1] for the details
 	on the receiving end.
 
+--[no-]atomic::
+	Use an atomic transaction on the remote side if available.
+	Either all refs are updated, or on error, no refs are updated.
+	If the server does not support atomic pushes the push will fail.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index a076b19..8f1d945 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -487,6 +487,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int flags = 0;
 	int tags = 0;
 	int rc;
+	int atomic = 0;
 	const char *repo = NULL;	/* default repository */
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
@@ -518,6 +519,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
 		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
+		OPT_BOOL(0, "atomic", &atomic, N_("request atomic transaction on remote side")),
 		OPT_END()
 	};
 
@@ -533,6 +535,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (tags)
 		add_refspec("refs/tags/*");
 
+	if (atomic)
+		flags |= TRANSPORT_PUSH_ATOMIC;
+
 	if (argc > 0) {
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1, repo);
diff --git a/transport.c b/transport.c
index c67feee..1373152 100644
--- a/transport.c
+++ b/transport.c
@@ -830,6 +830,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 	args.push_cert = !!(flags & TRANSPORT_PUSH_CERT);
+	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
 	args.url = transport->url;
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
diff --git a/transport.h b/transport.h
index 3e0091e..18d2cf8 100644
--- a/transport.h
+++ b/transport.h
@@ -125,6 +125,7 @@ struct transport {
 #define TRANSPORT_PUSH_NO_HOOK 512
 #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
 #define TRANSPORT_PUSH_CERT 2048
+#define TRANSPORT_PUSH_ATOMIC 4096
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
2.2.1.62.g3f15098
