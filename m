From: Russell Steicke <russellsteicke@gmail.com>
Subject: [PATCH] [TopGit] Pretty print the help creation commands in Makefile.
Date: Wed, 6 Aug 2008 10:43:48 +0800
Message-ID: <20080806024348.GF11179@maggie.localnet>
Reply-To: Russell Steicke <russellsteicke@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 06 04:45:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQZ1I-0000Ct-S6
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 04:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757816AbYHFCn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 22:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757821AbYHFCn6
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 22:43:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:45141 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023AbYHFCn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 22:43:57 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2914025rvb.1
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 19:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:reply-to:mime-version:content-type:content-disposition
         :x-boo:x-message-flag:x-disclaimer:x-system:x-uptime:user-agent;
        bh=0Uojbe5GAm+CHiYDn7fV0lYOgDVeGqghVAfv7+Zbvkw=;
        b=hRBfDxVJ2FtYHOGoG5JEihq9tjV66eXe0x32chFNAPLOoZteZf7zd4G3In+5wiUEo7
         BurjnN+qOA3LqGmBAtC9O1PM/qEr4JsyOAGrTLlMP9G65T9Bvjxn0JjTCxNIcP765yHi
         N6Fy5iK4bUqCvqBBafQ3J/2x1c4czK/usc/+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-type:content-disposition:x-boo:x-message-flag:x-disclaimer
         :x-system:x-uptime:user-agent;
        b=QA34g1wnRaXFSOK3JmlVI0eVSVDLCwQjAR37iGZYaGw4ekoN4EzNGtZnC8ueEVhZka
         kF7ACbqIcLgvafIR136AaiwRI8upvSiu1nfNUEdO5cqlJCLsfYCNor+xLT37R6Sx+60d
         CQpOMtJq4iO+ilqnTccF33ys1sTLMOaj1T2lk=
Received: by 10.140.171.18 with SMTP id t18mr8601634rve.22.1217990636090;
        Tue, 05 Aug 2008 19:43:56 -0700 (PDT)
Received: from localhost ( [203.33.247.40])
        by mx.google.com with ESMTPS id c20sm10250627rvf.1.2008.08.05.19.43.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Aug 2008 19:43:55 -0700 (PDT)
Content-Disposition: inline
X-Boo: Boo!
X-message-flag: I see that you run Outlook...
X-Disclaimer: This message represents the official view of the voices in my head.
X-System: Linux maggie 2.6.18-6-powerpc64 
X-Uptime: 08:58:05 up 4 days, 15:17, 16 users,  load average: 4.74, 4.35, 3.89
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91475>

Print "[HELP] cmdname" while compiling the tg-cmdname.txt files.

Signed-off-by: Russell Steicke <russellsteicke@gmail.com>

---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 238d07d..2975f29 100644
--- a/Makefile
+++ b/Makefile
@@ -26,7 +26,9 @@ tg $(commands_out) $(hooks_out): % : %.sh
 	mv $@+ $@
 
 $(help_out): README
-	./create-help.sh `echo $@ | sed -e 's/tg-//' -e 's/\.txt//'`
+	@CMD=`echo $@ | sed -e 's/tg-//' -e 's/\.txt//'` && \
+	echo '[HELP]' $$CMD && \
+	./create-help.sh $$CMD
 
 install:: all
 	install tg "$(bindir)"
-- 
tg: (e311d15..) t/help2 (depends on: master)




-- 
Russell Steicke

-- Fortune says:
Today is the first day of the rest of your life.
