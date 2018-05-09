Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD3D1F424
	for <e@80x24.org>; Wed,  9 May 2018 12:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934198AbeEIMfz convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 May 2018 08:35:55 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:41361 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbeEIMfx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 08:35:53 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0M9tPw-1f9kTb3ilk-00B3si; Wed, 09 May 2018 14:35:47 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 5AADC64A8D4;
        Wed,  9 May 2018 12:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ebrrfJ201SCp; Wed,  9 May 2018 14:35:29 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 8B4DB64A94A;
        Wed,  9 May 2018 14:35:29 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Wed, 9 May 2018 14:35:29 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 3CA75804D2; Wed,  9 May 2018 14:35:29 +0200 (CEST)
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Paul Mackerras <paulus@ozlabs.org>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] gitk: add an option to run gitk on an item in the file list
Date:   Wed, 9 May 2018 14:35:26 +0200
Message-ID: <d3c1aad3b1152de9526d89d4c74042ff7b34a317.1525868167.git.raa.lkml@gmail.com>
X-Mailer: git-send-email 2.17.0.593.g2029711e64
In-Reply-To: <cover.1525868167.git.raa.lkml@gmail.com>
References: <cover.1525868167.git.raa.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset="UTF-8"
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180509-0, 09.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:MO3OJCrMNv8wNcdIfkE1N+jqG02PSAA2nIGJ5o+lCm+M+RNlksy
 FuZr2nf8UnY7eawPXaHQoE1YUgyLoh1SLHkWDoEmbxJaCtRoaYe/TGoiEz16pCQQNls4EIt
 TSqli/FxGVJ9V6uqmBNDMaWSg59sLPAySqek35R7X7XMvsOtaYfpq+iHJh7SaV8f6VCF/y5
 VGaOOAZIWaQGT1Rk4z0Yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fj7WfXg1LJU=:nqdXoeTDwWNqFcNV7cUqGa
 wiuQ4eqcHi/ppK16r4ffcyl4Yk2FckDC5XsdZPlenCqTLANccb+EKNuQIcqSLTe4y4u+aEMyF
 /WdFzCZsFq6vH0Gx7yELcvMDSV3enmIfDQ71NcdfqOlUtSlPuMdqymNS1nZoXPgphUEpCU9u/
 qRktJvS143QPFzHK+Y1mZg0NzxFqMagt88wc0x+mWO8GSj0IbJgvdeePF4k6ZEGrtniR12Vvh
 +be1WQUZMjgqubsOcWotHBh/2GPEExlxaWhhWzgmV9IRBSDW+JyEpYMLiqH1INLbj0sqPWzU4
 lu88cy4AJHhXArTu/3bgtSeh+VASJcDEJtLN3XIkXjt9miL93i3EkZ1UlkpM3JNZvlCJ8sSOS
 yXOAlLHKifo1sjyFFg1or/Q/2+b6Y061DgePSjiyHgU3EYRazrkuWZsveMguLFCIjPJfNF4qs
 C2PPQUH55MTCnrOxuAH8ScAtjTLEspQeR3bfDX2wURaUUCGHc+Dil2cOEv+lSQhNwNnp3WICi
 vN7+sPC06bzySo4AWpQCsq+wF6KvdPYgvSGFzNoPNxmw8spl9gIOqgidTJFOIYp3jzbladfba
 kXa0dp1Cu3aPR5+UisdV8KtY8qC5+G2QAEj97Nb3BQPm8jtxox8WbkklQKFVvF+5dH6ly5F1V
 Kd1bSXr1Z8l/jGFbDTQ8IC9fNHwmYzBgSa5+q44t13o5E6qIGP9ujUKTWJV5A3t9dG7DkJ+WX
 Lv9uvzGYOYUbIc0q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

Similar to a git gui feature which visualizes history in a submodule,
the submodules cause the gitk be started inside the submodule.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
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

