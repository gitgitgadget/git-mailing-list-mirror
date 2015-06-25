From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 07/17] engine.pl: Properly accept quoted spaces in filenames
Date: Thu, 25 Jun 2015 01:03:43 +0100
Message-ID: <1435190633-2208-8-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:20 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001JB-1m
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by lbiv13 with SMTP id v13sf16791761lbi.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=D7TlwwBux/myMJ+slYruPu3iaViFANoSHcfQ+m68fE4=;
        b=qCEs5SA+p9SIeZKU6TKpSfEruWXJy1N6LRGmkkmfEMQ0Tnd1t/u+lnrjXH0+U7GoXB
         anJYbkBK4fZjHAaz2iFgVVwz7D50LIsrgwV5YWovw+JIs3kdF0s9tcWeiuxTUIGvbUD3
         Z9qVvabHn1zAwLOZKAuOk2yHjU/8c3Hk0xCSNlQPCJyU357Kxe/xqAzbgjvoDp14y/4F
         S2FLShD/Pr815jMAU7LczbvU1/IAIfv7TT0z/+RJh5ERkG7J5zK50mF0ODvpAo/KhZ85
         cUWA/zdkJynU+wbWQpDMgO/706/GeWO+pgVpfRI+vLkOZkrweWgMOomdVeIBSTmKle6m
         4eww==
X-Received: by 10.180.23.74 with SMTP id k10mr2199wif.10.1435190530793;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.96.234 with SMTP id dv10ls1328585wib.35.canary; Wed, 24
 Jun 2015 17:02:10 -0700 (PDT)
X-Received: by 10.180.37.198 with SMTP id a6mr269503wik.7.1435190530183;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id t6si17968wiz.0.2015.06.24.17.02.10
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CYBwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/hCMBAQRWIxAISTkKFAYTiDPNagErkFAHhCsFlAWEWIh1ljyBCYMYPTGCSAEBAQ
X-IPAS-Result: A2CYBwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/hCMBAQRWIxAISTkKFAYTiDPNagErkFAHhCsFlAWEWIh1ljyBCYMYPTGCSAEBAQ
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366773"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:56 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272615>

The engine.pl script barfs on the properly quoted spaces in
filename options prevalent on Windows. Use shellwords() rather
than split() to separate such options.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
$gamane/21145 & $gmane/21147
---
 contrib/buildsystems/engine.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 4d0a616..ccb59fd 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -12,6 +12,7 @@ use File::Basename;
 use File::Spec;
 use Cwd;
 use Generators;
+use Text::ParseWords;
 
 my (%build_structure, %compile_options, @makedry);
 my $out_dir = getcwd();
@@ -231,7 +232,7 @@ sub removeDuplicates
 sub handleCompileLine
 {
     my ($line, $lineno) = @_;
-    my @parts = split(' ', $line);
+    my @parts = shellwords($line);
     my $sourcefile;
     shift(@parts); # ignore cmd
     while (my $part = shift @parts) {
@@ -265,7 +266,7 @@ sub handleLibLine
     my (@objfiles, @lflags, $libout, $part);
     # kill cmd and rm 'prefix'
     $line =~ s/^rm -f .* && .* rcs //;
-    my @parts = split(' ', $line);
+    my @parts = shellwords($line);
     while ($part = shift @parts) {
         if ($part =~ /^-/) {
             push(@lflags, $part);
@@ -306,7 +307,7 @@ sub handleLinkLine
 {
     my ($line, $lineno) = @_;
     my (@objfiles, @lflags, @libs, $appout, $part);
-    my @parts = split(' ', $line);
+    my @parts = shellwords($line);
     shift(@parts); # ignore cmd
     while ($part = shift @parts) {
         if ($part =~ /^-IGNORE/) {
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
