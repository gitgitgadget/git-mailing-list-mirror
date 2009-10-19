From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v4 5/8] imap-send: build imap-send on Windows
Date: Mon, 19 Oct 2009 17:42:06 +0200
Message-ID: <1255966929-1280-6-git-send-email-kusmabite@gmail.com>
References: <1255966929-1280-1-git-send-email-kusmabite@gmail.com> <1255966929-1280-2-git-send-email-kusmabite@gmail.com> <1255966929-1280-3-git-send-email-kusmabite@gmail.com> <1255966929-1280-4-git-send-email-kusmabite@gmail.com> <1255966929-1280-5-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Oct 19 17:43:51 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f162.google.com ([209.85.221.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzuOe-0006N3-6J
	for gcvm-msysgit@m.gmane.org; Mon, 19 Oct 2009 17:43:44 +0200
Received: by mail-qy0-f162.google.com with SMTP id 34so3506781qyk.22
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 Oct 2009 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=F+frffd8AgMTdSMeAY1hVj0ZEag2VIJLQkWsmPbUs7s=;
        b=UWp36yG3VtvtKNJnC8jjdDtjMv9W78v8FL/cMRH8PgMbO1i0AFfSgwgqeyh7PafBQf
         fng20WOIuoPIEi/0326BPwdqmqeTUMoyfAlpV67lEngJrxQT0ZQTdxv8S/QvRsPMuyPy
         tyPpjtgZUzhQpYT5DQMu2LVzb7SozLKyTuJRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=g+GIcJpUhyrH3bwWAbBf8sikXh7bqtsBD1IQzNpXGzgUPwK+udJxxc67lFi3g6b0sN
         KSgJ7VUyiBuBkL+sKmMjuMowYQ11d6cQKHNOQb2Zbss02siDXpGVckWtdaHL8hVG+gmS
         UeYNdzUCCfv+7FSau9MFoGT50zalZeNZQbkSw=
Received: by 10.224.68.13 with SMTP id t13mr254891qai.11.1255967017498;
        Mon, 19 Oct 2009 08:43:37 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7451yqh.0;
	Mon, 19 Oct 2009 08:43:27 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.146.6 with SMTP id y6mr259397ebn.7.1255967005817; Mon, 19 Oct 2009 08:43:25 -0700 (PDT)
Received: by 10.211.146.6 with SMTP id y6mr259396ebn.7.1255967005696; Mon, 19 Oct 2009 08:43:25 -0700 (PDT)
Received: from mail-ew0-f216.google.com (mail-ew0-f216.google.com [209.85.219.216]) by gmr-mx.google.com with ESMTP id 15si913810ewy.0.2009.10.19.08.43.24; Mon, 19 Oct 2009 08:43:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.216 as permitted sender) client-ip=209.85.219.216;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.216 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-ew0-f216.google.com with SMTP id 12so4401495ewy.24 for <msysgit@googlegroups.com>; Mon, 19 Oct 2009 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=IXy+D/qjPCbhWID3lWEJFbJpS54bNLfYjOod4a9pSbI=; b=bpIv0AjI7i5mUON28ayAMUvq17x/bwEq94KDqRVhzkVOVTUMyA7+IgwWt8PVEZfG3x dm7BJ1uRfCw+khxMtwi1veau27u8KUrHQprNdUQ83AdIArZJvyCGUX+3eYBDAxaa+i1+ Eiv0XbGZLnht4/+cYZ/4dvYnGRgJEiz4Ai8OM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=WD4jbUzKlev+h7E1LcjkWLpEJsc2GjvqnDajIEkjU2N0eCsVud2UT7dSeM+RHHwoNX C7dNW7OtNBe8MWoJ3vD/ufUHmxwCm//HoXfiweTF8SZ8kotFogem3XFGM8ik+zEPxdyi O6nknTEeLbGQwHjBKj4g3xtfPhSri/R0/qzEc=
Received: by 10.211.132.3 with SMTP id j3mr5065632ebn.54.1255967004575; Mon, 19 Oct 2009 08:43:24 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 10sm461930eyd.42.2009.10.19.08.43.23 (version=TLSv1/SSLv3 cipher=RC4-MD5); Mon, 19 Oct 2009 08:43:24 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255966929-1280-5-git-send-email-kusmabite@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130707>


Since the POSIX-specific tunneling code has been replaced
by the run-command API (and a compile-error has been
cleaned away), we can now enable imap-send on Windows
builds.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index fea237b..0d13af3 100644
--- a/Makefile
+++ b/Makefile
@@ -354,6 +354,7 @@ EXTRA_PROGRAMS =
 PROGRAMS += $(EXTRA_PROGRAMS)
 PROGRAMS += git-fast-import$X
 PROGRAMS += git-hash-object$X
+PROGRAMS += git-imap-send$X
 PROGRAMS += git-index-pack$X
 PROGRAMS += git-merge-index$X
 PROGRAMS += git-merge-tree$X
@@ -1075,7 +1076,6 @@ EXTLIBS += -lz
 
 ifndef NO_POSIX_ONLY_PROGRAMS
 	PROGRAMS += git-daemon$X
-	PROGRAMS += git-imap-send$X
 endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
-- 
1.6.5.15.g5f078
