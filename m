From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 16/17] msvc-build: add complete Microsoft Visual C
 compilation script
Date: Thu, 25 Jun 2015 01:03:52 +0100
Message-ID: <1435190633-2208-17-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBA4KVWWAKGQE2AJN6UQ@googlegroups.com Thu Jun 25 02:02:20 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBA4KVWWAKGQE2AJN6UQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBA4KVWWAKGQE2AJN6UQ@googlegroups.com>)
	id 1Z7ucN-0001KT-IX
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by lbiv13 with SMTP id v13sf16788099lbi.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=wVAATf7TKohWHzFLocR4fray5pbdqNZDTeuyYCYL8aY=;
        b=P4gDYDMV4TywgQ10p1jFcb6kPcRzesfuChwL4ijj9aNQu9KN5gxh8H/Fuo73IJg5ZN
         kqBYFvNZs7a9QQ88KfeC2wkFDhhbt0N5SRCyNUvtNAVn2rj0DlyRy+t79aSh+s18xVaW
         KByQF42j6cBW9vFttV5MRTscHEfVV5DuXQlO01O9T8eTc3eojf+1Clr0z2p5Rft4KMxv
         Mrrtsdn2RmbxWoT4aLrC4yu2hs9zfajgwF5FUlb673977jWv5JzOaXkqLDUa0Q9Aizpw
         oVBzxsSBAqrMeQFeHJbs6bVVm1gD0NPdhCNhxXBjJzrh5N18Gt2fSUPW0kCnl0oPktVK
         ci2A==
X-Received: by 10.180.19.69 with SMTP id c5mr2437wie.2.1435190531288;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.92.34 with SMTP id cj2ls1318051wib.1.canary; Wed, 24 Jun
 2015 17:02:10 -0700 (PDT)
X-Received: by 10.180.182.110 with SMTP id ed14mr275133wic.5.1435190530600;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id t6si17968wiz.0.2015.06.24.17.02.10
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CYBwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/hCMBAQRWIxAISTkKBgENBhMUiB/NagEBCCKPZAdlB4QrBYVahjmFFYJdhFiIdZY8gQmDGD0xgQOBRQEBAQ
X-IPAS-Result: A2CYBwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/hCMBAQRWIxAISTkKBgENBhMUiB/NagEBCCKPZAdlB4QrBYVahjmFFYJdhFiIdZY8gQmDGD0xgQOBRQEBAQ
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366785"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:02:01 +0100
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272622>

Implement the README to facilitate cross community development.
Include comments for those Windows folks not yet fully familiar
with bash commands.

This is identical to the msysgit script, except for the 'cd toplevel'
step, and comments for the edification of converts from Windows.
Original author: Johannes Schindelin (2011-11-01 3142da4 : Add a script
to make the MSVC build more convenient).

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

TODO:
Also resolve the cleaning of newer VS2010 products.
---
 compat/vcbuild/README             |  2 +-
 compat/vcbuild/scripts/msvc-build | 89 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 compat/vcbuild/scripts/msvc-build

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index 7548dc4..faaea69 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -58,4 +58,4 @@ The Steps of Build Git with VS2008
 
 Done!
 
-Or, use the Msysgit msvc-build script; available from that project.
+Or, use the msvc-build script; available from /compat/vcbuild/scripts/.
diff --git a/compat/vcbuild/scripts/msvc-build b/compat/vcbuild/scripts/msvc-build
new file mode 100644
index 0000000..52b925d
--- /dev/null
+++ b/compat/vcbuild/scripts/msvc-build
@@ -0,0 +1,89 @@
+#!/bin/sh
+
+# This msvc-build command should be executed from the msysgit directory level
+# This is so that the 'cd/git' step works and the subequent operations have the right msysgit super directory.
+set -e # Exit immediately if a command exits with a nonzero exit status.
+
+gui=
+clean=
+while test $# -gt 0
+do
+	case "$1" in
+	--gui|--dev|--devenv|--vs|--visual-studio)
+		gui=t
+		;;
+	clean)
+		clean=t
+		;;
+	*)
+		echo "Usage: $0 [--vs] [clean]" >&2
+		exit 1
+		;;
+	esac
+	shift
+done
+
+cd $(git rev-parse --show-toplevel)
+
+case "$clean" in
+t)
+	case "$gui" in
+	t)
+		rm -rf git.sln libgit
+		# remove all the new VS2010 stuff as well
+		# rm -rf git.sdf
+		;;
+	'')
+		make clean
+		# surely needs "make clean MSVC=1"
+		# otherwise it could assume the wrong make products [MinGW vs Windows].
+		;;
+	esac
+	exit
+	;;
+esac
+
+to_ignore="$(git ls-files --other --exclude-standard msvcgit msvc-build.cmd)"
+test -z "$to_ignore" || {
+	mkdir -p .git/info &&
+	echo "$to_ignore" |
+	sed 's/^/\//' >> .git/info/exclude
+} || exit
+
+test -d msvcgit || git clone git://repo.or.cz/msvcgit.git
+
+vsvars=
+# assume cl.exe will populate its relevant environment variables
+# if cl.exe does not exist, populate vsvars with the most recent Visual Studio path
+type cl.exe 2> /dev/null ||
+vsvars="$(ls -t \
+	"$PROGRAMFILES/Microsoft Visual Studio"*/Common7/Tools/vsvars32.bat |
+	head -n 1)"
+
+
+config_mak=
+# if a config.mak file (dot, not underscore) exists, back it up,
+# remember the backup file name in config_mak.
+test -f config.mak &&
+config_mak=config.mak.bup.$$ &&
+mv config.mak $config_mak
+
+cat > config.mak << EOF
+CFLAGS += -Imsvcgit/32bits/include
+LDFLAGS += -Lmsvcgit/32bits/lib
+EOF
+
+echo "call \"$vsvars\"" > msvc-build.cmd
+if test -z "$gui"
+then
+	echo 'make MSVC=1' >> msvc-build.cmd
+else
+	echo 'perl contrib/buildsystems/generate -g Vcproj' >> msvc-build.cmd
+	echo 'start git.sln' >> msvc-build.cmd
+fi
+
+cmd /c msvc-build.cmd
+
+# if we made a backup file (name in config_mak), then restore it.
+test -z "$config_mak" ||
+mv $config_mak config.mak
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
