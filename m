From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 03/11] Use current output for "git repack"
Date: Tue, 27 Aug 2013 19:56:50 +0200 (CEST)
Message-ID: <1431109393.34423.1377626210746.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 19:56:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENVg-0003t6-8d
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 19:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab3H0R4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 13:56:52 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:34472 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752752Ab3H0R4w (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 13:56:52 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id C38E7A9CFA;
	Tue, 27 Aug 2013 19:56:50 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id BCB0228BA5D;
	Tue, 27 Aug 2013 19:56:50 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id B2B92E3B7D;
	Tue, 27 Aug 2013 19:56:50 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-05.arcor-online.net B2B92E3B7D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377626210; bh=6G20U9QMyQSO7JawaXdvMJwyR2MwcFyhC8TL0QlVEcY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=CjV5+mkw1Jl/NWozxLmdT/eORLfd2qwlDhzm1mRafYiarcrhPWOLN5H7bFHn3fQv6
	 cVAMFg40RL16kogqMJYnB7OdmRWEmhoQ+iSQgLoon+IGXCAdD6jQcL1YP+r8eVXb2K
	 D/7FLFH6pVC9/qpZkDlvqVS+UpkSS3q4WWeUt5Yc=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 19:56:50 +0200 (CEST)
In-Reply-To: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233123>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index bdefd9a..3f44ca0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3203,17 +3203,15 @@ To put the loose objects into a pack, just run git repack:
 
 ------------------------------------------------
 $ git repack
-Generating pack...
-Done counting 6020 objects.
-Deltifying 6020 objects.
- 100% (6020/6020) done
-Writing 6020 objects.
- 100% (6020/6020) done
-Total 6020, written 6020 (delta 4070), reused 0 (delta 0)
-Pack pack-3e54ad29d5b2e05838c75df582c65257b8d08e1c created.
+Counting objects: 6020, done.
+Delta compression using up to 4 threads.
+Compressing objects: 100% (6020/6020), done.
+Writing objects: 100% (6020/6020), done.
+Total 6020 (delta 4070), reused 0 (delta 0)
 ------------------------------------------------
 
-You can then run
+This creates a single "pack file" in .git/objects/pack/ 
+containing all currently unpacked objects.  You can then run
 
 ------------------------------------------------
 $ git prune
-- 
1.8.3.msysgit.0


---
Thomas
