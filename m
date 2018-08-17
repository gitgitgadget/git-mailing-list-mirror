Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 022671F97E
	for <e@80x24.org>; Fri, 17 Aug 2018 18:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeHQVtb (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 17:49:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55145 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQVtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 17:49:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so8446504wmb.4
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 11:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/yzxBEeXhI3FfVbucaZDJyO2QKYVjQWBasl1IIBQRjU=;
        b=mfENCYhY2lv5aA0uDEcFIFLgnTpkw9VQRjbNPsIiLALzHOfWJ5rK3L/TPvFzq/i0is
         nSfMTnTzgL1E4YYUDOhtkOCZcSmM9jXjika8Xo9lrRemBWKaFw9Vhli07jPBw7u0Pqbd
         rdBOZzAz7fXSMBYomQ64Q2XPCuNVRIUSuvwZ9yJWk5Gi6slrY7zpRtSiyALBHOFPaMyd
         LsNdk5xyxF3hmSaItbR7zRBk5lpHcERUk+0FD28mZAA8/huRKTMJAxd0eUAHav1lMhkj
         lA7YSZmdNdJw28ofG21Ecb/umVRTDZGTQLzTm3iZtZm6L4Y1CQ6q9jkCO4ujMMO273ss
         IShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/yzxBEeXhI3FfVbucaZDJyO2QKYVjQWBasl1IIBQRjU=;
        b=EjzDQJY44+a+88wQw6xIdMQ3KCNZjPRJ6TE+CvQQq08HaZKM+8nTQtxvF05Wu73/S/
         EOk0AX8cTFTDwt6RTkdnQOAICzKxCO1exfclGShg3jDdjvPnVwZBKxtJGwrSncZVCaFK
         pTIgsVehwDoNsmMDNVKwDqWU7RuIu++E/KOZE2dDeM96ZhqyaaERwk8ouWALur3YQahp
         5dJvH+a+yih1I54Mee+c4rw2cxnt/lttCp2CRwvu/4XCXzJ69vy65vq28+8IxDI9dHaX
         O/oNjl6zKNTtHuwbVA33ezjFfn/AkCU4krmjS6DroDWIp3vxCU5PNUzN/G1sDorYHi2n
         1/4Q==
X-Gm-Message-State: AOUpUlGvDBR92cBjrGqraaAbkKSzPHdGd/NRhQH+qaDCtSvh/0pmnm6f
        eCHMAO3vQCtC0wf6GkLiOrM=
X-Google-Smtp-Source: AA+uWPyevy5FOy5FiVnPPqplfp440GpptxynvfWQ0l8fS6AUyCQPUzmV+3te3JkRkkkVsJzRC3fIyQ==
X-Received: by 2002:a1c:92:: with SMTP id 140-v6mr18227562wma.87.1534531501282;
        Fri, 17 Aug 2018 11:45:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o33-v6sm4527469wrf.11.2018.08.17.11.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 11:45:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     sunshine@sunshineco.com, jrn@google.com, git@vger.kernel.org
Subject: Re* [PATCH v7 1/1] sideband: highlight keywords in remote sideband output
References: <20180807125108.104293-1-hanwen@google.com>
        <20180807125108.104293-2-hanwen@google.com>
        <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 17 Aug 2018 11:44:59 -0700
In-Reply-To: <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 17 Aug 2018 11:33:06 -0700")
Message-ID: <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This loop can run out of bytes in src in search of non-space before
> n gets to zero or negative, and when that happens ...
>
>> +	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
>> +		struct keyword_entry *p = keywords + i;
>> +		int len = strlen(p->keyword);
>> +		/*
>> +		 * Match case insensitively, so we colorize output from existing
>> +		 * servers regardless of the case that they use for their
>> +		 * messages. We only highlight the word precisely, so
>> +		 * "successful" stays uncolored.
>> +		 */
>> +		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
>
> ... these access src[] beyond the end of what the caller intended to
> show us, and also ...

Actually, leaving when !n before this loop is insufficient.  src[]
may have 2 bytes "in" remaining, and we may be trying to see if it
begins with "info", for example, and using strncasecmp() with len==4
would of course read beyond the end of src[].

-- >8 --
Subject: sideband: do not read beyond the end of input

The caller of maybe_colorize_sideband() gives a counted buffer
<src,n>, but the callee checked *src as if it were a NUL terminated
buffer.  If src[] had all isspace() bytes in it, we would have made
n negative, and then (1) called number of strncasecmp() to see if
the remaining bytes in src[] matched keywords, reading beyond the
end of the array, and/or (2) called strbuf_add() with negative
count, most likely triggering the "you want to use way too much
memory" error due to unsigned integer overflow.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sideband.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sideband.c b/sideband.c
index 1c6bb0e25b..372039247f 100644
--- a/sideband.c
+++ b/sideband.c
@@ -75,7 +75,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		return;
 	}
 
-	while (isspace(*src)) {
+	while (0 < n && isspace(*src)) {
 		strbuf_addch(dest, *src);
 		src++;
 		n--;
@@ -84,6 +84,9 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
 		struct keyword_entry *p = keywords + i;
 		int len = strlen(p->keyword);
+
+		if (n <= len)
+			continue;
 		/*
 		 * Match case insensitively, so we colorize output from existing
 		 * servers regardless of the case that they use for their
@@ -100,8 +103,8 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		}
 	}
 
-	strbuf_add(dest, src, n);
-
+	if (0 < n)
+		strbuf_add(dest, src, n);
 }
 
 
