From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 08/15] contrib: related: group persons with same email
Date: Sat, 18 May 2013 06:46:48 -0500
Message-ID: <1368877615-9563-9-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:49:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdfdF-0007C3-2T
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab3ERLsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:48:55 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:62964 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab3ERLsx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:48:53 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so5497982obc.40
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=sBWDuiSOms4Lt2XFMzDOZ7OvIBTfU/2oOTIdqx6JfFI=;
        b=mcMNMlMJYuFfFqhwVmTpF/WB4M4JUsDaeOgXsSlaT1tPzH/NKyR+Y6N0uvUAj1UMR1
         /RRHHqWqlkbBfoTwnJTJulPBvldYesF2DzRTMUuqJcQcBDeveDfhjXXeAyyjiohiUCtb
         AwhZudFJDuLrpDjfq9uFGtiToZoPt1NciaXpIs045shAA+BB6czWeixOkgJ0jisf6yd+
         JMUqzsBW4rNYFnwVIEb2tHSk10cnkRTz+gd94van2b3k0tNs6ADVKSLblqVvy4FncUdx
         k8SuZGG7wk3R2zHl9mjepnjF6JXcnS90o5gsz/uLI/BInJt01Qr9UN9A111rcNGvU+hW
         hixg==
X-Received: by 10.182.231.197 with SMTP id ti5mr23829095obc.64.1368877733417;
        Sat, 18 May 2013 04:48:53 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ri8sm11721457oeb.0.2013.05.18.04.48.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:48:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224781>

Suggested-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index eef776a..9194777 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -70,7 +70,7 @@ class Persons
   end
 
   def self.get(name, email)
-    id = [name, email]
+    id = email.downcase
     person = @@index[id]
     if not person
       person = @@index[id] = Person.new(name, email)
-- 
1.8.3.rc2.542.g24820ba
