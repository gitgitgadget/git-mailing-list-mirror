From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] fetch doc: escape asterisk in --tags paragraph
Date: Fri,  7 Jun 2013 17:01:34 +0530
Message-ID: <1370604694-2438-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 13:29:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukure-0003TS-Kg
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 13:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab3FGL3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 07:29:46 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:59091 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab3FGL3q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 07:29:46 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq12so348057pab.11
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JTAtacu8Dom+KM3XDVv9ByWsXq1G4Jog1ZlcXgWNc1U=;
        b=PrtMM7TUhuHdYvjuKIHAX0ROA+F4elp1RPJAPLBkswtHzXPm0Iwm+yLW+HYQu6zh4P
         k2Tx+5HYTdPIRikxldbhcVkeKSrzvsvyRcGfcbBn1duRgRAxqaStlhEn9tFY++CrOQ8q
         gQcAdZvOi09aIozUjGnFLfOsPup2ZKo+aWkpMDRKRyeC29zD1w8y2QJ9a6EdUbiV0Mo3
         09mSbo/zUnDTCCioUPKlZOfxHg81wKbPw8DMnYHQeLqc6XcdqDztX+8BAeXVy8JVsp/7
         8yadhHyGmS1lBIfwUrn/qRLCcQPuf0QoQJklWt7d7IGqRO4QqzmD3l9wDy0v0u7ktvW4
         foXA==
X-Received: by 10.66.138.75 with SMTP id qo11mr2239461pab.172.1370604585721;
        Fri, 07 Jun 2013 04:29:45 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([64.124.185.45])
        by mx.google.com with ESMTPSA id b7sm77192448pba.39.2013.06.07.04.29.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 04:29:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.20.g7940bce.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226620>

Currently, the paragraph corresponding to the --tags option in
git-fetch(1) looks like:

  -t, --tags
      This is a short-hand for giving "refs/tags/:refs/tags/" refspec
                                                 ^^^^^^^^^^^
						 this is in bold

This happens because the corresponding text in fetch-options.txt is
"refs/tags/*:refs/tags/*"; asciidoc renders the text between the two
asterisks in bold.  Escape the first asterisk, correcting the text.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Candidate for maint?

 Documentation/fetch-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 9cb6496..5f68149 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -61,7 +61,7 @@ endif::git-pull[]
 ifndef::git-pull[]
 -t::
 --tags::
-	This is a short-hand for giving "refs/tags/*:refs/tags/*"
+	This is a short-hand for giving "refs/tags/\*:refs/tags/*"
 	refspec from the command line, to ask all tags to be fetched
 	and stored locally.  Because this acts as an explicit
 	refspec, the default refspecs (configured with the
-- 
1.8.3.20.g7940bce.dirty
