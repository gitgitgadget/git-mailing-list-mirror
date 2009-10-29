From: Gisle Aas <gisle@aas.no>
Subject: [PATCH] More precise description of 'git describe --abbrev'
Date: Thu, 29 Oct 2009 22:38:29 +0100
Message-ID: <b48ea8a00910291438r8b66a0fq9e821393ecfff0bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 22:38:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3chY-0002Bh-0O
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 22:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756157AbZJ2Vi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 17:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756116AbZJ2Vi0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 17:38:26 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36616 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099AbZJ2ViZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 17:38:25 -0400
Received: by bwz27 with SMTP id 27so2840751bwz.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=o9inMCjdqwCTh6wadxZoQiewonEkrf5pv3hvfNcnY2o=;
        b=Hfnfed5+9Ons+EQGX2rDVPvxReOGeH1XsdD9BgWgU802D5bBpC9AMraCVkAKTtAGAZ
         eQrKVEeohCZi9uakBitkX+C2Vlloglq2haxeh4BKJHvNncApIVWFAm8PRVamiuHJEwh+
         gOnnkaBbdgCvzvlgCwL4Y9f6B/vM7mFLU7ECg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        b=Jk2fRZ7W/Qbz6vKPghcTWeVf1Kcg2KEVsYeOeVynbAmpSD4JLE5UiSXXXHW0CyWEup
         dwYwztQ9ha8Vzw+22O9GL3FkvPTKnzXv/iaiE2sMC2wjSacDuagdORyG0WJPrAseBAqe
         MvkrnUqtUyqJxmBcG55yS8GIQOuVqBa8+qaP0=
Received: by 10.239.143.214 with SMTP id l22mr68428hba.167.1256852309134; Thu, 
	29 Oct 2009 14:38:29 -0700 (PDT)
X-Google-Sender-Auth: cb5b116259a7ba37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131656>

Also make the examples show what 'git describe' actually outputs
currently.  I guess the default --abbrev value has been changed from 4
to 7 at some point.

Signed-off-by: Gisle Aas <gisle@aas.no>
---
 Documentation/git-describe.txt |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index b231dbb..743eb95 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -44,7 +44,9 @@ OPTIONS

 --abbrev=<n>::
 	Instead of using the default 7 hexadecimal digits as the
-	abbreviated object name, use <n> digits.
+	abbreviated object name, use <n> digits or as many digits
+	are needed to form a unique object name.  An <n> of 0
+	will suppress long format, only showing the closest tag.

 --candidates=<n>::
 	Instead of considering only the 10 most recent tags as
@@ -68,8 +70,8 @@ OPTIONS
 	This is useful when you want to see parts of the commit object name
 	in "describe" output, even when the commit in question happens to be
 	a tagged version.  Instead of just emitting the tag name, it will
-	describe such a commit as v1.2-0-deadbeef (0th commit since tag v1.2
-	that points at object deadbeef....).
+	describe such a commit as v1.2-0-gdeadbee (0th commit since tag v1.2
+	that points at object deadbee....).

 --match <pattern>::
 	Only consider tags matching the given pattern (can be used to avoid
@@ -106,10 +108,10 @@ With --all, the command can use branch heads as
references, so
 the output shows the reference path as well:

 	[torvalds@g5 git]$ git describe --all --abbrev=4 v1.0.5^2
-	tags/v1.0.0-21-g975b
+	tags/v1.0.0-21-g975b3

 	[torvalds@g5 git]$ git describe --all HEAD^
-	heads/lt/describe-7-g975b
+	heads/lt/describe-7-g975b31d

 With --abbrev set to 0, the command can be used to find the
 closest tagname without any suffix:
-- 
1.6.2.95.g934f7
