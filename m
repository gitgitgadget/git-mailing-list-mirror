Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 558F61F404
	for <e@80x24.org>; Wed,  3 Jan 2018 10:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeACK2x (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 05:28:53 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:40171 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeACK2v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 05:28:51 -0500
Received: by mail-wr0-f182.google.com with SMTP id p17so1051890wre.7
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m9Cnzu1j1JxVxZj1RMFE0CrlE6FsqsJFpPegnuycLNE=;
        b=rES/0dQGvGRWjOuzzyQSwfWNec5zjylabbhYFhtZouHcmDq6tZMTI795xGPxe1ox0b
         VfqmqGEVrTu0dItgeheWzm3GfrNAHMmnEN5kUT6J0TxVNFw/OW24oJ24sF0O6ZxDOTOo
         NCgEtCtVezMASx+sDQGe4b8CURe97yoSPZdbzUov5MgQFbBZD1HM/8Acc25rJgMY6mAk
         f41/zn6If3hdZobX+cADqpxlnti7ej4UMjWwFCBFAe2tJEH8wrq7fVtu0u873fEQBJgC
         PPXIx0FosZA5f5es91b21EXjR7ulTel6v4Oy3j0wtqKzCJGa7lPuGdTzXKRRFrGTIgWb
         Cq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m9Cnzu1j1JxVxZj1RMFE0CrlE6FsqsJFpPegnuycLNE=;
        b=CIPIHLCo1Accg9yX0jxHQjhdJdvBLsRGtLwUno2gWiMlAN1O74Qbgluvrxzl5zluE9
         o38Sz6kdY2O5GGpt5A5y97BNstrZ79bVx+tg1OrLQ/qJ1R1PRSmKtv0Q81qHRTgQexX+
         20NEIszQxFt082YW9At9qzRJzZKb06AepN1F9aip2yqG9K0tRp9ynOp+YwUN4Nj4YcvY
         0HXcodAUCB3Q/+U48t2lrlzgbqrNGjw/Z8OHmuaE3ajxGxN7SdagqVP+s3ZRQwUjFSdj
         a7b6Igvbx6NpK/sQxTXbc4bUmuGCi3KJZEm6riXPsD5cJZyfFDPpghcu7ErDVziI+XHo
         v9TQ==
X-Gm-Message-State: AKGB3mL23IFfXJb8JtPmSdsJgHbRQTZ+h1VPMeGlJVXTMrKA/bKP1sN7
        LOUyLMLJWOS+BDSpzqN4Ffpdk7tS
X-Google-Smtp-Source: ACJfBovJd2gRmL5xrVNk2rj5ElmO9EBMTS71djW0lwtfB6IAFQAa5YQJkSMxKYOovv2lIA1nyDK/kA==
X-Received: by 10.223.157.36 with SMTP id k36mr936664wre.153.1514975329423;
        Wed, 03 Jan 2018 02:28:49 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id r3sm872179wmg.31.2018.01.03.02.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 02:28:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Segev Finer <segev208@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH] connect: add GIT_SSH_{SEND,RECEIVE}{,_COMMAND} env variables
Date:   Wed,  3 Jan 2018 10:28:40 +0000
Message-Id: <20180103102840.27897-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the long-standing logic for overriding the ssh command with
GIT_SSH or GIT_SSH_COMMAND to also support
e.g. GIT_SSH_SEND_COMMAND. The new specific send/receive variables
take priority over the old ones, and fall back to the older ones if
they exist.

This is useful for talking to systems such as Github or Gitlab that
identify user accounts (or deploy keys) by ssh keys. Normally, ssh
could do this itself by supplying multiple keys via -i, but that trick
doesn't work on these systems as the connection will have already been
accepted when the "wrong" key gets rejected.

This new feature is redundant to and less general than setting the
GIT_SSH_COMMAND to the path of a script that's going to dispatch to
ssh depending on what the second argument to the script is, e.g.:

    $ cat ./git-ssh-command
    #!/usr/bin/perl
    if ($ARGV[1] =~ /^git-upload-pack /) {
       system qw(ssh -i /some/ro/key) => @ARGV;
    } elsif ($ARGV[1] =~ /^git-receive-pack /) {
       system qw(ssh -i /some/rw/key) => @ARGV;
    } else { ... }
    $ GIT_TRACE=1 GIT_SSH_COMMAND="./git-ssh-command" git fetch
    10:22:39.415684 git.c:344               trace: built-in: git 'fetch'
    10:22:39.432192 run-command.c:627       trace: run_command: './git-ssh-command' '-G' 'git@github.com'
    10:22:39.434156 run-command.c:627       trace: run_command: './git-ssh-command' 'git@github.com' 'git-upload-pack '\''git/git.git'\'''
    Warning: Identity file /some/ro/key not accessible: No such file or directory.

However, I feel that this is a common enough case to be worth
supporting explicitly, and such a script will also need to deal with
arbitrary arguments fed via git-fetch's --upload-pack="...", and
git-push's corresponding --receive-pack argument.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I'm not 100% sure about this one myself, but am leaning towards
inclusion for the reasons explained above, and the patch is trivial
enough that I think we can discuss whether it's worthwhile without
test / documentation.

 builtin/fetch-pack.c |  2 +-
 builtin/send-pack.c  |  3 ++-
 connect.c            | 21 ++++++++++++++++++---
 connect.h            |  2 ++
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 366b9d13f9..dae10f8419 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -189,7 +189,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		if (args.diag_url)
 			flags |= CONNECT_DIAG_URL;
 		conn = git_connect(fd, dest, args.uploadpack,
-				   flags);
+				   flags | CONNECT_RECEIVE);
 		if (!conn)
 			return args.diag_url ? 0 : 1;
 	}
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index fc4f0bb5fb..2374d2b29c 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -252,8 +252,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
+		int flags = args.verbose ? CONNECT_VERBOSE : 0;
 		conn = git_connect(fd, dest, receivepack,
-			args.verbose ? CONNECT_VERBOSE : 0);
+			flags | CONNECT_SEND);
 	}
 
 	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL,
diff --git a/connect.c b/connect.c
index c3a014c5ba..2a35924292 100644
--- a/connect.c
+++ b/connect.c
@@ -774,13 +774,23 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	return protocol;
 }
 
-static const char *get_ssh_command(void)
+static const char *get_ssh_command(int flags)
 {
 	const char *ssh;
 
+	if (flags & CONNECT_SEND && (ssh = getenv("GIT_SSH_SEND_COMMAND")))
+		return ssh;
+	else if (flags & CONNECT_RECEIVE && (ssh = getenv("GIT_SSH_RECEIVE_COMMAND")))
+		return ssh;
 	if ((ssh = getenv("GIT_SSH_COMMAND")))
 		return ssh;
 
+	if (flags & CONNECT_SEND &&
+	    !git_config_get_string_const("core.sshsendcommand", &ssh))
+		return ssh;
+	else if (flags & CONNECT_RECEIVE &&
+	    !git_config_get_string_const("core.sshreceivecommand", &ssh))
+		return ssh;
 	if (!git_config_get_string_const("core.sshcommand", &ssh))
 		return ssh;
 
@@ -997,7 +1007,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 	if (looks_like_command_line_option(ssh_host))
 		die("strange hostname '%s' blocked", ssh_host);
 
-	ssh = get_ssh_command();
+	ssh = get_ssh_command(flags);
 	if (ssh) {
 		variant = determine_ssh_variant(ssh, 1);
 	} else {
@@ -1008,7 +1018,12 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 		 */
 		conn->use_shell = 0;
 
-		ssh = getenv("GIT_SSH");
+		if (flags & CONNECT_SEND)
+			ssh = getenv("GIT_SSH_SEND");
+		else if (flags & CONNECT_RECEIVE)
+			ssh = getenv("GIT_SSH_RECEIVE");
+		if (!ssh)
+			ssh = getenv("GIT_SSH");
 		if (!ssh)
 			ssh = "ssh";
 		variant = determine_ssh_variant(ssh, 0);
diff --git a/connect.h b/connect.h
index 01f14cdf3f..e3ff0d5838 100644
--- a/connect.h
+++ b/connect.h
@@ -5,6 +5,8 @@
 #define CONNECT_DIAG_URL      (1u << 1)
 #define CONNECT_IPV4          (1u << 2)
 #define CONNECT_IPV6          (1u << 3)
+#define CONNECT_SEND          (1u << 4)
+#define CONNECT_RECEIVE       (1u << 5)
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
-- 
2.15.1.424.g9478a66081

