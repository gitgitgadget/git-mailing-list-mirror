Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548961F462
	for <e@80x24.org>; Sun,  9 Jun 2019 08:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfFIImm (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 04:42:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35140 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfFIIml (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 04:42:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so6145684wrv.2
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DrAsMOTPkvMtwcXWteD19j6D/XY0rSPyVLvFMp0GrR8=;
        b=kdnFWUQ2PRRvtlXANIUEviqtqkueTS23mMOKWneZzPFuzJDK8koyJ3Z0wmG9cY4QNC
         C9zyyKLdhCR4JFf/cKUq3fnrHdSYURyhwetjR1I7px3NCQaaV9pnVJP0h4qvViD49CZa
         Jc8kMjmHz/vdVWYmT9PBF9bVYuwHMGbR9aDUqXyIBl8yTtA8fCPP8cbIfkIRfmHf3a9l
         fN/4Plnou2j7bcPl7AXCKFdJonE4Rfzy0VkbRwPoZYtkxLjfgjJTJ0n08vgJM5jR+kQD
         vqdvL9QMFz5qFCLwWWI4qQPmpUhj5lnyBH9sHhdhGqLhDZDNqPVT6JjBrOe5FdygbaSF
         DyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DrAsMOTPkvMtwcXWteD19j6D/XY0rSPyVLvFMp0GrR8=;
        b=rr95w9aUWwd7O0rdb9Q6MtcMHT2EXZ8PJq1DiNHuprodgzUeVakLaP/jOPr1cB1VSH
         NwjREkHX+VWhOOC4enG2n9WpFyS7gcJYX2ejNBPzYUwBJJhXzzro2H65xj9mmjgVX+Bb
         ycHuqJy03S56EQLvb4NdgiAuASpnaaUkNvT9wcP1XjDI7MEO8/ODSu74r1P+A4utuJp6
         b70Ab7qw5y0/b/Fa3+Ut9TeZ8jLCYO799zJgi7FLKbrVSMSMldgwaHCEPsO3K7XD2QxV
         CCNq4yQ0xw1dnt7LscpsQjwHflz1L2cB9ANbsY3e8769KBr6MoOdJ9PPLufde1FqV+B7
         WsZg==
X-Gm-Message-State: APjAAAWekTMUwuv0bzT23qgzP7W6wPTG7SmEHoZ8Nx7oSaI/o9x9KBMG
        /6j+vDRb0EN5vWOUCAF4puI=
X-Google-Smtp-Source: APXvYqy3xUJuOghfX69xPWZ5iFIIUTfuWAW7yW/s1YyqKL6cGNf1ALyHyC/ob7vlIEmEhnNIC3AkcA==
X-Received: by 2002:adf:e808:: with SMTP id o8mr8232367wrm.191.1560069759915;
        Sun, 09 Jun 2019 01:42:39 -0700 (PDT)
Received: from localhost (adsl-22.176.58.193.tellas.gr. [176.58.193.22])
        by smtp.gmail.com with ESMTPSA id u5sm8900291wmc.32.2019.06.09.01.42.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 01:42:38 -0700 (PDT)
Date:   Sun, 9 Jun 2019 09:42:36 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [GSoC][PATCH 3/3] cherry-pick/revert: update hints
Message-ID: <20190609084236.GB28007@hank.intra.tgummerer.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190608191958.4593-4-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608191958.4593-4-rohit.ashiwal265@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: [GSoC][PATCH 3/3] cherry-pick/revert: update hints

"update hints" is very generic when read in 'git log --oneline', and
doesn't give the reader much useful information.  Maybe something like

        cherry-pick/revert: advice using --skip

        In the previous commit we introduced a --skip flag for
        cherry-pick and revert.  Update the advice messages, to tell
        users about this less cumbersome way of skipping commits

would work better?  The rest of the patch looks good to me.

On 06/09, Rohit Ashiwal wrote:
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>  builtin/commit.c | 13 ++++++++-----
>  sequencer.c      |  4 ++--
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 1c9e8e2228..1f47c51bdc 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -60,15 +60,18 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
>  "\n");
>  
>  static const char empty_cherry_pick_advice_single[] =
> -N_("Otherwise, please use 'git reset'\n");
> +N_("Otherwise, please use 'git cherry-pick --skip'\n");
>  
>  static const char empty_cherry_pick_advice_multi[] =
> -N_("If you wish to skip this commit, use:\n"
> +N_("and then use:\n"
>  "\n"
> -"    git reset\n"
> +"    git cherry-pick --continue\n"
>  "\n"
> -"Then \"git cherry-pick --continue\" will resume cherry-picking\n"
> -"the remaining commits.\n");
> +"to resume cherry-picking the remaining commits.\n"
> +"If you wish to skip this commit, use:\n"
> +"\n"
> +"    git cherry-pick --skip\n"
> +"\n");
>  
>  static const char *color_status_slots[] = {
>  	[WT_STATUS_HEADER]	  = "header",
> diff --git a/sequencer.c b/sequencer.c
> index f586e677d3..e889427eef 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2654,8 +2654,8 @@ static int create_seq_dir(void)
>  {
>  	if (file_exists(git_path_seq_dir())) {
>  		error(_("a cherry-pick or revert is already in progress"));
> -		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
> -		advise(_("or  \"git revert (--continue | --quit | --abort)\""));
> +		advise(_("try \"git cherry-pick (--continue | --skip | --quit | --abort)\""));
> +		advise(_("or  \"git revert (--continue | --skip | --quit | --abort)\""));
>  		return -1;
>  	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
>  		return error_errno(_("could not create sequencer directory '%s'"),
> -- 
> 2.21.0
> 
