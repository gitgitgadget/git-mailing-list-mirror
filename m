Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289521F803
	for <e@80x24.org>; Mon,  7 Jan 2019 19:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfAGTJV (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 14:09:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54519 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAGTJV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 14:09:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so1884844wmh.4
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 11:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=onMmYENHqz+l0ZSfTQR2dV0IindB1AQ0bzzVTtbxoGM=;
        b=PNdgi95hlJA3/SemTFjd0p9RHCjgsC1umK7jtx7IcjNb1go1DdfkkVSNFQHhSJ+suH
         NN8oy1iTaws2ZNS0Oj36S8mb8tNCcymYjtRe8Bl6x/h+nsWAQ2qCm89YoPlgWkHCoZFg
         gb8tdNNYCEd/t0+lnnO1AhVZqrTJSvsJ15JZusm/5AcNnnarRHGgeiC2GAHCJsrOWsjF
         BiN0EJxYG+cScZ7Vk0lItE0SecV1nWeO3O9wy8WuU6O3VZOtfIYSmN6cdJ+5RmMDO6UJ
         Ljq947GxNB+SZstafwAsRmN60KiU5l0L0X54JeE5Zywh6yJGiaNaP8o3eD30bLCId0EN
         GRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=onMmYENHqz+l0ZSfTQR2dV0IindB1AQ0bzzVTtbxoGM=;
        b=NB9lDcI9l8Vl2U+4g5aBiFXZ//1YQj3z2S6pGQTu+y7Rg0GQKs3/+UNIsPOV3D3ZDb
         A2dD1HxuUWKeBmBD3wKSGDqDAKHxPyX2Nl5vaJG3OSuNBN/LI5SzmVnevrzsHKu3KEPS
         bmFdRYmfKMe3UUw0wEXUDpnZosGkE+6nyRXPEuu/Q2qgdDTL/UDGbnXh8DD6+fHs7zS1
         u/u6p240NxWTB1EC77AaqrC3NfAvYS1YU7QIn6JRJ0F19rI1XDqFGCwyWotPQo1/EQ63
         nJr4UhVydmKyQ1xpEx79gy9ODMh3L4I8JApixmm/u6nTBO1DK00Z3skDhvpPjqUEx8ks
         eQ4Q==
X-Gm-Message-State: AJcUukczsM4PfJfOJijt/X/VfUv0QrG2dvhjBzYnYQA5NifYI0eofXtI
        crrLpc2rkLaVqmHFbpFdDwM=
X-Google-Smtp-Source: ALg8bN4UDkeBzlBlW/WfgXXji3J+nL3DoOiW5adiLN6+IzWKPfEOMl/CQoGahXp6tMoOn6XKVONXJw==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr9015445wmi.57.1546888158491;
        Mon, 07 Jan 2019 11:09:18 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l14sm130345636wrp.55.2019.01.07.11.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:09:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, rafa.almas@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v5 3/3] branch: Add an extra verbose output displaying worktree path for refs checked out in a linked worktree
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190106002619.54741-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190106002619.54741-4-nbelakovski@gmail.com>
Date:   Mon, 07 Jan 2019 11:09:17 -0800
In-Reply-To: <20190106002619.54741-4-nbelakovski@gmail.com> (nbelakovski's
        message of "Sat, 5 Jan 2019 16:26:19 -0800")
Message-ID: <xmqqtvik8eua.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
>
> ---

All three patches lack sign off.

I am fairly negative on 2/3, but I think this one makes sense
without introducing a new verbosity level.  We do not promise
stability of Porcelain command output and update the UI if we
have useful information to give.  Just making

	git branch --list -v -v

show additional information should be sufficient.

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index b3eca6ffdc..6d1fc59e32 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -163,12 +163,15 @@ This option is only applicable in non-verbose mode.
>  
>  -v::
>  -vv::
> +-vvv::
>  --verbose::
>  	When in list mode,
>  	show sha1 and commit subject line for each head, along with
>  	relationship to upstream branch (if any). If given twice, print
>  	the name of the upstream branch, as well (see also `git remote
> -	show <remote>`).
> +	show <remote>`). If given 3 times, print the path of the linked
> +	worktree, if applicable (not applicable for main worktree since
> +	its path will be a subset of $PWD)
>  
>  -q::
>  --quiet::
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 2a24153b78..56589a3684 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -366,6 +366,10 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
>  		strbuf_addstr(&local, branch_get_color(BRANCH_COLOR_RESET));
>  		strbuf_addf(&local, " %s ", obname.buf);
>  
> +		if (filter->verbose > 2)
> +			strbuf_addf(&local, "%s%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)%%(worktreepath) %%(end)%%(end)%s",
> +				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
> +
>  		if (filter->verbose > 1)
>  			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
>  				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
