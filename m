Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C446C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 14:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiIZO5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbiIZO4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 10:56:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B419C84E44
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:27:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso3725099wmq.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=IH7WYnms8fgSxMHPj9F/xTvUgBJ6oSbfvhX/lN6P18g=;
        b=I7ySU1o6qI3JUTTGpREeDfjVeQUuSmeE/KLkr97IDsFe5tWfIIuvhiuWoYSi+YU7Rv
         U3NIHU+0gDM8HuvherogsqLp36KVVkK02+vSMLMN871q1RkDzjoAmUTohm47um11oPfa
         yaCnAZURRnQs/oLrrDesS4jggQlKHVO/cK4aSuDBa3oBDtGvuKmW/JmrDb9yNS1ydXHJ
         iRqi6oZ2OEw8IB9oPTntwj9HcY7L3EAWsAZuvN/os0ZUVut4+hOAy1WEitqVG47mV5md
         pOkGee5kyf9qiwNtdtZpGzaPMJr51zvPGJYH1rbGb6zFvODJYDgMSySvnA/Y8FJbMonH
         mLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=IH7WYnms8fgSxMHPj9F/xTvUgBJ6oSbfvhX/lN6P18g=;
        b=GldyHPSkTalHK86xAWaqBTHk3zowQduvzpKht6NNSfqXybtZVbzPeiReU6P0PKTo2m
         Q4dXm0U3SKN5aGdIsrDM2ghqqDymxXuduQwxK9A02dOk8R0bvlURkEUaC/OfenFlDhzK
         mnnEdmAXPkJYWnE2GI2mguOuagjFA8fIxQFWSAc2ph1qn9yVT+3NSOs5cDi6jHgNMRLn
         l/6IInlBaF0Beels7E/go4pTbh8PH+fHveK2vFRr/uYLdENrLYzwWh1300qeeWYihYQH
         k68af73ePfjGgE0q/trAZMCv/sGK1Z2kv5juTBp+5TEK8umuGtXKfXSXsahSwn0oni8U
         VdUQ==
X-Gm-Message-State: ACrzQf1yDWbI6aQHz1m7ZiMfmKcHP4Juy2Xd+ju2gssQy3JX6pTbudPA
        eBPSmbCXbAq+kONeXfV4GLKOplajf00r1A==
X-Google-Smtp-Source: AMsMyM5bkbsMoLrskpIKYS9kxKjcSZoUZyLWxgO7UcVcKQBTvJgb3sWBc0lFEGoXyPhPMigau3BMNA==
X-Received: by 2002:a7b:cb49:0:b0:3b4:b08a:89b with SMTP id v9-20020a7bcb49000000b003b4b08a089bmr14763432wmj.173.1664198853149;
        Mon, 26 Sep 2022 06:27:33 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id y17-20020adff6d1000000b00228daaa84aesm14898798wrp.25.2022.09.26.06.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 06:27:32 -0700 (PDT)
Message-ID: <e7278794-428d-4aff-e91b-d2e6527f142d@gmail.com>
Date:   Mon, 26 Sep 2022 14:27:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/10] evolve: add support for parsing metacommits
Content-Language: en-US
To:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2e9a4a9bd819785404e8a5343385f4fb2bc06109.1663959325.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <2e9a4a9bd819785404e8a5343385f4fb2bc06109.1663959325.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris

On 23/09/2022 19:55, Stefan Xenos via GitGitGadget wrote:
> From: Stefan Xenos <sxenos@google.com>
> 
> This patch adds the get_metacommit_content method, which can classify
> commits as either metacommits or normal commits, determine whether they
> are abandoned, and extract the content commit's object id from the
> metacommit.
> 
> Signed-off-by: Stefan Xenos <sxenos@google.com>
> Signed-off-by: Chris Poucet <poucet@google.com>
> ---
>   Makefile            |   1 +
>   metacommit-parser.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
>   metacommit-parser.h |  19 ++++++++
>   3 files changed, 130 insertions(+)
>   create mode 100644 metacommit-parser.c
>   create mode 100644 metacommit-parser.h
> 
> diff --git a/Makefile b/Makefile
> index cac3452edb9..b2bcc00c289 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -999,6 +999,7 @@ LIB_OBJS += merge-ort.o
>   LIB_OBJS += merge-ort-wrappers.o
>   LIB_OBJS += merge-recursive.o
>   LIB_OBJS += merge.o
> +LIB_OBJS += metacommit-parser.o

There seems to be a problem with the indent here

>   LIB_OBJS += midx.o
>   LIB_OBJS += name-hash.o
>   LIB_OBJS += negotiator/default.o

 > diff --git a/metacommit-parser.h b/metacommit-parser.h
 > new file mode 100644
 > index 00000000000..1c74bd6d699
 > --- /dev/null
 > +++ b/metacommit-parser.h
 > @@ -0,0 +1,19 @@
 > +#ifndef METACOMMIT_PARSER_H
 > +#define METACOMMIT_PARSER_H
 > +
 > +#include "commit.h"
 > +#include "hash.h"
 > +
 > +/* Indicates a normal commit (non-metacommit) */
 > +#define METACOMMIT_TYPE_NONE 0
 > +/* Indicates a metacommit with normal content (non-abandoned) */
 > +#define METACOMMIT_TYPE_NORMAL 1
 > +/* Indicates a metacommit with abandoned content */
 > +#define METACOMMIT_TYPE_ABANDONED 2

Is it possible to define these as an enum? It would make the signature 
of get_meta_commit_content() nicer.

 > +struct commit;

What's this for? We're including commit.h above.

 > +extern int get_metacommit_content(
 > +	struct commit *commit, struct object_id *content);

> diff --git a/metacommit-parser.c b/metacommit-parser.c
> new file mode 100644
> index 00000000000..70c1428bfc6
> --- /dev/null
> +++ b/metacommit-parser.c
> @@ -0,0 +1,110 @@
> +#include "cache.h"
> +#include "metacommit-parser.h"
> +#include "commit.h"
> +
> +/*
> + * Search the commit buffer for a line starting with the given key. Unlike
> + * find_commit_header, this also searches the commit message body.
> + */

There is no explanation in the code or commit message as to why this 
function is needed. The documentation added in the first commit says 
that "parent-type" header is a commit header. I think the answer is that 
this series does not implement that header but uses the commit message 
instead. That's perfectly fine for a proof of concept but it is 
precisely the sort of detail that should be described it the commit 
message and probably flagged up in the cover letter.

> +static const char *find_key(const char *msg, const char *key, size_t *out_len)
> +{
> +	int key_len = strlen(key);
> +	const char *line = msg;
> +
> +	while (line) {
> +		const char *eol = strchrnul(line, '\n');
> +
> +		if (eol - line > key_len && !memcmp(line, key, key_len) &&
> +		    line[key_len] == ' ') {
> +			*out_len = eol - line - key_len - 1;
> +			return line + key_len + 1;
> +		}
> +		line = *eol ? eol + 1 : NULL;
> +	}
> +	return NULL;
> +}
> +
> +static struct commit *get_commit_by_index(struct commit_list *to_search, int index)
> +{
> +	while (to_search && index) {
> +		to_search = to_search->next;
> +		index--;
> +	}
> +
> +	if (!to_search)
> +		return NULL;
> +
> +	return to_search->item;
> +}

This function is a useful utility for struct commit_list and should live 
in commit.c. It could be used to simplify object-name.c:get_parent() for 
example.

> +/*
> + * Writes the index of the content parent to "result". Returns the metacommit
> + * type. See the METACOMMIT_TYPE_* constants.
> + */
> +static int index_of_content_commit(const char *buffer, int *result)

I found the signature confusing as it is returning an int but that is 
not the index. Switching to an enum for the metacommit types would 
clarify that.

> +{
> +	int index = 0;
> +	int ret = METACOMMIT_TYPE_NONE;
> +	size_t parent_types_size;
> +	const char *parent_types = find_key(buffer, "parent-type",
> +		&parent_types_size);
> +	const char *end;
> +	const char *enum_start = parent_types;
> +	int enum_length = 0;
> +
> +	if (!parent_types)
> +		return METACOMMIT_TYPE_NONE;
> +
> +	end = &parent_types[parent_types_size];
> +
> +	while (1) {
> +		char next = *parent_types;
> +		if (next == ' ' || parent_types >= end) {
> +			if (enum_length == 1) {

if enum_length != 1 then there is an error in the parent-type header and 
we should probably bail out.

> +				char first_char_in_enum = *enum_start;

It's not just the first character, it's the only character, do we really 
need such a long variable name? (how about just calling it "type")

I'll try and take at look at the next couple of patches later in the week.

Best Wishes

Phillip

