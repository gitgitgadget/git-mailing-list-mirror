From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 5/6] msvc: opendir: handle paths ending with a slash
Date: Tue, 23 Nov 2010 19:38:28 +0100
Message-ID: <1290537509-360-6-git-send-email-kusmabite@gmail.com>
References: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxDXlLDnBBoENpsKDA@googlegroups.com Tue Nov 23 19:39:43 2010
Return-path: <msysgit+bncCOPdven-DxDXlLDnBBoENpsKDA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDXlLDnBBoENpsKDA@googlegroups.com>)
	id 1PKxmI-0007Yx-Ve
	for gcvm-msysgit@m.gmane.org; Tue, 23 Nov 2010 19:39:43 +0100
Received: by mail-ww0-f58.google.com with SMTP id 40sf3016877wwj.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 23 Nov 2010 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=TvyCyiR/Qkskjtv9mZi2zjoIFJ3xkrhRW9DAPkdkIa0=;
        b=I0GNSrU4m/HIp5aXHZHIVLpH/5XRsxvnSGSkvztaFVzEVuOHENokJmTgln6VJLxmZn
         WPZsOSJyDcmXS+Ss9fYIhO9WTV8G7M/PdpwpQLQ/zjIBj4TBlODqdn74D1mk+2RFyLJE
         kKjGjuA5dELvt+GKvbunF+80wZ5uQxmbFJOPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=S/pkowYwMyNvgUSniF51bJhD/clXPGjFon1GJAb57Xg25kEpo0yZeMITqR+TuVPBfu
         U6Fhh33NZsgWz5QxeKmyaEAHALkzciGh780SC7hcvSZsL2o+rTMl2NV+2Yvf1vBL0JL/
         T8EBe5vDowA1NGIJV7RpFWIken+x5BWjyGPxc=
Received: by 10.217.7.68 with SMTP id z46mr591817wes.2.1290537559154;
        Tue, 23 Nov 2010 10:39:19 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.25.20 with SMTP id y20ls1436837eey.1.p; Tue, 23 Nov 2010
 10:39:17 -0800 (PST)
Received: by 10.14.37.132 with SMTP id y4mr1152773eea.20.1290537557380;
        Tue, 23 Nov 2010 10:39:17 -0800 (PST)
Received: by 10.14.37.132 with SMTP id y4mr1152772eea.20.1290537557314;
        Tue, 23 Nov 2010 10:39:17 -0800 (PST)
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com [209.85.215.51])
        by gmr-mx.google.com with ESMTP id z15si780216eeh.2.2010.11.23.10.39.16;
        Tue, 23 Nov 2010 10:39:16 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.51 as permitted sender) client-ip=209.85.215.51;
Received: by ewy19 with SMTP id 19so548649ewy.38
        for <msysgit@googlegroups.com>; Tue, 23 Nov 2010 10:39:16 -0800 (PST)
Received: by 10.14.47.200 with SMTP id t48mr5629033eeb.23.1290537555991;
        Tue, 23 Nov 2010 10:39:15 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q58sm6069906eeh.21.2010.11.23.10.39.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 10:39:15 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.51 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162007>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/msvc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/compat/msvc.c b/compat/msvc.c
index 199eb22..fdbfb70 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -23,6 +23,8 @@ DIR *opendir(const char *name)
 
 	/* check that the pattern won't be too long for FindFirstFileA */
 	len = strlen(name);
+	if (is_dir_sep(name[len - 1]))
+		len--;
 	if (len + 2 >= MAX_PATH) {
 		errno = ENAMETOOLONG;
 		return NULL;
-- 
1.7.3.2.493.gc8738
