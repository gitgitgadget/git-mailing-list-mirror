From: Peter Harris <pharris@opentext.com>
Subject: [PATCH 2/2] Modify MSVC wrapper script
Date: Mon,  5 Jul 2010 15:41:37 -0400
Message-ID: <1278358897-488-2-git-send-email-pharris@opentext.com>
References: <1278358897-488-1-git-send-email-pharris@opentext.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com,
   Peter Harris <pharris@opentext.com>
To: msysgit@googlegroups.com
X-From: msysgit+bncCAAQ-e7I4QQaBCDqKLY@googlegroups.com Mon Jul 05 21:50:40 2010
Return-path: <msysgit+bncCAAQ-e7I4QQaBCDqKLY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gy0-f186.google.com ([209.85.160.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCAAQ-e7I4QQaBCDqKLY@googlegroups.com>)
	id 1OVrge-0002Qg-7m
	for gcvm-msysgit@m.gmane.org; Mon, 05 Jul 2010 21:50:40 +0200
Received: by gyg13 with SMTP id 13sf9570613gyg.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 05 Jul 2010 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received:received-spf:received:received
         :received:received:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:x-originalarrivaltime:x-archived
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=ORr0kZ0PxfoHMxtw2zL0YdhCOv9Ba14sa9ehEy6nwYc=;
        b=yHIy1Nre5DNuit90BTpAp4j6bJW5Q+5rLBEb5joPHj1L8TP59xbGOxNF5g+7kD2+SO
         lsjmNGpuIZAL83NC8wFMNMZzG+ihy4gR+km1vjDFLzflMWH00f40liusVs9KJdKyxoUy
         qifHYk72O8qj8pxdbp1uJsgplGoGYmpqhReRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-originalarrivaltime
         :x-archived:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        b=u42awvIMrC1tSqvII5b8nQ6T3l4MvXVe+ThvLtPeJ1uX7LNiSogGiK2FLEW/nlNrlX
         c19OpTGOMGPVQ8WPo8NwvNqRoiqLFEG6dO4Ss/5MlpXbX20tWhXCkkx2O1Lks0/Kd3nq
         yvaBpfptc551YbXtCxGfQmJgAyQGVeHYvJITk=
Received: by 10.101.63.16 with SMTP id q16mr323489ank.67.1278359417373;
        Mon, 05 Jul 2010 12:50:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.101.148.2 with SMTP id a2ls7274804ano.1.p; Mon, 05 Jul 2010 
	12:50:16 -0700 (PDT)
Received: by 10.100.50.5 with SMTP id x5mr2820099anx.45.1278359416832;
        Mon, 05 Jul 2010 12:50:16 -0700 (PDT)
Received: by 10.231.34.70 with SMTP id k6mr321970ibd.13.1278358927169;
        Mon, 05 Jul 2010 12:42:07 -0700 (PDT)
Received: by 10.231.34.70 with SMTP id k6mr321968ibd.13.1278358926542;
        Mon, 05 Jul 2010 12:42:06 -0700 (PDT)
Received: from opentext.com (smtpout.opentext.com [204.138.115.203])
        by gmr-mx.google.com with ESMTP id db12si2803824ibb.1.2010.07.05.12.42.06;
        Mon, 05 Jul 2010 12:42:06 -0700 (PDT)
Received-SPF: pass (google.com: domain of pharris@opentext.com designates 204.138.115.203 as permitted sender) client-ip=204.138.115.203;
Received: from otwlpm02.smtp.dmz.opentext.com (otwlpm02.smtp.dmz.opentext.com [192.168.15.231])
	by opentext.com (8.12.8/8.12.8) with ESMTP id o65Jg5S9006324
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=FAIL);
	Mon, 5 Jul 2010 15:42:05 -0400
Received: from vectorsvc.wl.opentext.com (ava.wl.opentext.com [172.21.5.96])
	by otwlpm02.smtp.dmz.opentext.com (8.14.4/8.14.4) with ESMTP id o65Jg5Cc016204
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Jul 2010 15:42:05 -0400
	(envelope-from pharris@opentext.com)
Received: from OTWLMX04.opentext.net (otwlxg02.wl.opentext.com [10.2.102.24])
	by vectorsvc.wl.opentext.com (8.12.8/8.12.8) with ESMTP id o65Jg5qt006321;
	Mon, 5 Jul 2010 15:42:05 -0400
Received: from localhost.localdomain ([10.3.14.168]) by OTWLMX04.opentext.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 Jul 2010 15:42:04 -0400
X-Mailer: git-send-email 1.7.0.6
In-Reply-To: <1278358897-488-1-git-send-email-pharris@opentext.com>
X-OriginalArrivalTime: 05 Jul 2010 19:42:04.0795 (UTC) FILETIME=[25529CB0:01CB1C7A]
X-Archived: msg.2qdUOJ3:2010-07-05:otwlpm02.smtp.dmz.opentext.com
X-Original-Sender: pharris@opentext.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of pharris@opentext.com designates 204.138.115.203 as permitted 
	sender) smtp.mail=pharris@opentext.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150289>

This reduces warnings, and supports additional linker
flags (such as -DEBUG and -MAP)

Signed-off-by: Peter Harris <pharris@opentext.com>
---
 Makefile                        |    1 +
 compat/vcbuild/scripts/clink.pl |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 7134509..d4fd4b0 100644
--- a/Makefile
+++ b/Makefile
@@ -1073,6 +1073,7 @@ ifndef DEBUG
 	AR += -LTCG
 else
 	BASIC_CFLAGS += -Zi -MTd
+	BASIC_LDFLAGS = -DEBUG -MAP
 endif
 	X = .exe
 endif
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index 4374771..3f51886 100644
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -12,10 +12,14 @@
 use strict;
 my @args = ();
 my @cflags = ();
+my @lflags = ();
 my $is_linking = 0;
+my %linkflag = ( '-DEBUG' => 1, '-MAP' => 1 );
 while (@ARGV) {
 	my $arg = shift @ARGV;
-	if ("$arg" =~ /^-[DIMGO]/) {
+	if ($linkflag{$arg}) {
+		push(@lflags, $arg);
+	} elsif ("$arg" =~ /^-[DIMGOWZ]/) {
 		push(@cflags, $arg);
 	} elsif ("$arg" eq "-o") {
 		my $file_out = shift @ARGV;
@@ -44,6 +48,7 @@ while (@ARGV) {
 }
 if ($is_linking) {
 	unshift(@args, "link.exe");
+	push(@args, @lflags);
 } else {
 	unshift(@args, "cl.exe");
 	push(@args, @cflags);
-- 
1.7.1.msysgit.0.4.gea744.MSVC
