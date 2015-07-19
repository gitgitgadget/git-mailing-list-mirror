From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 00/16] Make the msvc-build scripts work again
Date: Sun, 19 Jul 2015 21:08:00 +0100
Message-ID: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBZEGWCWQKGQEPLBURXY@googlegroups.com Sun Jul 19 22:07:01 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBZEGWCWQKGQEPLBURXY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f187.google.com ([209.85.212.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBZEGWCWQKGQEPLBURXY@googlegroups.com>)
	id 1ZGurV-0002GQ-Kj
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:01 +0200
Received: by wicmv11 with SMTP id mv11sf137583wic.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=twy5aki6hKv+E+iP/cPLLz7UOFXrVA0ocWlJHXnS1As=;
        b=QAB3sSm+ZsKlTb1Ym58F08SKcspnTsHgwJTe8aqA2wij4RcGTrG6sMr5/c5fL4sFyP
         obc+uuwt6VCiUCxe4kjJdYgHNQhLBQ60Abi3vmF579BjqjBNbntHQdrliX3ceUTXJQ5b
         Qp0Qd/w38dKpAwyZiaw60g0adZylkaptflWbAoGCz+hajJP94+A3zBSv724y/kpCeY3Y
         ZJYcme7dyHWMtDOjc5TizantpgaO/8rX+4p7tBapbt1lpBO/k4dGubjX7VagVQt7LaLA
         cTXLiIoz0pcWYCd8L0IsuQKEc+/MdA5GFmosn/7WTRO5kaicb2FAgK6z/HbYqCGLd6pU
         u/IQ==
X-Received: by 10.152.29.37 with SMTP id g5mr372759lah.30.1437336421001;
        Sun, 19 Jul 2015 13:07:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.227 with SMTP id n3ls739467lan.0.gmail; Sun, 19 Jul 2015
 13:06:59 -0700 (PDT)
X-Received: by 10.112.98.42 with SMTP id ef10mr13119338lbb.18.1437336419450;
        Sun, 19 Jul 2015 13:06:59 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.06.58
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:06:59 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2D1IQCSAqxVPN4GFlxcgkFRAQFTabtlCYFmEYVvBAKBHDkUAQEBAQEBAQYBAQEBQAE/hE0ECwEjHgUYHQImAjsKBgETiEUJryODXZFfASuBIokohgiCb4FDBYVghliIGoRviTuWfoEJgSocgVQ9MYJLAQEB
X-IPAS-Result: A2D1IQCSAqxVPN4GFlxcgkFRAQFTabtlCYFmEYVvBAKBHDkUAQEBAQEBAQYBAQEBQAE/hE0ECwEjHgUYHQImAjsKBgETiEUJryODXZFfASuBIokohgiCb4FDBYVghliIGoRviTuWfoEJgSocgVQ9MYJLAQEB
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118923"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:06:59 +0100
X-Mailer: git-send-email 2.3.1
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.238 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274277>

This updated series fixes the scripts which generated Visual Studio project
files. The scripts had bit rotted over the years as other commits
changed the git makefile which it post-processes.

The series doesn't attempt (yet) to install the Visual Studio compiled product
but allows Windows developers familiar with VS to support the Windows SDK
port of Git.

The fixes are presented in a fine grained manner.

The key change in this series is that the failure of using the git/Makefile
for a clean dry-run has been identified in perl/Makefile. The new fix replaces
two previous hack patches.

Grammatical corrections and other comments have all been included. In
particular the use of deactivated code is now better explained. The false
mode change has also been fixed (from using 'git gui', who's unstage/re-stage
action on Windows with its core.filemode=false loses the 'x' bit).

The previous patch series was not picked up on $gmane, but is available
at http://marc.info/?t=143519065200003&r=1&w=2 (2015-06-25)

Older patch series were at:
 $gmane/21132 (2014-11-20),
 $gmane/21207 (2014-12-26),
 and on Msysgit list (2015-02-23) at
 https://groups.google.com/forum/?hl=en_US?hl%3Den#!topic/msysgit/aiEVBKjRshY
 and as a PR https://github.com/msysgit/git/pull/318/files


Philip Oakley (16):
  perl/Makefile: treat a missing PM.stamp as if empty
  .gitignore: improve MSVC ignore patterns
  .gitignore: ignore library directories created by MSVC VS2008
    buildsystem
  (msvc-build) Vcproj.pm: remove duplicate GUID
  engine.pl: fix error message (lib->link)
  engine.pl: Properly accept quoted spaces in filenames
  engine.pl: Fix i18n -o option in msvc buildsystem generator
  engine.pl: ignore invalidcontinue.obj which is known to MSVC
  engine.pl: name the msvc buildsystem's makedry error file
  engine.pl: delete the captured stderr file if empty
  engine.pl: add debug line to capture the dry-run
  engine.pl: provide more debug print statements
  Vcproj.pm: list git.exe first to be startup project
  vcbuild/readme: Improve layout
  msvc-build: add complete Microsoft Visual C compilation script
  config.mak.uname: add MSVC No_SafeExeceptionHandler option

 .gitignore                                |  8 ++-
 compat/vcbuild/README                     | 27 +++++++---
 compat/vcbuild/scripts/msvc-build         | 86 +++++++++++++++++++++++++++++++
 config.mak.uname                          |  9 ++++
 contrib/buildsystems/Generators/Vcproj.pm | 34 ++++++------
 contrib/buildsystems/engine.pl            | 37 ++++++++++---
 perl/Makefile                             |  2 +
 7 files changed, 170 insertions(+), 33 deletions(-)
 create mode 100755 compat/vcbuild/scripts/msvc-build

-- 
2.4.2.windows.1.5.gd32afb6

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
