Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5111FC43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 13:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiFSNvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 09:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiFSNu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 09:50:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011F2655E
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 06:50:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g4so11322020wrh.11
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 06:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=neKG6RCtVZNVNw9mT1WIZvV2GBoWM+xpKd69VRBB56Y=;
        b=OdBvd3mTmW4EsBOLuVOzZaWOby5ByTJUQqemxnoB8ZTC4nqVwuVEYp5QqYhX3sDWTY
         3jPX0x4kYCWTOs5R6lZbmSholAzglWYTTeddNBmndnqhU98thk26gEKa1Xah6nyzgPpN
         yqP64MpDIkiu8rwtrCgywYo2cqxF/V/5rxVDKuSDwzV/9YYRQH2lMcBiPLVelH6kgT4b
         npYbpKL/inIuZbrj3IAE29Z9pulOEkvNp22jfzY2NWWqBYR5VXVKYnsVuRTCVDJeaJ0H
         yP8EMxcjM6rMkAHpruh3RJ9LJzIcZ3MNZcKmt7lL5Bz+V545XlD2+/22UP6yypDim+oa
         sCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=neKG6RCtVZNVNw9mT1WIZvV2GBoWM+xpKd69VRBB56Y=;
        b=ETwy/MKVI4DrUB73xrRGq82UTI+XO1tkc/YkR/KJ7Q8k+zypyvZYm9fKB8a+Bn4e9Z
         2wyoiOpX7N1Wl64gcdm0xtpMqUzTU/pPQYmXCmOWkPaWn5kFOXuqriPG4PQWJK6FxRk9
         sI6ZjRadbB4m8VoctMt1uYL93ZRDT6kiyhvF0GVFTtpemE+4EdXCnGWlXyRCJTtTneV6
         d0DahzsiPaLG6mG0vL0jBtKAC2O++1r+c18bspfJbo1E4H4J3lYam8ms4OGFqTiGdYhN
         WGyocKYIGfhy/vCMhDkUmf0NHrXAYPMJfJAvBV8gpGxb6JC2RX1EbzQBM1uGWHCTkcTj
         kD6w==
X-Gm-Message-State: AJIora8pQzY9SAMCoGfVdEJzX/Rjk4gj/NnbEVfEmHWs2B8He+ALTi3U
        AcA2uBfx4nVd4mTQDm2RjHM=
X-Google-Smtp-Source: AGRyM1u4fTAzxmtpIaqfQz0q5EzEC7PriDA6mweLAU8Xd2u9yCb/wXJeiIwqkzmgKominHbec/ENXg==
X-Received: by 2002:adf:f890:0:b0:21b:896a:aae1 with SMTP id u16-20020adff890000000b0021b896aaae1mr4615574wrp.543.1655646656378;
        Sun, 19 Jun 2022 06:50:56 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm17933675wmq.41.2022.06.19.06.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 06:50:56 -0700 (PDT)
Message-ID: <44f572b8-6cef-fad4-04c0-3cbb79db5bf9@gmail.com>
Date:   Sun, 19 Jun 2022 14:50:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] ls-files: introduce "--format" option
Content-Language: en-GB-large
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1262.git.1655300752.gitgitgadget@gmail.com>
 <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing

On 19/06/2022 10:13, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> Add a new option --format that output index enties
> informations with custom format, taking inspiration
> from the option with the same name in the `git ls-tree`
> command.
> 
> --format cannot used with -s, -o, -k, --resolve-undo,
> --deduplicate and --debug.

I think this is an interesting feature that provides functionality that 
is not available by feeding index entries into cat-file.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>   Documentation/git-ls-files.txt |  51 ++++++++++++-
>   builtin/ls-files.c             | 130 ++++++++++++++++++++++++++++++++-
>   t/t3013-ls-files-format.sh     | 130 +++++++++++++++++++++++++++++++++
>   3 files changed, 307 insertions(+), 4 deletions(-)
>   create mode 100755 t/t3013-ls-files-format.sh
> 
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 0dabf3f0ddc..9a88c92f1ad 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -20,7 +20,7 @@ SYNOPSIS
>   		[--exclude-standard]
>   		[--error-unmatch] [--with-tree=<tree-ish>]
>   		[--full-name] [--recurse-submodules]
> -		[--abbrev[=<n>]] [--] [<file>...]
> +		[--abbrev[=<n>]] [--format=<format>] [--] [<file>...]
>   
>   DESCRIPTION
>   -----------
> @@ -192,6 +192,13 @@ followed by the  ("attr/<eolattr>").
>   	to the contained files. Sparse directories will be shown with a
>   	trailing slash, such as "x/" for a sparse directory "x".
>   
> +--format=<format>::
> +	A string that interpolates `%(fieldname)` from the result being shown.
> +	It also interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
> +	interpolates to character with hex code `xx`; for example `%00`
> +	interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
> +	--format cannot be combined with `-s`, `-o`, `-k`, `--resolve-undo` and
> +	`--debug`.
>   \--::
>   	Do not interpret any more arguments as options.
>   
> @@ -223,6 +230,48 @@ quoted as explained for the configuration variable `core.quotePath`
>   (see linkgit:git-config[1]).  Using `-z` the filename is output
>   verbatim and the line is terminated by a NUL byte.
>   
> +It is possible to print in a custom format by using the `--format`
> +option, which is able to interpolate different fields using
> +a `%(fieldname)` notation. For example, if you only care about the
> +"objectname" and "path" fields, you can execute with a specific
> +"--format" like
> +
> +	git ls-files --format='%(objectname) %(path)'
> +
> +FIELD NAMES
> +-----------
> +Various values from structured fields can be used to interpolate
> +into the resulting output. For each outputting line, the following
> +names can be used:
> +
> +tag::
> +	The tag of file status.

The documentation for -t strong discourages its use, so I wonder if we 
really want to expose it here.

> +objectmode::
> +	The mode of the object.
> +objectname::
> +	The name of the object.
> +stage::
> +	The stage of the file.
> +eol::
> +	The line endings of files.

Every other option refers to either a "file" or "object" but here we 
have "files". Looking at the implementation below this will print the 
line ending from both the index and the worktree, it would be useful to 
clarify that here.

> +path::
> +	The pathname of the object.
> +ctime::
> +	The create time of file.

It is not clear from this whether this (and all the file attributes 
below) are coming from the worktree or the index or both like eol?

> +mtime::
> +	The modify time of file.
> +dev::
> +	The ID of device containing file.
> +ino::
> +	The inode number of file.
> +uid::
> +	The user id of file owner.
> +gid::
> +	The group id of file owner.
> +size::
> +	The size of the file.
> +flags::
> +	The flags of the file.

What are the flags?

> [...]  
> +static size_t expand_show_index(struct strbuf *sb, const char *start,
> +			       void *context)
> +{
> +	struct show_index_data *data = context;
> +	const char *end;
> +	const char *p;
> +	unsigned int errlen;
 > [...]
> +	else if (skip_prefix(start, "(flags)", &p))
> +		strbuf_addf(sb, "flags: %x", data->ce->ce_flags);
> +	else {
> +		errlen = (unsigned long)len;
> +		die(_("bad ls-files format: %%%.*s"), errlen, start);

errlen is declared as an unsigned int, but you cast len which is a 
size_t to unsigned long when assigning to errlen. Then errlen is used 
where a signed int is required by die. There is also a style violation 
as if any branch of an if needs braces then they should all be braced. I 
think that the best solution would be to drop errlen and just write

	else
		die(_("bad ls-files format: %%%.*s"), (int)len, start);

It would be interesting to check the performance of this implementation 
on a large repository as it is doing a lot of branching inside a loop. I 
don't think we should change it unless it turns out to be a problem. 
Then we could try switching on the first character of the format 
specifier or some other optimization.

Best Wishes

Phillip
