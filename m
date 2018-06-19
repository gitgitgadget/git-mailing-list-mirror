Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E286C1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 18:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030246AbeFSSGK (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 14:06:10 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:54380 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030228AbeFSSGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 14:06:09 -0400
Received: by mail-wm0-f43.google.com with SMTP id o13-v6so1809921wmf.4
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CHYjx2R7EuLYWWYNvEa5Gkz9b7lo1udRl2JLDcq+YSM=;
        b=HNscPDt0hK00J0Pwmke4/TOrWoH9ULho7LrQg8FSW/vAEYfZ5/kNLrKviNIKOum8NU
         5V0MalGkN+sNlxLqzKjUqPFwgGSqB8JBK7x26hvK0GefSOsuzydS8DxtrpLaAAY4/wK0
         sqHWzc77ZzkNoNYoMI4Jg/TUosd2luSZFvAH5D5pOqQw+bLe1y0cwLulYIsjqVlzEMey
         ZjZ38Fmyog3WKuUqg5Cc86Qjco0ixXLKGTltgqVPcv6O1EQpwr1irDUJoOEOWy3dtP9+
         o4RXIugGdqmN9IQ9+Aps+8UtjC252mqm0r65LSbwS/EhrAdbgLtudCc9yj+bwn52+3+r
         q8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CHYjx2R7EuLYWWYNvEa5Gkz9b7lo1udRl2JLDcq+YSM=;
        b=fQzl5vFt3rcSlP+jv2K8pHIfYl4L1hptHUug8eU+J08InRUZI5R2WTkiYRkNv6mubT
         WKGBt4fPAkNUUXtsLSDzcBVt4U+VG+R5IUXcE2KqPeLqYJWoaX7fe97ppwa+JH/aKSqR
         9Q34zJmrVXHI+a4AljabH29WxAWMa7A86MoLtC0HPrt/5KjLOqwW/RnchBGX8A2OKlzn
         qnOkvo8/sNvtsATBCHC+S+yhEbHQ3fnV7xe5crw6eOx4hb51rT1a9Y6sCwS5AEW9/jD5
         n2ykJ5uOCuIHD4m9sGOZtUmgESWR0fuyHHF9jJKwcDbD7g5L8Xw5QZyRZGc43seW6BdM
         8kSA==
X-Gm-Message-State: APt69E1Pgme7UTKbNFFLoiftNj/1Fp1n1DCxEXUyDvxScJfaUM+V/EGy
        PGHnCr+6T06LjeYj5LxoISg=
X-Google-Smtp-Source: ADUXVKKM8bYLisGhSdmpmHbaulXmGrZn4WUkAAPUmVgk5Q59nBmnyQCPaMJI0/m3Bkvd6J4MDXAEFA==
X-Received: by 2002:a1c:d8:: with SMTP id 207-v6mr11579407wma.99.1529431567496;
        Tue, 19 Jun 2018 11:06:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n7-v6sm359493wrr.39.2018.06.19.11.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:06:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>, max@max630.net
Subject: Re: t5562: gzip -k is not portable
References: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de>
Date:   Tue, 19 Jun 2018 11:06:06 -0700
In-Reply-To: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 19 Jun 2018 19:25:15
 +0200")
Message-ID: <xmqqk1quvegh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> Hej Max,
>
> t5562 fails here under MacOS:
> "gzip -k"  is not portable.

Sigh.  Perhaps -c would help.  Or do BSD implementations also lack -c?

 t/t5562-http-backend-content-length.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 8040d80e04..98b6543827 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -61,9 +61,9 @@ test_expect_success 'setup' '
 '
 
 test_expect_success GZIP 'setup, compression related' '
-	gzip -k fetch_body &&
+	gzip -c fetch_body >fetch_body.gz &&
 	test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
-	gzip -k push_body &&
+	gzip -c push_body >push_body.gz &&
 	test_copy_bytes 10 <push_body.gz >push_body.gz.trunc
 '
 
