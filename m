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
	by dcvr.yhbt.net (Postfix) with ESMTP id CB24D1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 13:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfJaNki (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 09:40:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42286 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfJaNki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 09:40:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id a15so6281850wrf.9
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t49qoImiM4//RjBDQ/6QzNhjIcKVYNbpFdbIgECXAjA=;
        b=SOVleKIWHUGKQgBqoXTQmXaQV9hhzEhU8joNNYle0pv9QjFKc1HhUgHfmWxw0r+iLA
         pBVXMO6UUCakt+u7h9tN92sHhgkzTBOBqNAuHuxQU+G0WWJN+uTDXMuUlhJVF9FBg6Je
         kPugE/V/qjOOGVFR56Krq1Cm15QddtLPkQNwrm3zba6dpFhstNuaBQeoguwoQ6O5TCq1
         ktkbzVq+gFYIq8PlKgHLSb/9RPqhClge3hB06xglRW0QluD1FYj1MtuTl3qFro5uCLEu
         Vtjt/P4sNaGC0pl2y5XLgmReKPH5RQ4dGK5SZXHp1DZtMYKj866/gXIyA7BzDG0T/ojf
         EIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t49qoImiM4//RjBDQ/6QzNhjIcKVYNbpFdbIgECXAjA=;
        b=IAoOv6NhlTr+9Gb5kN5RsIt0yXvDYMZNoeGZy4ICQMa8pPVOMExgH3sqXI7MDsDbKj
         bnfw0XZw5nWA2MJhU2SYmCw8TbreLeXDbDwbNOdaxvUbTjM6cZJ5f8XPf1uNAsLLSdxM
         Q9jY9q2Sw9t2rCx9MyEmXSm7yLQGZdfnmA8JsoLFp5+GXvDJ4PhEVhays7VSi7E6V9lB
         yHO32h3l0oJduYSqWnE56JVDRQKOJEegPf8W686Dlowz5R8MEEQXifL6r0HQu1Odi1+s
         Oct7dRHk5OTMn8YF5+JB3p57y7UAS1gVxsBRQG+ZVeN/n10oiAQ+CRy4do0bZdSGMctp
         d0WA==
X-Gm-Message-State: APjAAAUFAbfzjTeo6yIO7LNcKVUP/qkFlKFsVNp2zXSAIHs7A9an7gL1
        s9IfcQEWb6miHa+YCTDuxyA=
X-Google-Smtp-Source: APXvYqyCOZV3RwiQef64kygG8GHzPWZQwEg3+sA32RFHudgyHh8xqLhlSzVS3hkMx/2wZLfscebfDQ==
X-Received: by 2002:a5d:6702:: with SMTP id o2mr4982386wru.339.1572529236195;
        Thu, 31 Oct 2019 06:40:36 -0700 (PDT)
Received: from localhost ([95.149.189.152])
        by smtp.gmail.com with ESMTPSA id 65sm5261861wrs.9.2019.10.31.06.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 06:40:35 -0700 (PDT)
Date:   Thu, 31 Oct 2019 13:40:34 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, dev@kipras.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [FR] Allow `git stash create` to include untracked changes
Message-ID: <20191031134034.GA63909@cat>
References: <d02ddc0db596771820b0cfdfae5b1504@kipras.org>
 <xmqqa79lbpte.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910290806310.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910290806310.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/29, Johannes Schindelin wrote:
> So why does `git stash create -u ...` not work? Because the original
> design of `git stash create` never intended to take any command-line
> arguments other than the stash message. And that design can obviously
> not be fixed without breaking backwards compatibility.

Yup that's exactly right.  Not breaking this sort of backwards
compatibility is also why we have both 'git stash save' and 'git stash
push' nowadays.

We did have a similar conversation back when 'git stash push' was
introduced [1].  We almost decided this regression would be okay, but
in the end went with calling 'create_stash -m "$*"' internally to
circumvent the problem.  Now that somebody has an actual usecase we
may or may not find this "regression" acceptable.  I don't have a
strong opinion about it, so this is just to add a little bit of
context here.

[1]: https://public-inbox.org/git/20170206155606.xgkmhg656vuc6uki@sigill.intra.peff.net/

> What we _could_ do is to add a new command-line option to `git stash
> push` that would make it behave like the `create` subsubcommand: _not_
> update the `refs/stash` ref but instead print the commit hash.
> 
> I am not quite sure how to call this option (`--ephemeral` came to my
> mind, as the created commit is not reachable from anywhere and is hence
> subject to garbage collection).
> 
> A completely different approach would be to allow overriding the ref to
> store the stash in, with an empty value triggering the mode where the
> ref is not updated but the commit hash would be printed instead. I am
> thinking of something like `git stash -r '' push ...`, starting with
> this patch:
> 
> -- snip --
> diff --git a/builtin/stash.c b/builtin/stash.c
> index bb4f6d8d762..43b0a155b1d 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1553,6 +1553,8 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
>  	struct argv_array args = ARGV_ARRAY_INIT;
> 
>  	struct option options[] = {
> +		OPT_STRING('r', "ref", &ref_stash, N_("ref"),
> +			   N_("override `refs/stash`")),
>  		OPT_END()
>  	};
> 
> -- snap --
> 
> The biggest trick will be to make all the code paths safe that assume
> that `ref_stash` refers to a valid ref ;-)
> 
> Ciao,
> Dscho
