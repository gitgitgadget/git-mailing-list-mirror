From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v3 7/8] mingw: enable OpenSSL
Date: Tue, 13 Oct 2009 19:25:24 +0000
Message-ID: <1255461925-2244-8-git-send-email-kusmabite@gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-2-git-send-email-kusmabite@gmail.com> <1255461925-2244-3-git-send-email-kusmabite@gmail.com> <1255461925-2244-4-git-send-email-kusmabite@gmail.com> <1255461925-2244-5-git-send-email-kusmabite@gmail.com> <1255461925-2244-6-git-send-email-kusmabite@gmail.com> <1255461925-2244-7-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 21:26:50 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxn1B-0006Yc-QA
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 21:26:45 +0200
Received: by mail-qy0-f143.google.com with SMTP id 7so10658267qyk.15
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=XwSR9m7hjNr9EtIzW4YicdFB0aY4cnbxdjts2NzzSkA=;
        b=KtGewZQLOwC6KcXmKS7ORcvGn3LofuwHsVyo58VbqLk3qEMu1i5fXNrdmxh52kDzqQ
         4oJs3uV6RIgxlnD/NOqT+zRZCiUMEMVXsek1NDlubnRipuXNYnWouQmnNNIo4ld+DF0G
         hfh+no0CtepZKieW+ijhAwDHSMEUDqb1yV5ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=YwFXWVzHse3DqT19ONRoTMDQ2kQUAn2OEQlYPJseo6kJpjDdTWO2oihJllI1fYHMya
         uHh43tyegKD4NgXrdmR/6B7DJC3azXoLPNYiKPrvGg+09ijhm1ot7vcyYgDfc7DrE0W1
         iccdqXrhPVdyZVCXNiQ3pN7bwP5cnZWg+vphI=
Received: by 10.224.64.208 with SMTP id f16mr336994qai.38.1255461999112;
        Tue, 13 Oct 2009 12:26:39 -0700 (PDT)
Received: by 10.176.149.32 with SMTP id w32gr7401yqd.0;
	Tue, 13 Oct 2009 12:26:38 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.2.19 with SMTP id 19mr807538ebb.14.1255461997093; Tue, 13 Oct 2009 12:26:37 -0700 (PDT)
Received: by 10.210.2.19 with SMTP id 19mr807537ebb.14.1255461997066; Tue, 13 Oct 2009 12:26:37 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144]) by gmr-mx.google.com with ESMTP id 15si322678ewy.0.2009.10.13.12.26.36; Tue, 13 Oct 2009 12:26:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.144 as permitted sender) client-ip=74.125.78.144;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.144 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ey-out-1920.google.com with SMTP id 13so191029eye.56 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=1f+17FvuwGt13bA8/jfwhZk7WU8RpusZdwON7u/bEAw=; b=sQ+r9vs/B5mKDPMyVyt14BUosPl7L2ODCkImAqmVJAnKwnsodwcFNE6xswFOyoVN+i 5atTCP0E92UGKG2jkszEtBNt0np/ou+TN5eUA0usn9BHCzgbITFZyUjNrrXh2j8+aiiz /FRmOlaPFikoHKz9yPPeQ+LVnEnYe04gcN73Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=EastYSthPLPZ/FNoAXnIwFwzy0VNOrf8ehadI2N1i1tiqZJg20KxuQq45eKsTRPT/9 jrtaPVTB1do7WqREi6B2WuPzW1os7678xdpioiBvxOT3nmHf7RjIA21vaETzt41Y32iZ pLdZVC4b6hIMuJGAgEz7x19sFQkmW0+/LGCz8=
Received: by 10.210.9.12 with SMTP id 12mr9176604ebi.3.1255461995935; Tue, 13 Oct 2009 12:26:35 -0700 (PDT)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12]) by mx.google.com with ESMTPS id 7sm4157636eyb.8.2009.10.13.12.26.34 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 13 Oct 2009 12:26:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1255461925-2244-7-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130189>


Since we have OpenSSL in msysgit now, enable it to support SSL
encryption for imap-send.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 3ddb3b3..e416fdb 100644
--- a/Makefile
+++ b/Makefile
@@ -952,7 +952,6 @@ else
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
-	NO_OPENSSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
-- 
1.6.4
