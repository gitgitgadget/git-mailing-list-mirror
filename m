From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC 2/4] Properly accept quoted space in filenames
Date: Thu, 20 Nov 2014 23:38:00 +0000
Message-ID: <1416526682-6024-3-git-send-email-philipoakley@iee.org>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Wookey <michaelwookey@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Msysgit <msysgit@googlegroups.com>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBSHWXGRQKGQENSCOJ5Y@googlegroups.com Fri Nov 21 00:37:46 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBSHWXGRQKGQENSCOJ5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f184.google.com ([209.85.212.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBSHWXGRQKGQENSCOJ5Y@googlegroups.com>)
	id 1XrbIH-0002XW-K9
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 00:37:45 +0100
Received: by mail-wi0-f184.google.com with SMTP id ho1sf389230wib.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 20 Nov 2014 15:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=KVffLinYWZDxWwA8jRtJxwvd9E4M9WoHzFbFAr6EYDA=;
        b=Wf44dYDwVQRrYBMEJ6CMt+mZvahbah47pveKSnVKbDkeOQCdKvXdu2S71/95CrI02e
         1xcKZdDhtC7/t5dQZhtQ1LBzbIHMX4zby6p/r9bZy5tdpFCDAh1aFxQjkKV+V2iVXbTM
         8XdBJvacywCw3ovzf7AQJJ58NUR7RxRbuKp2ZKukSL51bLOGo8iQ3DUWwWUf2PRZXSMz
         Uxh862VZMnfqn1OCDS0VVC/ZvcinipmiggYI+CqTaCKLz5/oHzAva/nQZsV7vjGlbUL1
         xJr67MS8gPUHoF1vZ1SND2yXm+rRqe2eZi5GXw2M8C4W4FDIHOP4JBhGpRfFz5fDwMC+
         C6xw==
X-Received: by 10.152.29.228 with SMTP id n4mr13424lah.16.1416526665429;
        Thu, 20 Nov 2014 15:37:45 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.234.133 with SMTP id ue5ls134886lac.6.gmail; Thu, 20 Nov
 2014 15:37:43 -0800 (PST)
X-Received: by 10.112.151.38 with SMTP id un6mr377270lbb.0.1416526663326;
        Thu, 20 Nov 2014 15:37:43 -0800 (PST)
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net. [62.24.128.242])
        by gmr-mx.google.com with ESMTP id jv2si90840wid.1.2014.11.20.15.37.43
        for <msysgit@googlegroups.com>;
        Thu, 20 Nov 2014 15:37:43 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.242 as permitted sender) client-ip=62.24.128.242;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmoOAPx5blROl3PwPGdsb2JhbABagw5VWYI2hFPET4dLBAICgQYXAQEBAQEBBQEBAQE4O4QDAQVWIxAISTkKFAYTiEXUfAEBAQEGAiCRCAeESwWXNYkcmQY9MIJLAQEB
X-IPAS-Result: AmoOAPx5blROl3PwPGdsb2JhbABagw5VWYI2hFPET4dLBAICgQYXAQEBAQEBBQEBAQE4O4QDAQVWIxAISTkKFAYTiEXUfAEBAQEGAiCRCAeESwWXNYkcmQY9MIJLAQEB
X-IronPort-AV: E=Sophos;i="5.07,426,1413241200"; 
   d="scan'208";a="651403026"
Received: from host-78-151-115-240.as13285.net (HELO localhost) ([78.151.115.240])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 20 Nov 2014 23:37:43 +0000
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.242 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

    the engine.pl script barfs on the properly quoted space
    in filename options prevalent on Windows. Use quotewords()
    rather than split() to separate such options.

    Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 9144ea7..8e41808 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -12,6 +12,7 @@ use File::Basename;
 use File::Spec;
 use Cwd;
 use Generators;
+use Text::ParseWords;
 
 my (%build_structure, %compile_options, @makedry);
 my $out_dir = getcwd();
@@ -243,7 +244,8 @@ sub removeDuplicates
 sub handleCompileLine
 {
     my ($line, $lineno) = @_;
-    my @parts = split(' ', $line);
+    # my @parts = split(' ', $line);
+    my @parts = quotewords('\s+', 0, $line);
     my $sourcefile;
     shift(@parts); # ignore cmd
     while (my $part = shift @parts) {
@@ -277,7 +279,8 @@ sub handleLibLine
     my (@objfiles, @lflags, $libout, $part);
     # kill cmd and rm 'prefix'
     $line =~ s/^rm -f .* && .* rcs //;
-    my @parts = split(' ', $line);
+    # my @parts = split(' ', $line);
+    my @parts = quotewords('\s+', 0, $line);
     while ($part = shift @parts) {
         if ($part =~ /^-/) {
             push(@lflags, $part);
@@ -318,7 +321,9 @@ sub handleLinkLine
 {
     my ($line, $lineno) = @_;
     my (@objfiles, @lflags, @libs, $appout, $part);
-    my @parts = split(' ', $line);
+    # my @parts = split(' ', $line);
+    my @parts = quotewords('\s+', 0, $line);
+
     shift(@parts); # ignore cmd
     while ($part = shift @parts) {
         if ($part =~ /^-IGNORE/) {
-- 
1.9.4.msysgit.0

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
