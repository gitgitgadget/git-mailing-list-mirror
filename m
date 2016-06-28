Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9149F1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 09:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbcF1JA6 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 05:00:58 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54771 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbcF1JA5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 05:00:57 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue003) with ESMTPSA (Nemesis) id
 0MgaZf-1awhCz2zUl-00O1g8; Tue, 28 Jun 2016 10:59:34 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id 67001B00F22;
	Tue, 28 Jun 2016 10:59:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fSMGb00535Ha; Tue, 28 Jun 2016 10:59:32 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
	by pflsmail.localdomain (Postfix) with ESMTPS id 599FEB00EA4;
	Tue, 28 Jun 2016 10:59:32 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.11.230) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.847.32; Tue, 28 Jun 2016 10:59:25 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)	id
 7522C804B0; Tue, 28 Jun 2016 10:59:25 +0200 (CEST)
Date:	Tue, 28 Jun 2016 10:59:25 +0200
From:	Alex Riesen <alexander.riesen@cetitec.com>
To:	<git@vger.kernel.org>
CC:	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] git-gui: ensure the file in the diff pane is in the list
 of selected files
Message-ID: <20160628085925.GE3710@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20160628085742.GD3710@pflmari>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.10.11.230]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: avast! (VPS 160627-1, 27.06.2016), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K0:OCE6h2J7PzAWoL3hAvXQDosNCfp4sOnVN3MeeEkKzLuZLZChKDk
 v9GdZtblOAJA5H/69uUBiszttCOo2G3nYD7OH5k1tqCtBmML5peLIF9nF2seCOiLLa6EOs0
 r/peP5MvfxrHcIaIea15wWSfBnTMLf83IYmxHbLexhmGyq97ICsiePbNYEw4EV+fCmjY6cx
 g9uTYl+cZ8nxFbMEkKEBQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:KqR1W+f4Pqs=:z1xmtQy7SfCPpljAho+Pxo
 O97shR9sOIqV7aWn3YSYpiaPpu9n/LMtKPAsaYoDRtgefl+jYy3v3a2sPH5oX56nrrlNfV5oP
 j5oiK9u4OpvibMmUcHgvM+s+++dye6+Fmqp/wFW1OgFfXcZenxHX4Hdy9QuOSUULdmW1Q0WrY
 2YeI1biHuonXkR9p69wPn/L9xgwOi1Q+tLWwdMmJvvC64BoB3opp83vlcU8flxFxzO4FnYm21
 tzXpLUKRYIvJlk6IiZDgZnVerH+oCwZEyQfNiiIsieTuHotoISw0HQZyqTL7PHfYJovh6e/nf
 yhJU9ik+KP2HmeBWIlr3NFxivZ7zcnFPVfJ5tEK8+th8lWocxykwQim6JFOvZ9GYbN5xFCpDn
 VQUreJhJ33XUqMC1BdeT61r8/CrBuLXx7o7YkU7pvVdtffyrGE4BiUGT4yN4cMM1rQ1ZqoDIG
 atdqUBcwTo9GzXYTUAP0aKYJeFSEDjQXfWZPNlduDsLb+xFRU7Tn9ptytacEJle+l0tLGmUMG
 lK146qt/VkMNof61iMisF4B12pObmFy14q0RNa3DNL2i0iZOD/oqEJifQQlzW52YHj89Jl6l+
 2ksm0GYoebtrRLJi1wTFetvOc1YHUcmwQMX5DPww4aw1w2FP++HHVa7ixwgjiXMbo7j2tc6Ga
 QHGxbjbZN980A6cQ6+8rtXe5sMANb3hONITlJhfweNJl8tXVSP0x9nymn6UruxLStvPg=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It is very confusing that the file which diff is displayed is marked as
selected, but it is not in fact selected (that means the array of selected
files does not include the file in question).

Fixing this also improves the use of $FILENAMES in custom defined tools: one
does not have to click the file in the list to make it selected.

Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
---
 lib/diff.tcl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 0d56986..30bdd69 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -127,6 +127,9 @@ proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
 	} else {
 		start_show_diff $cont_info
 	}
+
+	global current_diff_path selected_paths
+	set selected_paths($current_diff_path) 1
 }
 
 proc show_unmerged_diff {cont_info} {
-- 
2.9.0.45.g28c608e.dirty


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

