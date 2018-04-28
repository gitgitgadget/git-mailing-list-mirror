Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E621F428
	for <e@80x24.org>; Sat, 28 Apr 2018 18:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeD1S1g (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 14:27:36 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42898 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeD1S1f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 14:27:35 -0400
Received: by mail-pg0-f65.google.com with SMTP id p9-v6so830011pgc.9
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8FGyFfw2+pjYQmA2IgWEGOGeYhWyuBDHeHzLuTJ/dNY=;
        b=o+kDnc6PCN2PNJYhW2G1l1H5iWmgFNrx7oG5W3BOY2PNVRz5OgmP8zXOMxoUw3N0Pu
         zjlSDQxHMGn8L4/+oDUgCNvfJWs0Y+NSDHmniatDFVVdbzSxC3TfwBw3pSRYlL2H51aD
         OW7b1ILfIr/dLSwtkWpv/HL2+qK1i+ka6sEiT8DXW5VkMTVfD+F5EYiRPXYDycPG4Xhq
         AB3OSE3DKvI2OwnDfhUUpi2OoGtKXgToQUv6Rqh6T5/UYRpOoufMI3YIvu3iwNE2Krog
         QjQJNsWMMdO+ogleqVFYT+BlXIbQ7Jtd7hhJBVJrWmTVshjoGO08rqvZiLeaaUoX4ZuC
         TDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8FGyFfw2+pjYQmA2IgWEGOGeYhWyuBDHeHzLuTJ/dNY=;
        b=V8FwEQlpzTafLJinPul8hlDoNT1biecJQaWnE9A3PNf4D44qeYN1DZYq1/pxmMscQb
         gGcDZuMDNsz1ipJ09EQxgQa4xvP55oWgxPIGPbpXCBCeSzg+O5sTjAEoIUofpZitY1wZ
         SmLmmeQA84wcAQKww9k44K3U5gVPxaUcnQpcRBupkLovmLpOUGhhWmNIOe+myyMOK4Us
         ALtbWBJlKIbKh8sw0Sv8CIWQsVZCBd/9TShJL1JZy7Huu80AJgfeXADh6ujqSx9oxsFc
         vJFWfeuIXblWD4qMtXf5KvhwsbYASQwHBhlalE3y9Ze8cK1KwVJ334jaSH/56TeQCJS/
         rgmw==
X-Gm-Message-State: ALQs6tD6pU6QJ1kv7CxzxJOwppTfgjEY3qJeF6M0z2qQr+T5tfQjXLLp
        Yn7yTMb8t/c+D4CYLvhSN9aD4B3On1o=
X-Google-Smtp-Source: AB8JxZrYODQo1CEwhNbo3hQneldpcoqYE77tG8bColB3XON5LNSes0Pqm/Vbh3Qw1UW+vLgjfMd6Uw==
X-Received: by 10.98.62.194 with SMTP id y63mr6609994pfj.102.1524940053501;
        Sat, 28 Apr 2018 11:27:33 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:6e43::93dc])
        by smtp.gmail.com with ESMTPSA id s17sm9268470pfk.105.2018.04.28.11.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Apr 2018 11:27:31 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gitster@pobox.com
Subject: [RFC PATCH v3] Teach remote add the --remote-tags option
Date:   Sat, 28 Apr 2018 11:27:28 -0700
Message-Id: <20180428182728.21696-1-wink@saville.com>
X-Mailer: git-send-email 2.17.0.392.ga7de9262c6
In-Reply-To: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When --remote-tags is passed to `git remote add` the tagopt is set to
--remote-tags and a second fetch line is added so tags are placed in
a separate hierarchy per remote.

For example:
  $ git remote add -f --remote-tags gbenchmark git@github.com:google/benchmark
  Updating gbenchmark
  warning: no common commits
  remote: Counting objects: 4406, done.
  remote: Compressing objects: 100% (18/18), done.
  remote: Total 4406 (delta 7), reused 13 (delta 6), pack-reused 4382
  Receiving objects: 100% (4406/4406), 1.34 MiB | 7.58 MiB/s, done.
  Resolving deltas: 100% (2865/2865), done.
  From github.com:google/benchmark
   * [new branch]      clangtidy       -> gbenchmark/clangtidy
   * [new branch]      iter_report     -> gbenchmark/iter_report
   * [new branch]      master          -> gbenchmark/master
   * [new branch]      releasing       -> gbenchmark/releasing
   * [new branch]      reportercleanup -> gbenchmark/reportercleanup
   * [new branch]      rmheaders       -> gbenchmark/rmheaders
   * [new branch]      v2              -> gbenchmark/v2
   * [new tag]         v0.0.9          -> refs/remote-tags/gbenchmark/v0.0.9
   * [new tag]         v0.1.0          -> refs/remote-tags/gbenchmark/v0.1.0
   * [new tag]         v1.0.0          -> refs/remote-tags/gbenchmark/v1.0.0
   * [new tag]         v1.1.0          -> refs/remote-tags/gbenchmark/v1.1.0
   * [new tag]         v1.2.0          -> refs/remote-tags/gbenchmark/v1.2.0
   * [new tag]         v1.3.0          -> refs/remote-tags/gbenchmark/v1.3.0
   * [new tag]         v1.4.0          -> refs/remote-tags/gbenchmark/v1.4.0

And the .git/config remote "gbenchmark" section looks like:
  [remote "gbenchmark"]
    url = git@github.com:google/benchmark
    fetch = +refs/heads/*:refs/remotes/gbenchmark/*
    fetch = +refs/tags/*:refs/remote-tags/gbenchmark/*
    tagopt = --remote-tags

Based on a solution proposed by Junio on the email list [1]

[1]: https://public-inbox.org/git/xmqqbme51rgn.fsf@gitster-ct.c.googlers.com/T/#me7f7f153b8ba742c0dc48d8ec79c280c9682d32e

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Wink Saville <wink@saville.com>
---
 Documentation/git-remote.txt |  8 +++++--
 builtin/remote.c             | 44 ++++++++++++++++++++++++++++++++----
 remote.c                     |  2 ++
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 4feddc0293..fc983c2ff1 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [--tags | --remote-tags | --no-tags] [--mirror=<fetch|push>] <name> <url>
 'git remote rename' <old> <new>
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
@@ -54,7 +54,11 @@ With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
 With `--tags` option, `git fetch <name>` imports every tag from the
-remote repository.
+remote repository to refs/tags, use --remote-tags to import them
+to refs/remote-tags/<name>/<tag>.
++
+With `--remote-tags` option, `git fetch <name>` imports every tag from the
+remote repository to refs/remote-tags/<name>/<tag>.
 +
 With `--no-tags` option, `git fetch <name>` does not import tags from
 the remote repository.
diff --git a/builtin/remote.c b/builtin/remote.c
index 805ffc05cd..07832113e9 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -11,7 +11,7 @@
 
 static const char * const builtin_remote_usage[] = {
 	N_("git remote [-v | --verbose]"),
-	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
+	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags | --remote-tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
 	N_("git remote rename <old> <new>"),
 	N_("git remote remove <name>"),
 	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
@@ -101,7 +101,8 @@ static int fetch_remote(const char *name)
 enum {
 	TAGS_UNSET = 0,
 	TAGS_DEFAULT = 1,
-	TAGS_SET = 2
+	TAGS_SET = 2,
+	TAGS_SET_REMOTE = 3
 };
 
 #define MIRROR_NONE 0
@@ -123,6 +124,14 @@ static void add_branch(const char *key, const char *branchname,
 	git_config_set_multivar(key, tmp->buf, "^$", 0);
 }
 
+static void add_remote_tags(const char *key, const char *remotename,
+			    struct strbuf *tmp)
+{
+	strbuf_reset(tmp);
+	strbuf_addf(tmp, "+refs/tags/*:refs/remote-tags/%s/*", remotename);
+	git_config_set_multivar(key, tmp->buf, "^$", 0);
+}
+
 static const char mirror_advice[] =
 N_("--mirror is dangerous and deprecated; please\n"
    "\t use --mirror=fetch or --mirror=push instead");
@@ -161,6 +170,9 @@ static int add(int argc, const char **argv)
 		OPT_SET_INT(0, "tags", &fetch_tags,
 			    N_("import all tags and associated objects when fetching"),
 			    TAGS_SET),
+		OPT_SET_INT(0, "remote-tags", &fetch_tags,
+			    N_("import all tags and associated objects when fetching to refs/remote-tags/<name>/<tag>"),
+			    TAGS_SET_REMOTE),
 		OPT_SET_INT(0, NULL, &fetch_tags,
 			    N_("or do not fetch any tag at all (--no-tags)"), TAGS_UNSET),
 		OPT_STRING_LIST('t', "track", &track, N_("branch"),
@@ -182,6 +194,10 @@ static int add(int argc, const char **argv)
 		die(_("specifying a master branch makes no sense with --mirror"));
 	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
 		die(_("specifying branches to track makes sense only with fetch mirrors"));
+	if ((fetch_tags == TAGS_SET_REMOTE) && mirror)
+		die(_("specifying --remote-tags makes no sense with --mirror"));
+	if ((fetch_tags == TAGS_SET_REMOTE) && track.nr)
+		die(_("specifying --remote-tags makes no sense with -t or --track"));
 
 	name = argv[0];
 	url = argv[1];
@@ -215,10 +231,30 @@ static int add(int argc, const char **argv)
 	}
 
 	if (fetch_tags != TAGS_DEFAULT) {
+		if (fetch_tags == TAGS_SET_REMOTE) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "remote.%s.fetch", name);
+			add_remote_tags(buf.buf, name, &buf2);
+		}
+
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.tagopt", name);
-		git_config_set(buf.buf,
-			       fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
+		char *config_val = NULL;
+		switch (fetch_tags) {
+		case TAGS_UNSET:
+			config_val = "--no-tags";
+			break;
+		case TAGS_SET:
+			config_val = "--tags";
+			break;
+		case TAGS_SET_REMOTE:
+			config_val = "--remote-tags";
+			break;
+		default:
+			die(_("Unexpected TAGS enum %d"), fetch_tags);
+			break;
+		}
+		git_config_set(buf.buf, config_val);
 	}
 
 	if (fetch && fetch_remote(name))
diff --git a/remote.c b/remote.c
index 91eb010ca9..86cccc0b6e 100644
--- a/remote.c
+++ b/remote.c
@@ -447,6 +447,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 			remote->fetch_tags = -1;
 		else if (!strcmp(value, "--tags"))
 			remote->fetch_tags = 2;
+		else if (!strcmp(value, "--remote-tags"))
+			remote->fetch_tags = -1;
 	} else if (!strcmp(subkey, "proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
-- 
2.17.0.392.ga7de9262c6

