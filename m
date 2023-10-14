Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503D15D2
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="Kt+e9GYi"
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF4EC0
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 21:01:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27cfb8442f9so1914357a91.2
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 21:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697256075; x=1697860875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lyvfKHPl2ZFAOu5EpaNHvDMXLhUYLdwTgxVd/gSprzA=;
        b=Kt+e9GYispGYNMcrmuVSogsO9gS/kRQGUPwBjPvq5IrBNwqL7jj8JCYxTojsvpoJsF
         E/MPzG+5yP9/uw+Eato3ilvIM+Qcr7CoyuHGskcIYH0+1MgPw4UmkPwFhdor/MDEBQAv
         4kh8Dcz5j5UAughrAOGoggUlC1/M3y0YXQhMh6i7gFHMgKaaMIeHPancFYVmib2JAtuy
         OTKWjftyuzfPicckejK+rdDZbZSpHp5ZwgMCTLLlm8w8xL6I4qo6Yao2avfubptW1i3Z
         mV8gpur5brxCvNGWPWEp7VY7Ud1idDLnF1UEObqlThPlJkF6gnUO5Evlv79XawnbNo6T
         OBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697256075; x=1697860875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyvfKHPl2ZFAOu5EpaNHvDMXLhUYLdwTgxVd/gSprzA=;
        b=pEB3li9y8P8oVWWSLYh9RK2g7mI5yZ4n0p97oRMIN5GRzdN+sSO89Q8KAcoGVcQYat
         JXfty/FELDPd0a8CKrbYOUmOLkilt5Xh5o6PLyzlrtfJdSQxqTnQPtedupDfyQ0lyNoA
         G5sRwJYmUE2lwU2OkU3M0MOyVu/3UoshBKI5c2XdESA1xVq7WGECMiN95Hm9Sor0nbDG
         IrjJLNB6SaA6BMTn/owgqaSzulHmegVLfnnGsXb0ifbQvgI6tof8KJir7JrtbvY1FtEd
         Y7hqIW9blXOVbMgppQYUL3WBbjPrfkMaThiBDsWfkkiYnZ6/Swkp15N9Rf+1zD6iy7UH
         3ljQ==
X-Gm-Message-State: AOJu0YxaFbIs/C+w9qq3wS45WqKk1aWIqFOhvxN0sOfZSkt9FoejE0nL
	HE9rLVgap+HPvI36STjRjVMXtJRv2UCSQl1vh9o=
X-Google-Smtp-Source: AGHT+IH625b7WpZseW1mIHw2kx/IhVQWEpB9k6mdwCpMleyvaVHSAuI60njT6f/q4hITygWItu4L/w==
X-Received: by 2002:a17:90a:983:b0:27c:edd6:b08d with SMTP id 3-20020a17090a098300b0027cedd6b08dmr10964678pjo.24.1697256074934;
        Fri, 13 Oct 2023 21:01:14 -0700 (PDT)
Received: from localhost.localdomain (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id gd1-20020a17090b0fc100b0026801e06ac1sm837767pjb.30.2023.10.13.21.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 21:01:14 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [PATCH] bugreport: add 'seconds' to default outfile name
Date: Fri, 13 Oct 2023 21:01:01 -0700
Message-ID: <20231014040101.8333-1-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.297.g393e7d1581
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, git bugreport postfixes the default bugreport filename (and
diagnostics zip filename if --diagnose is supplied) with the current
calendar hour and minute values, assuming the -s flag is absent.

If a user runs the bugreport command more than once within a calendar
minute, a filename conflict with an existing file occurs and the program
errors, since the new output filename was already used for the previous
file. If the user waits anywhere from 1 to 60 seconds (depending on
_when_ during the calendar minute the first command was run) the command
works again with no error since the default filename is now unique, and
multiple bug reports are able to be created with default settings.

This is a minor thing but can cause confusion especially for first time
users of the bugreport command, who are likely to run it multiple times
in quick succession to learn how it works, (like I did).

This patch adds the calendar second value to the default bugreport
filename. This technically just shortens the window during which the
issue occurs, but a single second is a small enough time increment that
users will avoid the filename conflict in practice in this scenario.

This means the user will end up with multiple bugreport files being
created if they run the command multiple times quickly, but that feels
more intuitive and consistent than an error arbitrarily occuring within
a calendar minute, especially given that the time window in which the
error currently occurs is variable as described above.

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 builtin/bugreport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index d2ae5c305d..b556c6e135 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -106,7 +106,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	struct tm tm;
 	enum diagnose_mode diagnose = DIAGNOSE_NONE;
 	char *option_output = NULL;
-	char *option_suffix = "%Y-%m-%d-%H%M";
+	char *option_suffix = "%Y-%m-%d-%H%M%S";
 	const char *user_relative_path = NULL;
 	char *prefixed_filename;
 	size_t output_path_len;

base-commit: 493f4622739e9b64f24b465b21aa85870dd9dc09
-- 
2.42.0.297.g393e7d1581

