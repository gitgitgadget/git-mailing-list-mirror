From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 44/44] refs.c: remove forward declaration of write_ref_sha1
Date: Thu, 15 May 2014 10:29:59 -0700
Message-ID: <1400174999-26786-45-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVG-0001Iu-Q4
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785AbaEORbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:12 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:34102 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700AbaEORaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so257144pbb.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7RycSFos0dSVRONXN9nVUCKmaoJaoTgTEV6yQYp7sb4=;
        b=lDpp3a/IKc9dX4dp25UOhUoFpOuUgnW5NJn1FvcRtc4oHRNs6jf4DoWMzEehr7qPo3
         L8W2Z/GudJSn95/0ydbYMMeuQN7WszM/K87ltxKbrShKpFqnTDwYq8t0lgqqaKMbWmOP
         c6LcPKHtqC9H87CTL8qJeZSpklyt6cvDX+4A3NQbbeAnzwjUj9IdRMz1KaNL2roUTF6K
         k3EFckR2WdOqZfjvdXPGXKxS2cQrhT07zRAQwBK7+3FC4avESoNw4D+B/rCieuo4c7pS
         yPrXFrv5XXMEhJsN15q0+0u1OfpQHWqA0DpLovJsX37YWz8nmCAuqTOu6gaVSyvvKQKM
         KCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7RycSFos0dSVRONXN9nVUCKmaoJaoTgTEV6yQYp7sb4=;
        b=krfGKftoKuiDAm5V7vpVmuFSIYZoI2lt2TbbQ+gLEV5gkegRzI8h+C/W5FNvAf+Nh7
         U9Tfn4Ga7nlEzwsgEmr7rB5ee/xm8vRx+SeOcHsj2GUyXJVb2rFgwMZyKYTUT5Dd/Yvx
         63+RdF+EvM2nxk9+FWuyeURJy+V4Pr66h+XlXOUL5mN4d0AT/6o7zmIo+goTXPk63X/+
         ailpUbPgL8CJKh/AjDDEe/BB21T/qub99QQnG4zKZxX53OQLbsypWSps0w3dT3B118bH
         gxbuafPhzFq3oDl9ZssBfgaaylxcxlaVKqawDL9UfmpVWHXeTktGHl8RxoPf6Lo+JZmw
         ToFA==
X-Gm-Message-State: ALoCoQnt5NnrD+HYJmPVwyIiOMLqHmYlje1ioX3IBY0Muwv5Yn5Xqjv4W6ufV8UmK9Chnrubbwzf
X-Received: by 10.66.197.131 with SMTP id iu3mr2890052pac.15.1400175007805;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si199315yhj.5.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 922AD5A42E3;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6D120E16A3; Thu, 15 May 2014 10:30:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249142>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs.c b/refs.c
index 336df40..ed93b75 100644
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
2.0.0.rc3.477.g0f8edf7
