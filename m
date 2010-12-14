From: Jerzy Kozera <jerzy.kozera@gmail.com>
Subject: [PATCH] git-p4: Fix 'p4 opened' in git-p4 for names with spaces
Date: Tue, 14 Dec 2010 20:56:05 +0000
Message-ID: <1292360165-26771-2-git-send-email-jerzy.kozera@gmail.com>
References: <1292360165-26771-1-git-send-email-jerzy.kozera@gmail.com>
Cc: Jerzy Kozera <jerzy.kozera@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 21:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSbuz-0006f7-5l
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 21:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760034Ab0LNU4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 15:56:13 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37085 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759636Ab0LNU4L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 15:56:11 -0500
Received: by wwa36 with SMTP id 36so921038wwa.1
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 12:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1/MHBWwUzXQ/d49NX113enBsUc/SkNIxhpc72eI4nwc=;
        b=miFr3eObwwL9bLurmNovvk33TILxW/OnnUEYQn0slgeiJmrSNKqAaI1jv1aBjaohpf
         VDqKaNedlksXIo3EgZy7g0YhpR2UtzQQTcJxxpX4ICcr8cv/KMC0LJQm4zsh2vApkMLu
         CacN16KEz9wUa6mHpVK5SL4Uc2fq5GdZ5f5Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hd3Ng+vyIsA/GWdy51WTOAmrLlarurJfqsRRjITfwR4tfMCGq3VNv07dzw0kH0W5Rw
         gUbG6/8dJoMZ092JPW0igoT5E1U0KwS+pxDCGIGdGYfwGn/ijAsGIeU8CXhg4uLVItZx
         FEKtjLDjZC5zBH/f1o5Q1a/t5Uz8avvNxNTHw=
Received: by 10.216.30.67 with SMTP id j45mr5180289wea.99.1292360170548;
        Tue, 14 Dec 2010 12:56:10 -0800 (PST)
Received: from localhost.localdomain (188-223-231-164.zone14.bethere.co.uk [188.223.231.164])
        by mx.google.com with ESMTPS id b30sm376246wen.1.2010.12.14.12.56.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Dec 2010 12:56:09 -0800 (PST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1292360165-26771-1-git-send-email-jerzy.kozera@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163688>

Signed-off-by: Jerzy Kozera <jerzy.kozera@gmail.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..a5297e7 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -144,7 +144,7 @@ def setP4ExecBit(file, mode):
 def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
-    result = p4_read_pipe("opened %s" % file)
+    result = p4_read_pipe("opened \"%s\"" % file)
     match = re.match(".*\((.+)\)\r?$", result)
     if match:
         return match.group(1)
-- 
1.6.5.2
