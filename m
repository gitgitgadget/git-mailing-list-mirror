Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF06A1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 18:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeHQVhe (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 17:37:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38493 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHQVhe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 17:37:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id w11-v6so5265285wrc.5
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ejEEE5gWni2zzVOMtFUqdjJyFDo5kFHJBFxwpEMCHPw=;
        b=N/kbcI0dsFHdL+npx0mPOy87oRw+ncwS/KmBtd/wIKdacwZjeI2lVhun8nRzEl04T7
         NxRAmixZJKajrRaMHzyMFeLx1gYGMrTtVv41h8ric44bUSUiXs/H7JNbujlp3mv580de
         MkplsBY0xWxoVR91J6jx3stjD6Ab9OSa7wmjW0pEPEYRnpI3ayscJzC6HyLbFxPtxK0A
         YksAmkUeDDZ5zDYnxgrbolNKzndaZciR1BliNCYnNWtAEddNQmG9XuVF3pL4Y1aL+Cuz
         CVHxdiKvNoAqLTWM6phhEN1ZHHKfKEGL4yCyAgilqC7q/3gpOjTTXag1vH30kRN+0BuJ
         bQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ejEEE5gWni2zzVOMtFUqdjJyFDo5kFHJBFxwpEMCHPw=;
        b=lgxt0gB584ZjKV/x7xlmhOHMdfKylPVuUZPZXv48L0qOEFDBXvF4vg4bGERigtqvD5
         lS2km8ciMzGwvEVILLF/s2Ak+El91jSQ3ceymJUMCgpNGqCq6CwuMAJYmsAJdtwZ8j+M
         +EzUSmatf8WDI9BY81DxsSMvOH5z+4Cwbej8+iOL6eRgmpyX25h2gZebQvmX05r3y+OE
         U9NtkjcLyIs2zZLb1Z/lhE5H1TNAGQrKueIiG93Xad5pBxTdmtarYc6EHU+1ZOvOXKyv
         JCGNjDP0cLJM7yT38egAPaib5/893KlLMQKSvtBs+32y5EDGJ6ZPyWTCRElj/3dwVR+5
         86UQ==
X-Gm-Message-State: AOUpUlH5OBflhTm7goFbFfVHG4dq1YkiXHbV7XEYU6K2tLTuTFfaL1iN
        HoySFpa5a1loor/83QZhXi8=
X-Google-Smtp-Source: AA+uWPyIrA92KzuKP04oQYG+i28DyjhZvWYw4MsnHsaP1SsvwNCPNCSUBIoo7xdhsIG5VtYvvl8pKA==
X-Received: by 2002:adf:adc9:: with SMTP id w67-v6mr23104727wrc.135.1534530787505;
        Fri, 17 Aug 2018 11:33:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t19-v6sm2811223wmi.42.2018.08.17.11.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 11:33:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     sunshine@sunshineco.com, jrn@google.com, git@vger.kernel.org
Subject: Re: [PATCH v7 1/1] sideband: highlight keywords in remote sideband output
References: <20180807125108.104293-1-hanwen@google.com>
        <20180807125108.104293-2-hanwen@google.com>
Date:   Fri, 17 Aug 2018 11:33:06 -0700
In-Reply-To: <20180807125108.104293-2-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Tue, 7 Aug 2018 14:51:08 +0200")
Message-ID: <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> +/*
> + * Optionally highlight one keyword in remote output if it appears at the start
> + * of the line. This should be called for a single line only, which is
> + * passed as the first N characters of the SRC array.
> + */
> +static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
> +{
> +	int i;
> +
> +	if (!want_color_stderr(use_sideband_colors())) {
> +		strbuf_add(dest, src, n);
> +		return;
> +	}
> +
> +	while (isspace(*src)) {
> +		strbuf_addch(dest, *src);
> +		src++;
> +		n--;
> +	}

This loop can run out of bytes in src in search of non-space before
n gets to zero or negative, and when that happens ...

> +	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
> +		struct keyword_entry *p = keywords + i;
> +		int len = strlen(p->keyword);
> +		/*
> +		 * Match case insensitively, so we colorize output from existing
> +		 * servers regardless of the case that they use for their
> +		 * messages. We only highlight the word precisely, so
> +		 * "successful" stays uncolored.
> +		 */
> +		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {

... these access src[] beyond the end of what the caller intended to
show us, and also ...

> +			strbuf_addstr(dest, p->color);
> +			strbuf_add(dest, src, len);
> +			strbuf_addstr(dest, GIT_COLOR_RESET);
> +			n -= len;
> +			src += len;
> +			break;
> +		}
> +	}
> +
> +	strbuf_add(dest, src, n);

... this will now try to add 0 or negative number of bytes.

> +
> +}
> +

Perhaps this will help (not really tested).  The second hunk is an
unrelated style clean-up.


 sideband.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index 1c6bb0e25b..d99a559a44 100644
--- a/sideband.c
+++ b/sideband.c
@@ -75,11 +75,13 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		return;
 	}
 
-	while (isspace(*src)) {
+	while (isspace(*src) && n) {
 		strbuf_addch(dest, *src);
 		src++;
 		n--;
 	}
+	if (!n)
+		return;
 
 	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
 		struct keyword_entry *p = keywords + i;
@@ -101,7 +103,6 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 	}
 
 	strbuf_add(dest, src, n);
-
 }
 
 
