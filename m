Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22EFB1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 08:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbcF1I6P (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 04:58:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54975 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbcF1I6M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 04:58:12 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue003) with ESMTPSA (Nemesis) id
 0LjOHr-1buAaq04Z5-00dWDB; Tue, 28 Jun 2016 10:57:47 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id 93035B00F22;
	Tue, 28 Jun 2016 10:57:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EgBPdlYtlMcN; Tue, 28 Jun 2016 10:57:43 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
	by pflsmail.localdomain (Postfix) with ESMTPS id 506A6B00EA4;
	Tue, 28 Jun 2016 10:57:43 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.11.230) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.847.32; Tue, 28 Jun 2016 10:57:43 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)	id
 B203A804B0; Tue, 28 Jun 2016 10:57:42 +0200 (CEST)
Date:	Tue, 28 Jun 2016 10:57:42 +0200
From:	Alex Riesen <alexander.riesen@cetitec.com>
To:	<git@vger.kernel.org>
CC:	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] git-gui: support for $FILENAMES in tool definitions
Message-ID: <20160628085742.GD3710@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.10.11.230]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: avast! (VPS 160627-1, 27.06.2016), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K0:HZy/lG/xD7BiHTP+1HdcyhcEK8+1ENohvFcwmsvyzKdVukwThsb
 LCxnHyvh/Fm2USwHok0bErB7zAFNjNHNv8DNhSHyI/VHrS3/XdhIW9CV32CsmhswvoRIskb
 l8qYU3s1YAO2wED3j6mifQKsJxgUAEWoot7YkVwYJBCfCXtoVjtrszXGWPBFN4eWp67dOWP
 46Cuou3TKBtTBiQXhxQyg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:MilLWUfr8aw=:b9cQkbbwGUgXdyjest4tzY
 a+o+q8Y9HdV2JJA+7ycUzaXOxT0swaA4UZPpTi5gYzAU/RTE+YzNyxH18wLjwH8mEU+9ygDnS
 eyqX/ezxvNF9tQVEorheYnEBb7KJfAigwzngHq4tsFvwRHD7xoKsOFxg2nzi5IP5D8QHnjSsK
 cehxbjin9prsozQ+jDqHOubOR8syM+3PLKjLIXNnZwHRdLl9fo7MafYFVZ6BoyigzdpEbx6jO
 m2ZZoEAaL7XzIQKCCYTsXjE0/3A42WtjNdwEor8CjsNP8WXqNCNB8nV+OJXQLmXq/xiswmPlG
 TnOXN8GyUGIsrb9LfBO+Uy63FdJWey6alQNR+/RkkRDjzGUs8VliUJxopKNPJVAEdXdRoZw5J
 Sw/UThvctUmCfFpIHbvQEDo6MRGuz2+d+47Tmq8utEhYh5zu35V22AM9vpCiy0+E8ZPIE5ZFU
 3tQ2NlFWf9SjaZk8t8naXRrINREondB2Nv1anPr9BmZRPNFegLIgV8KGBsjyaUZHpOd3jtIJC
 M+go7aJAfIdcJBvgnDFO939n2BqTFpp3qp/5T+HtQ9sZR7ji4QjfVWQsET3gvB9wiNBueNOU3
 HveUpuxPLDMI6BUko3DPAwmlQIPs6A9KyRIqRciZ3in+GpAXmbPOgCUIXez7JmpEgF+vRaO6c
 2SwX+BIxEWONAZ/UCmYwhKUvj3gFNsY6XiUhh7nWfiHwYb6M1N8ZZMtpsGkC2BvuPYvQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This addes a FILENAMES environment variable, which contains the repository
pathnames of all selected files the list.
The variable contains the names separated by LF (\n, \x0a).

If the file names contain LF characters, the tool command might be unable to
unambiguosly split the value of $FILENAME into the separate names.

Note that the file marked and diffed immediately after starting the GUI up,
is not actually selected. One must click on it once to really select it.

Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
---
 lib/tools.tcl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tools.tcl b/lib/tools.tcl
index 6ec9411..413f1a1 100644
--- a/lib/tools.tcl
+++ b/lib/tools.tcl
@@ -69,6 +69,7 @@ proc tools_populate_one {fullname} {
 proc tools_exec {fullname} {
 	global repo_config env current_diff_path
 	global current_branch is_detached
+	global selected_paths
 
 	if {[is_config_true "guitool.$fullname.needsfile"]} {
 		if {$current_diff_path eq {}} {
@@ -100,6 +101,7 @@ proc tools_exec {fullname} {
 
 	set env(GIT_GUITOOL) $fullname
 	set env(FILENAME) $current_diff_path
+	set env(FILENAMES) [join [array names selected_paths] \n]
 	if {$is_detached} {
 		set env(CUR_BRANCH) ""
 	} else {
@@ -121,6 +123,7 @@ proc tools_exec {fullname} {
 
 	unset env(GIT_GUITOOL)
 	unset env(FILENAME)
+	unset env(FILENAMES)
 	unset env(CUR_BRANCH)
 	catch { unset env(ARGS) }
 	catch { unset env(REVISION) }
-- 
2.9.0.45.g28c608e.dirty


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

