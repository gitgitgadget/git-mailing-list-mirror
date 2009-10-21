From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v5 7/8] mingw: enable OpenSSL
Date: Wed, 21 Oct 2009 19:04:50 +0200
Message-ID: <1256144691-2908-8-git-send-email-kusmabite@gmail.com>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com> <1256144691-2908-2-git-send-email-kusmabite@gmail.com> <1256144691-2908-3-git-send-email-kusmabite@gmail.com> <1256144691-2908-4-git-send-email-kusmabite@gmail.com> <1256144691-2908-5-git-send-email-kusmabite@gmail.com> <1256144691-2908-6-git-send-email-kusmabite@gmail.com> <1256144691-2908-7-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Oct 21 19:06:03 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f163.google.com ([209.85.221.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0edO-0007fq-FX
	for gcvm-msysgit@m.gmane.org; Wed, 21 Oct 2009 19:06:02 +0200
Received: by mail-qy0-f163.google.com with SMTP id 35so5684134qyk.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 Oct 2009 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=R+lr7wPPZWrIt2XLJ3bxCm/Leta7+pjWCQtx5JMrRAo=;
        b=efJeYh2hvB6cebNVlvrXy8KFoMmeulpKAEPFNY7B+6qscwDYZv0An4G50Ba+o+xAm/
         PYMbJHzfxbm8ZAdw5csU/zjJjFjmt+GxMpnNKVeoTLrdOTOOX89qSzrYvD0+I9JtsuhP
         MUGX7gA8vw8iHu99CrDrTlJQGGhfBUpAB6QFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=p21QDsb+EOPoscrrmj1esmuyDVagaHkTfv6s45ZbuS6oJChC4lggL8EBhEufpbHPep
         krgT6kaBI81I/BlBz8r9BHLM/4ifgqXwggycZUIouXH2zin6rAHKO+BC38dtL8IfMiCR
         5ymBy1S0vfF/sNaeAYKU4uY93p+7Lr79AVkWo=
Received: by 10.224.112.78 with SMTP id v14mr400133qap.22.1256144755692;
        Wed, 21 Oct 2009 10:05:55 -0700 (PDT)
Received: by 10.177.108.35 with SMTP id k35gr7481yqm.0;
	Wed, 21 Oct 2009 10:05:41 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.171.2 with SMTP id y2mr806870ebo.19.1256144740964; Wed, 21 Oct 2009 10:05:40 -0700 (PDT)
Received: by 10.211.171.2 with SMTP id y2mr806869ebo.19.1256144740941; Wed, 21 Oct 2009 10:05:40 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27]) by gmr-mx.google.com with ESMTP id 14si44903ewy.5.2009.10.21.10.05.39; Wed, 21 Oct 2009 10:05:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.27 as permitted sender) client-ip=74.125.78.27;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.27 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ey-out-2122.google.com with SMTP id 9so1368308eyd.27 for <msysgit@googlegroups.com>; Wed, 21 Oct 2009 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=NPlfu6RrRGzG4hLAl5b4AtPINDNIjcf49+cbnQJLBmg=; b=iMkQRsjYUUB4kgyqB1Ca8tg1uGku6+vuigd6RMXYOPLLZZcJ0ccjhrYDBgYmKbXHfR vaSi2F8/B0lCF4g0JMdprLzsOh++TEebMXYqspsJ1o08PxG0mpGyL6S2FqvOx38SxczK 4WXtrr6QM4MNFttBPMU2Rzjv0K6UBIWYLKQmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=T8VVqThgsozxvc681AP2h/SChk167OU2G4BBunnxR1Ok3i9aZoe2e2gozFGgd77iuJ FD+3xz1uhIiVqMxaSiy0pMlll4vCI81C+8WJ3VkwfjOrvzY3EdJ/ShIMaNMPopmA8lIB v7EMM9K8ugOhFXyw/mUt15kP3PeyKIf74NcJo=
Received: by 10.211.142.18 with SMTP id u18mr2200231ebn.88.1256144739851; Wed, 21 Oct 2009 10:05:39 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 5sm523063eyh.2.2009.10.21.10.05.38 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 21 Oct 2009 10:05:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1256144691-2908-7-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130936>


Since we have OpenSSL in msysgit now, enable it to support SSL
encryption for imap-send.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 0d13af3..986483b 100644
--- a/Makefile
+++ b/Makefile
@@ -952,7 +952,7 @@ else
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
-	NO_OPENSSL = YesPlease
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
-- 
1.6.4.msysgit.0
