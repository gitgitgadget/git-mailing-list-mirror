From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 27/41] refs.c: make lock_ref_sha1 static
Date: Tue,  3 Jun 2014 14:37:45 -0700
Message-ID: <1401831479-3388-28-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSQ-0007P1-Mb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965387AbaFCVlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:13 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:45160 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934279AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-yk0-f202.google.com with SMTP id 9so469830ykp.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PyX57HU+RLn3p8Icd0QqoriR8GtzbED2VXQ7ahtpUZw=;
        b=ktAyiogp4MwJ7pkr3J5BN4uqw6Mpf7ga3wDTP6UWOqiGtTZvWWm133BMdTV6s/YaGm
         AV87yTjOWFa62TogUUY9RC7f77JjQkkWu9H6d8s9+gnAIelQaUPR3HJfu63vRW5qjwHI
         5U55OQUZAiwIKBqOm2Fr61rno1j9wQRiM4QcHC4fPuvbq369h8enn9jiA5Zuo5U2So5w
         Ck81esQZA9yRHWJrav7KanHf1F9Cq1LAvKUfJabkrful1veid6scjzo7mG+NHdR3w/fr
         FLq+R5K3aC3pNXilwQ+sv1ayZob4k3b3WiFi5KuV3vRdiCo2fQs69H6A0QMhh8/DU7Hf
         MprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PyX57HU+RLn3p8Icd0QqoriR8GtzbED2VXQ7ahtpUZw=;
        b=Yakza4unnUOY7SfyTeUia6HVrcG02abI2SSTFK/YbGhXEd8sgRZQER9S7kgwJfrhZu
         viVT1ho5LmCKLEXRYp76TXBp+tLTvBEIOA79r2YhPirteyBWbqfikJs9m14CSONuJ/jP
         B3dYJsVOFW9PGCFe2SfGL4yE61znplAQ14S8Bc20vsz4qLgWnPPQ9X0+Hh3vX1syARB3
         6O8BxeOobQor/URoF+zmvkSkjjSG+Blt+1d4n8iI9cDe82qsRREBALf9qYmVii6vUpBR
         3AYk/IqG8R5Csdqc8mev6+K7w04q1V8Iuw4m+VQjQsHqPa9yXHtlSSx6G9S3gnMO3snz
         atfg==
X-Gm-Message-State: ALoCoQm0kCFEcTtL8EG/3LUtbdziQZ9XDHlF/5Iq0GRsKvh0iYl/AV6xEaDQ8TqNzTXPNWK4Weq/
X-Received: by 10.236.140.42 with SMTP id d30mr17383565yhj.2.1401831488025;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si30410yhg.2.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DC3C931C462;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B841BE05F1; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250669>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 6d2caf7..d2fd419 100644
--- a/refs.c
+++ b/refs.c
@@ -2139,7 +2139,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index 743358f..c38ee09 100644
--- a/refs.h
+++ b/refs.h
@@ -171,9 +171,6 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
-extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
-
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
-- 
2.0.0.567.g64a7adf
