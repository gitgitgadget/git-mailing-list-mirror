From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 09/12] Don't include windows.h at winansi.c at MSVC build
Date: Wed, 19 Aug 2009 23:52:44 +0800
Message-ID: <1250697167-5536-9-git-send-email-lznuaa@gmail.com>
References: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-2-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-3-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-4-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-5-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-6-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-7-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-8-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:55:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnV8-0002JE-3H
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbZHSPyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbZHSPyu
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:54:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:42860 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbZHSPyu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:54:50 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1311212rvb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oFz5Zd94NSXQ8d7GkHnCJ+H7YI0NpP3kbzlnYF8wllc=;
        b=kDZdv95Iy5fBbyIUXFEXSTnZkS3KdY/JrJzttKdFGzXyOmdaTxv7CeZlm9kwVpK8D7
         uIIqc4l7QKrL79xVKQ/PUrLrT+unaTqnoyD1jBvcnXU/0P8LdFc13mvIgIrr7vBCPN9g
         PZgOWha5tmiZISrHrEcnFhj7+yKAv331tbMZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s1rLX3/M4ns+J/GrO4bELt4tBK9MCVuh322MpYKb7L4edDmNrOqMSru/lgNd70XCFN
         b33h3VfaICwpu6CUZ32jJkN/ekEGiFPOk9qi1vn6ei/ISoZu6jqUYOP3IoOB1PT0Acuq
         AV2xvka9YBDzRe9pR3NONYJ2jFpMX1MRk31c8=
Received: by 10.140.148.9 with SMTP id v9mr3099359rvd.247.1250697292099;
        Wed, 19 Aug 2009 08:54:52 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id c20sm1250893rvf.31.2009.08.19.08.54.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:54:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250697167-5536-8-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126559>

msvc.h include winsock2.h, which conflict windows.h.
msvc.h define minimized  required windows version

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/winansi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 9217c24..15053d0 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -1,8 +1,9 @@
 /*
  * Copyright 2008 Peter Harris <git@peter.is-a-geek.org>
  */
-
+#ifndef _MSC_VER
 #include <windows.h>
+#endif
 #include "../git-compat-util.h"
 
 /*
-- 
1.6.4.msysgit.0
