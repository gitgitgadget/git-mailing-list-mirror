Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73EC61F461
	for <e@80x24.org>; Sat, 29 Jun 2019 14:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfF2OFk (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 10:05:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34003 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfF2OFk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 10:05:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so11181970wmd.1
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6SPUESF6Jd2BZpCkQ+k2xo9TMdFlRea0rJwQqjfokPA=;
        b=MhflMC9opJLQbGAHoXZ3KrDkpvA+6TlyZ9Fs6e/U9gKJk+T379peBBoSONtHQMLRsS
         K7oeaZK3yEIkz5/AQZfFX6LNP0ENr+JYNXpZ/P8IedkOCyoCqV/SkJ13VYVXEyDHTO3U
         u1/zfNolhbpvu5q1CLMlhK7Nan5TcB8ToiVE9FkFvWEEi6xhzhy9WDHRMguSUGALr9y6
         JdpEcdomvyG1RWh2n6+ZmJNUK5EiBMZaWqTPoNyZU9LmRXkaVyFq52jy1y+AMlyJ8pMu
         urMVk7jMoGgjvfrIdYEp4W5+apZwUJM5DQRYgbfdIWDqmK4jylKYdR9eYuef8i4jrQJv
         CaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6SPUESF6Jd2BZpCkQ+k2xo9TMdFlRea0rJwQqjfokPA=;
        b=MA9UWvK470GbxJtP2zr/gZQdB3wayeUCpED0M3GNi6y4wcnZegls0f7Oq1Mha/PCA9
         raNEgMkSElZfe8XxBYl6wK3glUZIJJyil24A48NCZBsG+gxXD4mm38DZvAJmSIl0Q7pA
         CXylBA2R9brTzgB1R7RP2QWNCrGGfmq+iljtk1F9hUF1MTAgDJ45AM3E/a1g7yjSAQx9
         sJZsn4u/fwQ/Kt2qI4+2GZiSZYjzIY9p9QhEJqIrFX0+bV+nvegsgDDU8e3eq7mfwqCm
         B3k7VGyjkG1ViP2hliXiyy5fZ+3IhSoNMZ3blSavjWM1zjGS5A0aHXF8zJZ/g1QXfiGi
         X4Xw==
X-Gm-Message-State: APjAAAWkJsYp5TrAxnBPaYjNQyhH1xdGBeB3n+PSvSi58IpmOHaehfgF
        U7u45z0upNh2v3GqRRj0IGc=
X-Google-Smtp-Source: APXvYqyUI+jWyiJsPk2/ZQ9iGIagwvv5gAMRIeOliaI8NFHHPKt6FkLasYirpKnUISZJ++ddWF2ziw==
X-Received: by 2002:a1c:700b:: with SMTP id l11mr10787051wmc.106.1561817137941;
        Sat, 29 Jun 2019 07:05:37 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id h19sm4763173wrb.81.2019.06.29.07.05.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 07:05:37 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v7 2/6] sequencer: add advice for revert
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        gitster@pobox.com, martin.agren@gmail.com
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
 <20190623200338.17144-3-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5ae3461e-7c83-2eeb-552c-ffe838bb03b6@gmail.com>
Date:   Sat, 29 Jun 2019 15:05:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190623200338.17144-3-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 23/06/2019 21:03, Rohit Ashiwal wrote:
> In the case of merge conflicts, while performing a revert, we are
> currently advised to use `git cherry-pick --<sequencer-options>`
> of which --continue is incompatible for continuing the revert.

I'm not sure why this says we cannot use --continue with revert, I think 
it should work fine. Also below your new advice recommends `revert 
--continue` as an option which contradicts this part of the commit message.

Oh do you mean `cherry-pick --abort` and `cherry-pick --quit` work with 
a revert but `cherry-pick --continue` does not? If so that's a quirk of 
the implementation that should be fixed. If that's the case I'm think 
mentioning it just confuses the commit message. Just say the advice for 
revert should say revert.

I'd also squash the first patch into this one so the new variable is 
used when it is introduced

Best Wishes

Phillip

> Introduce a separate advice message for `git revert`. Also change
> the signature of `create_seq_dir` to handle which advice to display
> selectively.
> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>   sequencer.c | 35 +++++++++++++++++++++++++++++------
>   1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index f88a97fb10..0ef2622a69 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2650,15 +2650,38 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
>   	return 0;
>   }
>   
> -static int create_seq_dir(void)
> +static int create_seq_dir(struct repository *r)
>   {
> -	if (file_exists(git_path_seq_dir())) {
> -		error(_("a cherry-pick or revert is already in progress"));
> -		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
> +	enum replay_action action;
> +	const char *in_progress_error = NULL;
> +	const char *in_progress_advice = NULL;
> +
> +	if (!sequencer_get_last_command(r, &action)) {
> +		switch (action) {
> +		case REPLAY_REVERT:
> +			in_progress_error = _("revert is already in progress");
> +			in_progress_advice =
> +			_("try \"git revert (--continue | --abort | --quit)\"");
> +			break;
> +		case REPLAY_PICK:
> +			in_progress_error = _("cherry-pick is already in progress");
> +			in_progress_advice =
> +			_("try \"git cherry-pick (--continue | --abort | --quit)\"");
> +			break;
> +		default:
> +			BUG("unexpected action in create_seq_dir");
> +		}
> +	}
> +	if (in_progress_error) {
> +		error("%s", in_progress_error);
> +		if (advice_sequencer_in_use)
> +			advise("%s", in_progress_advice);
>   		return -1;
> -	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
> +	}
> +	if (mkdir(git_path_seq_dir(), 0777) < 0)
>   		return error_errno(_("could not create sequencer directory '%s'"),
>   				   git_path_seq_dir());
> +
>   	return 0;
>   }
>   
> @@ -4237,7 +4260,7 @@ int sequencer_pick_revisions(struct repository *r,
>   	 */
>   
>   	if (walk_revs_populate_todo(&todo_list, opts) ||
> -			create_seq_dir() < 0)
> +			create_seq_dir(r) < 0)
>   		return -1;
>   	if (get_oid("HEAD", &oid) && (opts->action == REPLAY_REVERT))
>   		return error(_("can't revert as initial commit"));
> 
