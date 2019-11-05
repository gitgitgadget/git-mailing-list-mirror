Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78EEC1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 15:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbfKEPCZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 10:02:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37627 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388842AbfKEPCY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 10:02:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id q130so20476927wme.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 07:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ba4y242rhU4GMx94phQpo9qXglzE9EX6znStdr9IVZU=;
        b=LSAJ2NZI2r6I64hLAtKYXa9shEvoziO6dx7pA2zK0mJUueP24HPczv5+S5+c1OlQxm
         8P6jyD4cmY33dnaqlpWiedmhp09360IPyY/W4p/tHf+nJ4mBOHNPXLObZBbam426Ruvn
         MVV6d6Vie/5mILQUPgiAltMQxy3G4MSxqDDWeqDW2f19+yERN1WCug/AdlpWAXoUwKYo
         QDlllxJZTC6NeMtP/mipQw0GU6ZrhEIrz3yzTHS+3pvPkf+K9w8G93+w3UuAM5F9Z90s
         M/dulzuP10RvfgATM+xqWs4jNp31D7gaXXy9xTcIcFYQGZMAb+wxKV0XEbAx1UULtsmi
         jxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ba4y242rhU4GMx94phQpo9qXglzE9EX6znStdr9IVZU=;
        b=twgRMVXYbkNV7ysF/V5spQIW+y4agJd3lFmeUXei4aHHsRBUn8NG4kaN4NIgxlv89S
         O3/2W8wq1Kp8PRGSiMChFgKrzV9fAaQ47dpA1WBU8fVdKIQyCYqh6bDXh96iiI+tvMVw
         zTPePs2JcTio8TZUZFq/E/1/THErUXs4Hqj3jGLEDjucGObMNbd9Dknpf/yy6+/BWY07
         yEdBAFfDaugwRidWL7bT3E5+eqcy+sluD9i/s/5UfPz68LxgbAjIqO2uqz05bK7qv8iW
         0heb5nRaLoLJ6KvwIbtLiIpteDC0dkLJ/0JDMYqcki3MPIRvMGUgy4IP1x7zMRS1dHqB
         8DYw==
X-Gm-Message-State: APjAAAXxHBXOH+bbtQdK/xO1jv0Ad7fUIlTBC20BgchErEtVlMnik4s7
        JFUk4rC6Kv2CE8kZgA82bV0=
X-Google-Smtp-Source: APXvYqw2lrfx6yr6aEN3KWzPUGKOqaaHNh2gipVKKgM5YkiGOt4TaL8dzcCquLS0zQDBLtzxSO9/qg==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr4853110wmj.39.1572966141019;
        Tue, 05 Nov 2019 07:02:21 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-7-224.as13285.net. [92.22.7.224])
        by smtp.gmail.com with ESMTPSA id q6sm21649448wrx.30.2019.11.05.07.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:02:20 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/5] pathspec: add new function to parse file
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <52e7a84a2ee61d6481286f6a32751107efc234d0.1572895605.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e34eba95-f413-ddd3-08c6-4f5b2bed3761@gmail.com>
Date:   Tue, 5 Nov 2019 15:02:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <52e7a84a2ee61d6481286f6a32751107efc234d0.1572895605.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr

Thanks for working on this. I've got a couple of comments about 
improving the error messages but this looks fine to me

On 04/11/2019 19:26, Alexandr Miloslavskiy via GitGitGadget wrote:
> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> 
> This will be used to support the new option '--pathspec-from-file' in
> `git add`, `git-commit`, `git reset` etc.
> 
> Note also that we specifically handle CR/LF line endings to support
> Windows better.
> 
> To simplify code, file is first parsed into `argv_array`. This allows
> to avoid refactoring `parse_pathspec()`.
> 
> I considered adding `nul_term_line` to `flags` instead, but decided
> that it doesn't fit there.
> 
> The new code is mostly taken from `cmd_update_index()` and
> `split_mail_conv()`.
> 
> Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> ---
>   pathspec.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   pathspec.h | 10 ++++++++++
>   2 files changed, 51 insertions(+)
> 
> diff --git a/pathspec.c b/pathspec.c
> index 12c2b322b3..97d4e77875 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -3,6 +3,8 @@
>   #include "dir.h"
>   #include "pathspec.h"
>   #include "attr.h"
> +#include "argv-array.h"
> +#include "quote.h"
>   
>   /*
>    * Finds which of the given pathspecs match items in the index.
> @@ -613,6 +615,45 @@ void parse_pathspec(struct pathspec *pathspec,
>   	}
>   }
>   
> +void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
> +			 unsigned flags, const char *prefix,
> +			 const char *file, int nul_term_line)
> +{
> +	struct argv_array parsed_file = ARGV_ARRAY_INIT;
> +	strbuf_getline_fn getline_fn = nul_term_line ? strbuf_getline_nul :
> +						       strbuf_getline;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf unquoted = STRBUF_INIT;
> +	FILE *in = NULL;
> +
> +	if (!strcmp(file, "-"))
> +		in = stdin;
> +	else
> +		in = fopen(file, "r");
> +
> +	if (!in)
> +		die(_("could not open '%s' for reading"), file);

die_errno() would give a more informative message here

> +	while (getline_fn(&buf, in) != EOF) {
> +		if (!nul_term_line && buf.buf[0] == '"') {
> +			strbuf_reset(&unquoted);
> +			if (unquote_c_style(&unquoted, buf.buf, NULL))
> +				die(_("line is badly quoted"));

It would be nice to show the offending line in the error message

> +			strbuf_swap(&buf, &unquoted);
> +		}
> +		argv_array_push(&parsed_file, buf.buf);
> +		strbuf_reset(&buf);
> +	}
> +
> +	strbuf_release(&unquoted);
> +	strbuf_release(&buf);
> +	if (in != stdin)
> +		fclose(in);
> +
> +	parse_pathspec(pathspec, magic_mask, flags, prefix, parsed_file.argv);
> +	argv_array_clear(&parsed_file);
> +}
> +
>   void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
>   {
>   	int i, j;
> diff --git a/pathspec.h b/pathspec.h
> index 1c18a2c90c..d72e0b4c4a 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -85,6 +85,16 @@ void parse_pathspec(struct pathspec *pathspec,
>   		    unsigned flags,
>   		    const char *prefix,
>   		    const char **args);
> +/*
> + * Same as parse_pathspec() but uses file as input.
> + * When 'file' is exactly "-" it uses 'stdin' instead.
> + */
> +void parse_pathspec_file(struct pathspec *pathspec,
> +		    unsigned magic_mask,
> +		    unsigned flags,
> +		    const char *prefix,
> +		    const char *file,
> +		    int nul_term_line);

Do these align with the 's' in "struct pathspec" ?

Best Wishes

Phillip

>   void copy_pathspec(struct pathspec *dst, const struct pathspec *src);
>   void clear_pathspec(struct pathspec *);
>   
> 
