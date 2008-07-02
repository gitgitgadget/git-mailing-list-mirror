From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 09/12] We need to check for msys as well as Windows
 in add--interactive.
Date: Wed,  2 Jul 2008 10:32:09 +0200
Message-ID: <1214987532-23640-9-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, Mike Pape <dotzenlabs@gmail.com>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:28 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmI-0001Gu-98
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:26 +0200
Received: by yw-out-2122.google.com with SMTP id 8so2058163yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=+XL3sVNlRW6BlEfB+P9TyfdeZRQJmQGE3w5Y8mXhpC8=;
        b=vauY+HZ5A5UuWiydAis+uQlrXHLN/MHq/ovagmYFjV+3GYzzImZOZhLt2gcDsNf04+
         MLTm19oRSle5d0m6IG/hR7rLEm1bqlNhiB4u+CBiZ20oT8sZseA8XyCILA2Up2UBYEZT
         sim5WjQR7OdBl/FIbLH2UkDhcIXWG/J86fGgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=nlzDCJhtucLegAUplyA6dDu2RGjktqG0sl2TrIyW6tZZp/uX/PvPLj7eVjcC78M2JZ
         w/Tm4/mmNJLMbV1QvSZogcy/4CdqNhkUT8BfMHY/ceX0mLQESDZhzIa0dwq8/1YsvL4E
         2nL0ngxJS70/Z5bUXqXstQrf2LIV4mUfNQHs4=
Received: by 10.114.81.1 with SMTP id e1mr543396wab.9.1214987541900;
        Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received: by 10.106.239.31 with SMTP id m31gr2548prh.0;
	Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.65.5 with SMTP id n5mr8843537aga.1.1214987541266; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 7si7856909yxg.1.2008.07.02.01.32.20; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WEMe019119; Wed, 2 Jul 2008 10:32:19 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0Q017527; Wed, 2 Jul 2008 10:32:14 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1214987532-23640-8-git-send-email-prohaska@zib.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87108>


From: Mike Pape <dotzenlabs@gmail.com>

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-add--interactive.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 903953e..78a64e6 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -42,7 +42,7 @@ sub colored {
 my $patch_mode;
 
 sub run_cmd_pipe {
-	if ($^O eq 'MSWin32') {
+	if ($^O eq 'MSWin32' || $^O eq 'msys') {
 		my @invalid = grep {m/[":*]/} @_;
 		die "$^O does not support: @invalid\n" if @invalid;
 		my @args = map { m/ /o ? "\"$_\"": $_ } @_;
-- 
1.5.6.1.255.g32571
