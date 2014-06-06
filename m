From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 27/40] refs.c: make lock_ref_sha1 static
Date: Fri,  6 Jun 2014 15:29:05 -0700
Message-ID: <1402093758-3162-28-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2eq-0002sC-47
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbaFFWai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:38 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:52872 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so680631veb.4
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i8rauZki18Xn0iAVlOtK2tGQbHQI2aRAEK6nlMLIi6g=;
        b=VT4Jex0vS4rymaQ4oQtqt8zpopx4ihr3BjJocS0UhnxxAJelMtT1fSlRTYVDxaDDDb
         W4R+0uRC12xZnLTPOYhDvOiaaSch5BaDGEqf56dxUVGl2L8YhtMSP4NdpeA8gvTNK3cD
         tfqSv6vkGE+sP/YaL16PU1H22Xc8Ro7BVNqJkcbg6zTnQOyZuYysRz6qN0V3V2HbQumJ
         tUJhiO8RMVLEKPX6YLi99naxgPuKR6tWBYNGHtnURvJEiKg0TMqy47WvvbrOXjIp1ScO
         qLFV1XHod12OHs0IVaYo2suVJdmSssqPUs7DpJp+ZpQwyQkHVE7AWumSSeNrsl5uCV4D
         +2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i8rauZki18Xn0iAVlOtK2tGQbHQI2aRAEK6nlMLIi6g=;
        b=aAxF3vaCfvhOadxnFX+Zuv+yhkAlSFy2V80EFATbeTFQe4L9p8cUht1ZgFOu0LwS6y
         aikLEpsm5HxwfdpFs4QUfSBjqtrY788AWtFcgeZaX+NhaJ0YdrqpdgjPd8e6Ryq3cCg9
         5BcYhpgzh8IP5APUboFQle+11CQeVGjT/k4zE++SSmtjTgiV36ZeISVrJs/iaxb8bUAL
         y4YfMdu3OYtNwUhzLjHD7iXaJY0fUPmz5RFw2IViKBBR9IRx8brZFFgvv4VdHhUq/AqN
         qoucrI7rF6nipqVG4KhGVsJGQqqZ57LkSC/DEU1zV9ZjPS033dYWxpZB/kbnvCqeX9H0
         Fudg==
X-Gm-Message-State: ALoCoQmsrDKDuU0XNq+I5GoHSaWvRY0z953JXxUEgjqENPjyniUspnTrHI/EYEZnKuoexriLy8wP
X-Received: by 10.58.49.194 with SMTP id w2mr5254157ven.26.1402093762935;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id pr8si750961vdb.1.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id ADC225A44FE;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7A19CE0D74; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250994>

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
2.0.0.582.ge25c160
