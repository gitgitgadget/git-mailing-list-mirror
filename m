Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6ACC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 19:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiEWTVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 15:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiEWTVI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 15:21:08 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3801276290
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:57:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id w17so299670qtk.13
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LjTCwgPAzms87TpdiQZ4W9j3dOwUXFnL5GWgbuqmOnA=;
        b=JC/OA2O5oiKh/Nl5le5UC+tMgezl3DMmQ2TQ69JLOgX7a2m+s9dF4qgRFtoG+pFcig
         EEW1sCMrBzbO6vbUxZtwhySBgV5BP/NELz5h73M2EHk70yrh0Ac8XMZDBmg7qu24UJoM
         8TDP110M4FftAZX8bCMfWpIf1UfUr1mv/qB68kl7BLuN+WLa1dwNB6vqRP3SVAF50nwN
         6f9yIFzXfZ8NnLE7j3OemyY/xS4BcIBeyspGOvxTWmFiYO/NhbOWVK5v8QQPbNVJ3mhg
         XzfPm8XilgLEDg+Ru+xDSHT7J1TQtvbiIi1uJimRGrIytJxptiAaOjDBtJu0tTaF6Smw
         CcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LjTCwgPAzms87TpdiQZ4W9j3dOwUXFnL5GWgbuqmOnA=;
        b=uaiYqisdThSxPmgfUG2GJKDacj4f8kByJvb2ZLYre884KBX2iOqGZUuxHBoFfMik/r
         /dNPBDHgGIEo1o0Lpg46EXJu4K1VE6YQx39ztbFU/+6f0p8MDN27DguJucKkOvZLAbMR
         DJPmsj0o5A78k4THFIGsv8jTosJxRXMbdtF45UL7a6b0wE3IEoUqzHh+Ki/pMQmQxPB1
         txHz9U2+TFMkEwcVZ0hRuPQcliwwLfjhBflhXB6cl10qeJRzT5y0d7UvIoVI4zG3tOgU
         Tk5kJ1bGuHi3R7yTDQjVGwUUcSpfM9J2izFDJtMTWF821DoU/C8Z/l3mlv0TXXTMK+Mh
         4bPw==
X-Gm-Message-State: AOAM531N+EZbjZMFTEy26Jq31pnSyGIU22Dth64vWCP6aLggryqTlxQP
        l+KkkX8a3+GatlkzM6QRCU/o
X-Google-Smtp-Source: ABdhPJyf3cKdro2iLJBOmbZCwg6b8oTdJ38eOgqLfXQbidCczZRSNfo5FrV8Ey2uZrhIB0gpsXwkmw==
X-Received: by 2002:ac8:5f50:0:b0:2f3:dc83:7435 with SMTP id y16-20020ac85f50000000b002f3dc837435mr17872059qta.283.1653332277370;
        Mon, 23 May 2022 11:57:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:71ba:8ad9:40cd:d364? ([2600:1700:e72:80a0:71ba:8ad9:40cd:d364])
        by smtp.gmail.com with ESMTPSA id c22-20020a05622a025600b002f39b99f689sm4767679qtx.35.2022.05.23.11.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 11:57:57 -0700 (PDT)
Message-ID: <1580ad10-43f6-bc73-901a-b65b1aea73ff@github.com>
Date:   Mon, 23 May 2022 14:57:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2] setup: don't die if realpath(3) fails on getcwd(3)
Content-Language: en-US
To:     Kevin Locke <kevin@kevinlocke.name>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
 <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/21/22 9:53 AM, Kevin Locke wrote:
> -	/* Normalize the directory */
> -	strbuf_realpath(&tmp, tmp_original_cwd, 1);
> -	free((char*)tmp_original_cwd);
> -	tmp_original_cwd = NULL;
> -	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
> +	/* Try to normalize the directory. */
> +	if (strbuf_realpath(&tmp, tmp_original_cwd, 0)) {

I had to look it up, but this last argument going from 1 to 0
is "die_on_error", so it makes sense why it wasn't checked by
an 'if' earlier _and_ why it needs to change now.

> +		free((char*)tmp_original_cwd);

Hm. I'm never a fan of this casting, but it existed before. It's
because tmp_original_cwd is exposed globally in cache.h, which
is _really widely_. However, there are only two uses: setup.c,
which defines it, and common-main.c, which initializes it during
process startup.

The following diff could apply before your commit, removing this
use of "const char *", but maybe it doesn't fit normal Git
coding guidelines (putting the extern directly in a *.c file):

--- >8 ---

diff --git a/cache.h b/cache.h
index aaf334e2aa4..ce9cd6fa3f0 100644
--- a/cache.h
+++ b/cache.h
@@ -1797,7 +1797,6 @@ struct startup_info {
 	const char *original_cwd;
 };
 extern struct startup_info *startup_info;
-extern const char *tmp_original_cwd;
 
 /* merge.c */
 struct commit_list;
diff --git a/common-main.c b/common-main.c
index 29fb7452f8a..e472258b83b 100644
--- a/common-main.c
+++ b/common-main.c
@@ -23,6 +23,8 @@ static void restore_sigpipe_to_default(void)
 	signal(SIGPIPE, SIG_DFL);
 }
 
+extern char *tmp_original_cwd;
+
 int main(int argc, const char **argv)
 {
 	int result;
diff --git a/setup.c b/setup.c
index 04ce33cdcd4..86986317490 100644
--- a/setup.c
+++ b/setup.c
@@ -12,7 +12,7 @@ static int work_tree_config_is_bogus;
 
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
-const char *tmp_original_cwd;
+char *tmp_original_cwd;
 
 /*
  * The input parameter must contain an absolute path, and it must already be
@@ -459,7 +459,7 @@ static void setup_original_cwd(void)
 
 	/* Normalize the directory */
 	strbuf_realpath(&tmp, tmp_original_cwd, 1);
-	free((char*)tmp_original_cwd);
+	free(tmp_original_cwd);
 	tmp_original_cwd = NULL;
 	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
 
--- >8 ---

> +		tmp_original_cwd = NULL;
> +		startup_info->original_cwd = strbuf_detach(&tmp, NULL);
> +	} else {
> +		trace_printf("realpath(cwd) failed: %s\n", strerror(errno));

It could also be helpful to include a trace2 output, since
most modern tracing uses that mechanism:

		trace2_data_string("setup", the_repository,
				   "realpath-path", tmp_original_cwd);
		trace2_data_string("setup", the_repository,
				   "realpath-failure", strerror(errno));

But this is also unlikely to be necessary. We can instruct
a user to rerun their command with GIT_TRACE=1 if we see
this error in the wild.

> +		tmp_original_cwd = NULL;
> +		goto no_prevention_needed;
> +	}

So, I don't see a need for this patch to change before it
is merged. I'm curious to hear thoughts on the diff I put
inline, though.

Thanks,
-Stolee
