Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F193C433FE
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 10:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbiDZKcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 06:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349048AbiDZKbU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 06:31:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B793E65E0
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 03:09:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y21so10874170wmi.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DTguhVg7Q0AqbCgRKm0gJyTp5t+SMJdTc3nNHdZz+Mk=;
        b=Ac4wzOBMSFra4KC9kvebJySv0v00W1PfcwhBl3Qwskl1EJjA8aJ2oxnx6ttpUPk9hx
         cvnfLSXAn0v8uEuAJMzbElepTPiKl1UXt4Kj3KkClKz1nlb6Pa5Wei0diLHr+0p3fJR/
         NCg8/UWeP4nqEOdR+Tj2cd7HeeHny7l5i+Mc8FMpgnCB82uqDLcpnIWHXaBTMTBXRdB8
         8GQktoUb6+PTgqWfjUTNOQaXc2IuMdPqCwpivfyhDXZCmxbsaC+41Xpc9sBKk9gKxmIN
         PGPpH5oQBh7dxp5IPkALu/TXYgAjR5imghFOj1ctCQaGbMNWtz58t69TCN0N6YGYQSCs
         BLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DTguhVg7Q0AqbCgRKm0gJyTp5t+SMJdTc3nNHdZz+Mk=;
        b=XDdrEXzWuGG5u2mgUnOrZrmnruSRV2oBe+hTJyLLtEnPcs4czF5B4sW+fFnbQRYjxN
         7kCk+uQKtXFfP4uLLfiIm3C9LpnV5iP8XBpwF60I5Ia8xtJLU/zYQyBCjgEgoDyz2w4s
         QvemZPkLS+WuOtuLeiCBg2mkPgOyZflrMMrPitXRd2lW9nL1t8RGpglwmVOJENGrxgqp
         p03R3H2T2MJca86sAS/TcF9Zcj4QouHM/u2WTWaKufwIJj+b561/gyXP51nT4pkFQDH5
         b48HNj6y2N04OTeyMaTWdsCcLHZV7+tS/rPKVjH01SDPQG0kJLaeUZ7Qj5cHfAW+7M4A
         sXAg==
X-Gm-Message-State: AOAM532WZNxHAiZBFCaLG2F5wcR4C5LT6Bg9wP3ZhQeRlrRxp1PfReMu
        avq2U2HukeVPZynoZNs9iTc=
X-Google-Smtp-Source: ABdhPJwD4lZ38rUakVILylZUOvsjn+vofUId1Ja6b0PiioYSzqy5ZJoGH/d6vYCLhkbr1XMadYneAQ==
X-Received: by 2002:a1c:cc08:0:b0:393:e7d2:e580 with SMTP id h8-20020a1ccc08000000b00393e7d2e580mr12259380wmb.145.1650967797236;
        Tue, 26 Apr 2022 03:09:57 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id o9-20020adf8b89000000b0020adeb916d8sm3904334wra.30.2022.04.26.03.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 03:09:56 -0700 (PDT)
Message-ID: <83a76d46-5069-d6c7-b8b3-f3a063637abb@gmail.com>
Date:   Tue, 26 Apr 2022 11:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] 2.36 gitk/diff-tree --stdin regression fix
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh76j3i3r.fsf@gitster.g> <xmqqbkwpvyyc.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqbkwpvyyc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/04/2022 18:45, Junio C Hamano wrote:
> This reverts commit 244c2724 (diff.[ch]: have diff_free() call
> clear_pathspec(opts.pathspec), 2022-02-16).
> 
> The diff_free() call is to be used after a diffopt structure is used
> to compare two sets of paths to release resources that were needed
> only for that comparison, and keep the data such as pathspec that
> are reused by the diffopt structure to make the next and subsequent
> comparison (imagine "git log -p -<options> -- <pathspec>" where the
> options and pathspec are kept in the diffopt structure, used to
> compare HEAD and HEAD~, then used again when HEAD~ and HEAD~2 are
> compared).
> 
> We by mistake started clearing the pathspec in diff_free(), so
> programs like gitk that runs
> 
>      git diff-tree --stdin -- <pathspec>
> 
> downstream of a pipe, processing one commit after another, started
> showing irrelevant comparison outside the given <pathspec> from the
> second commit.

I notice from the patch context that we are still calling 
diff_free_ignore_regex(options) which was added in c45dc9cf30 ("diff: 
plug memory leak from regcomp() on {log,diff} -I", 2021-02-11). I think 
that will need reverting as well as it freeing data that is needed when 
options is reused by "diff-tree --stdin" or "log -p".

Best Wishes

Phillip

> The buggy commit may have been hiding the places where diff
> machinery is used only once and called diff_free() to release that
> per-comparison resources, but forgetting to call clear_pathspec() to
> release the resource held for the (potentially) repeated comparison,
> and we eventually would want to add clear_pathspec() to clear
> resources to be released after a (potentially repeated) diff session
> is done (if there are similar resources other than pathspec that
> need to be cleared at the end, we should then know where to clear
> them), but that is "per program invocation" leak that will be
> cleaned up by calling exit(3) and of lower priority than fixing this
> behavior-breaking regression.
> 
> Reported-by: Matthias Aßhauer <mha1993@live.de>
> Helped-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   add-interactive.c | 6 +++---
>   blame.c           | 3 +++
> 
>   builtin/reset.c   | 1 +
>   diff.c            | 1 -
>   notes-merge.c     | 2 ++
>   5 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/add-interactive.c b/add-interactive.c
> index e1ab39cce3..6498ae196f 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -797,14 +797,14 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
>   	diffopt.flags.override_submodule_config = 1;
>   	diffopt.repo = s->r;
>   
> -	if (do_diff_cache(&oid, &diffopt)) {
> -		diff_free(&diffopt);
> +	if (do_diff_cache(&oid, &diffopt))
>   		res = -1;
> -	} else {
> +	else {
>   		diffcore_std(&diffopt);
>   		diff_flush(&diffopt);
>   	}
>   	free(paths);
> +	clear_pathspec(&diffopt.pathspec);
>   
>   	if (!res && write_locked_index(s->r->index, &index_lock,
>   				       COMMIT_LOCK) < 0)
> diff --git a/blame.c b/blame.c
> index 401990726e..206c295660 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -1403,6 +1403,7 @@ static struct blame_origin *find_origin(struct repository *r,
>   		}
>   	}
>   	diff_flush(&diff_opts);
> +	clear_pathspec(&diff_opts.pathspec);
>   	return porigin;
>   }
>   
> @@ -1446,6 +1447,7 @@ static struct blame_origin *find_rename(struct repository *r,
>   		}
>   	}
>   	diff_flush(&diff_opts);
> +	clear_pathspec(&diff_opts.pathspec);
>   	return porigin;
>   }
>   
> @@ -2326,6 +2328,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
>   	} while (unblamed);
>   	target->suspects = reverse_blame(leftover, NULL);
>   	diff_flush(&diff_opts);
> +	clear_pathspec(&diff_opts.pathspec);
>   }
>   
>   /*
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 24968dd628..b97745ee94 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -274,6 +274,7 @@ static int read_from_tree(const struct pathspec *pathspec,
>   		return 1;
>   	diffcore_std(&opt);
>   	diff_flush(&opt);
> +	clear_pathspec(&opt.pathspec);
>   
>   	return 0;
>   }
> diff --git a/diff.c b/diff.c
> index 0aef3db6e1..c862771a58 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6345,7 +6345,6 @@ void diff_free(struct diff_options *options)
>   
>   	diff_free_file(options);
>   	diff_free_ignore_regex(options);
> -	clear_pathspec(&options->pathspec);
>   }
>   
>   void diff_flush(struct diff_options *options)
> diff --git a/notes-merge.c b/notes-merge.c
> index 7ba40cfb08..b4a3a903e8 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -175,6 +175,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
>   		       oid_to_hex(&mp->remote));
>   	}
>   	diff_flush(&opt);
> +	clear_pathspec(&opt.pathspec);
>   
>   	*num_changes = len;
>   	return changes;
> @@ -260,6 +261,7 @@ static void diff_tree_local(struct notes_merge_options *o,
>   		       oid_to_hex(&mp->local));
>   	}
>   	diff_flush(&opt);
> +	clear_pathspec(&opt.pathspec);
>   }
>   
>   static void check_notes_merge_worktree(struct notes_merge_options *o)
