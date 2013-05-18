From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 04/15] contrib: related: print the amount of involvement
Date: Sat, 18 May 2013 06:46:44 -0500
Message-ID: <1368877615-9563-5-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:48:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udfd3-00070f-5d
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab3ERLsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:48:41 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:55332 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab3ERLsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:48:40 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so5564455obc.26
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=EwaZm/kICcLogEghdq/3CCKUIs5fI0OJtE62Hg3lUB0=;
        b=GeC5QmBCzUmXj+xxcZDZfY3noZF6DZ3vk6Llh3IfUOKyeIrn7/zOPI6T4uacQFgrvF
         CoLGCU7VJG6rrSoB2Xz38pINT7HGLZjv7toTx8JWMq+y8c4+wSaPVlxC3mRe0dabG9Yv
         2dsfIQz/JkWw/mEA55DZX6OcRkrA8wATRwR/VO4t0hyk57VVJ0ilTdwcFSRJ4fRMEU/z
         bTA9lRJIbQ5V1kn9a1HW55A3OSV09iZIvVyieBJMvaJyucQFrCLFWO29nmIhRUZWQc7U
         TCRZ9ZYSMMvI2N5P6r6fCmOaQVGSb4lRQv2BdlJX+ckNCSpHlBAtsU1B+SpAtZYZ50rh
         qUpw==
X-Received: by 10.60.97.4 with SMTP id dw4mr25055546oeb.75.1368877719926;
        Sat, 18 May 2013 04:48:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ln8sm670475obb.3.2013.05.18.04.48.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:48:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224777>

100% means the person was involved in all the commits, in one way or the
other.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 8c26cf8..7be2829 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -142,5 +142,5 @@ end
 count_per_person.sort(&count_sort).each do |person, count|
   percent = count.to_f * 100 / commits.size
   next if percent < $min_percent
-  puts person
+  puts '%s (involved: %u%%)' % [person, percent]
 end
-- 
1.8.3.rc2.542.g24820ba
