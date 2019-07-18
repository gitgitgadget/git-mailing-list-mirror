Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19BB21F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390448AbfGRNTG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34388 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390416AbfGRNTE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so28715634wrm.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IpYxuyg0d7h+PkcMcFpH5/CrbD7XZfHhe7dTuXO7RfQ=;
        b=h4aYuniVkesHL9f24toKHoMLPneANtpykMkku9DdGbPOnV7xhReg6GHUY6CIJJHr9k
         bi3UVBdhSA2zUHRkI3uyqSgvmUVRl0/sm4/doKayTDu64eYbemc6Z/A7pQsapo4lgEL4
         lUvWZB9oRskpq9owA8ieMxY4sD/LCbcOvEycpTQkMeKwkKe11aaVjfwlh663AU5HVeQg
         iFI0qA+HVV7kIjmfF7wg8DrN+KzElKhzSHhn85aOTsNZcjT88R9o59ctSZXZHLYrXvn8
         F59NdS3eEz2ouezMdjje0OB90/eynh9qFg07akV/6Ctt1YNNl+zIlAIeDjYFSNrVIwRQ
         7e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=IpYxuyg0d7h+PkcMcFpH5/CrbD7XZfHhe7dTuXO7RfQ=;
        b=OahM1ZuZG0FvDkNqd2H/oUZ7PzV0KNEzBC47OrfGujZwAB/CcHWAK+MNHChUjprElp
         gmds1amExfw6EQxsHI8JyVFY/hYBERf6dJ0glPREbnZpElFodfExt5JGeVqi5Ae7Tdou
         2tp1KPaBUY1AGdgNGYBwHRBCwzwJrellh/4JNY36j6p+OJuAs0nPLp6DBi9ZHVfqYz78
         +bPND2d3giUXrRhzQBaOU6Fgo6/A388nfBWhcj850kWwvQSj8gVvT46PwDT7ouvO5qaZ
         QleQhccRGjj0Thtacr6pzZzGh/49t4RytrWHAAqlApB9E2Dp5Fm5NvlLgsxIgVX0KtCw
         KtLA==
X-Gm-Message-State: APjAAAUkGpmifOHkyTwtDeDS2HAnjP7iwS8AIZYGuo3uC+EuPwjoVhSC
        0pb39SptaoJ0pvlpjEX5rSlvSdG7
X-Google-Smtp-Source: APXvYqwluHOj/lqaokF6lRK8jsxzYvi5JKfYW/bjjw+qcpthYrHtXRXTtkIVpLnOZz1jD4nNYNifEQ==
X-Received: by 2002:adf:e790:: with SMTP id n16mr34847894wrm.120.1563455942558;
        Thu, 18 Jul 2019 06:19:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm26624105wrw.33.2019.07.18.06.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:02 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:02 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:37 GMT
Message-Id: <a7898b002590adcfb103e6851d84267715ee05b0.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/24] Vcproj.pm: list git.exe first to be startup project
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

Visual Studio takes the first listed application/library as the default
startup project [1].

Detect the 'git' project and place it at the head of the project list,
rather than at the tail.

Export the apps list before libs list for both the projects and global
structures of the .sln file.

[1] http://stackoverflow.com/questions/1238553/
vs2008-where-is-the-startup-project-setting-stored-for-a-solution
    "In the solution file, there are a list of pseudo-XML "Project"
    entries. It turns out that whatever is the first one ends up as
    the Startup Project, unless it’s overridden in the suo file. Argh.
    I just rearranged the order in the file and it’s good."

    "just moving the pseudo-xml isn't enough. You also have to move the
    group of entries in the "GlobalSection(ProjectConfigurationPlatforms)
    = postSolution" group that has the GUID of the project you moved to
    the top. So there are two places to move lines."

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/Generators/Vcproj.pm | 33 +++++++++++++----------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsystems/Generators/Vcproj.pm
index c79b706bc8..d862cae503 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -513,20 +513,18 @@ sub createGlueProject {
     foreach (@apps) {
         $_ =~ s/\//_/g;
         $_ =~ s/\.exe//;
-        push(@tmp, $_);
+        if ($_ eq "git" ) {
+            unshift(@tmp, $_);
+        } else {
+            push(@tmp, $_);
+        }
     }
     @apps = @tmp;
 
     open F, ">git.sln" || die "Could not open git.sln for writing!\n";
     binmode F, ":crlf";
     print F "$SLN_HEAD";
-    foreach (@libs) {
-        my $libname = $_;
-        my $uuid = $build_structure{"LIBS_${libname}_GUID"};
-        print F "$SLN_PRE";
-        print F "\"${libname}\", \"${libname}\\${libname}.vcproj\", \"${uuid}\"";
-        print F "$SLN_POST";
-    }
+
     my $uuid_libgit = $build_structure{"LIBS_libgit_GUID"};
     my $uuid_xdiff_lib = $build_structure{"LIBS_xdiff_lib_GUID"};
     foreach (@apps) {
@@ -540,6 +538,13 @@ sub createGlueProject {
         print F "	EndProjectSection";
         print F "$SLN_POST";
     }
+    foreach (@libs) {
+        my $libname = $_;
+        my $uuid = $build_structure{"LIBS_${libname}_GUID"};
+        print F "$SLN_PRE";
+        print F "\"${libname}\", \"${libname}\\${libname}.vcproj\", \"${uuid}\"";
+        print F "$SLN_POST";
+    }
 
     print F << "EOM";
 Global
@@ -551,17 +556,17 @@ sub createGlueProject {
     print F << "EOM";
 	GlobalSection(ProjectConfigurationPlatforms) = postSolution
 EOM
-    foreach (@libs) {
-        my $libname = $_;
-        my $uuid = $build_structure{"LIBS_${libname}_GUID"};
+    foreach (@apps) {
+        my $appname = $_;
+        my $uuid = $build_structure{"APPS_${appname}_GUID"};
         print F "\t\t${uuid}.Debug|Win32.ActiveCfg = Debug|Win32\n";
         print F "\t\t${uuid}.Debug|Win32.Build.0 = Debug|Win32\n";
         print F "\t\t${uuid}.Release|Win32.ActiveCfg = Release|Win32\n";
         print F "\t\t${uuid}.Release|Win32.Build.0 = Release|Win32\n";
     }
-    foreach (@apps) {
-        my $appname = $_;
-        my $uuid = $build_structure{"APPS_${appname}_GUID"};
+    foreach (@libs) {
+        my $libname = $_;
+        my $uuid = $build_structure{"LIBS_${libname}_GUID"};
         print F "\t\t${uuid}.Debug|Win32.ActiveCfg = Debug|Win32\n";
         print F "\t\t${uuid}.Debug|Win32.Build.0 = Debug|Win32\n";
         print F "\t\t${uuid}.Release|Win32.ActiveCfg = Release|Win32\n";
-- 
gitgitgadget

