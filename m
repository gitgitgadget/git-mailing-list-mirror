From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3] send-email: recognize absolute path on Windows
Date: Wed, 16 Apr 2014 10:08:18 +0200
Message-ID: <1397635698-6252-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	johannes.schindelin@gmx.de,
	j.sixt@viscovery.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRB37UXCNAKGQEEZS4VYQ@googlegroups.com Wed Apr 16 10:08:18 2014
Return-path: <msysgit+bncBDR53PPJ7YHRB37UXCNAKGQEEZS4VYQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f56.google.com ([74.125.83.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB37UXCNAKGQEEZS4VYQ@googlegroups.com>)
	id 1WaKtE-0002yf-DO
	for gcvm-msysgit@m.gmane.org; Wed, 16 Apr 2014 10:08:16 +0200
Received: by mail-ee0-f56.google.com with SMTP id c13sf829197eek.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Apr 2014 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=tYqtkQWINqfQwh5vAJDSz15hWU+Xmih1Trmo5CBhApw=;
        b=qd20JpqCQi2+YCBxu64uOOCaaRvJBjrN9yXnIwx7A6vU38wUfNrHYWNIX5+TQxUDho
         V6b6aFVoQLYaCD4zHsw03tJ61/Km+mK9OqChl8q+6ZVr/7/JtGxJc52ZB1c/AHowuNoq
         VYVHcWyzPBhQWdTDc3p2oMyIUEzwZzdSR61i/pudqwqA0HMLNRR9ASYJWenrwjjtj/Qq
         O78IEU3oh30ODdy0SQswTuE36pGrQQNFkAhLGwIF3KGBBbiGE3VUDelwk8GqtbBAhqad
         9ROuztj254uImwS+cK9U0nSTFknhWqxzL0JXGowOS2vn+gW5rxLDNp/nw1YYZnOM7izj
         dX8w==
X-Received: by 10.152.115.133 with SMTP id jo5mr3134lab.36.1397635696137;
        Wed, 16 Apr 2014 01:08:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.37.97 with SMTP id x1ls93962laj.34.gmail; Wed, 16 Apr 2014
 01:08:14 -0700 (PDT)
X-Received: by 10.112.56.138 with SMTP id a10mr117662lbq.14.1397635694672;
        Wed, 16 Apr 2014 01:08:14 -0700 (PDT)
Received: from mail-ee0-x22b.google.com (mail-ee0-x22b.google.com [2a00:1450:4013:c00::22b])
        by gmr-mx.google.com with ESMTPS id m49si65135eeu.0.2014.04.16.01.08.14
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 01:08:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2a00:1450:4013:c00::22b as permitted sender) client-ip=2a00:1450:4013:c00::22b;
Received: by mail-ee0-x22b.google.com with SMTP id e53so8526435eek.30
        for <msysgit@googlegroups.com>; Wed, 16 Apr 2014 01:08:14 -0700 (PDT)
X-Received: by 10.14.225.132 with SMTP id z4mr3223934eep.92.1397635694597;
        Wed, 16 Apr 2014 01:08:14 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPSA id q49sm55723571eem.34.2014.04.16.01.08.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 01:08:13 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.msysgit.0
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2a00:1450:4013:c00::22b
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246316>

From: Erik Faye-Lund <kusmabite@googlemail.com>

On Windows, absolute paths might start with a DOS drive prefix,
which these two checks failed to recognize.

Unfortunately, we cannot simply use the file_name_is_absolute
helper in File::Spec::Functions, because Git for Windows has an
MSYS-based Perl, where this helper doesn't grok DOS
drive-prefixes.

So let's manually check for these in that case, and fall back to
the File::Spec-helper on other platforms (e.g Win32 with native
Perl)

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

So here's a version that does the old and long-time tested
approach without requiring breaking changes to msysGit's perl.

 git-send-email.perl | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fdb0029..8f5f986 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1113,6 +1113,18 @@ sub ssl_verify_params {
 	}
 }
 
+sub file_name_is_absolute {
+	my ($path) = @_;
+
+	# msys does not grok DOS drive-prefixes
+	if ($^O eq 'msys') {
+		return ($path =~ m#^/# || $path =~ m#[a-zA-Z]\:#)
+	}
+
+	require File::Spec::Functions;
+	return File::Spec::Functions::file_name_is_absolute($path);
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -1197,7 +1209,7 @@ X-Mailer: git-send-email $gitversion
 
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif ($smtp_server =~ m#^/#) {
+	} elsif (file_name_is_absolute($smtp_server)) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
@@ -1271,7 +1283,7 @@ X-Mailer: git-send-email $gitversion
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
 	} else {
 		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
-		if ($smtp_server !~ m#^/#) {
+		if (!file_name_is_absolute($smtp_server)) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
 			foreach my $entry (@recipients) {
-- 
1.9.0.msysgit.0

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
