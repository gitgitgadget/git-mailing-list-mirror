Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A521FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 21:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933600AbdBPVDE (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 16:03:04 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33451 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbdBPVDB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 16:03:01 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so2378048pfg.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+xqLwj/OpAboO164Md3ZMPGVEpOpaof1BnZLD4oDtOk=;
        b=EkA9hVmk1wYJVw8lWmoPDXRIhc6Ewm9tM0EXck0WWqBr2kmbctMAzTGMu+ArUAMBJ2
         ayfSmpTufz+Sn00UBpcUcYFjNTSgYeApv+zKKVnClbEXYu9sGQvLqCn71Mj6MQ2H2TES
         Axz79/JJhmmjuPNKI/6h1NQBqtB6qn+6pCdFVDtxUzF08rIftu4NSLN4eUQa2vqKhdzS
         jIQNBZd1fSqoCCverumGl3wKLBlxtJgd5ks108pzYs6OUSRO3Ax3b5yt1rPIBlQuCW/O
         pB2N4S3me3J5kNOfz9u8nboR36SCu6tMrwN59MnJeWJbne8mdvTpLKLA3d9OtQjWjd2r
         rocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+xqLwj/OpAboO164Md3ZMPGVEpOpaof1BnZLD4oDtOk=;
        b=PFKRG438Imrd5noKVFvldZ4/GgHU26INvjTajBq94nbeQqdFP6bu7iIQ+Qyy9B3GTI
         SfUQg6ryx2icPGtwM2qH+S9xLIemmBLwKh1Zbz3ma407coBNiiwc7z/SCYLQDSR8/hCf
         eCqICoMyqEFV0HzgJh3g/jLHG82JFWMcubrVg59TqwWy576Qlo9GkVl5PYscDPfJXDpi
         auMfn+70+sOMyKPL+Z0Z878+An3OHXoq+VLkvmC7OeuALxq45HBK9FI+6q0voneQcRmL
         44KyWTphqGz95mKn8Y2Swnwyw+nXDxjAyiGZb7xp4XeAHVvQd4caJ80q6i/we2r9cDBN
         qYhQ==
X-Gm-Message-State: AMke39mVQEmKmyThGh22KXyB3DoPrNV9sZffO3Qcka9Bsx4baomUtvCJg3IN8GfHnpUGvA==
X-Received: by 10.99.170.70 with SMTP id x6mr5449270pgo.14.1487278981183;
        Thu, 16 Feb 2017 13:03:01 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id t87sm15285782pfe.59.2017.02.16.13.02.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 13:03:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     unlisted-recipients:; (no To-header on input) git@vger.kernel.org,
        sandals@crustytoothpaste.net, jrnieder@gmail.com, bmwill@google.com
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)git@vger.kernel.org
                                                                     ^-missing end of address
Subject: Re: [PATCH 08/15] submodules: introduce check to see whether to touch a submodule
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
        <20170216003811.18273-1-sbeller@google.com>
        <20170216003811.18273-9-sbeller@google.com>
Date:   Thu, 16 Feb 2017 13:02:59 -0800
In-Reply-To: <20170216003811.18273-9-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Feb 2017 16:38:04 -0800")
Message-ID: <xmqqd1ehx30c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In later patches we introduce the --recurse-submodule flag for commands
> that modify the working directory, e.g. git-checkout.
>
> It is potentially expensive to check if a submodule needs an update,
> because a common theme to interact with submodules is to spawn a child
> process for each interaction.
>
> So let's introduce a function that checks if a submodule needs
> to be checked for an update before attempting the update.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 27 +++++++++++++++++++++++++++
>  submodule.h | 13 +++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/submodule.c b/submodule.c
> index 591f4a694e..2a37e03420 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -548,6 +548,33 @@ void set_config_update_recurse_submodules(int value)
>  	config_update_recurse_submodules = value;
>  }
>  
> +int touch_submodules_in_worktree(void)
> +{
> +	/*
> +	 * Update can't be "none", "merge" or "rebase",
> +	 * treat any value as OFF, except an explicit ON.
> +	 */
> +	return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
> +}

I somehow sense a somewhat misnamed function.

> +int is_active_submodule_with_strategy(const struct cache_entry *ce,
> +				      enum submodule_update_type strategy)
> +{
> +	const struct submodule *sub;
> +
> +	if (!S_ISGITLINK(ce->ce_mode))
> +		return 0;
> +
> +	if (!touch_submodules_in_worktree())
> +		return 0;

Reading this caller alone, it is totally unclear what this !touch is
about.  "We try to touch it by calling this function, and if the
function successfullly touches it, we return without doing anything
else?"

Would it help to avoid confusion, if the helper function is named to
be clearly a boolean?  should_update_submodules_in_worktree() or
something along those lines?

> +	sub = submodule_from_path(null_sha1, ce->name);
> +	if (!sub)
> +		return 0;
> +
> +	return sub->update_strategy.type == strategy;
> +}

I am not sure if this is a good API design; if it were "static int"
contained inside the module I wouldn't care, but wouldn't it be more
natural for the caller of this function to say

	if (get_submodule_update_strategy(ce) == STRATEGY_I_WANT)
		do something;
	else
		do something else;

rather than forced to say:

	if (is_active_submodule_with_strategy(ce, STRATEGY_I_WANT))
		do something;
	else
		do something else;

no?  The caller can easily be extended to

	switch (get_submodule_update_strategy(ce)) {
        case STRATEGY_I_WANT:
	case STRATEGY_I_TOLERATE:
		do something; 
		break;
	default:
		do something else;
		break;
	}                

if the function does not insist taking a single allowed strategy and
return just yes/no as its answer.
