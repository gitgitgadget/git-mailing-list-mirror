Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A13B1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 19:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932978AbeFUTrz (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 15:47:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45266 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932866AbeFUTry (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 15:47:54 -0400
Received: by mail-wr0-f195.google.com with SMTP id o12-v6so4354771wrm.12
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 12:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qZt3XEVngtwlfm4gchSJAEuPl3RFzaPUnhHdJKfjaYY=;
        b=jbqKrovl0M0A5ddJA30thSBhksOi60njH9e7PiqBSIi8jV4jYpuo1x2yrN+LecMFZc
         2wPICmVrrujBOd1bOQq9pW+RirbtpghUw+njBP9FR5k90Gq85gZ4IYlJKa487MdOE+kC
         XOoX4OYxd1Ky8kr4j3hqCyl/v8S41ydVtFnBWNSVytTbdx0WLof2ZvM3S4JV95EeIwdW
         awTm1VE728mZD3B5xUKVCeovVeDUNbkD2WuHZHay39xUxbXgYqGUCwVGLpY1MLPRE0Dg
         r94BWVZj9apRr2p7V6vB7up6ztGHPvx5XDyih0ITP4fLjn+tvB61Mz6eXaJgJrclMWlg
         ArgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qZt3XEVngtwlfm4gchSJAEuPl3RFzaPUnhHdJKfjaYY=;
        b=hu63Q1HFiMDIyeaCBDpPAnf81AyFuO/PMppA3QpB8whep6+yvya3jQ/2drMRE3CnKm
         K/Spx8bzajKxuy2duOV1qUkUn73dPInneGr7QuIxOEFZTZyox0d0CuQ7WGyxqN5EMWfZ
         Og36hzDvc2zC40G7S8ju1cQjH989UeLZWPJ3/durRATHQSLHpKKuZiGYduQdneSao+wC
         w8XJFEXHjThRmUmXn7mEoaknAYTOOljBNXmzhMTlNYE8jHAGVunilvkDWyeZoXN20tu3
         kGzypYqQdPbnq0tHTAdtWetLOBRvL8LHVOVUSDUZb9CKJ4CavB59uKH/gl95na25J5sp
         Ahdg==
X-Gm-Message-State: APt69E1u94dRH2iBAG+MVU+9xAojlcanwefoLPUFDELYMNpiCGW827ef
        krzSV6YwqVwGHTiVXzFLcNE=
X-Google-Smtp-Source: ADUXVKL4jC7ktTlvQZhIrUGrz7RAwp23SS58SGSxkg454U8SWzBFzwZkphclcJdHVjrKMHL1fuMD7g==
X-Received: by 2002:adf:b60d:: with SMTP id f13-v6mr22005268wre.186.1529610473061;
        Thu, 21 Jun 2018 12:47:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6757193wrb.22.2018.06.21.12.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 12:47:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/7] git-rebase.txt: document incompatible options
References: <20180617055856.22838-1-newren@gmail.com>
        <20180621150023.23533-1-newren@gmail.com>
        <20180621150023.23533-2-newren@gmail.com>
Date:   Thu, 21 Jun 2018 12:47:50 -0700
In-Reply-To: <20180621150023.23533-2-newren@gmail.com> (Elijah Newren's
        message of "Thu, 21 Jun 2018 08:00:17 -0700")
Message-ID: <xmqq4lhvudjt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> @@ -280,8 +286,10 @@ other words, the sides are swapped.
>  +
>  Because 'git rebase' replays each commit from the working branch
>  on top of the <upstream> branch using the given strategy, using
> -the 'ours' strategy simply discards all patches from the <branch>,
> +the 'ours' strategy simply empties all patches from the <branch>,

I think overall the direction this series takes, and especially what
this step does---clarify what the current code & design does first
before attempting to improve the status quo, makes sense, but I had
trouble justifying this change.  Do you want to emphasize that the
operation discards the changes but still leaves empty commits, and
"discards all patches" imply there won't be any commits left on top
of the "onto" point?

>  which makes little sense.
> ++
> +See also INCOMPATIBLE OPTIONS below.

> @@ -487,6 +510,52 @@ recreates the topic branch with fresh commits so it can be remerged
>  successfully without needing to "revert the reversion" (see the
>  link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
>  
> +INCOMPATIBLE OPTIONS
> +--------------------
> +
> +git-rebase has many flags that are incompatible with each other,
> +predominantly due to the fact that it has three different underlying
> +implementations:
> +
> + * one based on linkgit:git-am[1] (the default)
> + * one based on linkgit:git-merge-recursive[1] (merge backend)
> + * one based on linkgit:git-cherry-pick[1] (interactive backend)
> +
> +Flags only understood by the am backend:
> +
> + * --committer-date-is-author-date
> + * --ignore-date
> + * --whitespace
> + * --ignore-whitespace
> + * -C
> +
> +Flags understood by both merge and interactive backends:
> +
> + * --merge
> + * --strategy
> + * --strategy-option
> + * --allow-empty-message
> +
> +Flags only understood by the interactive backend:
> +
> + * --[no-]autosquash
> + * --rebase-merges
> + * --preserve-merges
> + * --interactive
> + * --exec
> + * --keep-empty
> + * --autosquash
> + * --edit-todo
> + * --root when used in combination with --onto
> +
> +Other incompatible flag pairs:
> +
> + * --preserve-merges and --interactive
> + * --preserve-merges and --signoff
> + * --preserve-merges and --rebase-merges
> + * --rebase-merges and --strategy
> + * --rebase-merges and --strategy-option
> +
>  include::merge-strategies.txt[]

It is a bit unclear what these lists want to say.  If --ignore-date
is only understood by "rebase" and not "rebase -i", wouldn't that
make "--interactive and --ignore-date" an incompatible flag pair?
Or do you mean the "Other incompatible" list to enumerate the ones
that are explicitly rejected, as opposed to getting silently
ignored?

In any case, I'll need to read through the remainder of the series
to come to any conclusion, but given that -p is getting killed by
its primary author, with help from others to split out its
implementation from the --interactive codepath, it might be a bad
time to do this series.  Thanks for working on this topic.

