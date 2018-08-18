Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56531F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeHRTYo (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:24:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55910 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeHRTYo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:24:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so10266193wmc.5
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NP6Mj+vrhj+QaVtOkfMf+Paijf70tH4F4YNSszgRv/k=;
        b=dF6iEDTYrFtJ4sGakalk+qu5vMBG7nCi8CG5nXAkAskkoVmlFA0244IQpEvg+BejBK
         W10oKwQyA4CbXwXuRvF49Bawg2SbC1I4/9Juz10UwjtOGvXGz9HhQBPYvPsdfC089fj+
         IQomc29UKBCuu0aFdUifd8Kr2PL+D4+Iiz3j8FizxbM5rPQ/+M0+GtUeKpj9S3AH95YD
         memRV+xlC/BfR+W5sQqv4g9JQHNqrUdYLCW8R4EbBSyCl+EGgEQ1iaBQH/d2rOoH5vzK
         5EOUyAAiOWNMjw5OKl/T0Nk91daGRsrDo1+koKCGumgIUJpn1D3IEZzUQFR6i0UK7sSY
         CP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NP6Mj+vrhj+QaVtOkfMf+Paijf70tH4F4YNSszgRv/k=;
        b=iwqeGjOq3O8orS7ui2xQKzBCo9+AXxgs4sVkxtZSOFbPRd0BQa/8HyqOyp1ITImvVe
         HgqM+rh2RrySd/B8EqzBH8D3PeFMVJPiyuTrO+nJB975sOg/sCa6Vno3W6elBJ0p7r0W
         w49TUbRT8+AMcOQRO887vqbred+MUs+o0QzfqtDFEqegAU08OW29vGrq6g9bKdVWksrz
         9sHKiwwzaGqf51xXikZbaP9aQ12/e2r9jKzlFqRwMfaZr7OZRn5SE11/WYunJX9aU03e
         /JegCXOaasb2YhGmL+in+0UnUmrjbJVv3VzD9JE+SX3tJxm827AVoTjiwGyYdQ+vigsv
         YYvQ==
X-Gm-Message-State: AOUpUlE8P5L7LHXwXSQKdkhOD6yBQxsaCO9P1z9CqJTRNAAQBE3dQsOt
        siCSidzgT35Qv0tn1mZkC5U=
X-Google-Smtp-Source: AA+uWPwyqu23O33gRX8K3gpQ5O9LxhpRr20lz25OtlR1URoAqppz0uJQbvnMrfQMybzCc90SxBJ4ug==
X-Received: by 2002:a1c:3545:: with SMTP id c66-v6mr21943626wma.120.1534608989086;
        Sat, 18 Aug 2018 09:16:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x82-v6sm19830757wmd.11.2018.08.18.09.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 09:16:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, sunshine@sunshineco.com,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v7 1/1] sideband: highlight keywords in remote sideband output
References: <20180807125108.104293-1-hanwen@google.com>
        <20180807125108.104293-2-hanwen@google.com>
        <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com>
        <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
        <20180818060911.GC241538@aiede.svl.corp.google.com>
        <xmqqmutjagc7.fsf@gitster-ct.c.googlers.com>
        <xmqqin47acir.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 18 Aug 2018 09:16:28 -0700
In-Reply-To: <xmqqin47acir.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 18 Aug 2018 09:02:36 -0700")
Message-ID: <xmqqa7pjabvn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>>> -	strbuf_add(dest, src, n);
>>>> +	if (0 < n)
>>>> +		strbuf_add(dest, src, n);
>>>
>>> This check seems unnecessary.  strbuf_add can cope fine with !n.
>>
>> I was primarily interested in catching negatives, and !n was a mere
>> optimization, but you are correct to point out that negative n at
>> this point in the codeflow is a BUG().
>
> Actually, let's just lose the conditional.  strbuf_add() would catch
> and issue an error message when it notices that we fed negative
> count anyway ;-).

So I'll have this applied on top of the original topic to prevent a
buggy version from escaping the lab.

-- >8 --
Subject: [PATCH] sideband: do not read beyond the end of input

The caller of maybe_colorize_sideband() gives a counted buffer
<src, n>, but the callee checked src[] as if it were a NUL terminated
buffer.  If src[] had all isspace() bytes in it, we would have made
n negative, and then

 (1) made number of strncasecmp() calls to see if the remaining
     bytes in src[] matched keywords, reading beyond the end of the
     array (this actually happens even if n does not go negative),
     and/or

 (2) called strbuf_add() with negative count, most likely triggering
     the "you want to use way too much memory" error due to unsigned
     integer overflow.

Fix both issues by making sure we do not go beyond &src[n].

In the longer term we may want to accept size_t as parameter for
clarity (even though we know that a sideband message we are painting
typically would fit on a line on a terminal and int is sufficient).
Write it down as a NEEDSWORK comment.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sideband.c                          |  8 ++++++--
 t/t5409-colorize-remote-messages.sh | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index 1c6bb0e25b..368647acf8 100644
--- a/sideband.c
+++ b/sideband.c
@@ -65,6 +65,8 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
  * Optionally highlight one keyword in remote output if it appears at the start
  * of the line. This should be called for a single line only, which is
  * passed as the first N characters of the SRC array.
+ *
+ * NEEDSWORK: use "size_t n" instead for clarity.
  */
 static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 {
@@ -75,7 +77,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		return;
 	}
 
-	while (isspace(*src)) {
+	while (0 < n && isspace(*src)) {
 		strbuf_addch(dest, *src);
 		src++;
 		n--;
@@ -84,6 +86,9 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
 		struct keyword_entry *p = keywords + i;
 		int len = strlen(p->keyword);
+
+		if (n <= len)
+			continue;
 		/*
 		 * Match case insensitively, so we colorize output from existing
 		 * servers regardless of the case that they use for their
@@ -101,7 +106,6 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 	}
 
 	strbuf_add(dest, src, n);
-
 }
 
 
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index eb1b8aa05d..f81b6813c0 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -15,6 +15,8 @@ test_expect_success 'setup' '
 	echo warning: warning
 	echo prefixerror: error
 	echo " " "error: leading space"
+	echo "    "
+	echo Err
 	exit 0
 	EOF
 	echo 1 >file &&
@@ -44,6 +46,12 @@ test_expect_success 'whole words at line start' '
 	grep "prefixerror: error" decoded
 '
 
+test_expect_success 'short line' '
+	git -C child -c color.remote=always push -f origin HEAD:short-line 2>output &&
+	test_decode_color <output >decoded &&
+	grep "remote: Err" decoded
+'
+
 test_expect_success 'case-insensitive' '
 	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/case-insensitive 2>output &&
 	cat output &&
@@ -58,6 +66,12 @@ test_expect_success 'leading space' '
 	grep "  <BOLD;RED>error<RESET>: leading space" decoded
 '
 
+test_expect_success 'spaces only' '
+	git -C child -c color.remote=always push -f origin HEAD:only-space 2>output &&
+	test_decode_color <output >decoded &&
+	grep "remote:     " decoded
+'
+
 test_expect_success 'no coloring for redirected output' '
 	git --git-dir child/.git push -f origin HEAD:refs/heads/redirected-output 2>output &&
 	test_decode_color <output >decoded &&
-- 
2.18.0-748-gfa03cdc39b

