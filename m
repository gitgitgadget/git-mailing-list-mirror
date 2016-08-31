Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EB71F859
	for <e@80x24.org>; Wed, 31 Aug 2016 20:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbcHaUKq (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:10:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36200 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932200AbcHaUKp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:10:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id i138so9267601wmf.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Vpdh4vFDDUSwSf8SYPUcobJafweRaI1vbwk1+ls9rV4=;
        b=qm/LVp6yOF9AQkNl+1aLrT+kioyvxzQZ4ltweuKUS5AIgcomD9ASq5H+pKTm36pR+X
         I4akwILxO/hPZVduI25myWM5QBvbCQZMb/OHpJn26bNnjfvn+kvxfTQhQfwdOZcOES10
         Cx2U7NZKYyu7Wgc9w6s4KzcPUXwb3s/vZNKDUBeNioSvSqaFzQbI9etRmcv5COCz2BCK
         Nc+OPgoAXZ5YtT0jWs3I4Ag8gKOzh0cUmP/mMYLoIz/FdgTwkeAtXJdVr2ObyNtHAQLZ
         0gY3M4XLPUsu+CgJ/rOeGQWVITVigatNXC+akMFUZhjz7cC4orhEw7ZbHXnaC+xg6QR4
         R/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Vpdh4vFDDUSwSf8SYPUcobJafweRaI1vbwk1+ls9rV4=;
        b=PH+YgGUUyhCmFL6y7WJmjmNFsH/0oR2oLGeaIWHAHxne7ol6IDo1ZFhPk9uX1l5gMu
         Bv8K5HU7HLtfFlaFXo42awfOZHdYZ+6iXQb//3cVp6vqZLw8qA8pFSCyjlYzRjYiGSFP
         oQSq6gkS2IY9fgljUvMtE7IsGvrZQEhBDrc42fWX9lPafqqvSjwFmxkjr4bI2Gs5LDvS
         H1cAdr1c8/fh5ubQO24KCUrIsninrNUqASDEiQMHM4W3aqrvVuwGdjpA91Ek9/ywdLd/
         5FfRBOZVf6rimLIWZzw5/bUZL0CYFzDy33D7zBsSWkQBVMyXxG5TvVrC0cH4dXzyDD1p
         c0VQ==
X-Gm-Message-State: AE9vXwMSaT/A8tV3B5NEWgfu2Mnbs4aymi3elL2K5UA4cMnQLvi/1tNFlMfOP+P9LymAsw==
X-Received: by 10.194.2.7 with SMTP id 7mr12166942wjq.45.1472674243506;
        Wed, 31 Aug 2016 13:10:43 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id ly9sm1442357wjb.44.2016.08.31.13.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 13:10:42 -0700 (PDT)
Subject: Re: [PATCH 16/22] sequencer: prepare for rebase -i's GPG settings
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <c6a37af958f59390c00429a5b38b34d34c9a5b95.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <104de15c-77e8-9474-9579-4934ca8a4323@gmail.com>
Date:   Wed, 31 Aug 2016 22:10:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <c6a37af958f59390c00429a5b38b34d34c9a5b95.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:

> The rebase command sports a `--gpg-sign` option that is heeded by the
> interactive rebase.

Should it be "sports" or "supports"?

> 
> This patch teaches the sequencer that trick, as part of the bigger
> effort to make the sequencer the work horse of the interactive rebase.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 4204cc8..e094ac2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -15,6 +15,7 @@
>  #include "merge-recursive.h"
>  #include "refs.h"
>  #include "argv-array.h"
> +#include "quote.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -33,6 +34,11 @@ static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
>   * being rebased.
>   */
>  static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
> +/*
> + * The following files are written by git-rebase just after parsing the
> + * command-line (and are only consumed, not modified, by the sequencer).
> + */

It is good to have this comment here.

> +static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")

I know it is not your fault, but I wonder why this file uses
snake_case_name, while all other use kebab-case-names.  That is,
why it is gpg_sign_opt and not gpg-sign-opt.

>  
>  /* We will introduce the 'interactive rebase' mode later */
>  #define IS_REBASE_I() 0
> @@ -129,6 +135,16 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
>  	return 1;
>  }
>  
> +static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_reset(&buf);
> +	if (opts->gpg_sign)
> +		sq_quotef(&buf, "-S%s", opts->gpg_sign);
> +	return buf.buf;
> +}

All right, this function is quite clear.

Sidenote: it's a pity api-quote.txt is just a placeholder for proper
documentation (including sq_quotef()).  I also wonder why it is not
named sq_quotef_buf() or strbuf_addf_sq().

> +
>  void *sequencer_entrust(struct replay_opts *opts, void *set_me_free_after_use)
>  {
>  	ALLOC_GROW(opts->owned, opts->owned_nr + 1, opts->owned_alloc);
> @@ -471,17 +487,20 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
>  
>  	if (IS_REBASE_I()) {
>  		env = read_author_script();
> -		if (!env)
> +		if (!env) {
> +			const char *gpg_opt = gpg_sign_opt_quoted(opts);
> +
>  			return error("You have staged changes in your working "
>  				"tree. If these changes are meant to be\n"
>  				"squashed into the previous commit, run:\n\n"
> -				"  git commit --amend $gpg_sign_opt_quoted\n\n"

How did this get expanded by error(), and why we want to replace
it if it works?

> +				"  git commit --amend %s\n\n"
>  				"If they are meant to go into a new commit, "
>  				"run:\n\n"
> -				"  git commit $gpg_sign_opt_quoted\n\n"
> +				"  git commit %s\n\n"
>  				"In both case, once you're done, continue "
>  				"with:\n\n"
> -				"  git rebase --continue\n");
> +				"  git rebase --continue\n", gpg_opt, gpg_opt);

Instead of passing option twice, why not make use of %1$s (arg reordering),
that is

  +				"  git commit --amend %1$s\n\n"
[...]
  +				"  git commit %1$s\n\n"


> +		}

So shell quoting is required only for error output.

>  	}
>  
>  	argv_array_init(&array);
> @@ -955,8 +974,27 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  
>  static int read_populate_opts(struct replay_opts *opts)
>  {
> -	if (IS_REBASE_I())
> +	if (IS_REBASE_I()) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
> +			if (buf.len && buf.buf[buf.len - 1] == '\n') {
> +				if (--buf.len &&
> +				    buf.buf[buf.len - 1] == '\r')
> +					buf.len--;
> +				buf.buf[buf.len] = '\0';
> +			}

Isn't there some strbuf_chomp() / strbuf_strip_eof() function?
Though as strbuf_getline() uses something similar...

> +
> +			if (!starts_with(buf.buf, "-S"))
> +				strbuf_reset(&buf);

Should we signal that there was problem with a file contents?

> +			else {
> +				opts->gpg_sign = buf.buf + 2;
> +				strbuf_detach(&buf, NULL);

Wouldn't we leak 2 characters that got skipped?  Maybe xstrdup would
be better (if it is leaked, and not reattached)?

> +			}
> +		}
> +
>  		return 0;
> +	}
>  
>  	if (!file_exists(git_path_opts_file()))
>  		return 0;
> 

-- 
Jakub Narębski

