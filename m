From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 00/17] Make the msvc-build scripts work again
Date: Thu, 25 Jun 2015 01:03:36 +0100
Message-ID: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:16 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001JO-71
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by wggz12 with SMTP id z12sf16836954wgg.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=RbgEESZ1bhrgr8NAMxYz8Mc7XxusYmoXlrEk1yax0Kk=;
        b=SqC0hCsgeynu/EIVjACh0yep3+D7wWVENrYXvA9Ubt+ugp0S8Yn6f7JChYqLkdr7Gb
         nAAOnnAPWNevHJLklx6YQsa5OE0Udncelbkq5/xlogYngydFP7ZcQhnCd/SzZgac1u6+
         hrJzZLePaL2W/n8Lp3iaBbswylseUN2RxwJA3lpI3IX+IBTo3FKOM89ToiT36Y510QhE
         OrtcE0q9Wgrt12nIZjgcmbTzh2lIPxqToErmLAtZB/olDbpLJnuvdgczYaB3AwDzV+T3
         3Gzvkc3jV2TtMXU0vuoRUritDsCG1/LAM7tzuFzaRrQFsx0VgakiX1xZmm/2UlnrQwVc
         SPHg==
X-Received: by 10.152.5.100 with SMTP id r4mr566409lar.13.1435190530850;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.8.201 with SMTP id t9ls256874laa.95.gmail; Wed, 24 Jun
 2015 17:02:09 -0700 (PDT)
X-Received: by 10.152.179.136 with SMTP id dg8mr1572257lac.4.1435190529629;
        Wed, 24 Jun 2015 17:02:09 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id da3si4921wib.1.2015.06.24.17.02.09
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:09 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2ByGACSRItVPCWpEVxbgxABAVNfgx6FBrBAhgsRhXAEAoFOTQEBAQEBAQcBAQEBQT+ETAQLASMjGB0CJgI7CgYBE4hGCbctljQBK4Ehjy+Cb4FDBYVahjmHcoRYiHWWPIEJgSkcgVM9MYJIAQEB
X-IPAS-Result: A2ByGACSRItVPCWpEVxbgxABAVNfgx6FBrBAhgsRhXAEAoFOTQEBAQEBAQcBAQEBQT+ETAQLASMjGB0CJgI7CgYBE4hGCbctljQBK4Ehjy+Cb4FDBYVahjmHcoRYiHWWPIEJgSkcgVM9MYJIAQEB
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366752"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:52 +0100
X-Mailer: git-send-email 2.3.1
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.237 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272623>

This series fixes the scripts which generated Visual Studio project
files. The scripts had bit rotted over the years as other commits
changed the git makefile which it post processed.

The series doesn't attempt to install the Visual Studio compiled product
but allows Windows developers familiar with VS to support the Windows SDK
port of Git.

The fixes are presented in a fine grained manner.

A previous patch series were at $gmane/21132 (2014-11-20), $gmane/21207
(2014-12-26), and on Msysgit list (2015-02-23)
 https://groups.google.com/forum/?hl=en_US?hl%3Den#!topic/msysgit/aiEVBKjRshY
 https://github.com/msysgit/git/pull/318/files

Hopefully it's not too late in the cycle for a review of this contrib/compat
item.

Philip Oakley (17):
  .gitignore: improve MSVC ignore patterns
  .gitignore: ignore library directories created by MSVC VS2008
    buildsystem
  (msvc-build) Vcproj.pm: remove duplicate GUID
  Makefile: a dry-run can error out if no perl. Document the issue
  engine.pl: fix error message (lib->link)
  engine.pl: Avoid complications with perl support
  engine.pl: Properly accept quoted spaces in filenames
  engine.pl: Fix i18n -o option in msvc buildsystem generator
  engine.pl: ignore invalidcontinue.obj which is known to MSVC
  engine.pl: name the msvc buildsystem's makedry error file
  engine.pl: delete the captured stderr file if empty
  engine.pl: add debug line to capture the dry-run
  engine.pl: provide more debug print statements
  Vcproj.pm: list git.exe first to be startup project
  vcbuild/readme: Improve layout and reference msvc-build script
  msvc-build: add complete Microsoft Visual C compilation script
  config.mak.uname: add MSVC No_SafeExeceptionHandler option

 .gitignore                                |  8 ++-
 Makefile                                  |  3 ++
 compat/vcbuild/README                     | 27 +++++++---
 compat/vcbuild/scripts/msvc-build         | 89 +++++++++++++++++++++++++++++++
 config.mak.uname                          |  9 ++++
 contrib/buildsystems/Generators/Vcproj.pm | 34 ++++++------
 contrib/buildsystems/engine.pl            | 37 ++++++++++---
 7 files changed, 174 insertions(+), 33 deletions(-)
 create mode 100644 compat/vcbuild/scripts/msvc-build
 mode change 100755 => 100644 contrib/buildsystems/engine.pl

-- 
2.3.1

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
