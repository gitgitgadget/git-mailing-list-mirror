Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA54B1F51C
	for <e@80x24.org>; Fri, 25 May 2018 08:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964918AbeEYI4i (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 04:56:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43695 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964804AbeEYI4h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 04:56:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id r13-v6so7837744wrj.10
        for <git@vger.kernel.org>; Fri, 25 May 2018 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Q7rl3EPhh7mC3qTzQLDHE1TiulRrtUziwM782s647Uo=;
        b=aQEzlZgutXHjsyVq8QdJ5Nefle8rrrz/RLkUidA6GBDpafthjXDFuTafdQj7eu8ZHv
         p6soW7mEFkfyC+QQ5E7Xls6IW8taUa6YebN5FhRLXyyxvvvJmHBCwWfmKNp3dMTCP8XG
         qRYqfZrefPxYUBT8udfZpaSkJcm/RNFgeXnFL1WwCzFFybieGKWUGVWuh7s6TTHp+Bin
         qG7tHXWtE+02qXLXYPjS6PioU+m44t/n69LMpJcd7Cy2Ur9uH5YtBjLTruvBpMsLXPCc
         2NQJnpDWUL+LR2GmX5bAQ19r7Q4M2JhREt88wTQrdxPoxlNRkBzFw8qdwmP4fmHyuGxY
         ZhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Q7rl3EPhh7mC3qTzQLDHE1TiulRrtUziwM782s647Uo=;
        b=rxu2tqqM1GwnLwTnwxEtvyxvsQANJtOx+gERhXRREv4AcZuxKEHNANwLMag5ZsQ18y
         gbXasusLVrKv6UU4m+Vh8c/xBYdIWm94q8lxF3iVGli1xbfBBgBZ6QHrKRjZs/Khf75k
         KhTqjAH/t06+/kNfkTosCK7o1XdzYkFu58oTwm+2+g8SVNfZhslZJ1zz9aNvRdFib7qE
         Ga3TEILjyz4xySJgtYIo7cXpHKPy1xDaz/OeoAQdSVbCr5Mr3yW9wrrHUVfGFrRThmuw
         /Kd3hEMcV0iAdHBBgcjIrE+48yIbPMLLgc7i8Eu9rNnwMYS3P9nwwxgmPGDU/3LaFbET
         uQIQ==
X-Gm-Message-State: ALKqPweZs3Z1dLVNh4mmFsLmGJ+CSDcu/k4mmsD0jp4zX26m6fHNUX9b
        +ejOKZeyj6Fqx3SOpNzia7M=
X-Google-Smtp-Source: AB8JxZoVUouNXByWWniXrXDhYQ1eIziTiOFW7q3fP1ZbhFQ8tgooB04OrgHllGaS+VE03vh8uY5Umw==
X-Received: by 2002:adf:b8ce:: with SMTP id c14-v6mr1323295wrg.122.1527238596069;
        Fri, 25 May 2018 01:56:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l41-v6sm5645808wre.87.2018.05.25.01.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 01:56:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
        <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
        <87fu2qbojy.fsf@evledraar.gmail.com>
        <20180517133601.GC17548@sigill.intra.peff.net>
        <1527174618.10589.4.camel@gmail.com>
        <20180524192214.GA21535@sigill.intra.peff.net>
        <20180524193105.GB21535@sigill.intra.peff.net>
        <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
        <20180525024002.GA1998@sigill.intra.peff.net>
Date:   Fri, 25 May 2018 17:56:34 +0900
In-Reply-To: <20180525024002.GA1998@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 24 May 2018 22:40:03 -0400")
Message-ID: <xmqqd0xknmf1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> People mistakenly use "git branch -l", thinking that it
> triggers list mode. It doesn't, but the lack of non-option
> arguments in that command does (and the "-l" becomes a
> silent noop).
>
> Since afc968e579 (branch: deprecate "-l" option, 2018-03-26)
> we've warned that "-l" is going away. But the warning text
> is primarily aimed at people who _meant_ to use "-l", as in
> "git branch -l foo". People who mistakenly said "git branch
> -l" may be left puzzled.

Yup, thanks for being extra explicit.  I do imagine there are quite
a few of us who would be puzzled without this update (but with the
previous one to unhide it from behind the pager).

> Let's make it clear that:
>
>   1. No, "-l" didn't do what they thought here.
>
>   2. It's going away, and what they should do instead.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/branch.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 55bfacd843..b0b33dab94 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -701,8 +701,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		setup_auto_pager("branch", 1);
>  
>  	if (used_deprecated_reflog_option) {
> -		warning("the '-l' alias for '--create-reflog' is deprecated;");
> -		warning("it will be removed in a future version of Git");
> +		if (list) {
> +			warning("the '-l' option is an alias for '--create-reflog' and");
> +			warning("has no effect in list mode. This option will soon be");
> +			warning("removed and you should omit it (or use '--list' instead).");
> +		} else {
> +			warning("the '-l' alias for '--create-reflog' is deprecated;");
> +			warning("it will be removed in a future version of Git");
> +		}
>  	}
>  
>  	if (delete) {
