Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C871F1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfBAWyO (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:54:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33672 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfBAWyN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:54:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id a16so3163098wrv.0
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=78QNGjtVVGf5bVH5DEQ7VWXiyeptnza1pAIWvUxymjw=;
        b=Jdy2nq/gD+qG384vzTiIBL5uW7dtqsbstqRPRP2Cw44zO61lShpnTc1I539AT1luM/
         izNtJWcm9bOwpg/ox1l4gpovKQ+M1klTnuEh1+IeQi+F3lUK3Y1mkklg1xcUZ7KgR5D+
         0G7OM9BsU3td7da+e7qPN3gY5hvfHzoear1CRh6ZVS1QdbhAm7qEbc59s8QdM+qu+5tD
         99hakRrEvhEBW5DOsL+j4QFqFMUNsUJRb5ltpRIBWFAsHhoHHdKONdzLGYtkj/xRQxOU
         VP3jEAzaqmWTsV0HCP2Xqw2g3DJbMQssxOWKyX93XgbtQ36ArzOCKbJ/SIr16m0oMfy7
         8dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=78QNGjtVVGf5bVH5DEQ7VWXiyeptnza1pAIWvUxymjw=;
        b=KXQAJtBygeR5iyV51+m1YUec8oKsXAw8kWWBOFRBefmlmjk+LA+A2TgD7WFHiOn9ZX
         HnYW0rZwGMze/sKJvgbHKt5uJmJ+F+Xt1Xs1gYAYlsE3bLEQJ3ri4zonUdPQx4topCxt
         aFiwv9mPpE/qUa3SoJLfZRkU7Cl9+x7PbD3CTlQOOHN3EZ6t1lqX4dO3cymzGdmg3qi/
         jDjGcW8Qbqt2rTD15mTN7tEPTXZIUJmFZxh1azjjFLimnXIsPJ1dzzrtwWKtvbH9bdV6
         3B7L9CR3dK3wTiu8JH9tlxK9jg1hMGJdRBnI8ZccyscNXACbzMi4w68UlW6VI9hLUi0D
         6k/Q==
X-Gm-Message-State: AHQUAua6uJN2z/ZgxaFgTm3kD3jmCNhpnxKTgIfaApY+WdV4NPsdwWvy
        W/p0MQPaHyByQ+Tfg/uhdNV1fKEb
X-Google-Smtp-Source: AHgI3IbhY5GDA6dsA1wWK1MhBdgQ/AQ8a2ZHOZeO3zT6VQzP/aQgJUHlN53s4Q9qUacSradIgpiaVw==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr28065027wrh.267.1549061650732;
        Fri, 01 Feb 2019 14:54:10 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z17sm6562425wrv.2.2019.02.01.14.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 14:54:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, rafa.almas@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v7 3/3] branch: Add an extra verbose output displaying worktree path for refs checked out in a linked worktree
Date:   Fri, 01 Feb 2019 14:53:28 -0800
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>">
        <20190201220420.36216-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190201220420.36216-4-nbelakovski@gmail.com>
Message-ID: <xmqqftt7w25q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

> @@ -167,8 +167,10 @@ This option is only applicable in non-verbose mode.
>  	When in list mode,
>  	show sha1 and commit subject line for each head, along with
>  	relationship to upstream branch (if any). If given twice, print
> -	the name of the upstream branch, as well (see also `git remote
> -	show <remote>`).
> +	the path of the linked worktree, if applicable (not applicable
> +	for main worktree since user's path will already be in main
> +	worktree) and the name of the upstream branch, as well (see also
> +	`git remote show <remote>`).

It is unclear what you mean by "user's path"; I take it as the
$(pwd) at least for now for the purpose of this review, but then
I am not sure if I agree with that justification part "since..."

If I start from a normal repository at /home/gitster/main.git,
create a linked worktree of it at /home/gitster/alt.git, chdir to
/home/gitster/alt.git and ask "git branch -v -v", then the branch
that is checked out in the main.git "main worktree" is not shown?

If the rule were "a branch that is checked out in one of the
worktrees connected to the repository is shown with the path to that
worktree" (i.e. no exception), I would understand it.  If the rule
were "a branch that is ... (the same sentence), unless it is the
branch that is checked out in the *current* worktree", then I would
understand it too.

Puzzled.

In any case, please add a test or two to protect this feature from
unintended future breakages.

Thanks.

>  
>  -q::
>  --quiet::
> diff --git a/builtin/branch.c b/builtin/branch.c
> index c2a86362bb..0b8ba9e4c5 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -367,9 +367,13 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
>  		strbuf_addf(&local, " %s ", obname.buf);
>  
>  		if (filter->verbose > 1)
> +		{
> +			strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
> +				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
>  			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
>  				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
>  				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
> +		}
>  		else
>  			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
