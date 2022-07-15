Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD5C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 02:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbiGOCiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbiGOCis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 22:38:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FD913DD4
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:38:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f2so4908798wrr.6
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4zvLDEf858k2Mb94pnld0ZfcIiiNE/Jwdbkemc1GiCw=;
        b=gkAzGkYZRci2HRWF4//dViil5ijezlj1Xb48v4nezIt++B9Bqv3Gz3Tu5Rd3DVGyWb
         7BprZrPfL5bb+vTljh5V8U+hDpZado3H41YywcED0T7OtPm+KXdSSPfcfkMYi0hrKxRW
         we6Q+2k2GTcE8Es8NeIvELUaf06kveSMAgxMFAF4RDGe2TRNHVGss0hP99w00IKftJjv
         Q+4Qpd0r2QigjdeJJqvLQu1Vmdl1uPPTgg+Y//yGvT+SnEVR4Aa47evoW9W7DlPb4uOy
         stR8rzMdG5j9g8TpDJAYUxPtsH9uWgHH9jNdhcqtTzjhY91UnbA48vT6Gng+2ACkupF0
         8tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4zvLDEf858k2Mb94pnld0ZfcIiiNE/Jwdbkemc1GiCw=;
        b=OiKVPSsfW+23jZEnQFdRtndhe86CI71htRlcMhfNzzy4CqN6c3RKzY+uFLbAHYV5hK
         3TL0djANhWekQt1MpZS/9G3aZxnk6XqZNBpquE6HYOfyxQAEz7FO9jMQZd4GMA+U5OTF
         kyYJ0sVbBxX/5ve3bUbB3sSw94lOXiXd4ptFBfFq0/2nfIPYTCZBHoxqGw0EvNbzpBDq
         KOTNWfkWNxhoReetyeMrPmV48/PWwCBjbzUiU3PmjtoqJ2pA0OM0mlmeuRqAqTR3a3y2
         ExhXf2S+5Em6yA53pXFzeKuvgaqoeh8lnDkU+jcOveiT2G8jnrOEKHYIPIYhpSS7z0Ah
         evNA==
X-Gm-Message-State: AJIora8rSQllY2Eq57Wdtfpw7sC/y4HWD0KA+sqaEqidZBuWfE3717Js
        5iapDYGsR81oumfhiSJfviDZCoYUUIg=
X-Google-Smtp-Source: AGRyM1thHTeeXI6Wi6KSH7brC5zRADZXq0OSqDGuEAn0FIFgV2r5THUevd4+4Mj2XoRlH0OhRVjGgA==
X-Received: by 2002:a5d:64c7:0:b0:21d:a742:5e2c with SMTP id f7-20020a5d64c7000000b0021da7425e2cmr10851224wri.178.1657852725201;
        Thu, 14 Jul 2022 19:38:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24-20020a056000181800b0021d68e1fd42sm2645380wrh.89.2022.07.14.19.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 19:38:44 -0700 (PDT)
Message-Id: <19632a2d2459114484dcdaddd4db0d22dfd64fa7.1657852722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
        <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Jul 2022 02:38:40 +0000
Subject: [PATCH v2 1/3] Documentation: remove use of whitelist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The word "whitelist" has cultural implications that are not inclusive.
Thankfully, it is not difficult to reword and avoid its use.

Remove uses of "whitelist" in the Documentation/ directory. In all
cases, we can rewrite the sentences to add clarity instead of relying on
the reader understanding this term.

The most substantial change is to git-daemon.txt which had several uses,
but we can refer to the input directories as a list of included
directories, making the descriptions slightly simpler.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-cvsserver.txt |  2 +-
 Documentation/git-daemon.txt    | 15 +++++++--------
 Documentation/git.txt           |  3 +--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 4dc57ed2547..e90b03402a5 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -313,7 +313,7 @@ circumstances, allowing easier restricted usage through git-shell.
 
 GIT_CVSSERVER_BASE_PATH takes the place of the argument to --base-path.
 
-GIT_CVSSERVER_ROOT specifies a single-directory whitelist. The
+GIT_CVSSERVER_ROOT specifies a single allowed directory. The
 repository must still be configured to allow access through
 git-cvsserver, as described above.
 
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index fdc28c041c7..7a0539cb411 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -32,8 +32,8 @@ that service if it is enabled.
 It verifies that the directory has the magic file "git-daemon-export-ok", and
 it will refuse to export any Git directory that hasn't explicitly been marked
 for export this way (unless the `--export-all` parameter is specified). If you
-pass some directory paths as 'git daemon' arguments, you can further restrict
-the offers to a whitelist comprising of those.
+pass some directory paths as 'git daemon' arguments, the offers are limited to
+repositories within those directories.
 
 By default, only `upload-pack` service is enabled, which serves
 'git fetch-pack' and 'git ls-remote' clients, which are invoked
@@ -50,7 +50,7 @@ OPTIONS
 	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
 	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
 	'git daemon' will refuse to start when this option is enabled and no
-	whitelist is specified.
+	specific directories are specified.
 
 --base-path=<path>::
 	Remap all the path requests as relative to the given path.
@@ -73,7 +73,7 @@ OPTIONS
 	%IP for the server's IP address, %P for the port number,
 	and %D for the absolute path of the named repository.
 	After interpolation, the path is validated against the directory
-	whitelist.
+	list.
 
 --export-all::
 	Allow pulling from all directories that look like Git repositories
@@ -218,7 +218,7 @@ standard output to be sent to the requestor as an error message when
 it declines the service.
 
 <directory>::
-	A directory to add to the whitelist of allowed directories. Unless
+	A directory to add to the list of allowed directories. Unless
 	--strict-paths is specified this will also include subdirectories
 	of each named directory.
 
@@ -264,9 +264,8 @@ git		9418/tcp		# Git Version Control System
 
 'git daemon' as inetd server::
 	To set up 'git daemon' as an inetd service that handles any
-	repository under the whitelisted set of directories, /pub/foo
-	and /pub/bar, place an entry like the following into
-	/etc/inetd all on one line:
+	repository in the directory list of `/pub/foo` and `/pub/bar`,
+	place an entry like the following into `/etc/inetd` all on one line:
 +
 ------------------------------------------------
 	git stream tcp nowait nobody  /usr/bin/git
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 302607a4967..dd5061563eb 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -886,8 +886,7 @@ for full details.
 	`protocol.allow` is set to `never`, and each of the listed
 	protocols has `protocol.<name>.allow` set to `always`
 	(overriding any existing configuration). In other words, any
-	protocol not mentioned will be disallowed (i.e., this is a
-	whitelist, not a blacklist). See the description of
+	protocol not mentioned will be disallowed. See the description of
 	`protocol.allow` in linkgit:git-config[1] for more details.
 
 `GIT_PROTOCOL_FROM_USER`::
-- 
gitgitgadget

