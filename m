From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 18/31] guilt-graph: Handle commas in branch names.
Date: Fri, 16 May 2014 16:46:05 +0200
Message-ID: <1400251578-17221-19-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:54:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJX3-00074b-SS
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbaEPOym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:54:42 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:59180 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838AbaEPOyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:54:41 -0400
Received: by mail-la0-f53.google.com with SMTP id ec20so2031197lab.40
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bwHk4OwyssY5R4bKiWE04oMx43FyfRkXFRHAzGsMs3Y=;
        b=kEDt1XI8SArg0OyQDnxjo6RyyKqjpkGjK/4XroR3GTUZmB/ldMCueo+uV3YGb+FJSh
         6b2CLZ7l8w7sCZRnbPKNk9/Yp3pE45we49Z+8goaU19KBzuc+2X+sUMTcfYEzEIpsqDz
         xgTUWf8+/bHwVO9/ll0+xB/H3wu1H0BV2benhFf4vl/SLbdvwWgok6m78Xp2l5ggKs99
         WJBOx+kqzWzpZFOuUpoSnsSt+Q1WUwHSB/6LOaIzpyHnY/838jNv9Z/oboYIukXaAaL8
         uRdR8c21V+YH3mOGkVcRXCpOeo0MF8Zf4LqXMOW/sBkGtBfw2ll7EbMyD6RoiTLSRHZp
         dQYA==
X-Gm-Message-State: ALoCoQkPyRN2v0EYWI3j/WFsbRxImRrSKR1hmB1+z9fGYkKeJVqlXh2n/zYBP1RyVZ9Sn1f4vE8J
X-Received: by 10.112.141.106 with SMTP id rn10mr1601755lbb.78.1400252080106;
        Fri, 16 May 2014 07:54:40 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.54.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:54:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249327>

This fix relies on the fact that git branch names can not contain ":".

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-graph | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-graph b/guilt-graph
index 56d0e77..924a63e 100755
--- a/guilt-graph
+++ b/guilt-graph
@@ -51,7 +51,7 @@ safebranch=`echo "$branch"|sed 's%/%\\\\/%g'`
 while [ "$current" != "$base" ]; do
 	pname=`git show-ref | sed -n -e "
 /^$current refs\/patches\/$safebranch/ {
-	s,^$current refs/patches/$branch/,,
+	s:^$current refs/patches/$branch/::
 	p
 	q
 }"`
-- 
1.8.3.1
