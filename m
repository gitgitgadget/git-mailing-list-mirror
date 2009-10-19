From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v4 7/8] mingw: enable OpenSSL
Date: Mon, 19 Oct 2009 17:42:08 +0200
Message-ID: <1255966929-1280-8-git-send-email-kusmabite@gmail.com>
References: <1255966929-1280-1-git-send-email-kusmabite@gmail.com> <1255966929-1280-2-git-send-email-kusmabite@gmail.com> <1255966929-1280-3-git-send-email-kusmabite@gmail.com> <1255966929-1280-4-git-send-email-kusmabite@gmail.com> <1255966929-1280-5-git-send-email-kusmabite@gmail.com> <1255966929-1280-6-git-send-email-kusmabite@gmail.com> <1255966929-1280-7-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Oct 19 17:43:48 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f162.google.com ([209.85.221.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzuOe-0006Xg-Pv
	for gcvm-msysgit@m.gmane.org; Mon, 19 Oct 2009 17:43:45 +0200
Received: by qyk34 with SMTP id 34so3507163qyk.22
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 Oct 2009 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=pbxpxmsgeQIENE73VnGfVC1u3elxi/n2Ry8hX+pjgJE=;
        b=NAgRDJLGX3IT+obXoLTdnIA5VEH6GSW4oQdJgCcLlEe532+zEtneeTwYmVvyZtjvKa
         Uxh4liIrHoe9zQHieWGYZdKXg10YE0e5laEdDZunzsPdPe2qVvJUwCpfsocGxmJh7f0u
         KwX9VWIaXJ/j46CUaeyxYxW1nYbaIFpRotE28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=U273KlxVc55v8OzB/UzSQpaiqDjwqeJUrnstO6Q2TcTz6aW0kjV2T+A6cRwKBVWWly
         l+h80eliASUTPxJ5bNUxllvUq63513YLM4bwlcc9CyqZtOR20vk6gbKkn1Q3Vv/kPd1S
         xtCWgXi7mnGcnjhSDRY5lf20WJLlfVDKmrUDA=
Received: by 10.224.40.208 with SMTP id l16mr254932qae.4.1255967017755;
        Mon, 19 Oct 2009 08:43:37 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7453yqh.0;
	Mon, 19 Oct 2009 08:43:34 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.7.23 with SMTP id 23mr278627ebg.4.1255967014008; Mon, 19 Oct 2009 08:43:34 -0700 (PDT)
Received: by 10.210.7.23 with SMTP id 23mr278626ebg.4.1255967013961; Mon, 19 Oct 2009 08:43:33 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25]) by gmr-mx.google.com with ESMTP id 15si913809ewy.4.2009.10.19.08.43.32; Mon, 19 Oct 2009 08:43:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.25 as permitted sender) client-ip=74.125.78.25;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.25 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ey-out-2122.google.com with SMTP id 9so1050386eyd.51 for <msysgit@googlegroups.com>; Mon, 19 Oct 2009 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=wS0vPrILYJ2W2JQ9aFHYqtYotlSuBHZfiThJsSS4w+s=; b=GtLSi8H/nfxhpwNeSmqcGWwa6Rqe8sTOfI/fvY0pcUm8IcsbUVTH0o73rGtoNC9LfS KtwE10GblsbccoZGiS/PjzC2abqb0PVwgstNfscRBd7rMOS1wyqErww1TjG4NrH3GBWW u6a1u2WPSN145Qbm1/lMKUbLlXkac4Py2QSkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=ZjvonIMBmWAaUXbF6vmEQr9UUQ3QHc2/Ai/43j0bbHZIWeN6eBIodrOUSKhARGcRhu oQtpGaGTIqkNYnN0G4k/4EqscfUESdSEXA5tNnjmLGNo6VSfy2f6X8CrKNLmRjpiQtNT r3VKRggJ93gv67Tw/33N8TmDerj+4NdSCNiic=
Received: by 10.211.147.7 with SMTP id z7mr5050996ebn.4.1255967012873; Mon, 19 Oct 2009 08:43:32 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 10sm1448059eyd.26.2009.10.19.08.43.32 (version=TLSv1/SSLv3 cipher=RC4-MD5); Mon, 19 Oct 2009 08:43:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255966929-1280-7-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130705>


Since we have OpenSSL in msysgit now, enable it to support SSL
encryption for imap-send.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 0d13af3..dbeaf2f 100644
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
1.6.5.15.g5f078
