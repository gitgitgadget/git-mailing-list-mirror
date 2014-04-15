From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] send-email: recognize absolute path on Windows
Date: Tue, 15 Apr 2014 10:44:25 +0200
Message-ID: <1397551465-10968-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	johannes.schindelin@gmx.de
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBZHCWONAKGQEMTJ2MNY@googlegroups.com Tue Apr 15 10:44:26 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBZHCWONAKGQEMTJ2MNY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f61.google.com ([209.85.161.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBZHCWONAKGQEMTJ2MNY@googlegroups.com>)
	id 1WZyyb-0004F2-Lu
	for gcvm-msysgit@m.gmane.org; Tue, 15 Apr 2014 10:44:21 +0200
Received: by mail-fa0-f61.google.com with SMTP id v1sf665492fav.26
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Apr 2014 01:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=eFqOr2xL3qKac/mf+wPl7SHQW6RB/viyNwGLfe217fE=;
        b=uFrub6NagZbm/Bjga+/GeY6Ds77v43aydgi5WqfDSBb1tWwi6hyZ9LyvdmBAhuNan1
         sQpM1oUvbjk42L+0GsshKJGYLKwcj4YYfYKaae+l0Prhx8PntxuQDOvvwzmpiAudIcFo
         XHyHu0DFX/WuHympitDGV4/RXe+4RGukUYrOQpvYa+0y2IPMT2KDTwq5v+J4NWTkcIpZ
         cI3y0XgSU8P4PAUK79pXq0yGTGGifn8TNPcgi74FlFchul/wo2iPpiqRjTY46SBr1OGk
         g4MN0Qe9OBkenfAD9pm4GD0K5lmK2PvQu4D6HWJ2mAiGKlJsMWESFwRhb20vfue6XGNS
         ZmFw==
X-Received: by 10.152.27.72 with SMTP id r8mr3248lag.23.1397551461331;
        Tue, 15 Apr 2014 01:44:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.6.6 with SMTP id w6ls28597law.2.gmail; Tue, 15 Apr 2014
 01:44:20 -0700 (PDT)
X-Received: by 10.112.64.68 with SMTP id m4mr75089lbs.10.1397551460348;
        Tue, 15 Apr 2014 01:44:20 -0700 (PDT)
Received: from mail-ee0-x22f.google.com (mail-ee0-x22f.google.com [2a00:1450:4013:c00::22f])
        by gmr-mx.google.com with ESMTPS id u49si582774eeo.1.2014.04.15.01.44.20
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Apr 2014 01:44:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2a00:1450:4013:c00::22f as permitted sender) client-ip=2a00:1450:4013:c00::22f;
Received: by mail-ee0-f47.google.com with SMTP id b15so7374880eek.6
        for <msysgit@googlegroups.com>; Tue, 15 Apr 2014 01:44:20 -0700 (PDT)
X-Received: by 10.15.43.77 with SMTP id w53mr933111eev.10.1397551460250;
        Tue, 15 Apr 2014 01:44:20 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPSA id p8sm47457249eef.26.2014.04.15.01.44.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 15 Apr 2014 01:44:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.msysgit.0
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2a00:1450:4013:c00::22f
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246279>

From: Erik Faye-Lund <kusmabite@googlemail.com>

On Windows, absolute paths might start with a DOS drive prefix,
which this check fails to recognize.

Unfortunately, we cannot simply use the file_name_is_absolute
helper in File::Spec::Functions, because Git for Windows has an
MSYS-based Perl, where this helper doesn't grok DOS
drive-prefixes.

So let's manually check for these in that case, and fall back to
the File::Spec-helper on other platforms (e.g Win32 with native
Perl)

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Here's a patch that we've been running with a variation of in
Git for Windows for a while. That version wasn't quite palatable,
as it recognized DOS drive-prefixes on all platforms.

 git-send-email.perl | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fdb0029..c4d85a7 100755
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
