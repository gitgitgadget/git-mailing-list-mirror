From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] git-gui (Win): make "Explore Working Copy" more
 robust
Date: Wed, 1 Apr 2009 01:55:36 +0200
Message-ID: <200904010155.37318.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Shawn O. Pearce <spearce@spearce.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Apr 01 01:57:20 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f191.google.com ([209.85.217.191])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LonpY-00083q-3u
	for gcvm-msysgit@m.gmane.org; Wed, 01 Apr 2009 01:57:20 +0200
Received: by gxk11 with SMTP id 11so937214gxk.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 31 Mar 2009 16:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:reply-to:to:subject:date:user-agent:cc:jabber-id
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:x-sender:x-provags-id:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=yRUAaSbqUqq5Z97P9EGyzKPVGT990X+uR70R3S1DmiY=;
        b=xuo67+BhSWMccVKaYmRujoL33ZUAIMdDppheoZDu/pDXJXTetXNLcP3te8sozynkdt
         b9z23DvuEMeGq+q6HEDjyaIF5vfoMOH4AVYflv1xWZ343gYLncvozesTU50SNE9cJfJF
         RzNX01/0SsUoKHVgsTPD5yJ7M0uxlCgIeDmiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :reply-to:to:subject:date:user-agent:cc:jabber-id:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:x-provags-id:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=hoMqevbgaP8qYNWTmS3AmW9bMJ6oAmGNa5laCRx7EVap7IRYyO38zHWNSXyd77bOaN
         ZcfDZ6avcQ7xoW9DWFBgmB419w16GFDjxLkGkz4wKhyggDLaBP71ZBzo7Atr9ObxKj8p
         RYiS9LpMKD20v0buIRGK/jp1ED/P93s1XhALw=
Received: by 10.90.106.4 with SMTP id e4mr137482agc.22.1238543735038;
        Tue, 31 Mar 2009 16:55:35 -0700 (PDT)
Received: by 10.177.113.42 with SMTP id q42gr4582yqm.0;
	Tue, 31 Mar 2009 16:55:35 -0700 (PDT)
X-Sender: markus.heidelberg@web.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.75.13 with SMTP id x13mr123958aga.21.1238543733477; Tue, 31 Mar 2009 16:55:33 -0700 (PDT)
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234]) by gmr-mx.google.com with ESMTP id 15si716983gxk.0.2009.03.31.16.55.33; Tue, 31 Mar 2009 16:55:33 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of markus.heidelberg@web.de designates 217.72.192.234 as permitted sender) client-ip=217.72.192.234;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: best guess record for domain of markus.heidelberg@web.de designates 217.72.192.234 as permitted sender) smtp.mail=markus.heidelberg@web.de
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215]) by fmmailgate03.web.de (Postfix) with ESMTP id C8BA7F9CEE04; Wed,  1 Apr 2009 01:55:32 +0200 (CEST)
Received: from [89.59.106.150] (helo=.) by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256) (WEB.DE 4.110 #277) id 1Lonno-0001c8-00; Wed, 01 Apr 2009 01:55:32 +0200
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/+XmPYO7ZYgZvuPSGtSvHNw7t3ZKQ3wxDZERCz gv2YXJLIhs0WE1VhtWiR6LMMDa4FsdUd4tUzuMBAXfM6jhlBGL 6SX/sI2OORMwWXiJHq9A==
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115332>


Starting the Explorer from the git-gui menu "Explore Working Copy"
didn't work, when git-gui was started via Windows Explorer shell
extension (Git GUI Here) from a directory within the project.
The Explorer raised an error message like this:

    Path "C:/somedir/worktree" is not available or not a directory

It worked when started from the project directory itself, because then
the path argument for the Explorer was just '.' (current directory)
without any problematic forward slashes.

To make it work, convert the path given as argument to explorer.exe to
its native format with backslashes.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

Now this is the real location of the problem in contrast of the
workaround attempt from 2 days before.
I've also tested this change with xdg-open.

 git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index b3aa732..712fe27 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1924,7 +1924,7 @@ proc do_explore {} {
 		# freedesktop.org-conforming system is our best shot
 		set explorer "xdg-open"
 	}
-	eval exec $explorer [file dirname [gitdir]] &
+	eval exec $explorer [list [file nativename [file dirname [gitdir]]]] &
 }
 
 set is_quitting 0
-- 
1.6.2.1.428.g41b20c
