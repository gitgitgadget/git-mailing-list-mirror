Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2E551F4C1
	for <e@80x24.org>; Mon, 14 Oct 2019 20:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbfJNUrD (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 16:47:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43525 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfJNUrC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 16:47:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id i32so10732992pgl.10
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 13:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9PdrpY76MAcG/lD3vgaxj2WyD/3XJP3q2wgW4VbWKYQ=;
        b=ADXkIpHo6/eog3seRUUNz2JgIysxTuVdH2pTLtdU3AKx6eg9u3GANKg2SXuobnqsW3
         CgXYx9N7nzHziT/0tjdwzafIZnjgcdjIgZEDLZtfW5JaZoJOVCC98zZuiNMnTak2uwco
         MvG0ROBUnZDbjWKEXTNmCfFf4aRg8Ne8X05gopoKzD+MaUfsYAg9SMYXfMGLGO7Fhimn
         7IDHp4T/o/D8IJt8U1MNQENGlKbs8+0DHSkV5VoIjuNPNxtXy+Ady2ynINaxsrpr9X/w
         kSjujzOpbPQ2ehHR4Fv38XYjuybxLMBpd534gFajEYcUJHDtxlSa4wbpslU/Hc/W7FSq
         BZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9PdrpY76MAcG/lD3vgaxj2WyD/3XJP3q2wgW4VbWKYQ=;
        b=o/4lcZ7l1v0puvEgC3vbx4ukxcXXk9TeF3H29EvRz6uaq8NbYNSAzFSGsGnhixmWio
         YQyQ2RytCjRIAbfUG3hRZGDa8s4meQnzWwNxqXXDHto73ht6iOePKpF5mcXZHPDmvCCv
         imXd/J3GnoiBfRBeXPpU6/4PGD9oJMDpyTXyJREnM19fGvTzx19n48PaEyyveks+RDWY
         UlWvSb5n2GN7Olws5yoGX1Glg7YYVUYSaNXWAvOrKBCGvZw9Fs5AyD0MTWP/q3R9xkZc
         CMGToA/Am09TzlBuuLw8ntAGTX3LI+LA4U/h9Wz6LXYiAJaECtrsOREoU+ggcKsTUqCW
         nGTA==
X-Gm-Message-State: APjAAAUf/a0gegtDw33DcaF6sqSq0B37J8djWH6Eq1oAKyaE/cSF24c0
        Fkn+LzOkgCChU7qd7CNbNHhk52Cx
X-Google-Smtp-Source: APXvYqyNkRHKfU/XNo5kdEH/lNnp38HUGPIO09NgGddAGuUWgsUUpGWXR+cIktWppnc8wMHNgpej0w==
X-Received: by 2002:a63:c40e:: with SMTP id h14mr34705890pgd.254.1571086021493;
        Mon, 14 Oct 2019 13:47:01 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id r28sm24113245pfg.62.2019.10.14.13.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 13:47:00 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:46:59 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 1/3] format-patch: change erroneous and condition
Message-ID: <56fb230ad271dc9aa91c0f43ac8e4e7085c15775.1571085952.git.liu.denton@gmail.com>
References: <cover.1570821015.git.liu.denton@gmail.com>
 <cover.1571085952.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571085952.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 30984ed2e9 (format-patch: support deep threading, 2009-02-19),
introduced the following lines:

	#define THREAD_SHALLOW 1

	[...]

	thread = git_config_bool(var, value) && THREAD_SHALLOW;

Since git_config_bool() returns a bool, the trailing `&& THREAD_SHALLOW`
is a no-op.

In Python, `x and y` is equivalent to `y if x else x`[1]. Since this
seems to be a Python-ism that's mistakenly leaked into our code, convert
this to the equivalent C expression.

[1]: https://docs.python.org/3/reference/expressions.html#boolean-operations

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 44b10b3415..351f4ffcfd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -835,7 +835,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			thread = THREAD_SHALLOW;
 			return 0;
 		}
-		thread = git_config_bool(var, value) && THREAD_SHALLOW;
+		thread = git_config_bool(var, value) ? THREAD_SHALLOW : THREAD_UNSET;
 		return 0;
 	}
 	if (!strcmp(var, "format.signoff")) {
-- 
2.23.0.17.g315c308950

