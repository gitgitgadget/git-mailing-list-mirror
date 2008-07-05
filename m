From: "Alexander N. Gavrilov" <angavrilov@gmail.com>
Subject: [PATCH] git-gui: Fix pre-commit hooks under MinGW/MSYS
Date: Sat, 5 Jul 2008 15:38:52 +0400
Organization: TEPKOM
Message-ID: <200807051538.53692.angavrilov@gmail.com>
Reply-To: ANGavrilov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Steffen Prohaska <prohaska@zib.de>
To: Shawn O. Pearce <spearce@spearce.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Jul 05 13:40:08 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.174])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF67b-0005O1-Rw
	for gcvm-msysgit@m.gmane.org; Sat, 05 Jul 2008 13:40:08 +0200
Received: by py-out-1314.google.com with SMTP id u10so4337434pyb.2
        for <gcvm-msysgit@m.gmane.org>; Sat, 05 Jul 2008 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:from
         :organization:to:subject:date:user-agent:cc:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=NSgwJHukkut+9ofbtmIDRVmfINaCgMVaqXTUpuxi+JI=;
        b=tHO2ejhEoymB62QAn11XN7vKbYehlKj6nMCclwR9I8Otue1QSeM1XAVfVN+hwOgjBW
         NTb8RBlhsTaBVb2/xlumxzs7OY/RrbZ2mJ3/Fhn4i8PJIvYSv4goReNhkjzvA7j3M1vL
         ZpaFkPSi/TCKVyZwOI8RfvKmu38b1xD03CAjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=BpbGkjv8fpO+phXM7MJoRcKvXaWem2fZnjd2eYLTPUSsPVgy/kbC2ACe7WPJCIZH4n
         mG6uEJ77HtNtOOfyFNgg9SJzhOZBlR6DEKa05zWPs946cRBkAlB4sOAtM0Amx7n44vKP
         m8754GJ18ggpHUxaorlPj0Mw6e/0mBMhTN1wM=
Received: by 10.141.186.1 with SMTP id n1mr170619rvp.27.1215257946031;
        Sat, 05 Jul 2008 04:39:06 -0700 (PDT)
Received: by 10.107.117.4 with SMTP id u4gr2619prm.0;
	Sat, 05 Jul 2008 04:39:06 -0700 (PDT)
X-Sender: angavrilov@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.78.10 with SMTP id a10mr3027309agb.12.1215257945093; Sat, 05 Jul 2008 04:39:05 -0700 (PDT)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159]) by mx.google.com with ESMTP id 22si1597247yxr.2.2008.07.05.04.39.03; Sat, 05 Jul 2008 04:39:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of angavrilov@gmail.com designates 72.14.220.159 as permitted sender) client-ip=72.14.220.159;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of angavrilov@gmail.com designates 72.14.220.159 as permitted sender) smtp.mail=angavrilov@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fg-out-1718.google.com with SMTP id 19so577527fgg.17 for <msysgit@googlegroups.com>; Sat, 05 Jul 2008 04:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:organization:to:subject :date:user-agent:cc:mime-version:content-disposition:content-type :content-transfer-encoding:message-id; bh=ll+u+F5xUZtwY3TPR0QbxeJJokjJ7zjq4a6FtLp5FiM=; b=m2FgotsfBECW+NruAIc8rdnyDQBkYdvrWyleWxtLNfzm0Q/VrixoJ5687K4UECk8Cj kSuBmfEUOJwj7La3nD9PiZ+Ydo7m74CDVYEQ/TsSvmKfiRgvFAK36rJlMif7KRMD+Oj9 vaNdYUX6J3A8t/pQiPraX4H9+C7MRGigUQDyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:organization:to:subject:date:user-agent:cc:mime-version :content-disposition:content-type:content-transfer-encoding :message-id; b=vW6+3OF9vKDE6oflmEU/vUY30rMAgCQ7g4nRD895fiMb5puEOqsL8uE4vF88Hx+TXM KbPyva0/i5hH6c/XHseOZfN10zuDx9mNTe0DebKERfZKetCYcdg7js1VcQ3Z2KDn5FAG cxSyr+xMUhrluF3OZz6YBrFOeZi9M+EbkYiS8=
Received: by 10.86.57.9 with SMTP id f9mr1915293fga.66.1215257943207; Sat, 05 Jul 2008 04:39:03 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130]) by mx.google.com with ESMTPS id 4sm1959821fgg.9.2008.07.05.04.39.00 (version=SSLv3 cipher=RC4-MD5); Sat, 05 Jul 2008 04:39:01 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87442>


From: Alexander Gavrilov <angavrilov@gmail.com>

Apply the work-around for checking the executable
permission of hook files not only on Cygwin, but on
Windows in general.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
	This is a fix for msysgit issue #118.
	(http://code.google.com/p/msysgit/issues/detail?id=118)

	It may be possible to fix this in a better way, e.g. perhaps assume
	that if the hook exists on Windows, then it's executable (msysgit
	uses renaming to disable hooks), or at least check existance
	before running the shell, but I don't know enough Tcl to do it.

	-- Alexander

 git-gui.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index e6e8890..2d14bf2 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -473,10 +473,10 @@ proc githook_read {hook_name args} {
 	set pchook [gitdir hooks $hook_name]
 	lappend args 2>@1
 
-	# On Cygwin [file executable] might lie so we need to ask
+	# On Windows [file executable] might lie so we need to ask
 	# the shell if the hook is executable.  Yes that's annoying.
 	#
-	if {[is_Cygwin]} {
+	if {[is_Windows]} {
 		upvar #0 _sh interp
 		if {![info exists interp]} {
 			set interp [_which sh]
-- 
1.5.3.3
