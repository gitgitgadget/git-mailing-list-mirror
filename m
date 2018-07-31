Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09ABE1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 19:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeGaV0y (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:26:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44347 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbeGaV0x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:26:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so17829553wrt.11
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 12:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9J7zyWMgvqjGfCiG5WXaB/+IXCK/eJfYzEQU/N6Pg74=;
        b=ZGgz+Df9l9Zdv7q72czx9aMNgYfp5F5xp5u7rMayK7IPQa+C3xVThxUtsdPJ/3rfoj
         wuSAyJsHMRfElY8uIU0jaApJvtKilTy09fQ3XncQrVJ0nN2ES3x+zMlqQUdT5JN++TGh
         OqnRu26/oVJe6ZU+W9AmRpjHBno2JfuBYJXYZQQQzRv5nZDYm0KHGU8S+FsgBg7ouTwr
         k2q1cU+MW6ArNj4GzTtJxS2D1tMHudcISmU6dmWa5lPPAFX/Lk+9DoLnL5oyViGQ+mmJ
         nrxjanuycIgWgZMGXJ+rfFYVOxTp9y5+MrGB0IyjXx3jrpf6tlZmwe9ndRnOrHUWA/3K
         gQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9J7zyWMgvqjGfCiG5WXaB/+IXCK/eJfYzEQU/N6Pg74=;
        b=MV97r/0ohT2S4y3Chl8b9DLUKx4T7LaHNuB/5OAr+7tK1DVVU8ymDibZkBRid6BYjz
         uCTUHTwKWGzIym280azrp3Y5jEsXiOxnB34Lo4byo/wwynY9Zzlw8J163z14ShLVaQWM
         kpdmLkfCZkqN1+kekMr4kwaQHOXXhg1iutLkE+rPxcvNU3zmFbTPIcmuCQwlpDMjETNN
         2QaJD0xOojq+RkSNo/Ql9cDI1uwYEhkOe5z8gRnhGc0jjLDWMqc0VnUfuswmMsB4cOC9
         78d97IMUdbTeJPi/Q30gTti36ufWcAl2TxGstbDxd1mFUekL3x/1q9MQC/b5IGsjoFnl
         ckQA==
X-Gm-Message-State: AOUpUlFStNrMfDKpgI1LIUJw3ZSqbwXMNX28GKwlbZ4NUKXo4LAdSEdZ
        ZYFf/CSC5J9C7EicGq5fSmA=
X-Google-Smtp-Source: AAOMgpcJ0IYzBssfYt8VroH8wzQeTGsvSrjc91mZWKl1POJ+1aeLL2owjhZTO8PxV7ggP9mALhcDSQ==
X-Received: by 2002:adf:9d46:: with SMTP id o6-v6mr21982606wre.51.1533066301502;
        Tue, 31 Jul 2018 12:45:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t70-v6sm4074519wmt.30.2018.07.31.12.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:45:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Highlight keywords in remote sideband output.
References: <20180731173651.184716-1-hanwen@google.com>
        <20180731173651.184716-3-hanwen@google.com>
Date:   Tue, 31 Jul 2018 12:45:00 -0700
In-Reply-To: <20180731173651.184716-3-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Tue, 31 Jul 2018 19:36:51 +0200")
Message-ID: <xmqqa7q7b35v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> The highlighting is done on the client-side. Supported keywords are
> "error", "warning", "hint" and "success".
>
> The colorization is controlled with the config setting "color.remote".
>
> Co-authored-by: Duy Nguyen <pclouds@gmail.com>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>

Thanks.  I'll squash the following in while queuing, though.

 * maybe_colorize_sideband() does not have outside caller; make it
   static to avoid missing-prototype error that breaks compilation.

 * correct space-before-tab whitespace style violation.

 * use write_script.

 * a test script must be executable to avoid triggering test-lint.

 * avoid overlong lines in the test.

 * no SP between redirection operator and its target.

Other than that, the result looks good to me.  So that others can
eyeball the result once more, I'll keep it in 'pu' for a few days,
and if nothing else comes up, hopefully the topic can be merged to
'next' after that.


diff --git a/sideband.c b/sideband.c
index 0d67583ec5..be4635446c 100644
--- a/sideband.c
+++ b/sideband.c
@@ -60,12 +60,12 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
  * Optionally highlight some keywords in remote output if they appear at the
  * start of the line.
  */
-void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
+static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 {
 	int i;
 
 	load_sideband_colors();
- 	if (!want_color_stderr(sideband_use_color)) {
+	if (!want_color_stderr(sideband_use_color)) {
 		strbuf_add(dest, src, n);
 		return;
 	}
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
old mode 100644
new mode 100755
index 4e1bd421ff..4547ec95b8
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -6,27 +6,27 @@ test_description='remote messages are colorized on the client'
 
 test_expect_success 'setup' '
 	mkdir .git/hooks &&
-	cat << EOF > .git/hooks/update &&
-#!/bin/sh
-echo error: error
-echo hint: hint
-echo success: success
-echo warning: warning
-echo prefixerror: error
-exit 0
-EOF
-	chmod +x .git/hooks/update &&
+	write_script .git/hooks/update <<-\EOF &&
+	echo error: error
+	echo hint: hint
+	echo success: success
+	echo warning: warning
+	echo prefixerror: error
+	exit 0
+	EOF
+
 	echo 1 >file &&
 	git add file &&
 	git commit -m 1 &&
 	git clone . child &&
 	cd child &&
-	echo 2 > file &&
+	echo 2 >file &&
 	git commit -a -m 2
 '
 
 test_expect_success 'push' '
-	git -c color.remote=always push -f origin HEAD:refs/heads/newbranch 2>output &&
+	git -c color.remote=always \
+		push -f origin HEAD:refs/heads/newbranch 2>output &&
 	test_decode_color <output >decoded &&
 	grep "<BOLD;RED>error<RESET>:" decoded &&
 	grep "<YELLOW>hint<RESET>:" decoded &&
@@ -36,7 +36,8 @@ test_expect_success 'push' '
 '
 
 test_expect_success 'push with customized color' '
-	git -c color.remote=always -c color.remote.error=white push -f origin HEAD:refs/heads/newbranch2 2>output &&
+	git -c color.remote=always -c color.remote.error=white \
+		push -f origin HEAD:refs/heads/newbranch2 2>output &&
 	test_decode_color <output >decoded &&
 	grep "<WHITE>error<RESET>:" decoded &&
 	grep "<YELLOW>hint<RESET>:" decoded &&

