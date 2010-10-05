From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] On Windows, avoid git-gui to call Cygwin's nice utility
Date: Tue, 5 Oct 2010 11:12:00 +0200
Message-ID: <AANLkTik4WdEcfQCGETJ6VQs=fj0DLr1DA+5JQCXqYpUP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pat Thoyts <patthoyts@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: msysGit Mailinglist <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
X-From: msysgit+bncCPLFkNe0FhDj16vlBBoEmn0M8w@googlegroups.com Tue Oct 05 11:12:28 2010
Return-path: <msysgit+bncCPLFkNe0FhDj16vlBBoEmn0M8w@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qw0-f58.google.com ([209.85.216.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCPLFkNe0FhDj16vlBBoEmn0M8w@googlegroups.com>)
	id 1P33ZT-0006E5-8J
	for gcvm-msysgit@m.gmane.org; Tue, 05 Oct 2010 11:12:27 +0200
Received: by qwd6 with SMTP id 6sf13936448qwd.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 05 Oct 2010 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:received:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=EncHufIQ3LFUfc2F3btjhrHtugCQOZ0QH2zzyzNEmlk=;
        b=kZv3uQ/EcZa7pMpPjLkFjgq+g9MNG0Ox07AsjuQmros2ASSjtEGLUNHEl+fz+Bv1p+
         sgcEfwjHgxWsH/mlExTpc+PdHZfOEs9kslRjLnt7sh+ME9OVyUbc1LQlDIowL4QZ6PhG
         hFYHQB3tz5aSa+RC8Jj5eNBPkmIvJvCVU6W+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:date:message-id:subject:from
         :to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        b=S+istahXuDpha6uG9zKgui7SwsGRRXu7wabkUEkWu+433nbd9Nhj2iTxoA5ALArnOL
         nByxGehFtsd1pj8z3pA/XgTvsgnwmxIY/NUW/XV7s6TBIkfpq6JUxKQbeZiE5v26PdHR
         Pzd5+u8NYLiwZbyctH5yjgS3iZdJy7Zr3IHd0=
Received: by 10.229.2.132 with SMTP id 4mr865383qcj.0.1286269923081;
        Tue, 05 Oct 2010 02:12:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.229.177.9 with SMTP id bg9ls1282462qcb.1.p; Tue, 05 Oct 2010
 02:12:02 -0700 (PDT)
Received: by 10.229.248.6 with SMTP id me6mr3046143qcb.2.1286269922286;
        Tue, 05 Oct 2010 02:12:02 -0700 (PDT)
Received: by 10.229.248.6 with SMTP id me6mr3046142qcb.2.1286269922230;
        Tue, 05 Oct 2010 02:12:02 -0700 (PDT)
Received: from mail-qy0-f177.google.com (mail-qy0-f177.google.com [209.85.216.177])
        by gmr-mx.google.com with ESMTP id 2si3372217qci.10.2010.10.05.02.12.01;
        Tue, 05 Oct 2010 02:12:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 209.85.216.177 as permitted sender) client-ip=209.85.216.177;
Received: by qyk29 with SMTP id 29so3712873qyk.1
        for <msysgit@googlegroups.com>; Tue, 05 Oct 2010 02:12:01 -0700 (PDT)
Received: by 10.229.185.137 with SMTP id co9mr8063702qcb.189.1286269920479;
 Tue, 05 Oct 2010 02:12:00 -0700 (PDT)
Received: by 10.229.230.77 with HTTP; Tue, 5 Oct 2010 02:11:59 -0700 (PDT)
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of sschuberth@gmail.com designates 209.85.216.177 as permitted sender)
 smtp.mail=sschuberth@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158179>

It's a common case for Windows developers to have both Cygwin and msysGit
installed. Unfortunately, some scenarios also require to have Cygwin in PATH.
By default, Cygwin comes with nice.exe, while msysGit does not. Since git-gui
calls nice if it is in PATH, this results in Cygwin's nice.exe being called
from msysGit's git-gui. Mixing Cygwin and msysGit generally is not a good idea,
and in this particular case it causes differences not being correctly detected.
So we only call nice.exe on Windows if it is in the same directory as git.exe.
This way, this work-around does neither affect a pure Cygwin environment, or
the case when nice.exe will be shipped with msysGit at some point in time.

This fixes msysGit issue 394.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-gui/git-gui.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 3c9a8aa..288ec87 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -444,6 +444,8 @@ proc _lappend_nice {cmd_var} {
 		set _nice [_which nice]
 		if {[catch {exec $_nice git version}]} {
 			set _nice {}
+		} elseif {[is_Windows] && [file dirname $_nice] != [file dirname $::_git]} {
+			set _nice {}
 		}
 	}
 	if {$_nice ne {}} {
-- 
1.7.2.3.msysgit.6
