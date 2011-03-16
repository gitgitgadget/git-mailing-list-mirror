From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/8] enums: omit trailing comma for portability
Date: Wed, 16 Mar 2011 01:59:10 -0500
Message-ID: <20110316065910.GB5988@elie>
References: <20110316024959.GA24932@elie>
 <20110316065256.GA5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 07:59:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzkhi-0005Hp-VT
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 07:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864Ab1CPG7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 02:59:24 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37429 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab1CPG7P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 02:59:15 -0400
Received: by yxs7 with SMTP id 7so542344yxs.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 23:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Ky6IlmwY+HXsNVCDVRpNjEJo0ZXMJVDokP4KOTVV5Fg=;
        b=bygqaTSCVMhHJtY8fqJdK92SprgwS45HwGBJOZegoPTHHyINJTf48QLTIWxGlSYj5Q
         QCQi78shRUlStQfaE0gGk+GSuUbr0kyhif0dL1hekCUGiVZFzdHi2FlEjkswLSjyhIKf
         3TLmBPFjgmiiFVrRqSsykBbr6Buoj+JLWq4XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RYczZUZSwPhDkrj+fTAwijToc5dRK6+hMeW3DewplH15KMQo1m2qIZgfF4tdqdUC8Z
         nYLIbKSnKRJyyAwX/eIaWHw4T/MUQiQEwbFmEatpK1Bn2gmw/WDQiZxlkVRy3KpKYqh4
         fPPtDLY0YC4nC8HxVR6alIvW/9zfJ1+xFmBOo=
Received: by 10.150.74.7 with SMTP id w7mr967788yba.160.1300258755129;
        Tue, 15 Mar 2011 23:59:15 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id o2sm3331095ybn.18.2011.03.15.23.59.13
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 23:59:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316065256.GA5988@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169109>

Since v1.7.2-rc0~23^2~2 (Add per-repository eol normalization,
2010-05-19), building with gcc -std=gnu89 -pedantic produces warnings
like the following:

 convert.c:21:11: warning: comma at end of enumerator list [-pedantic]

gcc is right to complain --- these commas are not permitted in C89.
In the spirit of v1.7.2-rc0~32^2~16 (2010-05-14), remove them.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
At first, I was worried that the fixes from the series v1.7.2-rc0~32
had been in vain, but in reality it seems that there are only a few
new C89-compatibility tweaks to make like this one.

 cache.h   |    2 +-
 convert.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index c4ef999..80f1236 100644
--- a/cache.h
+++ b/cache.h
@@ -585,7 +585,7 @@ extern enum safe_crlf safe_crlf;
 enum auto_crlf {
 	AUTO_CRLF_FALSE = 0,
 	AUTO_CRLF_TRUE = 1,
-	AUTO_CRLF_INPUT = -1,
+	AUTO_CRLF_INPUT = -1
 };
 
 extern enum auto_crlf auto_crlf;
diff --git a/convert.c b/convert.c
index d5aebed..7eb51b1 100644
--- a/convert.c
+++ b/convert.c
@@ -18,7 +18,7 @@ enum action {
 	CRLF_TEXT,
 	CRLF_INPUT,
 	CRLF_CRLF,
-	CRLF_AUTO,
+	CRLF_AUTO
 };
 
 struct text_stat {
-- 
1.7.4.1
