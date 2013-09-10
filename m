From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 13/14] shift dumb server response details
Date: Wed, 11 Sep 2013 01:07:57 +0800
Message-ID: <1378832878-12811-14-git-send-email-rctay89@gmail.com>
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
 <1378832878-12811-11-git-send-email-rctay89@gmail.com>
 <1378832878-12811-12-git-send-email-rctay89@gmail.com>
 <1378832878-12811-13-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:09:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRQr-0003Wj-Jq
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab3IJRIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:08:48 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44924 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab3IJRIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:46 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so7938159pdj.16
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sWCy/N2SoOaABs7rmAflxFHItZ+2J+bvaOJ3NzGqJlw=;
        b=WoLqeykGe1NKMfXq+J5aqny32F+1PDV9C5SGa/emgBKBcMOIYvVs9NsG7rwFPdM6d2
         bflUZ+xm5rKtl628yV+u/2+7VGKJmc8KVf9ar7wcRYA41NqsCDXluDxsBrupQLkkBv8Q
         vVVaEB+11VYrvOlnAqLw7yZQmWUNnMzJfoe7Wq87lUbtZhXQ0IwyVUDb8ygGwJzPxAqM
         veGY5TvItnfattbBzsvrLOLYZgrBwVwkb8tLTEAX0WK7UCDPntJEKu6jdCh24YHQ0/rB
         B8D/U/gPhTp/ILmwFcFqZ5d8gjHyCrcfniGs524R9xkikc63nOQcCxi28A1pZLLcN3Zz
         5kkw==
X-Received: by 10.68.52.200 with SMTP id v8mr26831406pbo.48.1378832926111;
        Tue, 10 Sep 2013 10:08:46 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-13-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234456>

Shift details like ABNF from the client section to server section. This
is in line with the smart analogue.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/technical/http-protocol.txt | 49 +++++++++++++++----------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 63a089a..3098aa4 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -162,30 +162,6 @@ without any search/query parameters.  E.g.
    S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0\n
    S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}\n
 
-The Content-Type of the returned info/refs entity SHOULD be
-"text/plain; charset=utf-8", but MAY be any content type.
-Clients MUST NOT attempt to validate the returned Content-Type.
-Dumb servers MUST NOT return a return type starting with
-"application/x-git-".
-
-Cache-Control headers MAY be returned to disable caching of the
-returned entity.
-
-When examining the response clients SHOULD only examine the HTTP
-status code.  Valid responses are '200 OK', or '304 Not Modified'.
-
-The returned content is a UNIX formatted text file describing
-each ref and its known value.  The file SHOULD be sorted by name
-according to the C locale ordering.  The file SHOULD NOT include
-the default ref named 'HEAD'.
-
-  info_refs        =  *( ref_record )
-  ref_record       =  any_ref / peeled_ref
-
-  any_ref          =  obj-id HTAB refname LF
-  peeled_ref       =  obj-id HTAB refname LF
-		      obj-id HTAB refname "^{}" LF
-
 Smart Clients
 ~~~~~~~~~~~~~
 
@@ -229,8 +205,29 @@ Dumb Server Response
 ^^^^^^^^^^^^^^^^^^^^
 Dumb servers MUST respond with the dumb server reply format.
 
-See the prior section under dumb clients for a more detailed
-description of the dumb server response.
+The Content-Type of the returned info/refs entity SHOULD be
+"text/plain; charset=utf-8", but MAY be any content type.
+Clients MUST NOT attempt to validate the returned Content-Type.
+Dumb servers MUST NOT return a return type starting with
+"application/x-git-".
+
+Cache-Control headers MAY be returned to disable caching of the
+returned entity.
+
+When examining the response clients SHOULD only examine the HTTP
+status code.  Valid responses are '200 OK', or '304 Not Modified'.
+
+The returned content is a UNIX formatted text file describing
+each ref and its known value.  The file SHOULD be sorted by name
+according to the C locale ordering.  The file SHOULD NOT include
+the default ref named 'HEAD'.
+
+  info_refs        =  *( ref_record )
+  ref_record       =  any_ref / peeled_ref
+
+  any_ref          =  obj-id HTAB refname LF
+  peeled_ref       =  obj-id HTAB refname LF
+		      obj-id HTAB refname "^{}" LF
 
 Smart Server Response
 ^^^^^^^^^^^^^^^^^^^^^
-- 
1.8.4.rc4.527.g303b16c
