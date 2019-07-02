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
	by dcvr.yhbt.net (Postfix) with ESMTP id 14CF01F461
	for <e@80x24.org>; Tue,  2 Jul 2019 15:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfGBP0d (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 11:26:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54286 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfGBP0d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 11:26:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so1262050wme.4
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bJZYHIdMAjt5D+6S/0TRqrP34qvrd2VS2Jzd+zTAfQE=;
        b=oYY1TXtnS4akWEoyVHv9mOx2gLV92vAYcsT7/qeAXSean5OV67obQ63dpa0R7xy0L0
         w/y40FWP1ya4oI8KwAqvAMH9fm04kO7EZpW5WZCBIii07t604oiqTi5mrvMyCVvLkSrr
         qNF1zisN+QP898Le1ZHxdv/KAALiGoHMfqlDXc228U2Y8eVCCyhJDSddx2EMeGya9p9j
         PuidshyY4M2ACI5AMtWduvFsl6vyMpg0+zMZGyMo/dW0tw5o48f0E078vCvwfPL6NDb1
         ZucMXuzwWG+PCHIfWJdwy6i6a4V9k9k504KwQwaPpikQ2Cm/TTt7hkMPyOScJCGvEfcm
         60xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bJZYHIdMAjt5D+6S/0TRqrP34qvrd2VS2Jzd+zTAfQE=;
        b=dCIBa9ygcNdcxqzkUe260QBcz38EbR1guNwn1nDGGro2mPQvONUXpP9h5G8RRTo1Bs
         r/QlBDgRS1TLZyZ7ya0kp7doGV6UcZ84Gv+2hnIT0qQNRasbOD7UTE8qX0yMH0LgVYOP
         bwx7DMM0IuALZZZqLTaR+S50LUYuV5CuvLV/H2UE1HkTNeDt3AH1Tmd/LC4zymzTaX1W
         zswjIYv49GK48+b5+i7OhsN3bq7432vmjOLjBx4ffDW7rXjmUqScWk5O4h0a1tPgC4En
         jwIqtyTCX4Gjjww6ZXna+0Kn5vk/TUhkmQyaNCntBz66Kgkl0jO1V58BjGninMOOvMJ5
         +6lg==
X-Gm-Message-State: APjAAAWDTO3Je4SoWrVXrr6RWuAdGNB/u9mUgwh40VukRKE+F8Dddrq0
        PmRI8XZyNYaXP+99Wb2V4U4=
X-Google-Smtp-Source: APXvYqxyc1b3RIzskDa/myGynYHruSR7aoYH1fNRwLs3FRVem4S6ts5pamiVoK/vh0uU7NnZlq5yrg==
X-Received: by 2002:a1c:a7ca:: with SMTP id q193mr4151441wme.150.1562081189957;
        Tue, 02 Jul 2019 08:26:29 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id o126sm3394580wmo.1.2019.07.02.08.26.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 08:26:29 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v8 0/5] Teach cherry-pick/revert to skip commits
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        martin.agren@gmail.com, jrnieder@gmail.com
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190702091129.7531-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <64b16b96-8c87-8010-9355-2d13c55f9d2f@gmail.com>
Date:   Tue, 2 Jul 2019 16:26:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190702091129.7531-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

Thanks for re-rolling again (and bearing with all the review rounds), I 
think the range-diff looks good. These are ready for next as far as I'm 
concerned.

Best Wishes

Phillip

On 02/07/2019 10:11, Rohit Ashiwal wrote:
> Another revision of my patch which takes care of all the nits.
> 
> Rohit Ashiwal (5):
>    sequencer: add advice for revert
>    sequencer: rename reset_for_rollback to reset_merge
>    sequencer: use argv_array in reset_merge
>    cherry-pick/revert: add --skip option
>    cherry-pick/revert: advise using --skip
> 
>   Documentation/config/advice.txt   |   2 +
>   Documentation/git-cherry-pick.txt |   4 +-
>   Documentation/git-revert.txt      |   4 +-
>   Documentation/sequencer.txt       |   4 +
>   advice.c                          |   2 +
>   advice.h                          |   1 +
>   builtin/commit.c                  |  13 +--
>   builtin/revert.c                  |   5 ++
>   sequencer.c                       | 134 ++++++++++++++++++++++++++----
>   sequencer.h                       |   1 +
>   t/t3510-cherry-pick-sequence.sh   | 122 +++++++++++++++++++++++++++
>   11 files changed, 266 insertions(+), 26 deletions(-)
> 
> Range-diff:
> 1:  207042a895 < -:  ---------- advice: add sequencerInUse config variable
> 2:  d7c603d47f ! 1:  91d3949b69 sequencer: add advice for revert
>      @@ -3,14 +3,58 @@
>           sequencer: add advice for revert
>       
>           In the case of merge conflicts, while performing a revert, we are
>      -    currently advised to use `git cherry-pick --<sequencer-options>`
>      -    of which --continue is incompatible for continuing the revert.
>      +    currently advised to use `git cherry-pick --<sequencer-options>`.
>           Introduce a separate advice message for `git revert`. Also change
>           the signature of `create_seq_dir` to handle which advice to display
>           selectively.
>       
>           Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>       
>      + diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
>      + --- a/Documentation/config/advice.txt
>      + +++ b/Documentation/config/advice.txt
>      +@@
>      + 	resolveConflict::
>      + 		Advice shown by various commands when conflicts
>      + 		prevent the operation from being performed.
>      ++	sequencerInUse::
>      ++		Advice shown when a sequencer command is already in progress.
>      + 	implicitIdentity::
>      + 		Advice on how to set your identity configuration when
>      + 		your information is guessed from the system username and
>      +
>      + diff --git a/advice.c b/advice.c
>      + --- a/advice.c
>      + +++ b/advice.c
>      +@@
>      + int advice_commit_before_merge = 1;
>      + int advice_reset_quiet_warning = 1;
>      + int advice_resolve_conflict = 1;
>      ++int advice_sequencer_in_use = 1;
>      + int advice_implicit_identity = 1;
>      + int advice_detached_head = 1;
>      + int advice_set_upstream_failure = 1;
>      +@@
>      + 	{ "commitBeforeMerge", &advice_commit_before_merge },
>      + 	{ "resetQuiet", &advice_reset_quiet_warning },
>      + 	{ "resolveConflict", &advice_resolve_conflict },
>      ++	{ "sequencerInUse", &advice_sequencer_in_use },
>      + 	{ "implicitIdentity", &advice_implicit_identity },
>      + 	{ "detachedHead", &advice_detached_head },
>      + 	{ "setupStreamFailure", &advice_set_upstream_failure },
>      +
>      + diff --git a/advice.h b/advice.h
>      + --- a/advice.h
>      + +++ b/advice.h
>      +@@
>      + extern int advice_commit_before_merge;
>      + extern int advice_reset_quiet_warning;
>      + extern int advice_resolve_conflict;
>      ++extern int advice_sequencer_in_use;
>      + extern int advice_implicit_identity;
>      + extern int advice_detached_head;
>      + extern int advice_set_upstream_failure;
>      +
>        diff --git a/sequencer.c b/sequencer.c
>        --- a/sequencer.c
>        +++ b/sequencer.c
> 3:  b70299c572 ! 2:  189ef90318 sequencer: rename reset_for_rollback to reset_merge
>      @@ -6,7 +6,7 @@
>           achieve this, we could really make use of existing functions.
>           reset_for_rollback is one such function, but the name does not
>           intuitively suggest to use it to reset a merge, which it was born to
>      -    perform see 539047c ("revert: introduce --abort to cancel a failed
>      +    perform, see 539047c ("revert: introduce --abort to cancel a failed
>           cherry-pick", 2011-11-23). Change the name to reset_merge to make
>           it more intuitive.
>       
> 4:  569122c861 = 3:  2b237e3174 sequencer: use argv_array in reset_merge
> 5:  4580f0e5af = 4:  5d64faf501 cherry-pick/revert: add --skip option
> 6:  f6f21b055b = 5:  807a344eb1 cherry-pick/revert: advise using --skip
> 
