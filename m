From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: cygwin git diff crash
Date: Wed, 14 Jan 2009 15:09:50 -0700
Message-ID: <b9fd99020901141409w1e0c926fkc762f8709bd1c13f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 23:11:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNDxD-0002aB-Qe
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbZANWJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755493AbZANWJx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:09:53 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:52240 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbZANWJv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:09:51 -0500
Received: by yw-out-2324.google.com with SMTP id 9so337895ywe.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 14:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=MriqyiTUl6DFtwnljJuh0Yee5WUHgNg8QsTxnNqcq0w=;
        b=ubgmPb4DOahT8tMmzoOGju8LfppE29ktIQL4oA1U1oNXEzOq+8dL7D4rg0d4CpjOpS
         0xZaQF/TeszyRYQI1RyRVOCY1tgKiiRJ0wMwSQSvLG6PxYVL8mFQwLTJ7K5w/e1jWwYs
         7JOLldwCvxRphQamnCZ8NahXKpDG7QpVjdTS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=gnpQA/pU4tqHkH5jB9f9oe+Wvqr7L6WAAUq9d+Zh5fVSY0FnoH9XvJ9rnNHBtAn+Zg
         P3+YFg3Av2QRRkEmfiJ5g3xlZUp1oX6QShADyNL6NF7fWRud6t99Vl7P+/y/6YuiTyWK
         ZkqP8icP7Q9nsA5N8WI+AlINwhaJHGyaAUaF8=
Received: by 10.100.96.10 with SMTP id t10mr646885anb.32.1231970990371;
        Wed, 14 Jan 2009 14:09:50 -0800 (PST)
Received: by 10.100.140.4 with HTTP; Wed, 14 Jan 2009 14:09:50 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105710>

Ok this is a weird issue and it's probably cygwin's fault, but I
haven't found any way to fix it so I' thought I would throw it out
here for comment.

I am using git 1.6.0.4 on cygwin. I have a repo where if any file has
changes and git detects as mode 100644 I get this error:
$git diff
      3 [main] git 2744 C:\cygwin\bin\git.exe: *** fatal error - could
not load user32, Win32 error

If I change the mode to 100755 git diff will work fine.
$chmod a+x test.cpp
$git diff
diff --git a/test.cpp b/test.cpp
old mode 100644
new mode 100755
index 7c0dfcd..20987a7
--- a/test.cpp
+++ b/test.cpp
@@ -6,9 +6,11 @@ int main()

 void func()
 {
+       int a;^M
 }

 void func2()
 {
+       int b;^M
 }

Anybody have a clue as to why this might occur?  I have seen this in
many of the repo's I use, but it is not repeatable.  I tried making a
test repo but could not reproduce.

Thanks!
Jeremy
