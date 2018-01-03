Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC921F406
	for <e@80x24.org>; Wed,  3 Jan 2018 20:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeACUdn (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 15:33:43 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35097 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeACUdj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 15:33:39 -0500
Received: by mail-qt0-f194.google.com with SMTP id u10so3652898qtg.2
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 12:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ySJ+OCN1e331GSl3Du0S2LAg18wzJB1n888twTd4ALc=;
        b=tyeiArchS0Ij7NjinDYlNk77nrdM19L1pzuXhbWXHLa9DIwXdGiGDZ01auPuwyLr/3
         IOtLPwIXKcdd+9jfjYNXt9YmFn2V4vb4lsjllCVeyJBXVeIayVQMCBxHc61UEqNrY3Q3
         72vMCwjfYusQJGMvrBbDBx92Nyxycip7uEfzyMhHg9aw3cqyc9VU5p+D1wXBzfjiJ27n
         HV0qHitcOZgtzGWZum8VByV7ZdBr0UOzmV0BlrlqJy8eJ45eLDDn1jWqu6ke2pMqK6Wq
         F8+m0FVW5GE428g/+4JgHfXbqLTE34vfbHfNcqFQJEOJVbUK5BZGPpm75qaGfUxy/xbM
         wzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ySJ+OCN1e331GSl3Du0S2LAg18wzJB1n888twTd4ALc=;
        b=akFVP10sAgFqcmcjLyo750xW3O78kfdT9itNlXa/zQWpXEBLJdWX1e2wVjpD3/W80v
         QoONH4NF2uxr+AdAITZeB97jVQAAICmjnYbM+LJxLnA59EaLF6reubNiA8hr3vqmYN+h
         BhkwGPGhOkbL+Q05hVg0FV6cUD4etcrtTOSEAlmtjnGNOPgKdG8U/a7TMRTWDnyCm173
         w86RtvgguBXtnKVtyERxFFJZELlNzFuf7PPa1mVmkUZUkHnoVGCGATGeT/l77C7gofhu
         Enc4AuQXQwXDTJEmUy9t/BOnT84ePKfN/vFEkB0Oc7DZ/6khgxDzopY8AU8grIsBOsD+
         airA==
X-Gm-Message-State: AKGB3mJfLpDOY0YguJyLl9LOeMGlieWrpB3a9JQfq8UaWKn4w8UyAESZ
        WvZAZhnEuei0FUftM8HFdqFTZAYMWnu/cSNFLX2G2G59
X-Google-Smtp-Source: ACJfBovAHae/F5OLDZlI0TvE9PE7iwYs8HoQsXr4Dwd9Q1Qngssyh2F8rlMhqQ50r0b+Es5vLm8wkern5+9IiQmxBlA=
X-Received: by 10.200.36.22 with SMTP id c22mr3439937qtc.207.1515011618003;
 Wed, 03 Jan 2018 12:33:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 3 Jan 2018 12:33:37 -0800 (PST)
In-Reply-To: <20180103001828.205012-5-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180103001828.205012-5-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Jan 2018 12:33:37 -0800
Message-ID: <CAGZ79kb2=uU0_K8wr27gNdNX-T+P+7gVdgc5EBdYc3zBobsR8w@mail.gmail.com>
Subject: Re: [PATCH 04/26] upload-pack: convert to a builtin
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 4:18 PM, Brandon Williams <bmwill@google.com> wrote:
> In order to allow for code sharing with the server-side of fetch in
> protocol-v2 convert upload-pack to be a builtin.

What is the security aspect of this patch?

By making upload-pack builtin, it gains additional abilities,
such as answers to '-h' or '--help' (which would start a pager).
Is there an easy way to sooth my concerns? (best put into the
commit message)

Thanks,
Stefan

>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Makefile      | 3 ++-
>  builtin.h     | 1 +
>  git.c         | 1 +
>  upload-pack.c | 2 +-
>  4 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 2a81ae22e..e0740b452 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -636,7 +636,6 @@ PROGRAM_OBJS += imap-send.o
>  PROGRAM_OBJS += sh-i18n--envsubst.o
>  PROGRAM_OBJS += shell.o
>  PROGRAM_OBJS += show-index.o
> -PROGRAM_OBJS += upload-pack.o
>  PROGRAM_OBJS += remote-testsvn.o
>
>  # Binary suffix, set to .exe for Windows builds
> @@ -701,6 +700,7 @@ BUILT_INS += git-merge-subtree$X
>  BUILT_INS += git-show$X
>  BUILT_INS += git-stage$X
>  BUILT_INS += git-status$X
> +BUILT_INS += git-upload-pack$X
>  BUILT_INS += git-whatchanged$X
>
>  # what 'all' will build and 'install' will install in gitexecdir,
> @@ -904,6 +904,7 @@ LIB_OBJS += tree-diff.o
>  LIB_OBJS += tree.o
>  LIB_OBJS += tree-walk.o
>  LIB_OBJS += unpack-trees.o
> +LIB_OBJS += upload-pack.o
>  LIB_OBJS += url.o
>  LIB_OBJS += urlmatch.o
>  LIB_OBJS += usage.o
> diff --git a/builtin.h b/builtin.h
> index 42378f3aa..f332a1257 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -231,6 +231,7 @@ extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
>  extern int cmd_update_server_info(int argc, const char **argv, const char *prefix);
>  extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
>  extern int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
> +extern int cmd_upload_pack(int argc, const char **argv, const char *prefix);
>  extern int cmd_var(int argc, const char **argv, const char *prefix);
>  extern int cmd_verify_commit(int argc, const char **argv, const char *prefix);
>  extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
> diff --git a/git.c b/git.c
> index c870b9719..f71073dc8 100644
> --- a/git.c
> +++ b/git.c
> @@ -478,6 +478,7 @@ static struct cmd_struct commands[] = {
>         { "update-server-info", cmd_update_server_info, RUN_SETUP },
>         { "upload-archive", cmd_upload_archive },
>         { "upload-archive--writer", cmd_upload_archive_writer },
> +       { "upload-pack", cmd_upload_pack },
>         { "var", cmd_var, RUN_SETUP_GENTLY },
>         { "verify-commit", cmd_verify_commit, RUN_SETUP },
>         { "verify-pack", cmd_verify_pack },
> diff --git a/upload-pack.c b/upload-pack.c
> index d5de18127..20acaa49d 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1032,7 +1032,7 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
>         return parse_hide_refs_config(var, value, "uploadpack");
>  }
>
> -int cmd_main(int argc, const char **argv)
> +int cmd_upload_pack(int argc, const char **argv, const char *prefix)
>  {
>         const char *dir;
>         int strict = 0;
> --
> 2.15.1.620.gb9897f4670-goog
>
