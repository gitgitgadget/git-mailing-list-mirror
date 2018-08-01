Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BAB01F597
	for <e@80x24.org>; Wed,  1 Aug 2018 19:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbeHAVAe (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 17:00:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36075 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeHAVAd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 17:00:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id w24-v6so199997wmc.1
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1kXPxR9DF3msz0YqWhuvs6JD66BrvutdftpyO8czamc=;
        b=bnmm91E3/mC01naBX5cGM2nl0tQFbrGgs79mqJByzMhMaF/DCqDBVT4/NqxiXigNZ1
         xnJDHPvih++ITdFuhPpYIFNO9Hhnzp2cwXILiBOkvO6JpGZ7yhvxB9hYmm0Fqlo5Lc0G
         6lxgK5y0I8/rr01VAGAaurzcOZ2rTdBRtKAG8Gh3bGvWEjyQO7wjSVLUWHZS8Fwix4Xn
         u9vSyYkqNzuem6x58bET31JAN8v9C0XlOt566lxn/at4C9f3B/kadATqncVSW4Zw/zki
         DIBeBqwWcTOtadYP+JfuAfIzEh52S2bvjBnigsLeRXiCrp+JwnkrnZazEhwD/BJDv904
         3e8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1kXPxR9DF3msz0YqWhuvs6JD66BrvutdftpyO8czamc=;
        b=c2Z2dyZhfStFzunteORusi4fQHP4qxezRGvXuJJJIZNKAYINM8Mqjg7D2juqu/pO31
         YxbM+0x/yAxyncTbV0576qMIe2O6qrUX2SGuF2g6AF/Fnc9F/9yS3DguE9TI+V3Z5Phd
         zHx/w4JxcdujkhEaD5VX4IO8UF8P9ZISfHq0SOgxdrJ1v5dia7dPnUgqODNL0NkTB8vA
         txYmny9bQm6tvztpJw1HsktCDMgjrgU82kId9/8LwiDFTRmmDoFMf1yVGYE5akPdobCW
         18XdFF/1LlcXwDLpVMP0Do4KK4tKDsw0bN6xTsYSiAnTaKCXRX2HvDbPsSOzj4Vfbd3Z
         VSEw==
X-Gm-Message-State: AOUpUlGRXO3NaMFdvrA6W9/pU+YiBp2r5TUDdgcsLBJTcbr5wh2yKrQx
        I7y0w+r3WYlLfy76w0I8XjM=
X-Google-Smtp-Source: AAOMgpdMut/PSLujrYeJBaZnXRbCkbn/fk+PgpK4NHb4RW+bdVBgzcXp1NM1p+wr9ByGLm9wFKMFpw==
X-Received: by 2002:a1c:85cc:: with SMTP id h195-v6mr89805wmd.110.1533150797889;
        Wed, 01 Aug 2018 12:13:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c124-v6sm65633wma.47.2018.08.01.12.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 12:13:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        sunshine@sunshineco.com
Subject: Re: [PATCHv2 0/8] Add color test for range-diff, simplify diff.c
References: <20180728030448.192177-1-sbeller@google.com>
        <20180731003141.105192-1-sbeller@google.com>
Date:   Wed, 01 Aug 2018 12:13:16 -0700
In-Reply-To: <20180731003141.105192-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 30 Jul 2018 17:31:33 -0700")
Message-ID: <xmqq8t5p7veb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Stefan Beller (8):
>   test_decode_color: understand FAINT and ITALIC
>   t3206: add color test for range-diff --dual-color
>   diff.c: simplify caller of emit_line_0
>   diff.c: reorder arguments for emit_line_ws_markup
>   diff.c: add set_sign to emit_line_0
>   diff: use emit_line_0 once per line
>   diff.c: compute reverse locally in emit_line_0
>   diff.c: rewrite emit_line_0 more understandably
>
>  diff.c                  | 94 +++++++++++++++++++++++------------------
>  t/t3206-range-diff.sh   | 39 +++++++++++++++++
>  t/test-lib-functions.sh |  2 +
>  3 files changed, 93 insertions(+), 42 deletions(-)

As I cannot merge this as is to 'pu' and keep going, I'll queue the
following to the tip.  I think it can be squashed to "t3206: add
color test" but for now they will remain separate patches.

Subject: [PATCH] fixup! t3206: add color test for range-diff --dual-color

---
 t/t3206-range-diff.sh | 64 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 019724e61a..e3b0764b43 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -143,38 +143,38 @@ test_expect_success 'changed message' '
 '
 
 test_expect_success 'dual-coloring' '
-	cat >expect <<-\EOF &&
-	<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
-	<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
-	    <REVERSE><CYAN>@@ -2,6 +2,8 @@<RESET>
-	     <RESET>
-	         s/4/A/<RESET>
-	     <RESET>
-	    <REVERSE><GREEN>+<RESET> <BOLD>   Also a silly comment here!<RESET>
-	    <REVERSE><GREEN>+<RESET>
-	     diff --git a/file b/file<RESET>
-	    <RED> --- a/file<RESET>
-	    <GREEN> +++ b/file<RESET>
-	<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
-	    <REVERSE><CYAN>@@ -10,7 +10,7 @@<RESET>
-	      9<RESET>
-	      10<RESET>
-	    <RED> -11<RESET>
-	    <REVERSE><RED>-<RESET><FAINT;GREEN>+BB<RESET>
-	    <REVERSE><GREEN>+<RESET><BOLD;GREEN>+B<RESET>
-	      12<RESET>
-	      13<RESET>
-	      14<RESET>
-	<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
-	    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
-	    <CYAN> @@<RESET>
-	      9<RESET>
-	      10<RESET>
-	    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
-	    <REVERSE><GREEN>+<RESET> <BOLD>B<RESET>
-	    <RED> -12<RESET>
-	    <GREEN> +B<RESET>
-	      13<RESET>
+	sed -e "s|^:||" >expect <<-\EOF &&
+	:<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
+	:<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
+	:    <REVERSE><CYAN>@@ -2,6 +2,8 @@<RESET>
+	:     <RESET>
+	:         s/4/A/<RESET>
+	:     <RESET>
+	:    <REVERSE><GREEN>+<RESET> <BOLD>   Also a silly comment here!<RESET>
+	:    <REVERSE><GREEN>+<RESET>
+	:     diff --git a/file b/file<RESET>
+	:    <RED> --- a/file<RESET>
+	:    <GREEN> +++ b/file<RESET>
+	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
+	:    <REVERSE><CYAN>@@ -10,7 +10,7 @@<RESET>
+	:      9<RESET>
+	:      10<RESET>
+	:    <RED> -11<RESET>
+	:    <REVERSE><RED>-<RESET><FAINT;GREEN>+BB<RESET>
+	:    <REVERSE><GREEN>+<RESET><BOLD;GREEN>+B<RESET>
+	:      12<RESET>
+	:      13<RESET>
+	:      14<RESET>
+	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
+	:    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
+	:    <CYAN> @@<RESET>
+	:      9<RESET>
+	:      10<RESET>
+	:    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
+	:    <REVERSE><GREEN>+<RESET> <BOLD>B<RESET>
+	:    <RED> -12<RESET>
+	:    <GREEN> +B<RESET>
+	:      13<RESET>
 	EOF
 	git range-diff changed...changed-message --color --dual-color >actual.raw &&
 	test_decode_color >actual <actual.raw &&
-- 
2.18.0-321-gffc6fa0e39


