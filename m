From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/9] Documentation: git fmt-merge-message is not a script
Date: Fri, 9 Oct 2009 05:16:15 -0500
Message-ID: <20091009101615.GB16558@progeny.tock>
References: <20091009101400.GA16549@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:14:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwCUr-0002is-4V
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760582AbZJIKIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760569AbZJIKIk
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:08:40 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:55293 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760564AbZJIKIj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 06:08:39 -0400
Received: by ywh6 with SMTP id 6so6098600ywh.4
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9/cn1gZh6Zqx8Ll5zPzf7HI4TDH++qMBE0zluXF2QYg=;
        b=C0d22v3BAEWmk+BibGahTWkR7N9+7LcvUBqJNUzo/KymTNcV1W9diIcgAikJzebxwE
         NEpr5gVuFju6rxAZM3I5Cr1vbRlE6ghEq3biu1MV+guRaZIx2pJe5GR14bFn7wrFmg/F
         4BRO29eGvrcJnu9Eh42u7f0QpKziK9lM4b590=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=loVeXXj1MYtT9TpHiXJVG22KtpvG8+jrZoEMoYFRsC1su+ybErht789+iA0q9TJuc7
         gBy3X1Z1BxwHPVl1zujr8Dv03Xiycw5NMl7WwE5i/MMPlhePZbImRVtaKBaozBCcmnNi
         HckRunah92Jz/98FyFnmXIsK9gWOUswP88gMI=
Received: by 10.150.87.4 with SMTP id k4mr4312695ybb.347.1255082883346;
        Fri, 09 Oct 2009 03:08:03 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm445505gxk.15.2009.10.09.03.08.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 03:08:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009101400.GA16549@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129759>

The fmt-merge-message builtin is usually invoked as
"git fmt-merge-message" rather than through the hard link in
GIT_EXEC_PATH.  Although this is unlikely to confuse most script
writers, it should not hurt to make the documentation a little
clearer anyway.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fmt-merge-msg.txt |    2 +-
 Documentation/git-merge.txt         |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 1c24796..0067805 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -18,7 +18,7 @@ Takes the list of merged objects on stdin and produces a suitable
 commit message to be used for the merge commit, usually to be
 passed as the '<merge-message>' argument of 'git-merge'.
 
-This script is intended mostly for internal use by scripts
+This command is intended mostly for internal use by scripts
 automatically invoking 'git-merge'.
 
 OPTIONS
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index af68d69..354e9d9 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -28,9 +28,10 @@ OPTIONS
 include::merge-options.txt[]
 
 -m <msg>::
-	The commit message to be used for the merge commit (in case
-	it is created). The 'git-fmt-merge-msg' script can be used
-	to give a good default for automated 'git-merge' invocations.
+	Set the commit message to be used for the merge commit (in
+	case one is created). The 'fmt-merge-msg' Git command can be
+	used to give a good default for automated 'git-merge'
+	invocations.
 
 <remote>...::
 	Other branch heads to merge into our branch.  You need at
-- 
1.6.5.rc1.199.g596ec
