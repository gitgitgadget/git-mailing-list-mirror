Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B6E1F42D
	for <e@80x24.org>; Wed,  9 May 2018 11:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933894AbeEIK76 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 May 2018 06:59:58 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeEIK75 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 06:59:57 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MUQrq-1epO2W325y-00Qzsu; Wed, 09 May 2018 12:59:50 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 3072E6499BE;
        Wed,  9 May 2018 10:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lKZ9PeZiDNFW; Wed,  9 May 2018 12:59:31 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 41D7A640C09;
        Wed,  9 May 2018 12:59:31 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Wed, 9 May 2018 12:59:30 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id D1AF5804D2; Wed,  9 May 2018 12:59:30 +0200 (CEST)
Date:   Wed, 9 May 2018 12:59:30 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
CC:     Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitk: do not limit tree mode listing in the file list panel
 to current sub-directory
Message-ID: <56ccabf699cdc6e15c5dcb73db5692180c79906d.1525863290.git.raa.lkml@gmail.com>
References: <20180508121104.rtsrektxiihvpqtx@pflmari>
 <20180508122256.nyv6ddcoifygfpk4@pflmari>
 <CAKPyHN3YMU3oZaW-wR2ZMV6aMwoeFGMmiJBQXtvipVvkWPLZVQ@mail.gmail.com>
 <20180508133905.6jhhhp6l7avjkctl@pflmari>
 <CAKPyHN1bGtCBZUh7cDAN-t+5DTutvyL6FLwynALTGZA5ijqwrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAKPyHN1bGtCBZUh7cDAN-t+5DTutvyL6FLwynALTGZA5ijqwrA@mail.gmail.com>
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180509-0, 09.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:jqWwvp27lz+TlzwTwR22WMLORCujSjibAav71e3YVcNTqEjTqse
 KdosVtwVw3V8uVh10tpnnyLrQGbtIGnjjFisOZkZIv9aYzvMzL8XYGjtELHPRfwFjs0s99o
 6DWZjApFp7+J9xP9/RAdIV1LAynxcFzcnajgxhJJ518mfl80SBsSgByoDemyfpmrUR+TM/P
 9GgWvFHtsm2fU5qYk32PA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vzREvdgSpo4=:ETeI8qTk4UfG2ML2ZQP3Wx
 J3zKUJ1btwOzkaiE83DF6uLnzq9L4M5ykAgV4NLN/R5dkF8u+ObfE9Pqc4bCoxhjsue3aDHQe
 a8sg2oV/+YU3b1TcxuooDQlgTbU+nQ+ufKVE8vy0PCSH8wLceo6P2p7EEspw5uPNXI8MHziAp
 9JpzEOZ68WwSjmkDKu4LUrH6fbwBvl9TwDdy4+TQx7hmOvmDE+V645eDQmf8p3U3rQKW3TVzw
 SJOwt9NmvKUe7wyoS6XV8TKF+9XnXP9HQytyopiZcCiZ0E7HK9vF8jSaJMUqqMGYnJqpS7IYd
 CNFNDRPHx0nlNixes+aHhw70lkG1gjk/nuoK23P9ekkhKGXkfhij4CtgBU0qReJEqB6CVl+mc
 lTq/7yPBN9VlHLh3lXF0L8n5bBfafp3QteFrZcmdd5iyC/iz/5seUUqDKcBk3CHMtQrNi0Cw6
 3Xy1fXelusKuwondDKqm4TzskbrAGqdOh70rK8xvvYeJ+hc5bqpw3KdbCVSSzw5o4uN1gOGe7
 Nr5Fmqkk+zmSi9L4hPrehCEUWQ44IbiguZHJicQ0S7hdXJavXRPm7z0xFW8KxZ4X0fbwRUdGI
 B8vqsXHOhNsafW3f98De05Bl96Fo3NW+isaKJ/NKp94Ps2DaQbYzmiQKDpsGgzSQxec9QJjMZ
 /G9KnLYRt9JiJ6jH+/U+Yi2ZbgDQ5Tb4EGBbxO9ZN5jVih5I7xT7Iuse7BEHS38s/40A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

The previous behavior conflicts with the "Patch" mode of the panel,
which always shows the changes from the top-level of the repository.
It is also impossible to get back to the full listing without restarting
gitk.
---

Bert Wesarg, Wed, May 09, 2018 09:19:55 +0200:
> > Frankly, this listing limited to just a sub-directory confuses me a bit. Is
> > there anyway to get to display full repository without changing to the top
> > level?
> 
> I noticed that too, while testing your patch and I'm also confused.
> But was not able to send a request to Paul yet. ls-tree --full-tree
> seems to be one that should be used here, I think.

Well, I just tried your suggestion. 'ls-files' doesn't have --full-tree, so
for those it is just cd-up.

It is on top of the re-sent series.

 gitk | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/gitk b/gitk
index c430dfe..03ead98 100755
--- a/gitk
+++ b/gitk
@@ -7600,18 +7600,18 @@ proc go_to_parent {i} {
 
 proc gettree {id} {
     global treefilelist treeidlist diffids diffmergeid treepending
-    global nullid nullid2
+    global nullid nullid2 cdup
 
     set diffids $id
     unset -nocomplain diffmergeid
     if {![info exists treefilelist($id)]} {
 	if {![info exists treepending]} {
 	    if {$id eq $nullid} {
-		set cmd [list | git ls-files]
+		set cmd [list | git -C $cdup ls-files]
 	    } elseif {$id eq $nullid2} {
-		set cmd [list | git ls-files --stage -t]
+		set cmd [list | git -C $cdup ls-files --stage -t]
 	    } else {
-		set cmd [list | git ls-tree -r $id]
+		set cmd [list | git ls-tree --full-tree -r $id]
 	    }
 	    if {[catch {set gtf [open $cmd r]}]} {
 		return
@@ -7670,7 +7670,7 @@ proc gettreeline {gtf id} {
 proc showfile {f} {
     global treefilelist treeidlist diffids nullid nullid2
     global ctext_file_names ctext_file_lines
-    global ctext commentend
+    global ctext commentend cdup
 
     set submodlog "log --format=%h\\ %aN:\\ %s -100"
     set fcmt ""
@@ -7680,15 +7680,15 @@ proc showfile {f} {
 	return
     }
     if {$diffids eq $nullid} {
-	if {[file isdirectory $f]} {
+	if {[file isdirectory "$cdup$f"]} {
 	    # a submodule
-	    set qf [shellquote $f]
+	    set qf [shellquote "$cdup$f"]
 	    if {[catch {set bf [open "| git -C $qf $submodlog" r]} err]} {
 		puts "oops, can't read submodule $f: $err"
 		return
 	    }
         } else {
-	    if {[catch {set bf [open $f r]} err]} {
+	    if {[catch {set bf [open "$cdup$f" r]} err]} {
 		puts "oops, can't read $f: $err"
 		return
 	    }
@@ -7704,7 +7704,7 @@ proc showfile {f} {
 	    }
 	} else {
 	    # also a submodule
-	    set qf [shellquote $f]
+	    set qf [shellquote "$cdup$f"]
 	    if {[catch {set bf [open "| git -C $qf $submodlog $blob" r]} err]} {
 		puts "oops, error reading submodule commit: $err"
 		return
-- 
2.17.0.593.g2029711e64


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

