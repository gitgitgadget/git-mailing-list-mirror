From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 10/14] fix example request/responses
Date: Wed, 11 Sep 2013 01:07:54 +0800
Message-ID: <1378832878-12811-11-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1378832878-12811-1-git-send-email-rctay89@gmail.com>
 <1378832878-12811-2-git-send-email-rctay89@gmail.com>
 <1378832878-12811-3-git-send-email-rctay89@gmail.com>
 <1378832878-12811-4-git-send-email-rctay89@gmail.com>
 <1378832878-12811-5-git-send-email-rctay89@gmail.com>
 <1378832878-12811-6-git-send-email-rctay89@gmail.com>
 <1378832878-12811-7-git-send-email-rctay89@gmail.com>
 <1378832878-12811-8-git-send-email-rctay89@gmail.com>
 <1378832878-12811-9-git-send-email-rctay89@gmail.com>
 <1378832878-12811-10-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRQr-0003Wj-1d
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab3IJRIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:08:46 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:57435 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056Ab3IJRIl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:41 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so8028771pab.34
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7bB/+s7FAmlHpkWBOS9hj/lACsfa1Yh7z78f/qAStgU=;
        b=jtuFeOFK1TraP+fMbDLJ12U/smH78YUadnAn8gdMJmKEFHzf289Vu5PouWG6+LjF8j
         4MFf1D2HuJocIPf1SDKMK1V+2FzkP+LD9ws2I3o8Qk0I/vs3rcVbK6NYkj5KBhFiNGfj
         6N979LrzSDLY+cYlYEwJXkpNjUYJGNTwWrP/kqBqrmSPfzHVS36LrEQUcCgPLLhODxk3
         l02e2oS9Y/lEiIspxDD+bzz6ItUCTYLzmuoZEzjODUJ1r22xa05GSE9/EDO/xx7VH4Ci
         No6w9WkcjUAHlHmq0yRHHD1mL1XnLsaGFkTspelhqio173KxO/ga7W8JlLvG/F9LcItQ
         bpWw==
X-Received: by 10.66.255.10 with SMTP id am10mr9753100pad.165.1378832920644;
        Tue, 10 Sep 2013 10:08:40 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-10-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234454>

Add LF for responses.

For smart interactions, add pkt-line lengths and the flush-pkt (0000) line.

Drop the SP that followed NUL before capability list.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/technical/http-protocol.txt | 35 ++++++++++++++++---------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 5141c6a..dbfff36 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -157,10 +157,10 @@ without any search/query parameters.  E.g.
 
    S: 200 OK
    S:
-   S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
-   S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master
-   S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0
-   S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
+   S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint\n
+   S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master\n
+   S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0\n
+   S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}\n
 
 The Content-Type of the returned info/refs entity SHOULD be
 "text/plain; charset=utf-8", but MAY be any content type.
@@ -208,21 +208,22 @@ $GIT_URLs, and thus may pass more than parameter to the server.
    dumb server reply:
    S: 200 OK
    S:
-   S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
-   S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master
-   S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0
-   S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
+   S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint\n
+   S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master\n
+   S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0\n
+   S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}\n
 
    smart server reply:
    S: 200 OK
    S: Content-Type: application/x-git-upload-pack-advertisement
    S: Cache-Control: no-cache
    S:
-   S: ....# service=git-upload-pack
-   S: ....95dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint\0 multi_ack
-   S: ....d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
-   S: ....2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0
-   S: ....a3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}
+   S: 001e# service=git-upload-pack\n
+   S: 004895dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint\0multi_ack\n
+   S: 0042d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master\n
+   S: 003c2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0\n
+   S: 003fa3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}\n
+   S: 0000
 
 Dumb Server Response
 ^^^^^^^^^^^^^^^^^^^^
@@ -286,8 +287,8 @@ Clients MUST first perform ref discovery with
    C: POST $GIT_URL/git-upload-pack HTTP/1.0
    C: Content-Type: application/x-git-upload-pack-request
    C:
-   C: ....want 0a53e9ddeaddad63ad106860237bbf53411d11a7
-   C: ....have 441b40d833fdfa93eb2908e52742248faf0ee993
+   C: 0032want 0a53e9ddeaddad63ad106860237bbf53411d11a7\n
+   C: 0032have 441b40d833fdfa93eb2908e52742248faf0ee993\n
    C: 0000
 
    S: 200 OK
@@ -383,7 +384,7 @@ The computation to select the minimal pack proceeds as follows
      emptied C_PENDING it SHOULD include a "done" command to let
      the server know it won't proceed:
 
-   C: 0009done
+   C: 0009done\n
 
   (s) Parse the git-upload-pack request:
 
@@ -447,7 +448,7 @@ Clients MUST first perform ref discovery with
    C: POST $GIT_URL/git-receive-pack HTTP/1.0
    C: Content-Type: application/x-git-receive-pack-request
    C:
-   C: ....0a53e9ddeaddad63ad106860237bbf53411d11a7 441b40d833fdfa93eb2908e52742248faf0ee993 refs/heads/maint\0 report-status
+   C: ....0a53e9ddeaddad63ad106860237bbf53411d11a7 441b40d833fdfa93eb2908e52742248faf0ee993 refs/heads/maint\0report-status
    C: 0000
    C: PACK....
 
-- 
1.8.4.rc4.527.g303b16c
