From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v7 06/16] Add documentation for the 'bidi-import' capability of remote-helpers
Date: Tue, 28 Aug 2012 10:49:40 +0200
Message-ID: <1346143790-23491-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:51:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HWK-00022f-7p
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875Ab2H1IvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:51:14 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51578 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2H1IvL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:51:11 -0400
Received: by bkwj10 with SMTP id j10so1533185bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vh4dlNy+nY9Pl3ZyyPrx9L+nGChyAd+TvlRlGuxc3QY=;
        b=V4y5H1PgGTl0xDT1dsBPbnSrHDBB+dQAce5hk/YZRaFFtg7eCU7v9YuAbkqoBqAMVF
         cfTVEA22+kxRSOyzpAvo/cmj2OfvI8jRIOjTRdywbKxMQ8LdS/kFpND8gDSlRRbm110a
         FNprzasvTawgsbaD0KEOqaHnqF1aAkN3oip+c/Wdtieoqky2XcVlGeS+VWYW0w7nzixx
         /RdP/bA11xmC+cYqUx7PKNjdwrIzO/N5R1HTDVlue112fSGwjO5LniMieZF8/GQ1f7NS
         gB5Wiw1Xd41fMcxyFtiAYhRO4WBtP0mE1w11R53rrL7HTC6pCmtqFRyRevmE62GTC+O2
         j3Tw==
Received: by 10.204.136.215 with SMTP id s23mr4527336bkt.32.1346143870414;
        Tue, 28 Aug 2012 01:51:10 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id m9sm12047800bkm.10.2012.08.28.01.51.08
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 01:51:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204404>

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-remote-helpers.txt |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index f5836e4..5ce4cda 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -98,6 +98,20 @@ advertised with this capability must cover all refs reported by
 the list command.  If no 'refspec' capability is advertised,
 there is an implied `refspec *:*`.
 
+'bidi-import'::
+	The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
+	to retrieve information about blobs and trees that already exist in
+	fast-import's memory. This requires a channel from fast-import to the
+	remote-helper.
+	If it is advertised in addition to "import", git establishes a pipe from
+	fast-import to the remote-helper's stdin.
+	It follows that git and fast-import are both connected to the
+	remote-helper's stdin. Because git can send multiple commands to
+	the remote-helper it is required that helpers that use 'bidi-import'
+	buffer all 'import' commands of a batch before sending data to fast-import.
+	This is to prevent mixing commands and fast-import responses on the
+	helper's stdin.
+
 Capabilities for Pushing
 ~~~~~~~~~~~~~~~~~~~~~~~~
 'connect'::
@@ -286,7 +300,12 @@ terminated with a blank line. For each batch of 'import', the remote
 helper should produce a fast-import stream terminated by a 'done'
 command.
 +
-Supported if the helper has the "import" capability.
+Note that if the 'bidi-import' capability is used the complete batch
+sequence has to be buffered before starting to send data to fast-import
+to prevent mixing of commands and fast-import responses on the helper's
+stdin.
++
+Supported if the helper has the 'import' capability.
 
 'connect' <service>::
 	Connects to given service. Standard input and standard output
-- 
1.7.9.5
