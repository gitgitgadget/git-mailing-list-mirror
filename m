Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F581F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeHVTbn (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43140 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeHVTbn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id m84-v6so1832632lje.10
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ZMPOdl2FJClyex2ASGAJN3tZbHF1z7EaJ24AxLbd4Y=;
        b=RcIpOTK7zCCHv70wHtlUdtanFdKxlCwZ7ULOQpjkf7pP7OL2TFX3vmEbTK58bmLpDl
         1/73iq/8/V4MARwjaFEMS1hBD4kgAqPBG+UMTEjX+Zv67X70yz0c8iquOt+3udbQAzDH
         i4aSU8qZlsUce8c7HX/tA/qNK2lucfn/3R46hERq3o5wodw5EjDcVfQzSZG7wqcMbwbu
         G8mZes/36+OkCoy1r8tgoCXkIHz8tEOT+aJD7Ay2Am4d5BvZt8/2Niy8hyW3Bv7xF+IN
         UcqRA3/YYn+TDxw2OyUwfM1NmTBAKxZgFl78L/E6kQFFWltSWQbTyvMmAw0S+pFpjK5k
         pynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ZMPOdl2FJClyex2ASGAJN3tZbHF1z7EaJ24AxLbd4Y=;
        b=liGSvs/8DGw8bxk4HCW0e1TpNkLxfgcTzBGEpoJW2/e+NmxG0xz/+aHd375uJXaSw5
         ScdpENU3IRrUqESdezHK4/zrz9t/6820tgPFncIoVXOlfih24j4BC9ZIbPqQK+KfqduY
         w2daAo2dUd/1oiwB8KZWfe1QTnXtnz6dlZ+jx9ANZKhXnsAEIwMzBK6WzfIOoV5gRjgC
         1cPRBEAIQXdZGakCKM5VQiSwzAV7mPk6jul0K0Dg3NlT4M/AZbNby8M4OlTu9bgych/m
         xMrz6bO23GjzFcGnk5lFwvdIe60CKA+p2E18Ol1D1OX11/ZwVDbF0zLOYaloBcsbegSj
         FVFg==
X-Gm-Message-State: AOUpUlGkd+yPoFPU1diG5Js1a8IpDwh5F/rKKeqp8J5oz1nXj8e0f1xo
        1kMaYcoG+dTdLUeYYBKcW8Zzc1Yl
X-Google-Smtp-Source: AA+uWPxeMfdPHEEj25uE6A6ws7tK+jFkHRF8gwnqTtjQa1WEMViBCmKscyoW/Pzt05tzPuMK4YEiZQ==
X-Received: by 2002:a2e:2d2:: with SMTP id y79-v6mr36472741lje.100.1534953971773;
        Wed, 22 Aug 2018 09:06:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/11] config.txt: move format part out to a separate file
Date:   Wed, 22 Aug 2018 18:05:57 +0200
Message-Id: <20180822160605.21864-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.335.ga73d156e9c
In-Reply-To: <20180822160605.21864-1-pclouds@gmail.com>
References: <20180822160605.21864-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt        | 88 +--------------------------------
 Documentation/format-config.txt | 87 ++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/format-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 33ba7ca2cd..393f6843f5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1507,93 +1507,7 @@ fastimport.unpackLimit::
 
 include::fetch-config.txt[]
 
-format.attach::
-	Enable multipart/mixed attachments as the default for
-	'format-patch'.  The value can also be a double quoted string
-	which will enable attachments as the default and set the
-	value as the boundary.  See the --attach option in
-	linkgit:git-format-patch[1].
-
-format.from::
-	Provides the default value for the `--from` option to format-patch.
-	Accepts a boolean value, or a name and email address.  If false,
-	format-patch defaults to `--no-from`, using commit authors directly in
-	the "From:" field of patch mails.  If true, format-patch defaults to
-	`--from`, using your committer identity in the "From:" field of patch
-	mails and including a "From:" field in the body of the patch mail if
-	different.  If set to a non-boolean value, format-patch uses that
-	value instead of your committer identity.  Defaults to false.
-
-format.numbered::
-	A boolean which can enable or disable sequence numbers in patch
-	subjects.  It defaults to "auto" which enables it only if there
-	is more than one patch.  It can be enabled or disabled for all
-	messages by setting it to "true" or "false".  See --numbered
-	option in linkgit:git-format-patch[1].
-
-format.headers::
-	Additional email headers to include in a patch to be submitted
-	by mail.  See linkgit:git-format-patch[1].
-
-format.to::
-format.cc::
-	Additional recipients to include in a patch to be submitted
-	by mail.  See the --to and --cc options in
-	linkgit:git-format-patch[1].
-
-format.subjectPrefix::
-	The default for format-patch is to output files with the '[PATCH]'
-	subject prefix. Use this variable to change that prefix.
-
-format.signature::
-	The default for format-patch is to output a signature containing
-	the Git version number. Use this variable to change that default.
-	Set this variable to the empty string ("") to suppress
-	signature generation.
-
-format.signatureFile::
-	Works just like format.signature except the contents of the
-	file specified by this variable will be used as the signature.
-
-format.suffix::
-	The default for format-patch is to output files with the suffix
-	`.patch`. Use this variable to change that suffix (make sure to
-	include the dot if you want it).
-
-format.pretty::
-	The default pretty format for log/show/whatchanged command,
-	See linkgit:git-log[1], linkgit:git-show[1],
-	linkgit:git-whatchanged[1].
-
-format.thread::
-	The default threading style for 'git format-patch'.  Can be
-	a boolean value, or `shallow` or `deep`.  `shallow` threading
-	makes every mail a reply to the head of the series,
-	where the head is chosen from the cover letter, the
-	`--in-reply-to`, and the first patch mail, in this order.
-	`deep` threading makes every mail a reply to the previous one.
-	A true boolean value is the same as `shallow`, and a false
-	value disables threading.
-
-format.signOff::
-	A boolean value which lets you enable the `-s/--signoff` option of
-	format-patch by default. *Note:* Adding the Signed-off-by: line to a
-	patch should be a conscious act and means that you certify you have
-	the rights to submit this work under the same open source license.
-	Please see the 'SubmittingPatches' document for further discussion.
-
-format.coverLetter::
-	A boolean that controls whether to generate a cover-letter when
-	format-patch is invoked, but in addition can be set to "auto", to
-	generate a cover-letter only when there's more than one patch.
-
-format.outputDirectory::
-	Set a custom directory to store the resulting files instead of the
-	current working directory.
-
-format.useAutoBase::
-	A boolean value which lets you enable the `--base=auto` option of
-	format-patch by default.
+include::format-config.txt[]
 
 filter.<driver>.clean::
 	The command which is used to convert the content of a worktree
diff --git a/Documentation/format-config.txt b/Documentation/format-config.txt
new file mode 100644
index 0000000000..dc77941c48
--- /dev/null
+++ b/Documentation/format-config.txt
@@ -0,0 +1,87 @@
+format.attach::
+	Enable multipart/mixed attachments as the default for
+	'format-patch'.  The value can also be a double quoted string
+	which will enable attachments as the default and set the
+	value as the boundary.  See the --attach option in
+	linkgit:git-format-patch[1].
+
+format.from::
+	Provides the default value for the `--from` option to format-patch.
+	Accepts a boolean value, or a name and email address.  If false,
+	format-patch defaults to `--no-from`, using commit authors directly in
+	the "From:" field of patch mails.  If true, format-patch defaults to
+	`--from`, using your committer identity in the "From:" field of patch
+	mails and including a "From:" field in the body of the patch mail if
+	different.  If set to a non-boolean value, format-patch uses that
+	value instead of your committer identity.  Defaults to false.
+
+format.numbered::
+	A boolean which can enable or disable sequence numbers in patch
+	subjects.  It defaults to "auto" which enables it only if there
+	is more than one patch.  It can be enabled or disabled for all
+	messages by setting it to "true" or "false".  See --numbered
+	option in linkgit:git-format-patch[1].
+
+format.headers::
+	Additional email headers to include in a patch to be submitted
+	by mail.  See linkgit:git-format-patch[1].
+
+format.to::
+format.cc::
+	Additional recipients to include in a patch to be submitted
+	by mail.  See the --to and --cc options in
+	linkgit:git-format-patch[1].
+
+format.subjectPrefix::
+	The default for format-patch is to output files with the '[PATCH]'
+	subject prefix. Use this variable to change that prefix.
+
+format.signature::
+	The default for format-patch is to output a signature containing
+	the Git version number. Use this variable to change that default.
+	Set this variable to the empty string ("") to suppress
+	signature generation.
+
+format.signatureFile::
+	Works just like format.signature except the contents of the
+	file specified by this variable will be used as the signature.
+
+format.suffix::
+	The default for format-patch is to output files with the suffix
+	`.patch`. Use this variable to change that suffix (make sure to
+	include the dot if you want it).
+
+format.pretty::
+	The default pretty format for log/show/whatchanged command,
+	See linkgit:git-log[1], linkgit:git-show[1],
+	linkgit:git-whatchanged[1].
+
+format.thread::
+	The default threading style for 'git format-patch'.  Can be
+	a boolean value, or `shallow` or `deep`.  `shallow` threading
+	makes every mail a reply to the head of the series,
+	where the head is chosen from the cover letter, the
+	`--in-reply-to`, and the first patch mail, in this order.
+	`deep` threading makes every mail a reply to the previous one.
+	A true boolean value is the same as `shallow`, and a false
+	value disables threading.
+
+format.signOff::
+	A boolean value which lets you enable the `-s/--signoff` option of
+	format-patch by default. *Note:* Adding the Signed-off-by: line to a
+	patch should be a conscious act and means that you certify you have
+	the rights to submit this work under the same open source license.
+	Please see the 'SubmittingPatches' document for further discussion.
+
+format.coverLetter::
+	A boolean that controls whether to generate a cover-letter when
+	format-patch is invoked, but in addition can be set to "auto", to
+	generate a cover-letter only when there's more than one patch.
+
+format.outputDirectory::
+	Set a custom directory to store the resulting files instead of the
+	current working directory.
+
+format.useAutoBase::
+	A boolean value which lets you enable the `--base=auto` option of
+	format-patch by default.
-- 
2.19.0.rc0.335.ga73d156e9c

