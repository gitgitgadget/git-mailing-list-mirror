Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF48220365
	for <e@80x24.org>; Thu, 13 Jul 2017 20:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbdGMUhC (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:37:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32816 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbdGMUhB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:37:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so8393981pfh.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WUEFdYLkwD/S30q4To05xxSSmsa3upCLLWGtU3+KgEU=;
        b=dRFlPNjr7fpd4BHU2vk4vkjOi5rzKKcFAvHCto+pbJX2j7VQSmoqS4PlV8V99k/2xN
         6KaRs9elpC+wz8fW4xe0F+ytZcPpbwkIXdjCJc3mw4RRziZwtLdt0QfFaLDWvfJ46eym
         9ALzgQL+YN11RGlEItDH9tx1LvdG+AW0n/IJ5/3umGWfeWH6rauwoVO5EdBrD308ICuI
         DUJqdfO8ifjJcKFhsaTx3h6Bc3gPCxpf6htfIitikhyBpimM3W+XswBCgmT1qS4oQgXe
         YiMI87G2W2eMf5HPFvHN6iqhA/QfZHcYtXs8TJK10kDivAQwuxnZKUc0DaTKVEKptN+m
         +1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WUEFdYLkwD/S30q4To05xxSSmsa3upCLLWGtU3+KgEU=;
        b=Q9nkUXHECyqn0bLbT5s7bcUR0Cc2IIuZtx09RUOun0CT8wx0qaBQekB1VxhuWA2OUp
         M/dSYLKkjj30sCVmvHoZJJ3I9jROxFxxdLtSM8ykdQJlYmdsSSszVP/LTGXz/vtXt8Yn
         2jI86F3tdlZb0UcL/nbXovuSwxutAoRFSnBu68YbNtYBle2fIA7ENz4hz27hCwhmRt6Z
         XboyxIxF1ZBFAmck5HWmRpEnDvTCHD0Nx1a/dECccqGvNWNwO2t216jq2yW1drB0Yehf
         PrvYo846sm6YlTi/eNiIbsY4+rdKd/p6rPzOcHfWzy1SNOg+AFutGXZZZBgKljkXCFPU
         yIYg==
X-Gm-Message-State: AIVw1112vOiEMavi0ZEBYidZgJPGFffDdfjUHhv7F/izfIN4VSBGoTb5
        BYCO/PE7JLIIKQ==
X-Received: by 10.99.2.213 with SMTP id 204mr11033931pgc.180.1499978220940;
        Thu, 13 Jul 2017 13:37:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id e13sm11748517pfh.96.2017.07.13.13.37.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 13:37:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/15] ref-filter: move need_color_reset_at_eol into ref_format
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
        <20170713150230.sy7zuksbgjcrllxh@sigill.intra.peff.net>
Date:   Thu, 13 Jul 2017 13:36:59 -0700
In-Reply-To: <20170713150230.sy7zuksbgjcrllxh@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Jul 2017 11:02:30 -0400")
Message-ID: <xmqqh8ygul90.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Calling verify_ref_format() doesn't just confirm that the
> format is sane; it actually sets some global variables that
> will be used later when formatting the refs. These logically
> should belong to the ref_format, which would make it
> possible to use multiple formats within a single program
> invocation.
>
> Let's move one such flag into the ref_format struct. There
> are still others that would need to be moved before it would
> be safe to use multiple formats, but this commit gives a
> blueprint for how that should look.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This commit is strictly optional for this series, but I wanted to give a
> sense of how the rest of the movement might look, since I was thinking
> about it. The big thing to move would be the used_atoms array, but I
> punted on that for now.

Heh, when I saw the hunk at 661,+7, used_atom[] was what immediately
came to mind.  It is OK to punt for the purpose of this patch, but
moving these statics into the ref-format structure would be a good
move in the longer term.

Thanks.

>
>  ref-filter.c | 7 +++----
>  ref-filter.h | 3 +++
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 66d234bb1..178396e1f 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -97,7 +97,6 @@ static struct used_atom {
>  	} u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
> -static int need_color_reset_at_eol;
>  
>  static void color_atom_parser(struct used_atom *atom, const char *color_value)
>  {
> @@ -661,7 +660,7 @@ int verify_ref_format(struct ref_format *format)
>  {
>  	const char *cp, *sp;
>  
> -	need_color_reset_at_eol = 0;
> +	format->need_color_reset_at_eol = 0;
>  	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
>  		const char *color, *ep = strchr(sp, ')');
>  		int at;
> @@ -673,7 +672,7 @@ int verify_ref_format(struct ref_format *format)
>  		cp = ep + 1;
>  
>  		if (skip_prefix(used_atom[at].name, "color:", &color))
> -			need_color_reset_at_eol = !!strcmp(color, "reset");
> +			format->need_color_reset_at_eol = !!strcmp(color, "reset");
>  	}
>  	return 0;
>  }
> @@ -2083,7 +2082,7 @@ void format_ref_array_item(struct ref_array_item *info,
>  		sp = cp + strlen(cp);
>  		append_literal(cp, sp, &state);
>  	}
> -	if (need_color_reset_at_eol) {
> +	if (format->need_color_reset_at_eol) {
>  		struct atom_value resetv;
>  		resetv.s = GIT_COLOR_RESET;
>  		append_atom(&resetv, &state);
> diff --git a/ref-filter.h b/ref-filter.h
> index 2bb58879d..9e1e89c19 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -79,6 +79,9 @@ struct ref_format {
>  	 */
>  	const char *format;
>  	int quote_style;
> +
> +	/* Internal state to ref-filter */
> +	int need_color_reset_at_eol;
>  };
>  
>  #define REF_FORMAT_INIT { NULL, 0 }
