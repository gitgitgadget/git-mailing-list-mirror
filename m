Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE541F42D
	for <e@80x24.org>; Wed,  9 May 2018 11:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934015AbeEILBX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 May 2018 07:01:23 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbeEILBW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 07:01:22 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0M6mdY-1eM2h71qCa-00wZPQ; Wed, 09 May 2018 13:01:17 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 8B116649F76;
        Wed,  9 May 2018 11:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9qLbvqPJhl8f; Wed,  9 May 2018 13:00:58 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id B67DD64A6C0;
        Wed,  9 May 2018 13:00:58 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Wed, 9 May 2018 13:00:58 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 746E6804D2; Wed,  9 May 2018 13:00:58 +0200 (CEST)
Date:   Wed, 9 May 2018 13:00:58 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Paul Mackerras <paulus@ozlabs.org>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 2/2] gitk: add an option to run gitk on an item in the
 file list
Message-ID: <20180509110058.5gwmxmai4mohui65@pflmari>
References: <cover.1525862998.git.raa.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <cover.1525862998.git.raa.lkml@gmail.com>
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180509-0, 09.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:MjCXL3ewZl/PrcxbjYl6Dwg+fcjZ60Czulko1u+XNkWlV7Ozpo1
 n3Bl4Lw3mE5bx4m5dnuK0UYpVrryjQfQ2Angqy24vEjK6kZVXOKgqe2mdESwR4hf0zHo9tQ
 s5rpjE3YpXrWflGQiUf4BwZqMHEnR6h6Loul6GyFXZD18k+NglilzqASkeL/kQNkjzIoazM
 604vuCHunulNsY/EJLe0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jCgwvrxi298=:uD08Uu67mxk1jQtRCeqV/r
 6aUSm7KCY+DVeTnvEZSrvXmWx72h+XXmnoyeVrJ9qzUd+1JSt67d3UZbSouQBIlY3L3gSS3cr
 NOKbq8/qhDB2eunE5Ecpn43jOHPvo46nrHxBMjC4upKUlMEED5VEWYfpYYAHNXZirtI9Ph844
 bqgspjnpFeolDK9DLOzgGgx9BbP+WkhxhoMEMg/M2kUJvruUJki5gnWkhKvRAHVwB1cth4bq2
 o+Qad0WKWuAloPOy9e8UFO7bcguZswUtlLPUSQaeXMbAim2OrzDuUmnAB9O9C+xO2FafD7/qx
 pcUxtTeAYEHO6jV4IO9timY3QpnSIzDA716MM8QJG+htdESqvTV1QhHCiSElj/rlqC4mFJGkM
 c2jvJSUdmIXtKLAOSvzVwPHKxGvWbKjMaC4CWeU1z8eYBDGIXpGHQEk1+jRhbJYjJyyNEMuY5
 BJ4dS2babqt1f79yOiwWJeRRebYqD2AuKVu6b7RDV5gmP2kx47S4dGi4kx04eGNNLNK7cuJip
 eZNDKA7YNwuDd1HUoDsK6vrSvZD6QlGnkv98pLt8s5HDWgvo769LICxcd0yK7qImZ//Fn4IFz
 s/duSJWtu1bpfDJqSwnWIQ8OUS4hmvAaduFLs8F0oiyjYX89mcZ3DFXY80MlNioQU2iBnILT/
 JHmBzSaGfwj0XYyQX94CghKr2LYr0IPLtAf1pdx8j1SewbP6Nu2JHzpyCsTMJdoM0tvI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

Similar to a git gui feature which visualizes history in a submodule,
the submodules cause the gitk be started inside the submodule.
---
 gitk | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/gitk b/gitk
index 742f36b..c430dfe 100755
--- a/gitk
+++ b/gitk
@@ -2682,6 +2682,7 @@ proc makewindow {} {
 	{mc "External diff" command {external_diff}}
 	{mc "Blame parent commit" command {external_blame 1}}
 	{mc "Copy path" command {clipboard clear; clipboard append $flist_menu_file}}
+	{mc "Run gitk on this" command {flist_gitk}}
     }
     $flist_menu configure -tearoff 0
 
@@ -3555,6 +3556,17 @@ proc flist_hl {only} {
     set gdttype [mc "touching paths:"]
 }
 
+proc flist_gitk {} {
+    global flist_menu_file findstring gdttype
+
+    set x [shellquote $flist_menu_file]
+    if {[file isdirectory $flist_menu_file]} {
+	exec sh -c "cd $x&&gitk" &
+    } else {
+	exec gitk -- $x &
+    }
+}
+
 proc gitknewtmpdir {} {
     global diffnum gitktmpdir gitdir env
 
-- 
2.17.0.593.g2029711e64

---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

