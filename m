From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [RFC 15/15] Tag GIT_VERSION when Git is built with MSVC
Date: Wed, 16 Sep 2009 10:20:31 +0200
Message-ID: <894136433cc5b03a4b89a1f9c0e4f8a2704222fa.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com> <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com> <eec2b652c5a8e3e21348a8211d336fce66cb21a5.1253088099.git.mstormo@gmail.com> <28e3400f29353cf8f93b4ca054b87f083f9e33e1.1253088099.git.mstormo@gmail.com> <8f578bb08bf5663a8ce5b02e3e4f77727692c501.1253088099.git.mstormo@gmail.com> <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com> <489a0e7c6c41985a5208e85e9b24900c97dcacdb.1253088099.git.mstormo@gmail.com> <38f180f3899d1f7a6acc8cf8c65f5f0ffb61699a.1253088099.git.mstorm
 o@gmail.com> <e9ffbe6e71d7f27c4ee5d31f59f860827c5a2f94.1253088099.git.mstormo@gmail.com> <49b1712beea2ac9eb00c61c8d92c035a7c412d69.1253088099.git.mstormo@gmail.com> <260603a54845df34659d605fadaf663d0094c8cb.1253088099.git.mstormo@gmail.com> <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:37 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnplb-0004o9-9V
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:31 +0200
Received: by mail-yx0-f137.google.com with SMTP id 1so8797092yxe.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=sI01vSiy6+rkoNxgtV71uCQFk26JGCzvSGIWqluAW6Y=;
        b=sF5YHCR6yij0albhZqyo8POGafLgEFofOk0JOttrZuptOYjRnrW/4T/YDxzoONCMSl
         QeVokZJAOYRF/bK+UuoRvxerseg4geUbpt/Oz0gFRIaGWO9UQdDQVPirTYD0wTKvFLZb
         37G8KIJFbwyyJcID3zP0g+FDVQizVRKdoySAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=h/xA4ot0VRdzaAQL7HC38lYODmn2eaDn7Ulz+jhMF3I6gS28jlf5zis5jT7dFPcBsF
         lXTQiM+bQ60P/JCEd/cYqPredH3l8fNA1pa90A/juhOBH89zuZllUTwWa/s3RImDHslF
         9LGfVd8XtdF/dXsSMatJJQtLIXukvuc8+v11Y=
Received: by 10.100.199.19 with SMTP id w19mr1874272anf.33.1253089285031;
        Wed, 16 Sep 2009 01:21:25 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7050yqh.0;
	Wed, 16 Sep 2009 01:21:14 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.139.15 with SMTP id r15mr291601ebn.1.1253089273327; Wed, 16 Sep 2009 01:21:13 -0700 (PDT)
Received: by 10.211.139.15 with SMTP id r15mr291600ebn.1.1253089273305; Wed, 16 Sep 2009 01:21:13 -0700 (PDT)
Received: from mail-ew0-f224.google.com (mail-ew0-f224.google.com [209.85.219.224]) by gmr-mx.google.com with ESMTP id 15si1687036ewy.0.2009.09.16.01.21.12; Wed, 16 Sep 2009 01:21:12 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.224 as permitted sender) client-ip=209.85.219.224;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.224 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f224.google.com with SMTP id 24so3733120ewy.46 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=nbjhrh19wxRHmexnd4yyw5X4szXSJxP2sPWdU2C69vE=; b=mXGsj3qjkTQdESAYVwMW1Rhk+qvhmkcZV6FwNb3yGoRycRG7VKiBhU/n0cU4IkkhDX EbLAe1m2MIqfBRQZvhgr8huP09bKs/75Z1JmM79Zx5+9Mk5MPVsiVbYFgXjlRMngXONv srgVARpqLBH527ot/p8qBkn4DBmt692PjrJHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=dZxO/yZ2XoHGO9nXoM7MYOItR+VikopmlZ4HooqvCyG2n15+kjHjjyh2gkdve85MuG NYkALa1KUJn5ALv29BlAr2ExK/DVqtlvMv1hxmGWQ+aI2SfCbaSFUyc/1zwCGMqzoEmz Ohc4hCHneJ8bZwyWjE3fQnR0Fsu6J4rgyDZWo=
Received: by 10.211.184.18 with SMTP id l18mr9521668ebp.30.1253089272182; Wed, 16 Sep 2009 01:21:12 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.21.10 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:21:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com>
In-Reply-To: <cover.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128630>


This may help us debug issues on Windows, as we now can build Git
natively on Windows with both MinGW and MSVC.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 I'm just throwing this one out there. If people think manipulating
 the version here, to ease debugging, I don't mind if this patch is
 squashed into patch 12.
 If people don't like it, just skip this path.
 
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index aa918eb..2c20922 100644
--- a/Makefile
+++ b/Makefile
@@ -878,6 +878,7 @@ ifneq (,$(findstring CYGWIN,$(uname_S)))
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 endif
 ifdef MSVC
+	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	NO_PREAD = YesPlease
 	NO_OPENSSL = YesPlease
-- 
1.6.2.1.418.g33d56.dirty
