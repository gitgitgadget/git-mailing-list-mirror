Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE1B1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 15:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfFLPQy (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 11:16:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32850 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbfFLPQy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 11:16:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so4517983wme.0
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O+vXzaNuH63dW8gU2Ot/POBKdXFNo5/gewSnVAtTIYY=;
        b=nYm9IHy9kNBdTuYSA9KnHdZ15W0sTaAAgKgP4onHBxxGEWJWostNbJoqVBUOvcDcF4
         jOTArIih8Mg4J/Dw+VLqU/DRc2B4qN0a4sXlWg0SnHwMQ1VLoO5wTryVrF+y2rOT6ncj
         9Zk93cUIrK545mG2LkGUyjzvgMDJPp2mJPivNU6yChoGv4O8+DzuK2doyxLcHN1Hnfrh
         E8VPF5qOrsFF4xaa1p6tRD6zQYztJJnD2TTBDyDgB0q4WVLpT4x58kOpXxDotqH5yROh
         wHgX4VGOU2UZw+7TyhSKylRTuz8djzTvdsDZmJKlhYbJl3AHNgrEpI+VSkhOGyX8+5kI
         rkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=O+vXzaNuH63dW8gU2Ot/POBKdXFNo5/gewSnVAtTIYY=;
        b=bdXXqYex0NUtopTAO2d5rFQhkUr1ba9E6SgEBmuvb5jBOfxM45um15pQ4zP8t8XRjL
         xMgzI4QdC4PeIeGwOHftGhe0LTRMn8UNeaATR7XOwTqCKy2GMgJIxz7v+H9kYSn4FEAn
         Ne/WcUNqL4D0Cy8SuSBruPQyVeswRja+nL4cWyK8XGllAEJh5o4Lyj+14iyJOAs+daW+
         +xen85ou7lsRw/b1sxyCW/NGnl86kYuzPyy/S/g1XkpvE3K7CVX+9ubMsMtjRtJbj4T0
         QT61Vu66TZ50p3IaOS0pqvWd+ykeFi+Sot3BYXSkB6i2rxG7iRqw+xaPidwsgIi/8CUA
         4GWQ==
X-Gm-Message-State: APjAAAU+52wrQyd3h+Pav04LID4oSQ+lFzGNuvx5NE98TGFFPlUf0ciu
        MmtJFrHzpwvd86IYgBVdTpU=
X-Google-Smtp-Source: APXvYqywe4d/tr6Q/Wq8ZZNp8UpV3wpTaMIpdwz84/f4MsYAXeT2WSn/ShW+1oeqcMEgM/HGAVJN2Q==
X-Received: by 2002:a1c:51:: with SMTP id 78mr23963603wma.9.1560352611218;
        Wed, 12 Jun 2019 08:16:51 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id p2sm22867005wrx.90.2019.06.12.08.16.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 08:16:50 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 3/3] cherry-pick/revert: advise using --skip
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        gitster@pobox.com
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190611073152.12214-1-rohit.ashiwal265@gmail.com>
 <20190611073152.12214-4-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3591ee0f-b302-23c8-dda5-00ff650887b8@gmail.com>
Date:   Wed, 12 Jun 2019 16:16:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611073152.12214-4-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 11/06/2019 08:31, Rohit Ashiwal wrote:
> The previous commit introduced a --skip flag for cherry-pick and
> revert. Update the advice messages, to tell users about this less
> cumbersome way of skipping commits. Also add tests to ensure
> everything is working fine.
> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
> changes since last revision:
>      - selectively advice --skip
>      - add new test
> 
>   builtin/commit.c                | 13 ++++++++-----
>   sequencer.c                     |  7 +++++--
>   t/t3510-cherry-pick-sequence.sh | 20 ++++++++++++++++++++
>   3 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 1c9e8e2228..1f47c51bdc 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -60,15 +60,18 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
>   "\n");
>   
>   static const char empty_cherry_pick_advice_single[] =
> -N_("Otherwise, please use 'git reset'\n");
> +N_("Otherwise, please use 'git cherry-pick --skip'\n");
>   
>   static const char empty_cherry_pick_advice_multi[] =
> -N_("If you wish to skip this commit, use:\n"
> +N_("and then use:\n"
>   "\n"
> -"    git reset\n"
> +"    git cherry-pick --continue\n"
>   "\n"
> -"Then \"git cherry-pick --continue\" will resume cherry-picking\n"
> -"the remaining commits.\n");
> +"to resume cherry-picking the remaining commits.\n"
> +"If you wish to skip this commit, use:\n"
> +"\n"
> +"    git cherry-pick --skip\n"
> +"\n");
>   
>   static const char *color_status_slots[] = {
>   	[WT_STATUS_HEADER]	  = "header",
> diff --git a/sequencer.c b/sequencer.c
> index 93284cd7dd..ecf4be7e15 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2661,10 +2661,13 @@ static int create_seq_dir(struct repository *r)
>   			error(_("a %s is already in progress"),
>   				 action == REPLAY_REVERT ?
>   				 "revert" : "cherry-pick");
> -			advise(_("try \"git %s (--continue | "
> +			advise(_("try \"git %s (--continue | %s"
>   				 "--quit | --abort)\""),
>   				 action == REPLAY_REVERT ?
> -				 "revert" : "cherry-pick");
> +				 "revert" : "cherry-pick",
> +				 !file_exists(git_path_revert_head(r)) ?
> +				 !file_exists(git_path_cherry_pick_head(r)) ? ""
> +				 : "--skip | " : "--skip | ");

This could be simplified as
	(file_exists(git_path_revert_head(r) ||
	file_exists(git_path_cherry_pick_head(r)) ?
	"--skip | " ""

Best Wishes

Phillip

>   			return -1;
>   		default:
>   			BUG(_("the control must not reach here"));
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 6c1903a735..f298f02cd0 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -172,6 +172,26 @@ test_expect_success 'check advice when we move HEAD by committing' '
>   	test_cmp expect advice
>   '
>   
> +test_expect_success 'selectively advise --skip while launching another sequence' '
> +	pristine_detach initial &&
> +	cat >expect <<-EOF &&
> +	error: a cherry-pick is already in progress
> +	hint: try "git cherry-pick (--continue | --skip | --quit | --abort)"
> +	fatal: cherry-pick failed
> +	EOF
> +	test_must_fail git cherry-pick picked..yetanotherpick &&
> +	test_must_fail git cherry-pick picked..yetanotherpick 2>advice && > +	test_cmp expect advice &&
> +	cat >expect <<-EOF &&
> +	error: a cherry-pick is already in progress
> +	hint: try "git cherry-pick (--continue | --quit | --abort)"
> +	fatal: cherry-pick failed
> +	EOF
> +	git reset --merge &&
> +	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
> +	test_cmp expect advice
> +'
> +
>   test_expect_success 'allow skipping commit but not abort for a new history' '
>   	pristine_detach initial &&
>   	cat >expect <<-EOF &&
> 
