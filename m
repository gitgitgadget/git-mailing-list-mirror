Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB961F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeJ0PEj (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33330 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeJ0PEg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id z21-v6so3126519ljz.0
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjBGHI4sDjINRh6JDGoNi1ZHRFlbsQ9tN6VwxwKCzC4=;
        b=YjYZMndsllmAKz7t3G1tc28+jbT2TKR1M+KktY6cRopLcLNVSrf5dDd5b/ZBZkR6kT
         4evY32as1PTX/Lz4reIl2Lm8yyXfDKZkmEk/uhWTXsXnz0bO3OJF7dDeEVkSALMRKLNy
         HPctPrZAYzWLVyb+23+9rVyphpfd2t48yYj7GGBzmJ8lsZoDUwIkfnDg01mWd89wGvjd
         NUJ+Cn2DGN7geBEtTHtJnQHXeWLu/WZbIOq3GRWImVnRp1ZnlS7Gh2wQeXt2D1TIT4xv
         laRg3/4WwHGamc3UZp51ofuN0XXmI2FSHd+F26cMMmkv+lq1vHF936f9etV6EusI9aMr
         x+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjBGHI4sDjINRh6JDGoNi1ZHRFlbsQ9tN6VwxwKCzC4=;
        b=sNwQslSjFuOvQrCwlE4rPsm4qbZHbNXJ3O389QgAxFVg/arpLcdvu4MHsUE6e3kfrj
         +73KS8sASXRBWxcUpzuRPUjQ8T5yRybrtcKE73UZeokYpwixNpD0foZYX0/PI80jqUPS
         4Uu8gq19K/7L3bAn+UDz79ElUkrPmk5rhsJgPf2dFb9l4faSARtqhOEvc76uvKo9DQI1
         uRsxzz469a9yml/4XBlDvL6fFL/ZAH+O9xNQH5jW/vG4xc570RWOt8ZMtzvAXhxy5Ogc
         ajoOcx+tlFxe3Oha/5j/xviGbCHf1wuYTDg91wafqLg8zvXkOk9RUsLJwwuPQQdB9KG6
         ljkQ==
X-Gm-Message-State: AGRZ1gKhyDWQYz5Cdtl+KwPMT1HbsoC2GnC5Peppsa0eZACpDFXWk20O
        rz52Arr8APFJBrLXs6+RAPUpIlBF
X-Google-Smtp-Source: AJdET5efR/SF6JVWFb28fUzy/ArJ9L2C5RAFN/lPZ30Xtq03WDx+IzRirBpyiUkTZm5E0VSZQkv/aQ==
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr4164593ljd.94.1540621480064;
        Fri, 26 Oct 2018 23:24:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 37/78] git-imap-send.txt: move imap.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:10 +0200
Message-Id: <20181027062351.30446-38-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt        |  4 +--
 Documentation/config/imap.txt   | 44 ++++++++++++++++++++++++++++++++
 Documentation/git-imap-send.txt | 45 +--------------------------------
 3 files changed, 46 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/config/imap.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a44e717f30..d26656df95 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -353,9 +353,7 @@ include::config/http.txt[]
 
 include::config/i18n.txt[]
 
-imap::
-	The configuration variables in the 'imap' section are described
-	in linkgit:git-imap-send[1].
+include::config/imap.txt[]
 
 index.threads::
 	Specifies the number of threads to spawn when loading the index.
diff --git a/Documentation/config/imap.txt b/Documentation/config/imap.txt
new file mode 100644
index 0000000000..06166fb5c0
--- /dev/null
+++ b/Documentation/config/imap.txt
@@ -0,0 +1,44 @@
+imap.folder::
+	The folder to drop the mails into, which is typically the Drafts
+	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
+	"[Gmail]/Drafts". Required.
+
+imap.tunnel::
+	Command used to setup a tunnel to the IMAP server through which
+	commands will be piped instead of using a direct network connection
+	to the server. Required when imap.host is not set.
+
+imap.host::
+	A URL identifying the server. Use an `imap://` prefix for non-secure
+	connections and an `imaps://` prefix for secure connections.
+	Ignored when imap.tunnel is set, but required otherwise.
+
+imap.user::
+	The username to use when logging in to the server.
+
+imap.pass::
+	The password to use when logging in to the server.
+
+imap.port::
+	An integer port number to connect to on the server.
+	Defaults to 143 for imap:// hosts and 993 for imaps:// hosts.
+	Ignored when imap.tunnel is set.
+
+imap.sslverify::
+	A boolean to enable/disable verification of the server certificate
+	used by the SSL/TLS connection. Default is `true`. Ignored when
+	imap.tunnel is set.
+
+imap.preformattedHTML::
+	A boolean to enable/disable the use of html encoding when sending
+	a patch.  An html encoded patch will be bracketed with <pre>
+	and have a content type of text/html.  Ironically, enabling this
+	option causes Thunderbird to send the patch as a plain/text,
+	format=fixed email.  Default is `false`.
+
+imap.authMethod::
+	Specify authenticate method for authentication with IMAP server.
+	If Git was built with the NO_CURL option, or if your curl version is older
+	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
+	option, the only supported method is 'CRAM-MD5'. If this is not set
+	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 7b157441eb..65b53fcc47 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -57,50 +57,7 @@ to appropriate values.
 Variables
 ~~~~~~~~~
 
-imap.folder::
-	The folder to drop the mails into, which is typically the Drafts
-	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
-	"[Gmail]/Drafts". Required.
-
-imap.tunnel::
-	Command used to setup a tunnel to the IMAP server through which
-	commands will be piped instead of using a direct network connection
-	to the server. Required when imap.host is not set.
-
-imap.host::
-	A URL identifying the server. Use an `imap://` prefix for non-secure
-	connections and an `imaps://` prefix for secure connections.
-	Ignored when imap.tunnel is set, but required otherwise.
-
-imap.user::
-	The username to use when logging in to the server.
-
-imap.pass::
-	The password to use when logging in to the server.
-
-imap.port::
-	An integer port number to connect to on the server.
-	Defaults to 143 for imap:// hosts and 993 for imaps:// hosts.
-	Ignored when imap.tunnel is set.
-
-imap.sslverify::
-	A boolean to enable/disable verification of the server certificate
-	used by the SSL/TLS connection. Default is `true`. Ignored when
-	imap.tunnel is set.
-
-imap.preformattedHTML::
-	A boolean to enable/disable the use of html encoding when sending
-	a patch.  An html encoded patch will be bracketed with <pre>
-	and have a content type of text/html.  Ironically, enabling this
-	option causes Thunderbird to send the patch as a plain/text,
-	format=fixed email.  Default is `false`.
-
-imap.authMethod::
-	Specify authenticate method for authentication with IMAP server.
-	If Git was built with the NO_CURL option, or if your curl version is older
-	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
+include::config/imap.txt[]
 
 Examples
 ~~~~~~~~
-- 
2.19.1.647.g708186aaf9

