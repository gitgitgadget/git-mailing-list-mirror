From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] Documentation: No argument of ALLOC_GROW should have
 side-effects
Date: Fri, 8 Oct 2010 11:46:59 -0500
Message-ID: <20101008164659.GC9212@burratino>
References: <20101008005256.GA21738@headley>
 <20101008074320.GB4671@burratino>
 <20101008164536.GB9212@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 18:50:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4G9C-0003Ul-BX
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 18:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359Ab0JHQuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 12:50:10 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61709 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab0JHQuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 12:50:09 -0400
Received: by qyk10 with SMTP id 10so1519386qyk.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7UODNKudZMAcKKDfG/BCDdH4lytsFVbkI0X33zVJpII=;
        b=fz3Bi/413p4ceEAPvE682Vs4MIYW5bg7a7T+iwrIAdilmWA6Quxa+lhD8/6ASnvQ9W
         7DZFH2XRby9xUMWNZgucSeWS/1PiUhodhsG9nmebts7LhUmxjci4EC8i6w879z1q0zS3
         NOnmRQFCeti6oGHIOSy7x3fdTtfeEzAQfL5eU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EndVTCh8FmwM/whdc19crX2D6AqFoGvWudJKZn98PmzvRl616JHV15S0m+XoyadSoa
         nONsHaqi4XjUNziTYbO+scf9MTW0k7LaC+ieG6aQbY9H6znEpCBeA/42MNtjLJUh6PX+
         JLT8hJDR2Xk9SzJX3srxW6ENZPZwc/CQyqi9k=
Received: by 10.229.141.75 with SMTP id l11mr2209334qcu.154.1286556608572;
        Fri, 08 Oct 2010 09:50:08 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l13sm2682374qck.43.2010.10.08.09.50.07
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 09:50:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101008164536.GB9212@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158504>

The explanatory comment before the definition of ALLOC_GROW carefully
lists arguments that will be used more than once and thus cannot have
side-effects; a lazy reader might conclude that the arguments not
listed are used only once and side effects safe.

Correct it to list all three arguments, avoiding this confusion.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 2ef2fa3..23d6d45 100644
--- a/cache.h
+++ b/cache.h
@@ -438,7 +438,7 @@ extern int init_db(const char *template_dir, unsigned int flags);
  * at least 'nr' entries; the number of entries currently allocated
  * is 'alloc', using the standard growing factor alloc_nr() macro.
  *
- * DO NOT USE any expression with side-effect for 'x' or 'alloc'.
+ * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
  */
 #define ALLOC_GROW(x, nr, alloc) \
 	do { \
-- 
1.7.2.3
