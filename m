Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD791F859
	for <e@80x24.org>; Wed, 31 Aug 2016 21:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbcHaVJW (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 17:09:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36762 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758286AbcHaVJR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 17:09:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so9527698wmf.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=O5R+bkRoBBDOgA8402BuyQB7BTIFFTQsJYa31gWgE1o=;
        b=G3yISb6F3FaUGLN3PhgcYCULxvdF8ZDJAhlAwuhhsZbZhP8aBux6kbbOhEVG5nmpue
         grAeMtkbROIXhggqMP8okbdWvYG8In9DUo2DM6GlUjiw3vk2BEFguDbKVhn7YPADc+1L
         qDMGZQCgt8Jc08qAIfTS1q3Q/MHSQEghakmIZSqdXJoxMjWap/DD8FbdY7ZHLQCzfe9z
         IcASTPR6gMmGRL12MG5Qc2hDeEYQ99KwWMAxnAgGOyk9GhL9qm0ddtv58b0MWnW3Yk5B
         WLvm/tDSCG5Ox5m6Hq1BPr/AxTKp73yTGSc6afkFXWxMbjNwiuuZYSnh0ZFK/z+AVeN6
         7zNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=O5R+bkRoBBDOgA8402BuyQB7BTIFFTQsJYa31gWgE1o=;
        b=b43lOq4YYD2jNAUkspL62f5dbcHLnOXjbpKUKmaypzZmbxhi7Y3wZRYns1y+YUM3W4
         kGYxiB/vysMc9O6sIiqA8QbFKGGZceMNdb4uwnT1ZKlcuIln6sf4l5gZyRKx12sK88A9
         LqRnfLWqPgIZQiu551QlBkFIN9P80LhnaY3GkzfJxDkSlGVg6yuMjjQj8wML7Ca44zPm
         wX7ZPUm6s2Y7EAREs2hGg6JvsJCWkt36PYxVQcwIZ3uZgsjS9OUxXuE5vXjuonazhQ9y
         FS3r4V3hkGPAkGHtG/5bqjXcWzrB52nmLLjbYMp3x/FaUjQOrHO4nnPKgw2LmDlZ6MEW
         juSQ==
X-Gm-Message-State: AE9vXwOptuenBu233YYP0/uUg7QyZQITk2e3UN2gahhBuT8K00xUMoD4nMZN3rbDpvXNZA==
X-Received: by 10.194.89.73 with SMTP id bm9mr11921510wjb.76.1472677741286;
        Wed, 31 Aug 2016 14:09:01 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id m5sm26958211wmd.1.2016.08.31.14.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 14:09:00 -0700 (PDT)
Subject: Re: [PATCH 18/22] sequencer: support amending commits
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <c4e474af8e6237522f4c452ca90c2e2670059e60.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <dd7e4c82-cedb-6cde-a186-8b52bac3a5b8@gmail.com>
Date:   Wed, 31 Aug 2016 23:08:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <c4e474af8e6237522f4c452ca90c2e2670059e60.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:

> This teaches the sequencer_commit() function to take an argument that
> will allow us to implement "todo" commands that need to amend the commit
> messages ("fixup", "squash" and "reword").
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 6 ++++--
>  sequencer.h | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)

Nice and small addition of a new feature, a scaffolding for implementing
rebase -i using the sequencer.

> 
> diff --git a/sequencer.c b/sequencer.c
> index 7e17d14..20f7590 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -478,7 +478,7 @@ static char **read_author_script(void)
>   * (except, of course, while running an interactive rebase).
>   */
>  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty, int edit)
> +			  int allow_empty, int edit, int amend)

I guess we won't get much more parameters; it would get unwieldy
(and hard to remember).  Five is all right.

>  {
>  	char **env = NULL;
>  	struct argv_array array;
> @@ -507,6 +507,8 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
>  	argv_array_push(&array, "commit");
>  	argv_array_push(&array, "-n");
>  
> +	if (amend)
> +		argv_array_push(&array, "--amend");
>  	if (opts->gpg_sign)
>  		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
>  	if (opts->signoff)
> @@ -779,7 +781,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	}
>  	if (!opts->no_commit)
>  		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
> -			opts, allow, opts->edit);
> +			opts, allow, opts->edit, 0);

... even of this makes one need to check the calling convention,
what does this 0 mean.

>  
>  leave:
>  	free_message(commit, &msg);
> diff --git a/sequencer.h b/sequencer.h
> index fd02baf..2106c0d 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -50,7 +50,7 @@ int sequencer_rollback(struct replay_opts *opts);
>  int sequencer_remove_state(struct replay_opts *opts);
>  
>  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty, int edit);
> +			  int allow_empty, int edit, int amend);
>  
>  extern const char sign_off_header[];
>  
> 

