Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3621D1F51C
	for <e@80x24.org>; Mon, 21 May 2018 00:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeEUABJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 20:01:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56259 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbeEUABI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 20:01:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id a8-v6so22373066wmg.5
        for <git@vger.kernel.org>; Sun, 20 May 2018 17:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jGQkxvITOy3ywBmU+qrhc0kffJb37GML+NWmx4KCGh8=;
        b=TpvazZefDMR3H2N+bZQuexXX8iYEr/S4/cn8SmDUlncA3CYLgXwb+A56bAOtwKsdpR
         15BtOwsRkvHs8jnuIfvDGnAbcAERqoBNAGHrULrRP8lK/JjzmYOWofKBP4SXGSX7sUMt
         puRKAZ3VIVW5rBZWOnk6jAurUQf4OUshm4otX6wmT+hHKkvTt95laS/PRfGv6fKZxHdQ
         TRqSy6m8zF6LUvVhvd7DTWb9CLYLOsp6JANXHwgIIfcDxitKDEPD1cpN+lMLyAxCpixV
         8gOSgrZDGDGq3Jgmlap20XzLpiJclCnYdUCOY7VydumfCp+ygjR+nkIWn+fIDy3flga6
         +xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jGQkxvITOy3ywBmU+qrhc0kffJb37GML+NWmx4KCGh8=;
        b=qCxkYpCqjggQUNd+hfkGBDB+GDZySS494qvvNI1HZ0zfe4t8Mq0YEvgCU9Z2sKUnYX
         v+SfjUE13+5VKs2jeXqUdugLAVJx+f2LrxeK9EKt7U+dbO5bfyWuYLGaVtv7VgQMvu75
         kXJHpCM27AzJj/IU2zLMrE5iLo8kGJrg5vYZec256Bxm6+NszfBNceeeaNWzS5nvunQp
         BKMDOKvXP5DBAuqICDZ/zaVdiG1uNmDsohWFCbZmOr0vqX4IphDQj144PTO3GzwsgkPD
         Hz6Seo6Unru0ZrRhS8R/ByoCrfWO2EzZg/JJd/9nZSNktVCmOT6v521tw5/4NZLGN+ym
         bReg==
X-Gm-Message-State: ALKqPwfb5WtUYGXALy/huOl/68jzUxaHOCFpbOk/p62x4DTa+0dS1uT+
        Qkc6qVwuCP7E1B1FzktcULQ=
X-Google-Smtp-Source: AB8JxZrfP7oPlTbn7pf13kHKkmAZgsJBNDOnH/RrV418b7yEhb22AoQ5zMh9WdPGOzKIeTWQJ2gPTg==
X-Received: by 2002:a1c:4a5d:: with SMTP id x90-v6mr8891770wma.101.1526860866414;
        Sun, 20 May 2018 17:01:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k126-v6sm24818099wmd.45.2018.05.20.17.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 17:01:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re*: [PATCH v4 3/4] string-list: provide `string_list_appendf()`
References: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com>
        <cover.1526810549.git.martin.agren@gmail.com>
        <77b025bb47869478e3eef1c3c34d379164f5d91c.1526810549.git.martin.agren@gmail.com>
        <CA+P7+xqPnuuQpp5e7fduLgaSd+JrTn95w=Da7q=iCXUgo0QHFA@mail.gmail.com>
Date:   Mon, 21 May 2018 09:01:05 +0900
In-Reply-To: <CA+P7+xqPnuuQpp5e7fduLgaSd+JrTn95w=Da7q=iCXUgo0QHFA@mail.gmail.com>
        (Jacob Keller's message of "Sun, 20 May 2018 12:12:33 -0700")
Message-ID: <xmqqvabh3mim.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Sun, May 20, 2018 at 3:17 AM, Martin Ågren <martin.agren@gmail.com> wrote:
>> +/**
>> + * Add formatted string to the end of `list`. This function ignores
>> + * the value of `list->strdup_strings` and always appends a freshly
>> + * allocated string, so you will probably not want to use it with
>> + * `strdup_strings = 0`.
>> + */
>> +struct string_list_item *string_list_appendf(struct string_list *list,
>> +                                            const char *fmt, ...);
>> +
>
> Would it make sense to verify that strdup_strings == 0? I guess we'd
> have to use die or BUG(), but that would mean that the program could
> crash..

It probably is clear to readers that any reasonable implementation
of *_appendf() will create a new and unique string, as the point of
*f() is to give a customized instantiation of fmt string for given
parameters.  So it would be natural to expect that the storage that
holds the generated string will belong to the list.  We _could_ make
it honor strdup_strings and make one extra copy when strdup_strings
is set to true, but the only effect such a stupid implementation has
is to unnecessarily leak ;-)

I think it is probably OK to check and BUG() when strdup_strings==0,
but such a check means that we now declare that a string list must
either borrow all of its strings from elsewhere or own all of its
strings itself, and mixture is not allowed.

The (overly) flexible string_list API could be used to mix both
borrowed and owned strings (an obvious strategy to do this without
leaking and crashing is to use the .util field to mark which ones
are owned and which ones are borrowed), so there might already be
current users of the API that violates that rule.

I have a feeling that argv_array might be a better fit for the
purpose of keeping track of to_free[] strings in the context of this
series.  Moving away from string_list would allow us to sidestep the
storage ownership issues the API has, and we do not need the .util
thing string_list gives us (which is one distinct advantage string_list
has over argv_array, if the application needs that feature).

We would need to make _pushf() and friends return "const char *" if
we go that route to make the resulting API more useful, though.

-- >8 --
Subject: argv-array: return the pushed string from argv_push*()

Such an API change allows us to use an argv_array this way:

	struct argv_array to_free = ARGV_ARRAY_INIT;
        const char *msg;

        if (some condition) {
		msg = "constant string message";
		... other logic ...
	} else {
		msg = argv_pushf(&to_free, "format %s", var);
	}
	... use "msg" ...
	... do other things ...
	argv_clear(&to_free);

Note that argv_array_pushl() and argv_array_pushv() are used to push
one or more strings with a single call, so we do not return any one
of these strings from these two functions in order to reduce the
chance to misuse the API.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 argv-array.c | 6 ++++--
 argv-array.h | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/argv-array.c b/argv-array.c
index 5d370fa336..449dfc105a 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -21,12 +21,13 @@ static void argv_array_push_nodup(struct argv_array *array, const char *value)
 	array->argv[array->argc] = NULL;
 }
 
-void argv_array_push(struct argv_array *array, const char *value)
+const char *argv_array_push(struct argv_array *array, const char *value)
 {
 	argv_array_push_nodup(array, xstrdup(value));
+	return array->argv[array->argc - 1];
 }
 
-void argv_array_pushf(struct argv_array *array, const char *fmt, ...)
+const char *argv_array_pushf(struct argv_array *array, const char *fmt, ...)
 {
 	va_list ap;
 	struct strbuf v = STRBUF_INIT;
@@ -36,6 +37,7 @@ void argv_array_pushf(struct argv_array *array, const char *fmt, ...)
 	va_end(ap);
 
 	argv_array_push_nodup(array, strbuf_detach(&v, NULL));
+	return array->argv[array->argc - 1];
 }
 
 void argv_array_pushl(struct argv_array *array, ...)
diff --git a/argv-array.h b/argv-array.h
index 29056e49a1..715c93b246 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -12,9 +12,9 @@ struct argv_array {
 #define ARGV_ARRAY_INIT { empty_argv, 0, 0 }
 
 void argv_array_init(struct argv_array *);
-void argv_array_push(struct argv_array *, const char *);
+const char *argv_array_push(struct argv_array *, const char *);
 __attribute__((format (printf,2,3)))
-void argv_array_pushf(struct argv_array *, const char *fmt, ...);
+const char *argv_array_pushf(struct argv_array *, const char *fmt, ...);
 LAST_ARG_MUST_BE_NULL
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pushv(struct argv_array *, const char **);
