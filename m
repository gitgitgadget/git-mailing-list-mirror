Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80FE21F424
	for <e@80x24.org>; Sat,  7 Apr 2018 10:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDGKHj (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 06:07:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37716 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeDGKH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 06:07:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id r131so7182162wmb.2
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4GPVuZiuFjk1wD+wIIeStc/WoXqLXgg03ui1gCs638=;
        b=NwKUaA9pYT1Aa23xHdTy2tp+jBHx9bDhiWB+hKBDFhIs5W6NL+sViMpSBitjlHazjn
         dl1SEJ01DpWRt7MdPQOk4W/vtxqi+yGb8G5WceVf2HPFQtbEkux6jeguDdlHTtO/i435
         mPfppYylrw8P7uabK0dFMPDr3fpvVCIOpFnkpV3TquydsAWmoM3TTaZOVXVUhv30CVaH
         PfD8udLuCBvSySVrIAvLuFi//WdsAyDEQAzmSS6E7r1xNg52h5Ta71h/MNyYtaPlHn1n
         HgpulhpaOKicnvVLlk61m70cHCHwYW5QW6V3rFJJ173mmIF2VLGspsfYu0OhgvTIGs62
         4UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=v4GPVuZiuFjk1wD+wIIeStc/WoXqLXgg03ui1gCs638=;
        b=glfHVHW4pam+eovca2q/zONhrJtR0Bf6IheREDiD1bGfmcPA3QzwqxPFXN4R+z1snm
         zjz22bUBnE+rcS8cQJuuWxBox7tnVG4k4u4Vl3Ve+wrrRtisAJiDcD5G7PsnUNxn0DWB
         AQ9vk4nnQ7hvvOVFe/U8AZfULwgLZF10+KEduHoridlQllnp5yI1C3k30CwiscF7JyzW
         2kUaarrJhhBr81ca/HNGf+1G65mZ2S42iE/oLvnY4oqIOgQjC1R1AmjT9hQXRLu5oXJw
         J1Tv7bHMPXgjZICr+jBzLR8RU2Jb52g1AbZ2bktUiTqiYafQnU2XrGYfpBraq4utkbOs
         O6hA==
X-Gm-Message-State: AElRT7G7RkfFn3t9W3DU4fE335iVM94zrVE594rkNes3SekExhq03Gzm
        eH98I9cdyBs/ezhZLXrHCA4=
X-Google-Smtp-Source: AIpwx481LjbgIC8br5hdEhCJL+iJ1DJYLXFxwnMNzneL9tJwJj3r1ayhuyIWAMtSkryxqwOG72TtVA==
X-Received: by 10.28.110.17 with SMTP id j17mr17836918wmc.65.1523095648728;
        Sat, 07 Apr 2018 03:07:28 -0700 (PDT)
Received: from darkstar.example.net (188.29.165.242.threembb.co.uk. [188.29.165.242])
        by smtp.gmail.com with ESMTPSA id d9sm19578340wmh.38.2018.04.07.03.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Apr 2018 03:07:27 -0700 (PDT)
From:   Michal Nazarewicz <mina86@mina86.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Michael Rappazzo <rappazzo@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Nazarewicz?= <mina86@mina86.com>
Subject: [PATCH] send-email: simplify Gmail example in the documentation
Date:   Sat,  7 Apr 2018 11:07:23 +0100
Message-Id: <20180407100723.2168-1-mina86@mina86.com>
X-Mailer: git-send-email 2.17.0.1.ga3da07cdf.dirty
In-Reply-To: <20180404211446.GC15402@sigill.intra.peff.net>
References: <20180404211446.GC15402@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need for use to manually call ‘git credential’ especially
as the interface isn’t super user-friendly and a bit confusing.  ‘git
send-email’ will do that for them at the first execution and if the
password matches, it will be saved in the store.

Simplify the documentaion so it dosn’t include the ‘git credential’
invocation (which was incorrect anyway as it should use ‘approve’
instead of ‘fill’) and instead just mentions that credentials helper
must be set up.

Signed-off-by: Michał Nazarewicz <mina86@mina86.com>
---
 Documentation/git-send-email.txt | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 71ef97ba9..af07840b4 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -473,16 +473,7 @@ edit ~/.gitconfig to specify your account settings:

 If you have multifactor authentication setup on your gmail account, you will
 need to generate an app-specific password for use with 'git send-email'. Visit
-https://security.google.com/settings/security/apppasswords to setup an
-app-specific password.  Once setup, you can store it with the credentials
-helper:
-
-	$ git credential fill
-	protocol=smtp
-	host=smtp.gmail.com
-	username=youname@gmail.com
-	password=app-password
-
+https://security.google.com/settings/security/apppasswords to create it.

 Once your commits are ready to be sent to the mailing list, run the
 following commands:
@@ -491,7 +482,11 @@ following commands:
 	$ edit outgoing/0000-*
 	$ git send-email outgoing/*

+The first time you run it, you will be prompted for your credentials.  Enter the
+app-specific or your regular password as appropriate.  If you have credential
+helper configured (see linkgit:git-credential[1]), the password will be saved in
+the credential store so you won't have to type it the next time.
+
 Note: the following perl modules are required
       Net::SMTP::SSL, MIME::Base64 and Authen::SASL

-- 
2.16.2
