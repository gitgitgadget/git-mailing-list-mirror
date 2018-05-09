Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A4C1F424
	for <e@80x24.org>; Wed,  9 May 2018 00:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeEIAaF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 20:30:05 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34660 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbeEIAaE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 20:30:04 -0400
Received: by mail-pg0-f66.google.com with SMTP id g20-v6so15198069pgv.1
        for <git@vger.kernel.org>; Tue, 08 May 2018 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3yQoqGPngE1zrs1dfNcpOD6Pj0voaz926kIpizSH+dY=;
        b=Xta1OIr60243tIjuYY+0xvpSQeRrTDa/w78tvvRH3XoaXgX3YY6s+uJh/hiD5gRRzF
         BACcy0ThDLO//PqnuKia2eDcC2dvfwnTSVmeA0InOihwAJgHjpvXR8/gVcvNkZnbYC0I
         gg9nQfkXmHr4hpNnKsqAbPlY6Y22fzZqmfoqjQr+t1rAdX5r/R+OpcGjr6dN8oSZG8C1
         PTzGHdANT12nwVMoC9wkPdxnYIQcFx5KW68Nke6bd4XB+CnpM6MxWX3UKqgbscn7Hvx8
         weFGI820vOjMomKfFwp7ZHEWtNgjYhNyP/MCYxOhEgqFCK5cUizb0JhbOAlpA/lr0t2v
         fB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3yQoqGPngE1zrs1dfNcpOD6Pj0voaz926kIpizSH+dY=;
        b=Lis3AmyDMLqQEAhfZfeumBWMC46JZpcZbrB+53/OoDWgEQunCG/xJb3sth0/uOHNhP
         4vecGzj9wYqSee7qka9AeNW9nM+WTB/kIgLkGXLz9xWFS6OFYAsBneqXQaJp1mMAJ4oM
         gT3GZshselqc7tkbjWBIC/NJaxf+t2IIURz9AZhWB9i04xnqRO2PHtSwFv8B3xmsvgS3
         jmyK1inFI22Q6V/anPByb0gQz0AyPQpkdZidXDsGJ/b6O9fgeshQByxflPsJc09ysG+4
         PZfN1svTjpZWXm80sW9xNhQBxEw09rofFhjuiqGsfQiuj3vT4R+1juPxajLkDsajAywp
         CbBQ==
X-Gm-Message-State: ALQs6tCVmzCpeB0A6CoeHDOzeLjc1DIHhJs9NDyny0jeuT1vk7BhEH2m
        UlMjAmjmb2J802/4Ov2K6JLweA==
X-Google-Smtp-Source: AB8JxZr48pNENJsTAN7o5IKOPVLscU2Sp5uiWsQCb82qaFVlFXXdVEpMZa0IkIrK9fH7tp3o+Rm8Bw==
X-Received: by 2002:a65:6249:: with SMTP id q9-v6mr17476037pgv.216.1525825803291;
        Tue, 08 May 2018 17:30:03 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y15sm52131189pfb.37.2018.05.08.17.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 17:30:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, pc44800@gmail.com
Subject: [PATCH 2/4] submodule foreach: document '$sm_path' instead of '$path'
Date:   Tue,  8 May 2018 17:29:50 -0700
Message-Id: <20180509002952.172347-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180509002952.172347-1-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
 <20180509002952.172347-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh Chavan <pc44800@gmail.com>

As using a variable '$path' may be harmful to users due to
capitalization issues, see 64394e3ae9 (git-submodule.sh: Don't
use $path variable in eval_gettext string, 2012-04-17). Adjust
the documentation to advocate for using $sm_path,  which contains
the same value. We still make the 'path' variable available and
document it as a deprecated synonym of 'sm_path'.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 630999f41a9..066c7b6c18e 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -183,12 +183,15 @@ information too.
 
 foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $path, $sha1 and
+	The command has access to the variables $name, $sm_path, $sha1 and
 	$toplevel:
 	$name is the name of the relevant submodule section in `.gitmodules`,
-	$path is the name of the submodule directory relative to the
-	superproject, $sha1 is the commit as recorded in the superproject,
-	and $toplevel is the absolute path to the top-level of the superproject.
+	$sm_path is the path of the submodule as recorded in the immediate
+	superproject, $sha1 is the commit as recorded in the immediate
+	superproject, and $toplevel is the absolute path to the top-level
+	of the immediate superproject.
+	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
+	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
 	ignored by this command. Unless given `--quiet`, foreach prints the name
 	of each submodule before evaluating the command.
-- 
2.17.0.255.g8bfb7c0704

