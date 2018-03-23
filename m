Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49AF31F404
	for <e@80x24.org>; Fri, 23 Mar 2018 18:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbeCWSBU (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 14:01:20 -0400
Received: from mout.web.de ([217.72.192.78]:57167 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbeCWSBT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 14:01:19 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mas22-1fJj0V2O42-00KOvv; Fri, 23
 Mar 2018 19:01:05 +0100
Subject: Re: [PATCH v2] json_writer: new routines to create data in JSON
 format
To:     git@jeffhostetler.com, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180321192827.44330-1-git@jeffhostetler.com>
 <20180321192827.44330-2-git@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <524c47a6-7c9f-5519-250a-4722081a0f32@web.de>
Date:   Fri, 23 Mar 2018 19:01:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321192827.44330-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:PB/bjFGaq77NeqFIjZ1lShhhsfzN+FSjscKQ5O1AJOvIzRgjVuR
 BCM1vcbVoBLVV//l0dzWeou3rCvDpUah1MJjN2CTdLgT/WXOucVr4P805GZp8BWnAK5E40M
 w8mQWvPFdFx5CoCIeV8FKk4TRJ+B8zC8FgZczOGcAueTpsneDYc6sAnVFTcJaMlEo82AKo0
 TCnvVrLXkjH4UA+Y1dsYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JwDphfbZCJY=:GhY282kJ3P48xrlcw0pJQu
 9XbM+B+NEtMAxQ3cwfrsmIgYZRUbrmNZ8wci+XFiMQA9FjTrdgMmocN9T5xuY54hjBRnCaZFk
 UW4R+G/9ynausf7jiY/E3guFQzzbEsi7hx+q+RoHD9it5VQg5FWnOWf1OPohh7BWCspx9webZ
 dW1vVkiwvPfF9LKjjG4w1af/6xeEMT9Ro3b/ZsrojxMXzIm3xl6meUbK7NNzKkC4WKYA0JGoW
 3okoA2bcMFjPEiXLubVKRC5JDI5FllVvR/E1yU14BGk5DAV0d+bpji4wINuVT5LxAVDCtTdQl
 6sNR/QqQXxAasbZi0ZoMXuJL3SeVtFpY9Y5f8qqjyorEKDLa8GqoK4UkIncwtvvNaEQfOg+D/
 9NhKdxRRrA5OP+O2HR9/30mmWX7HToxhoKRcjjuq/HrMIA+fHk0PqUiPq1qHnmyXp+rgiKDqf
 WiKfh01ViFiePIX+I+VM9pJNmjnGG2h02KGPPJq1xNhkuv8ku6nkDqic8R3I61Q0LeJm3a2Sp
 A7zPRQDb9Li3/tTQKga7WwEP9BvTRBnQFnhzsZRerZjdxFRr/0kiHBWUtvY6AVNLBy9GPOg33
 X4xqVggygRr8thKNBtm6ZAy+sowdCwYjMpYyefg7RckMdhWoVYt+gHrNnxCFCtIxkBh3hSUOy
 XFhJctwQ3TYLyKCfA/zmraYLUydmy/y2FHGqggod2lo3847zxDEg5m/r9D45RWSrWDgOQGhIw
 Ln1mhGKX8kyNH7Hmo8cHIaDK5Fk2kt1XiXp8DhmGT+XX2hkEi/QOioamgn5sV0/sElxtkD/9f
 6Gfz60C5Vds0/DiHnFD+wfnpoEK4tEJ2oOUXpm7LqtYxTzAOd8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.03.2018 um 20:28 schrieb git@jeffhostetler.com:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Add basic routines to generate data in JSON format.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>   Makefile                    |   2 +
>   json-writer.c               | 321 +++++++++++++++++++++++++++++++++
>   json-writer.h               |  86 +++++++++
>   t/helper/test-json-writer.c | 420 ++++++++++++++++++++++++++++++++++++++++++++
>   t/t0019-json-writer.sh      | 102 +++++++++++
>   5 files changed, 931 insertions(+)
>   create mode 100644 json-writer.c
>   create mode 100644 json-writer.h
>   create mode 100644 t/helper/test-json-writer.c
>   create mode 100755 t/t0019-json-writer.sh
> 
> diff --git a/Makefile b/Makefile
> index 1a9b23b..57f58e6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -662,6 +662,7 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
>   TEST_PROGRAMS_NEED_X += test-genrandom
>   TEST_PROGRAMS_NEED_X += test-hashmap
>   TEST_PROGRAMS_NEED_X += test-index-version
> +TEST_PROGRAMS_NEED_X += test-json-writer
>   TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
>   TEST_PROGRAMS_NEED_X += test-line-buffer
>   TEST_PROGRAMS_NEED_X += test-match-trees
> @@ -815,6 +816,7 @@ LIB_OBJS += hashmap.o
>   LIB_OBJS += help.o
>   LIB_OBJS += hex.o
>   LIB_OBJS += ident.o
> +LIB_OBJS += json-writer.o
>   LIB_OBJS += kwset.o
>   LIB_OBJS += levenshtein.o
>   LIB_OBJS += line-log.o
> diff --git a/json-writer.c b/json-writer.c
> new file mode 100644
> index 0000000..89a6abb
> --- /dev/null
> +++ b/json-writer.c
> @@ -0,0 +1,321 @@
> +#include "cache.h"
> +#include "json-writer.h"
> +
> +static char g_ch_open[2]  = { '{', '[' };
> +static char g_ch_close[2] = { '}', ']' };
> +
> +/*
> + * Append JSON-quoted version of the given string to 'out'.
> + */
> +static void append_quoted_string(struct strbuf *out, const char *in)
> +{
> +	strbuf_addch(out, '"');
> +	for (/**/; *in; in++) {
> +		unsigned char c = (unsigned char)*in;
> +		if (c == '"')
> +			strbuf_add(out, "\\\"", 2);
> +		else if (c == '\\')
> +			strbuf_add(out, "\\\\", 2);
> +		else if (c == '\n')
> +			strbuf_add(out, "\\n", 2);
> +		else if (c == '\r')
> +			strbuf_add(out, "\\r", 2);
> +		else if (c == '\t')
> +			strbuf_add(out, "\\t", 2);
> +		else if (c == '\f')
> +			strbuf_add(out, "\\f", 2);
> +		else if (c == '\b')
> +			strbuf_add(out, "\\b", 2);

Using strbuf_addstr() here would result in the same object code (its
strlen() call is inlined for constants) and avoid having to specify
the redundant length 2.

> +		else if (c < 0x20)
> +			strbuf_addf(out, "\\u%04x", c);
> +		else
> +			strbuf_addch(out, c);
> +	}
> +	strbuf_addch(out, '"');
> +}
> +
> +
> +static inline void begin(struct json_writer *jw, int is_array)
> +{
> +	ALLOC_GROW(jw->levels, jw->nr + 1, jw->alloc);
> +
> +	jw->levels[jw->nr].level_is_array = !!is_array;
> +	jw->levels[jw->nr].level_is_empty = 1;
> +
> +	strbuf_addch(&jw->json, g_ch_open[!!is_array]);
> +
> +	jw->nr++;
> +}
> +
> +/*
> + * Assert that we have an open object at this level.
> + */
> +static void inline assert_in_object(const struct json_writer *jw, const char *key)
> +{
> +	if (!jw->nr)
> +		BUG("object: missing jw_object_begin(): '%s'", key);
> +	if (jw->levels[jw->nr - 1].level_is_array)
> +		BUG("object: not in object: '%s'", key);
> +}
> +
> +/*
> + * Assert that we have an open array at this level.
> + */
> +static void inline assert_in_array(const struct json_writer *jw)
> +{
> +	if (!jw->nr)
> +		BUG("array: missing jw_begin()");
> +	if (!jw->levels[jw->nr - 1].level_is_array)
> +		BUG("array: not in array");
> +}
> +
> +/*
> + * Add comma if we have already seen a member at this level.
> + */
> +static void inline maybe_add_comma(struct json_writer *jw)
> +{
> +	if (jw->levels[jw->nr - 1].level_is_empty)
> +		jw->levels[jw->nr - 1].level_is_empty = 0;
> +	else
> +		strbuf_addch(&jw->json, ',');
> +}
> +
> +/*
> + * Assert that the given JSON object or JSON array has been properly
> + * terminated.  (Has closing bracket.)
> + */
> +static void inline assert_is_terminated(const struct json_writer *jw)
> +{
> +	if (jw->nr)
> +		BUG("object: missing jw_end(): '%s'", jw->json.buf);
> +}
> +
> +void jw_object_begin(struct json_writer *jw)
> +{
> +	begin(jw, 0);
> +}
> +
> +void jw_object_string(struct json_writer *jw, const char *key, const char *value)
> +{
> +	assert_in_object(jw, key);
> +	maybe_add_comma(jw);
> +
> +	append_quoted_string(&jw->json, key);
> +	strbuf_addch(&jw->json, ':');
> +	append_quoted_string(&jw->json, value);
> +}
> +
> +void jw_object_int(struct json_writer *jw, const char *key, int value)
> +{
> +	assert_in_object(jw, key);
> +	maybe_add_comma(jw);
> +
> +	append_quoted_string(&jw->json, key);
> +	strbuf_addf(&jw->json, ":%d", value);
> +}
> +
> +void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
> +{
> +	assert_in_object(jw, key);
> +	maybe_add_comma(jw);
> +
> +	append_quoted_string(&jw->json, key);
> +	strbuf_addf(&jw->json, ":%"PRIuMAX, value);
> +}
> +
> +void jw_object_double(struct json_writer *jw, const char *fmt,
> +		      const char *key, double value)
> +{
> +	assert_in_object(jw, key);
> +	maybe_add_comma(jw);
> +
> +	if (!fmt || !*fmt)
> +		fmt = "%f";
> +
> +	append_quoted_string(&jw->json, key);
> +	strbuf_addch(&jw->json, ':');
> +	strbuf_addf(&jw->json, fmt, value);

Hmm.  Can compilers check such a caller-supplied format matches the
value's type?  (I don't know how to specify a format attribute for
GCC and Clang for this function.)

> +}
> +
> +void jw_object_true(struct json_writer *jw, const char *key)
> +{
> +	assert_in_object(jw, key);
> +	maybe_add_comma(jw);
> +
> +	append_quoted_string(&jw->json, key);
> +	strbuf_addstr(&jw->json, ":true");
> +}
> +
> +void jw_object_false(struct json_writer *jw, const char *key)
> +{
> +	assert_in_object(jw, key);
> +	maybe_add_comma(jw);
> +
> +	append_quoted_string(&jw->json, key);
> +	strbuf_addstr(&jw->json, ":false");
> +}
> +
> +void jw_object_null(struct json_writer *jw, const char *key)
> +{
> +	assert_in_object(jw, key);
> +	maybe_add_comma(jw);
> +
> +	append_quoted_string(&jw->json, key);
> +	strbuf_addstr(&jw->json, ":null");
> +}
> +
> +void jw_object_sub(struct json_writer *jw, const char *key,
> +		   const struct json_writer *value)
> +{
> +	assert_is_terminated(value);
> +
> +	assert_in_object(jw, key);
> +	maybe_add_comma(jw);
> +
> +	append_quoted_string(&jw->json, key);
> +	strbuf_addch(&jw->json, ':');
> +	strbuf_addstr(&jw->json, value->json.buf);

strbuf_addbuf() would be a better fit here -- it avoids a strlen() call
and NUL handling issues.

> +}
> +
> +void jw_object_inline_begin_object(struct json_writer *jw, const char *key)
> +{
> +	assert_in_object(jw, key);
> +	maybe_add_comma(jw);
> +
> +	append_quoted_string(&jw->json, key);
> +	strbuf_addch(&jw->json, ':');
> +
> +	jw_object_begin(jw);
> +}
> +
> +void jw_object_inline_begin_array(struct json_writer *jw, const char *key)
> +{
> +	assert_in_object(jw, key);
> +	maybe_add_comma(jw);
> +
> +	append_quoted_string(&jw->json, key);
> +	strbuf_addch(&jw->json, ':');
> +
> +	jw_array_begin(jw);
> +}

Those duplicate calls in the last ten functions feel mind-numbing.  A
helper function for adding comma, key and colon might be a good idea.

> +
> +void jw_array_begin(struct json_writer *jw)
> +{
> +	begin(jw, 1);
> +}
> +
> +void jw_array_string(struct json_writer *jw, const char *value)
> +{
> +	assert_in_array(jw);
> +	maybe_add_comma(jw);
> +
> +	append_quoted_string(&jw->json, value);
> +}
> +
> +void jw_array_int(struct json_writer *jw,int value)
> +{
> +	assert_in_array(jw);
> +	maybe_add_comma(jw);
> +
> +	strbuf_addf(&jw->json, "%d", value);
> +}
> +
> +void jw_array_uint64(struct json_writer *jw, uint64_t value)
> +{
> +	assert_in_array(jw);
> +	maybe_add_comma(jw);
> +
> +	strbuf_addf(&jw->json, "%"PRIuMAX, value);
> +}
> +
> +void jw_array_double(struct json_writer *jw, const char *fmt, double value)
> +{
> +	assert_in_array(jw);
> +	maybe_add_comma(jw);
> +
> +	if (!fmt || !*fmt)
> +		fmt = "%f";
> +
> +	strbuf_addf(&jw->json, fmt, value);
> +}

Same question/quibbling about format checking again.

> +
> +void jw_array_true(struct json_writer *jw)
> +{
> +	assert_in_array(jw);
> +	maybe_add_comma(jw);
> +
> +	strbuf_addstr(&jw->json, "true");
> +}
> +
> +void jw_array_false(struct json_writer *jw)
> +{
> +	assert_in_array(jw);
> +	maybe_add_comma(jw);
> +
> +	strbuf_addstr(&jw->json, "false");
> +}
> +
> +void jw_array_null(struct json_writer *jw)
> +{
> +	assert_in_array(jw);
> +	maybe_add_comma(jw);
> +
> +	strbuf_addstr(&jw->json, "null");
> +}
> +
> +void jw_array_sub(struct json_writer *jw, const struct json_writer *value)
> +{
> +	assert_is_terminated(value);
> +
> +	assert_in_array(jw);
> +	maybe_add_comma(jw);
> +
> +	strbuf_addstr(&jw->json, value->json.buf);

strbuf_addbuf() again.

> +}
> +
> +
> +void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv)
> +{
> +	int k;
> +
> +	for (k = 0; k < argc; k++)
> +		jw_array_string(jw, argv[k]);
> +}
> +
> +void jw_array_argv(struct json_writer *jw, const char **argv)
> +{
> +	while (*argv)
> +		jw_array_string(jw, *argv++);
> +}
> +
> +void jw_array_inline_begin_object(struct json_writer *jw)
> +{
> +	assert_in_array(jw);
> +	maybe_add_comma(jw);
> +
> +	jw_object_begin(jw);
> +}
> +
> +void jw_array_inline_begin_array(struct json_writer *jw)
> +{
> +	assert_in_array(jw);
> +	maybe_add_comma(jw);
> +
> +	jw_array_begin(jw);
> +}
> +
> +int jw_is_terminated(const struct json_writer *jw)
> +{
> +	return !jw->nr;
> +}
> +
> +void jw_end(struct json_writer *jw)
> +{
> +	if (!jw->nr)
> +		BUG("too many jw_end(): '%s'", jw->json.buf);
> +
> +	jw->nr--;
> +
> +	strbuf_addch(&jw->json,
> +		     g_ch_close[jw->levels[jw->nr].level_is_array]);
> +}
> diff --git a/json-writer.h b/json-writer.h
> new file mode 100644
> index 0000000..ad38c95
> --- /dev/null
> +++ b/json-writer.h
> @@ -0,0 +1,86 @@
> +#ifndef JSON_WRITER_H
> +#define JSON_WRITER_H
> +
> +/*
> + * JSON data structures are defined at:
> + *      http://json.org/
> + *      http://www.ietf.org/rfc/rfc7159.txt
> + *
> + * The JSON-writer API allows one to build JSON data structures using a
> + * simple wrapper around a "struct strbuf" buffer.  It is intended as a
> + * simple API to build output strings; it is not intended to be a general
> + * object model for JSON data.  In particular, it does not re-order keys
> + * in an object (dictionary), it does not de-dup keys in an object, and
> + * it does not allow lookup or parsing of JSON data.
> + *
> + * All string values (both keys and string r-values) are properly quoted
> + * and escaped if they contain special characters.
> + *
> + * These routines create compact JSON data (with no unnecessary whitespace,
> + * newlines, or indenting).  If you get an unexpected response, verify
> + * that you're not expecting a pretty JSON string.
> + *
> + * Both "JSON objects" (aka sets of k/v pairs) and "JSON array" can be
> + * constructed using a 'begin append* end' model.
> + *
> + * Nested objects and arrays can either be constructed bottom up (by
> + * creating sub object/arrays first and appending them to the super
> + * object/array) -or- by building them inline in one pass.  This is a
> + * personal style and/or data shape choice.
> + *
> + * See t/helper/test-json-writer.c for various usage examples.
> + */
> +
> +struct json_writer_level
> +{
> +	unsigned level_is_array : 1;
> +	unsigned level_is_empty : 1;
> +};
> +
> +struct json_writer
> +{
> +	struct json_writer_level *levels;
> +	int nr, alloc;
> +	struct strbuf json;
> +};

A simpler and probably more compact representation of is_array would
be a strbuf with one char per level, e.g. '[' for an array and '{'
for an object (or ']' and '}').

I don't understand the need to track emptiness per level.  Only the
top level array/object can ever be empty, can it?

> +
> +#define JSON_WRITER_INIT { NULL, 0, 0, STRBUF_INIT }
> +
> +void jw_object_begin(struct json_writer *jw);
> +void jw_array_begin(struct json_writer *jw);
> +
> +void jw_object_string(struct json_writer *jw, const char *key,
> +		      const char *value);
> +void jw_object_int(struct json_writer *jw, const char *key, int value);
> +void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value);
> +void jw_object_double(struct json_writer *jw, const char *fmt,
> +		      const char *key, double value);
> +void jw_object_true(struct json_writer *jw, const char *key);
> +void jw_object_false(struct json_writer *jw, const char *key);
> +void jw_object_null(struct json_writer *jw, const char *key);
> +void jw_object_sub(struct json_writer *jw, const char *key,
> +		   const struct json_writer *value);
> +
> +void jw_object_inline_begin_object(struct json_writer *jw, const char *key);
> +void jw_object_inline_begin_array(struct json_writer *jw, const char *key);
> +
> +
> +
> +void jw_array_string(struct json_writer *jw, const char *value);
> +void jw_array_int(struct json_writer *jw,int value);
> +void jw_array_uint64(struct json_writer *jw, uint64_t value);
> +void jw_array_double(struct json_writer *jw, const char *fmt, double value);
> +void jw_array_true(struct json_writer *jw);
> +void jw_array_false(struct json_writer *jw);
> +void jw_array_null(struct json_writer *jw);
> +void jw_array_sub(struct json_writer *jw, const struct json_writer *value);
> +void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv);
> +void jw_array_argv(struct json_writer *jw, const char **argv);
> +
> +void jw_array_inline_begin_object(struct json_writer *jw);
> +void jw_array_inline_begin_array(struct json_writer *jw);
> +
> +int jw_is_terminated(const struct json_writer *jw);
> +void jw_end(struct json_writer *jw);
> +
> +#endif /* JSON_WRITER_H */
