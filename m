From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] log doc: the argument to --encoding is not optional
Date: Fri, 2 Aug 2013 15:16:40 -0700
Message-ID: <20130802221640.GA7478@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 00:16:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5NeY-00089d-2i
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 00:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570Ab3HBWQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 18:16:49 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49512 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab3HBWQs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 18:16:48 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so1123588pab.39
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 15:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=gfN3wq9xsm/6R1e3PEOpDVqHDhZdWh+zC85+b+HOpgk=;
        b=LNbTAfkqG2jX4fKiJFAA9zqKw0H2LKTrS/kiYRHaJu/tdPEhfY5F2uO/0204xZALQa
         WyxkwU0z0BK1VCa0rQuOxZ99yzRh8kBj4qBuw/rJgTnY2lhuULayBrWggaLxyEmYjhk5
         LXtj7fJbOCzH1R2+ABlOLe+ujJL/OyFyVYUv4P0ORxDzNBHsjRm0T/u3JYQVR0NTmnQR
         raETBhv0muMfyfESvaJwy9RbxPYij66YZDkncXPQy2MiUMvGdP2dl7dl/gWX23v17I0y
         C9D28hSWCLpH4+FVGmFT3zTEE1rJjiL/jldiqsePUI69F+ZjlNS44BrL+KmZZeARFxd6
         b8ng==
X-Received: by 10.67.21.229 with SMTP id hn5mr12764335pad.135.1375481807960;
        Fri, 02 Aug 2013 15:16:47 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id qh10sm12390147pbb.33.2013.08.02.15.16.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 15:16:47 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231540>

 $ git log --encoding
 fatal: Option '--encoding' requires a value
 $ git rev-list --encoding
 fatal: Option '--encoding' requires a value

The argument to --encoding has always been mandatory.  Unfortunately
manpages like git-rev-list(1), git-log(1), and git-show(1) have
described the option's syntax as "--encoding[=<encoding>]" since it
was first documented.  Clarify by removing the extra brackets.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-rev-list.txt   | 2 +-
 Documentation/pretty-options.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 65ac27e0..045b37b8 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -40,7 +40,7 @@ SYNOPSIS
 	     [ \--right-only ]
 	     [ \--cherry-mark ]
 	     [ \--cherry-pick ]
-	     [ \--encoding[=<encoding>] ]
+	     [ \--encoding=<encoding> ]
 	     [ \--(author|committer|grep)=<pattern> ]
 	     [ \--regexp-ignore-case | -i ]
 	     [ \--extended-regexp | -E ]
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 5e499421..eea0e306 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -28,7 +28,7 @@ people using 80-column terminals.
 	This is a shorthand for "--pretty=oneline --abbrev-commit"
 	used together.
 
---encoding[=<encoding>]::
+--encoding=<encoding>::
 	The commit objects record the encoding used for the log message
 	in their encoding header; this option can be used to tell the
 	command to re-code the commit log message in the encoding
-- 
1.8.4.rc1
