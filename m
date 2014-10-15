From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/25] refs.c: lock_ref_sha1_basic is used for all refs
Date: Tue, 14 Oct 2014 17:47:13 -0700
Message-ID: <20141015004713.GG32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:47:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCkO-00089s-IU
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbaJOArT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:47:19 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:45725 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932637AbaJOArQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:47:16 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so229752pdb.3
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sB2ca9qMCr+XKqwM6RkMh6gN6ehZQJRV9ujYMAwqGPY=;
        b=Cg0Y5irGFW91EzUMI0iFtszpiimckoAr/Hw8vvt8nAFRl00ZRmGxoi4gbDNVC+X2b/
         A6ztj4ZBaMrlxoOWzoCe1XnF2yJcmQKOBPo2+yCxLX2y/XZdbpOu+sOmOaX6Wnqfrs+v
         SOeHs4q4Fh0ve1lrKzmzXbkILbpdNH7DOvn/d9cC7BdMeMOQFd6l4QkX/7ywGZamgdSl
         2TLrRVMu0pCCiQ+HGrpg9E5lztD3g5jlYHm8XQqJSwLjosVdltkuNVuXqm8QT4CVQAY8
         Y6cwEy2MEARYri1Fp1Lucu3FWVA214FZuJXukmKJN3+ITK9oTLZ/ZKZ4Vl4+upeGZAPN
         l5Jg==
X-Received: by 10.68.65.74 with SMTP id v10mr8856448pbs.96.1413334035958;
        Tue, 14 Oct 2014 17:47:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id hz1sm15267568pbb.75.2014.10.14.17.47.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:47:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 2 Oct 2014 07:59:02 -0700

lock_ref_sha1_basic is used to lock refs that sit directly in the .git
dir such as HEAD and MERGE_HEAD in addition to the more ordinary refs
under "refs/".  Remove the note claiming otherwise.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 2dcf6c6..4f2564d 100644
--- a/refs.c
+++ b/refs.c
@@ -2134,7 +2134,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 }
 
 /*
- * Locks a "refs/" ref returning the lock on success and NULL on failure.
+ * Locks a ref returning the lock on success and NULL on failure.
  * On failure errno is set to something meaningful.
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
-- 
2.1.0.rc2.206.gedb03e5
