Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689DD202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 06:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932822AbdJQGcm (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 02:32:42 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:52963 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756909AbdJQGcl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 02:32:41 -0400
Received: by mail-qk0-f194.google.com with SMTP id b15so727301qkg.9
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=g+2rIKphJlBt5mUvUWJ8j5kWz6Jxn6QP4aIwy8Xv4zM=;
        b=g9f6cXBU0Xq4REXB8mYnZOPwgPXIVIqwu9MMbRcJLClL4osmgDiu6LJ0IF5Kci3tRU
         Ug6ZnRzhV1XsYADDpZWBHZvfdq3DlteoZtMFxASeN27CpD09UGIoBwufBQLgI8M2+oAd
         aRXbzGoNgMbevp9NWcUGHChMe86brP+VGMuV305rxIjzalxVPJY4C3q7Ya/vtK8WezSX
         uSpERivipVnI4cuiivojzEciH0tUgepyAdlkdzu5XhAhmv1FZBe4FR9kQdiw2pkdtTGl
         pbvDm4HbCNRfHDgG8TNvuqS0gI3W2zjeWRxBSLimPrEY/Il2cZ6Q3mrRUrin6+UEyB0M
         vhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=g+2rIKphJlBt5mUvUWJ8j5kWz6Jxn6QP4aIwy8Xv4zM=;
        b=Izys1wfm19z/Xg26eROi7T2qPuuPrgcai/+UO4UGdP4srxmLiOs+J16LNmFxSm/Q8W
         YsaevUNykwzSOHYsjsuNfZHS1vY7wjc3LQKKLRcZtocAozDxc+EgKGD/u9+dLoYPtHij
         GFoyupOT2v6MbB5uK8P5Vir9Ioqv1ZPyzIm0Cc2OGtp8daP2xucxCy0pt3TCmc5p7C6j
         RfW6iJLxUB957uQyvm4qHoJRefnf12bIsS71aX417iDbhfuokLrGg9mYUwyLlr6AD65W
         xWdZ0tvy2UNJXXg9KCIkTvzfdBqwIJZACoI4y3d8psrR77+43L6LpS/pZTn4iel+LG9u
         TjfA==
X-Gm-Message-State: AMCzsaV9nq1JccOKXiCrm5nc6ZBvtlTQ2Tsv43o5SshpeNB8ri4WoDJO
        Sotncz8IvJzmsERNdIcdmG3PEIqLU1GfsX0uyrY=
X-Google-Smtp-Source: ABhQp+SdrUA8couc7COFNhBQrri5yopc23PmIKn+p6xogKCr/zCgbjKJVacOZya7qOKk1guXgOfSYlTUv1d5gJLOJ2Y=
X-Received: by 10.55.154.84 with SMTP id c81mr15621827qke.43.1508221960679;
 Mon, 16 Oct 2017 23:32:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.83.136 with HTTP; Mon, 16 Oct 2017 23:32:40 -0700 (PDT)
From:   Marius Paliga <marius.paliga@gmail.com>
Date:   Tue, 17 Oct 2017 08:32:40 +0200
Message-ID: <CAK7vU=1LGTLrEkRYS=autkDHmJAeq9=qa5jfx=DE+acPLsCqTg@mail.gmail.com>
Subject: [PATCH] Added support for new configuration parameter push.pushOption
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thais Diniz <thais.dinizbraz@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/push.c: add push.pushOption config

Currently push options need to be given explicitly, via
the command line as "git push --push-option".

The UX of Git would be enhanced if push options could be
configured instead of given each time on the command line.

Add the config option push.pushOption, which is a multi
string option, containing push options that are sent by default.

When push options are set in the system wide config
(/etc/gitconfig), they can be unset later in the more specific
repository config by setting the string to the empty string.

Add tests and documentation as well.

Signed-off-by: Marius Paliga <marius.paliga@gmail.com>
---
 Documentation/git-push.txt |  3 ++
 builtin/push.c             | 12 ++++++++
 t/t5545-push-options.sh    | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3e76e99f3..da9b17624 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -161,6 +161,9 @@ already exists on the remote side.
     Transmit the given string to the server, which passes them to
     the pre-receive as well as the post-receive hook. The given string
     must not contain a NUL or LF character.
+    Default push options can also be specified with configuration
+    variable `push.pushOption`. String(s) specified here will always
+    be passed to the server without need to specify it using `--push-option`

 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
diff --git a/builtin/push.c b/builtin/push.c
index 2ac810422..10e520c8f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -32,6 +32,8 @@ static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;

+static struct string_list push_options_from_config = STRING_LIST_INIT_DUP;
+
 static void add_refspec(const char *ref)
 {
     refspec_nr++;
@@ -503,6 +505,14 @@ static int git_push_config(const char *k, const
char *v, void *cb)
         int val = git_config_bool(k, v) ?
             RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
         recurse_submodules = val;
+    } else if (!strcmp(k, "push.pushoption")) {
+        if (v == NULL)
+            return config_error_nonbool(k);
+        else
+            if (v[0] == '\0')
+                string_list_clear(&push_options_from_config, 0);
+            else
+                string_list_append(&push_options_from_config, v);
     }

     return git_default_config(k, v, NULL);
@@ -562,6 +572,8 @@ int cmd_push(int argc, const char **argv, const
char *prefix)
     packet_trace_identity("push");
     git_config(git_push_config, &flags);
     argc = parse_options(argc, argv, prefix, options, push_usage, 0);
+    if (!push_options.nr)
+        push_options = push_options_from_config;
     set_push_cert_flags(&flags, push_cert);

     if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL |
TRANSPORT_PUSH_MIRROR))))
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 90a4b0d2f..463783789 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -140,6 +140,83 @@ test_expect_success 'push options and submodules' '
     test_cmp expect parent_upstream/.git/hooks/post-receive.push_options
 '

+test_expect_success 'default push option' '
+    mk_repo_pair &&
+    git -C upstream config receive.advertisePushOptions true &&
+    (
+        cd workbench &&
+        test_commit one &&
+        git push --mirror up &&
+        test_commit two &&
+        git -c push.pushOption=default push up master
+    ) &&
+    test_refs master master &&
+    echo "default" >expect &&
+    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+    test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'two default push options' '
+    mk_repo_pair &&
+    git -C upstream config receive.advertisePushOptions true &&
+    (
+        cd workbench &&
+        test_commit one &&
+        git push --mirror up &&
+        test_commit two &&
+        git -c push.pushOption=default1 -c push.pushOption=default2
push up master
+    ) &&
+    test_refs master master &&
+    printf "default1\ndefault2\n" >expect &&
+    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+    test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'push option from command line overrides
from-config push option' '
+    mk_repo_pair &&
+    git -C upstream config receive.advertisePushOptions true &&
+    (
+        cd workbench &&
+        test_commit one &&
+        git push --mirror up &&
+        test_commit two &&
+        git -c push.pushOption=default push --push-option=manual up master
+    ) &&
+    test_refs master master &&
+    echo "manual" >expect &&
+    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+    test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'empty value of push.pushOption in config clears
the list' '
+    mk_repo_pair &&
+    git -C upstream config receive.advertisePushOptions true &&
+    (
+        cd workbench &&
+        test_commit one &&
+        git push --mirror up &&
+        test_commit two &&
+        git -c push.pushOption=default1 -c push.pushOption= -c
push.pushOption=default2 push up master
+    ) &&
+    test_refs master master &&
+    echo "default2" >expect &&
+    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+    test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'invalid push option in config' '
+    mk_repo_pair &&
+    git -C upstream config receive.advertisePushOptions true &&
+    (
+        cd workbench &&
+        test_commit one &&
+        git push --mirror up &&
+        test_commit two &&
+        test_must_fail git -c push.pushOption push up master
+    ) &&
+    test_refs master HEAD@{1}
