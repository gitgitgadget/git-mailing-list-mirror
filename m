Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1881F803
	for <e@80x24.org>; Tue,  8 Jan 2019 22:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfAHWVo (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 17:21:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44258 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfAHWVo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 17:21:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so5638844wrt.11
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 14:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Y4Oj9t66NfVoYhChLgUV3ZfMeHGCaW4GzxCbymzs/KY=;
        b=kxkHheLsyASrubRclcmee9G+Z97zNcRJvEK2ZAWgUFpDxtYDh3L87CeY/5T6GR4cNf
         CYtwDv89H68M8Wa9gpBQbbW1Luci/KSDm/I939thtobEd0kncuIWDYNGM99+I8MyD63C
         YGiQKtnmIK3eOSeWQ1ofXLswW4OQg5YsuT9aBvFbdhMJ5myGuqsDlWOfZGo+mAlZx3/B
         j+qT8xZCupPX/p5ha29X+csQbvjupxLbUsuYXdSwHPPJc7iQqBHiV36bpp05qDh4K64k
         yayzUx47Ng5sCuyt+8hDV8YDCZLe8DaLhFdFta7Uo2wkkdD0M8yEKLb1+vVf/708CueD
         anaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Y4Oj9t66NfVoYhChLgUV3ZfMeHGCaW4GzxCbymzs/KY=;
        b=ZGO1Rm1i6RB4zEjvwE98wVrYEBF54tUjhCjbccxgHPt0N4i6o/VvuqIfy4ICRPrP3Y
         jMIY6vFKVv0LpsKjz1tURep91XII/frnlH6Kp3eVMZDzNVsRbrErMsU1x5FRs0FPCRUA
         U+vTQL4I+8icRRVk5FBKW4dlqcIQ3M+bBewokcOvXHXmQ/YOdG28g4ReJOEoBIGP1gW+
         kf+KdRyW5KZmkHhoGHS9yZaFN1l+I9vgHLeWjTjXbOKgYs0eucarBTiNB0mf63QN3uiI
         zlEWUm/DIAQhamQ97UxH6sCQELCstx8Ba9Wzn5zT8SDoN5S0mKKMXrcL0gVJWS/9UPIe
         qjeA==
X-Gm-Message-State: AJcUukf1gB6Jm+ld8t7iDZqmXV09CG9gfRQnYG6lQvDkMuEtuTjXgKoM
        aygjimtG1SFxIagLLE5Zupk=
X-Google-Smtp-Source: ALg8bN6Oyj0dvusUAE/NgSXFyo9XILuNqQCH0vhj+o40XHVF1zSpO9/eRRSrZqSa95ISzDDBqNaJKQ==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr2862010wro.194.1546986101854;
        Tue, 08 Jan 2019 14:21:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t70sm15868837wmd.36.2019.01.08.14.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 14:21:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     issac.trotts@gmail.com
Cc:     git@vger.kernel.org, noemi@sourcegraph.com,
        Issac Trotts <issactrotts@google.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
References: <20190108132048.57142-1-issactrotts@google.com>
Date:   Tue, 08 Jan 2019 14:21:40 -0800
In-Reply-To: <20190108132048.57142-1-issactrotts@google.com> (issac trotts's
        message of "Wed, 9 Jan 2019 00:20:48 +1100")
Message-ID: <xmqqmuoa4wp7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

issac.trotts@gmail.com writes:

> From: Issac Trotts <issac.trotts@gmail.com>

Heh, I'll edit this line to match S-o-b: below.

>
> Make it possible to write for example
>
>         git log --format="%H,%S"
>
> where the %S at the end is a new placeholder that prints out the ref
> (tag/branch) for each commit.
>
> Using %d might seem like an alternative but it only shows the ref for the last
> commit in the branch.
>
> Signed-off-by: Issac Trotts <issactrotts@google.com>
>
> ---



> diff --git a/log-tree.c b/log-tree.c
> index 10680c139..3cb14256e 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -700,6 +700,7 @@ void show_log(struct rev_info *opt)
>  	ctx.color = opt->diffopt.use_color;
>  	ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
>  	ctx.output_encoding = get_log_output_encoding();
> +	ctx.rev = opt;

There are quite a few existing codepaths that change their behaviour
based on NULL-ness of ctx.rev field.  How would we make sure that
this change have no unintended consequence, I wonder?

> +	case 'S':		/* tag/branch like --source */
> +		if (c->pretty_ctx->rev == NULL || c->pretty_ctx->rev->sources == NULL) {
> +			return 0;
> +		}
> +		slot = revision_sources_at(c->pretty_ctx->rev->sources, commit);
> +		if (!(slot && *slot)) {
> +			return 0;
> +		}
> +		strbuf_addstr(sb, *slot);
> +		return 1;

Let's update the style of this hunk here like so:

	if (!c->pretty_ctx->rev || !c->pretty_ctx->rev->sources)
		return 0;
	slot = ...;
	if (!(slot && *slot))
		return 0;
	strbuf_addstr(...);
	return 1;

I wonder if it is even better to apply de-Morgan to one of the above
two, i.e.

	if (!(c->pretty_ctx->rev && c->pretty_ctx->rev->sources))
		return 0;


Anyway, thanks.  Will queue.

