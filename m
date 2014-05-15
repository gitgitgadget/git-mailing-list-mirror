From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 44/44] refs.c: remove forward declaration of write_ref_sha1
Date: Thu, 15 May 2014 16:15:41 -0700
Message-ID: <1400195741-22996-45-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tQ-0006Dm-J3
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221AbaEOXQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:17 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:36937 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119AbaEOXPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:47 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so720950vcb.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w0BWh4x81diR+Qz7eV7dQUetauC8gUHnLGH039n9Gdc=;
        b=QP1YPvqkpkFecQZpeRA4BWBd33xi0ucsUwLSnRgePQNqIbS/DZriwfPHvMixC1F0TR
         FXtw4EyUbIeERjUBnXL4ShM7DAxSylnKocEh7L3nNO1kqc/62/Bzyj1XBySkmmqcEXB/
         7xKFYsaBn3myGExdKWRtk7wennmPN2KvMtalvPeUOlJN//Xc/Dl325XO6I3W2Xp/PGjw
         gPPCPrGY/rdUruyJslfJECZGucDwoP5LFiGYhiZIqvUnVjQtsPNd/OuBuYx/4NJziInc
         xCPRRdL7FBuCfhd4SB2T5DfZTYeq7gxbEzSgoPlbomq9rmWV3WsVMXNk9gobAMOjX3B5
         GpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w0BWh4x81diR+Qz7eV7dQUetauC8gUHnLGH039n9Gdc=;
        b=VM15EkeQfYdugsi+NyMqw2HMNYnti741OkNBz5IP4GwthVD+P0VDZXI4Gjr6J5SmCi
         WsGzqPGB7kw4GoQsmLEBDX9IehKl48nC06mB5nsapcihTI2qTJk7s8tPB2Z8c033DE8G
         x9zoYsXD1wuuROhmKwMkgQcP+kYguVO/hC0q8c/g8ajzJRZ2LNkwKFymnTV0sbjscSlS
         9kqKHFInENdSCKAoPDkMQm2jJJKyzivsuShEyOo9yRkDn88qrpN1bP9SziFNMlqPkMMC
         VbLhAXSV0mOeID5wwwOCgc5hQ4Flb4iWhqOsJ7ZdXxWzpdnaVQCYmyJ80lRTiVVe8bzZ
         yRrw==
X-Gm-Message-State: ALoCoQnV0iUTDmDc5Wdacvk5f/jSNWWax1TtaFmWbPNczYgrQsh5jOY1+W/9WmPnjbBbvOndzCK8
X-Received: by 10.236.92.204 with SMTP id j52mr5758568yhf.26.1400195746497;
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si318647yhk.4.2014.05.15.16.15.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5C7BD31C318;
	Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3AB8DE0475; Thu, 15 May 2014 16:15:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249241>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs.c b/refs.c
index 7ea3f42..8e30511 100644
--- a/refs.c
+++ b/refs.c
@@ -260,8 +260,6 @@ struct ref_entry {
 };
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
-static int write_ref_sha1(struct ref_lock *lock,
-			  const unsigned char *sha1, const char *logmsg);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
-- 
2.0.0.rc3.477.gffe78a2
