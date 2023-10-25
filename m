Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161615AE5
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pcsOdVk3"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2B6BB
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 15:53:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9c145bb5bso27695ad.1
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698274394; x=1698879194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sVqeGpdzFijl7pBD8uYc6CkN7L9jou3+eQ+mhcxy0Es=;
        b=pcsOdVk3Ks1iuWhoNW10ugHCx9cuDf56VHhCj106jIl3k/IutGkkfTvO1kveN5XVJW
         MrzZNhmsE+hQUPZcNqwg06NhdSREd4bZmiWZgPyyhYOSEHHDAkmGVvRsM0xWWLYr59vb
         nIwy4eAMrZu0nMkqttpMiPfLQsa4gHYl4DPi3Hz4LRiXgjc7yX7Nx+j7+s3Rc6+0rkGC
         LwFeseIet9jRri07huAKT/u0O2e07KMsDSM4v7NQcBdYKhbj4s0ecx+x0yy+bFVjPDx0
         Y4n1QOphabglef1H+OuM1gsQsgUI/m3xjaXLfhNE5YRs5UjshIRwdolH6ndBQGQEBAe6
         SxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698274394; x=1698879194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVqeGpdzFijl7pBD8uYc6CkN7L9jou3+eQ+mhcxy0Es=;
        b=SM3FtDrqBXojmsfn4uQ34p6hoC9ch5UzW0odErdWQfIy+yeMVSoVn9Gz0t/f+LQQ7T
         HHsfH7Q6zjweeIGc9uRnZ476cS0Cy+l176JpDST4n7TYNZrqhoTGZbn9f2lgu6MfXWq7
         tzfbhcsxirxvL/Y0YQOVsQQtjG3pbTeNtfadi4LEJC8MFaxncrGrPx5ZnLJKRTc22uae
         9N6SIC1nobgpn3GzHvCjZJlANcjUuyYu6oW8BgxR/zZyYj2uxUSAmaZxQQ+9578Z2A6K
         iJVtMqIIRVqqi8cSJeHWBQTFni+jaqqfad36VYHQyC3qsHBPblFXw/ImUBDoMzfO5Zu/
         dUHA==
X-Gm-Message-State: AOJu0YyCDyVBt7AG2dDE9cSXdYOlXaDTfhVGQtWSTkG5pVlw28QXOKl5
	dbun8tMgCM/LDYWsZ5r7aSgowwrZRIei/B/3KMNaew==
X-Google-Smtp-Source: AGHT+IE4SR2CjnKqwTOp/GByLrLwdHvKD3vOWQB+4ZiJtfGT2g2Ys4uNQ+BzfcpRZgmMWA8IcFjB2g==
X-Received: by 2002:a17:902:f60b:b0:1c6:212f:c8e5 with SMTP id n11-20020a170902f60b00b001c6212fc8e5mr334070plg.26.1698274393527;
        Wed, 25 Oct 2023 15:53:13 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:a9a1:5044:5663:ae78])
        by smtp.gmail.com with ESMTPSA id s10-20020a65690a000000b005b61a024ec7sm8030932pgq.74.2023.10.25.15.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 15:53:12 -0700 (PDT)
Date: Wed, 25 Oct 2023 15:53:08 -0700
From: Emily Shaffer <nasamuffin@google.com>
To: Sheik <sahibzone@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git bugreport with invalid CLI argument does not report error
Message-ID: <ZTmcVJaY2TjFCVyw@google.com>
References: <7a92b537-ba88-4667-bb18-2e8c74aa9915@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a92b537-ba88-4667-bb18-2e8c74aa9915@gmail.com>

On Thu, Oct 26, 2023 at 07:59:16AM +1100, Sheik wrote:
> 
> Hi Maintainers,
> 
> 
> Running git bugreport with an invalid CLI argument in a valid Git directory
> does not report error. Expected behaviour would be that it reports an error.
> 
> 
> #Example git commands which should have reported an error but continues to
> succeed
> 
> cd $ToAnyDirectory
> 
> git bugreport diagnose

It looks like parse-options.[ch] helps us here for misspelled dashed
options, like `--diaggnose`. But it doesn't complain when there are
unexpected positional arguments. I think we can just notice if there are
any argc left over, complain, and print usage.

I put together a quick patch; could be that we don't need to leave this
error about "positional arguments" and can leave it as an exercise to
the reader to compare their previous command to the usage text. I guess
we could also unroll remaining argv but it was just a hair more time
than I wanted to spend ;)

 - Emily

--- 8< ---

From 2031c7f55652559b8b4ec3c67ce4c4f94a355762 Mon Sep 17 00:00:00 2001
From: Emily Shaffer <nasamuffin@google.com>
Date: Wed, 25 Oct 2023 15:45:25 -0700
Subject: [PATCH] bugreport: reject positional arguments

git-bugreport already rejected unrecognized flag arguments, like
`--diaggnose`, but this doesn't help if the user's mistake was to forget
the `--` in front of the argument. This can result in a user's intended
argument not being parsed with no indication to the user that something
went wrong. Since git-bugreport presently doesn't take any positionals
at all, let's reject all positionals and give the user a usage hint.

Signed-off-by: Emily Shaffer <nasamuffin@google.com>
---
 builtin/bugreport.c  | 5 +++++
 t/t0091-bugreport.sh | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index d2ae5c305d..eb6234a50d 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -126,6 +126,11 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, bugreport_options,
 			     bugreport_usage, 0);
 
+	if (argc) {
+		error(_("git bugreport does not take positional arguments"));
+		usage(bugreport_usage[0]);
+	}
+
 	/* Prepare the path to put the result */
 	prefixed_filename = prefix_filename(prefix,
 					    option_output ? option_output : "");
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index f6998269be..2061d6f386 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -69,6 +69,12 @@ test_expect_success 'incorrect arguments abort with usage' '
 	test_path_is_missing git-bugreport-*
 '
 
+test_expect_success 'incorrect positional arguments abort with usage' '
+	test_must_fail git bugreport false 2>output &&
+	test_i18ngrep usage output &&
+	test_path_is_missing git-bugreport-*
+'
+
 test_expect_success 'runs outside of a git dir' '
 	test_when_finished rm non-repo/git-bugreport-* &&
 	nongit git bugreport
-- 
2.42.0.758.gaed0368e0e-goog


