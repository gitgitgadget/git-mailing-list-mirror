Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3C7C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 21:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBBVKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 16:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBBVKP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 16:10:15 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBE271640
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 13:10:13 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 7so2285016pga.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 13:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bY8li3sb9CSM8Oi9TP6yWDKPcIMRLmv6BYGBVi8E3Cs=;
        b=YLcbdcc7vlLILPesAeXKTr3rFN0ZyL8mR7PVcDufD3UmvwqBwWtPc6OLNeaxGLXzbi
         z+YCkw+wQ7Dsmkkcln7KTk/7B0okoYnALt/NBxgBHGOckXWAI4L2DJQ/vM+pY5K4geFg
         JiJSiLsDjYgETzJyJWhoYUUX+h8Bh+xrFB2inuhGXOcqyKfIyRiGu8DKW5W9M+nQIpmG
         mG3NyADO+IUMGtuTCWJ7tKt033fmY3A2yJhbOR6ZGD1XJr0yFWFgfiLGWk7NA6lxpjXj
         e+n4GQzCCPFfLlPNV8G4NAN7fWVtff578gG8oW2J5tozGJ5hOHEdX7wVg3pG9LA9QF9A
         KmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bY8li3sb9CSM8Oi9TP6yWDKPcIMRLmv6BYGBVi8E3Cs=;
        b=d3Is5d4v5FJmDMb4WAkqLcKcUw2i7VBXAnh8EtGCNSrdjyYAJJfhvWCGTuhjq4ETv7
         Cz6JCVqUpSboBVDMnLDp9yQypsHLL7UznvVU3ulEGku+GCx4Fed9tls3i8UihQN9uwrQ
         5tRzUPN3G0Woht79pYDOV3Sf+T1+mL1vl3/YP/Z20pIgC3uoM1PMFDrYwlrVgbni1GPL
         Z9RvTueUWuLK/Q+Qmw/4pg893gexWxqDvK073eXRu6+gJYXikaDEkwaAiGmnIBUHvFSa
         H9OHABU9yuWYFP8cG0BXBQMvGRS45C/nN2h53toIB/ELI/bHgw9xbaWOR5Zjq2hki1/r
         pDtw==
X-Gm-Message-State: AO0yUKUlhpVdhYeDxaut8ZsW+JpE84eh5vbnNgbEwGdtWGZiErRm5qBr
        SsYcShsXijv0hHHQlhoCFyc=
X-Google-Smtp-Source: AK7set/1j7Y7NZaOW4Gws07nBYD9lwyhn0nxMC9EcbnpYLlCQ1kqIuZH7dzDz3uIqpTZRi7HJEUrRg==
X-Received: by 2002:aa7:854f:0:b0:587:f436:6ea8 with SMTP id y15-20020aa7854f000000b00587f4366ea8mr6757601pfn.16.1675372212661;
        Thu, 02 Feb 2023 13:10:12 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id k131-20020a628489000000b0058dbd7a5e0esm129494pfd.89.2023.02.02.13.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:10:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] t4113: indent with tabs
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
        <20230202171821.10508-1-cheskaqiqi@gmail.com>
        <20230202171821.10508-5-cheskaqiqi@gmail.com>
Date:   Thu, 02 Feb 2023 13:10:11 -0800
In-Reply-To: <20230202171821.10508-5-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Thu, 2 Feb 2023 12:18:21 -0500")
Message-ID: <xmqqsffnsrik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> t4113-apply-ending.sh used 4-column indent with
> space,fix it in use tabs for indentation.

Good, but end the sentence with a full-top with a space after it,
and start the next sentence with a capital letter.


> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  t/t4113-apply-ending.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
> index d5b15e97d3..9e28c72355 100755
> --- a/t/t4113-apply-ending.sh
> +++ b/t/t4113-apply-ending.sh
> @@ -23,11 +23,11 @@ echo 'b' >>file
>  echo 'c' >>file
>  
>  test_expect_success setup '
> -    git update-index --add file
> +	git update-index --add file
>  '

This is not wrong per se, but the modern style is to avoid having
any executable lines outside test_expect_foo.  I'd expect that the
resulting script begins more like the attached.  [PATCH 4/4] stops
the conversion in the middle, which leaves funny taste in our mouth.

Thanks.

diff --git i/t/t4113-apply-ending.sh w/t/t4113-apply-ending.sh
index 66fa51591e..9746f45898 100755
--- i/t/t4113-apply-ending.sh
+++ w/t/t4113-apply-ending.sh
@@ -8,24 +8,20 @@ test_description='git apply trying to add an ending line.
 '
 . ./test-lib.sh
 
-# setup
-
-cat >test-patch <<\EOF
-diff --git a/file b/file
---- a/file
-+++ b/file
-@@ -1,2 +1,3 @@
- a
- b
-+c
-EOF
-
-echo 'a' >file
-echo 'b' >>file
-echo 'c' >>file
-
-test_expect_success setup \
-    'git update-index --add file'
+test_expect_success setup '
+	cat >test-patch <<-\EOF
+	diff --git a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1,2 +1,3 @@
+	 a
+	 b
+	+c
+	EOF
+
+	test_write_lines a b c >file
+	git update-index --add file
+'
 
 # test
 


