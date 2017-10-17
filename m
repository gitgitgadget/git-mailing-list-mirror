Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190C3202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 04:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756058AbdJQEmI (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 00:42:08 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:54080 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754806AbdJQEmG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 00:42:06 -0400
Received: by mail-io0-f170.google.com with SMTP id 189so818884iow.10
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 21:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rChoIAIlQqSpkrwn9TCGzlkXLVZM2jKuLhtF57OisZ0=;
        b=bhxYfiRqsXP7RzoVICnuI3GQ0OTPA9XkMbZjuuoPzf0U8yG/zhjOMeBvsL/QBgs+G+
         ZlOT9M9e+JF5els3Cj5ZPk1cALbxFVMxepLIXqA67m8ecS1BnyxWiTiyGYNHT8CXo6IO
         5SMwGLXxcI1ZjCLzpkjX+xicoVAhD6KnQt2BHng/6Yi7u1NXswt0TQO5y2LlpzJ/+D01
         TIC7/kTJNxUmxPjf5CoFiSYqkFMHd+lMk4JFWuH1Kf1zQGtiOltPSYrw6olgZZ5IewqE
         WCbtOhmA02UoVx77Q6NgiqnFUhoowzVtpK9XIBWFcwHRFYvqfovxlKCbEtKAShrFh9Hp
         dAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rChoIAIlQqSpkrwn9TCGzlkXLVZM2jKuLhtF57OisZ0=;
        b=FRwGH6GlCB6B5B4ZpfBIC8s09xJaWoMjhitF+5ZyOFZnsrOeYlAQ/QaYWKhV0i0ykC
         okObG1clEnwfJZUpUoHDQb+vzDVp80AxDGxLO2S2xORumyeX1B+bAqULK7ML2OSFwTYo
         l4HhCvBxDfOhAsiwyQUlioT8XQ3wOVhl4YzRD7Fu4kFoBDnYD7BnVy2sdJ5e4LrjlOV/
         wC/MeeWe6Bn45mq/Sa63F/l+J0qjASfoS5WK4Yzj/kE04CncXmb2fuNHeW5AfrZMtTwI
         xBxtdBhNgLRMvtqfRMDm52zK/mdFWjUOzSYS4UL0xz6+6osVAEv5XSOmbdoy/LFgRgqH
         RDew==
X-Gm-Message-State: AMCzsaUXSse2r6Mm77tabsmmI0Ud45lVlma3vkAtstAkrXrB0mafRYRn
        3t+GftJo77ZHwvhAsAy2znk=
X-Google-Smtp-Source: ABhQp+Q8xLkGVy/fAn3dpqoSaV7fT909JRV8bHLtlG8eOdsNMRegumtPYDeEE17yaEQn6782poz68A==
X-Received: by 10.107.37.129 with SMTP id l123mr14290631iol.262.1508215325385;
        Mon, 16 Oct 2017 21:42:05 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h124sm4338379ioa.60.2017.10.16.21.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Oct 2017 21:42:04 -0700 (PDT)
Date:   Mon, 16 Oct 2017 21:41:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20171017044111.ahe4eiepvokecnkr@aiede.mtv.corp.google.com>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
 <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> Things like @{-1} would not make any sense when the command is run
> outside a repository, and the documentation is quite clear that it
> is the primary reason why we added "--branch" option to the command,
> i.e.
>
>     With the `--branch` option, it expands the ``previous branch syntax''
>     `@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
>     were on.  This option should be used by porcelains to accept this
>     syntax anywhere a branch name is expected, so they can act as if you
>     typed the branch name.
>
> So I am tempted to take this patch to make sure that we won't gain
> more people who abuse the command outside a repository.

That seems very sensible on its face.  My only worry is that a script
that can be run both inside and outside a repository and does

	branch=$(git check-ref-format --branch "$user_supplied_branch_arg")

currently works with user_supplied_branch_arg='master' and would stop
working.  If we have reason to believe that no such scripts exist,
then this would be a good way to go, but I don't believe we can count
on that.

And in that spirit, I think the patch you replied with aims to go in
the right direction, by providing the core functionality when in a
repository while avoiding breaking such a script outside of one
(though I do not understand it fully yet).

> Having said that, there may still be a use case where a Porcelain
> script wants a way to see if a $name it has is appropriate as a
> branch name before it has a repository

This seems like a different goal than "git check-ref-format --branch"
was originally designed to fulfill (even though it fits well with the
check-ref-format name and coincides with --branch behavior when in a
repository).  I think it's fine for us not to fulfill it.

>                                        (e.g. a wrapper to "git
> clone" that wants to verify the name it is going to give to the "-b"
> option), and a check desired in such a context is different from
> (and is stricter than) feeding refs/heads/$name to the same command
> without the "--branch" option.

Can you say more about this example?  E.g. why is this hypothetical
wrapper unable to rely on "git clone -b"'s own error handling?

> So I think the right endgame in the longer term is:
>
>  - Find (or add if it doesn't exist) a way to recommend to Porcelain
>    scripts to use to expand an end-user generated string, and to map
>    it to a branch name (it may be "rev-parse --symbolic-full-name
>    $name"; I dunno).

--symbolic-full-name seems like a good fit.  Do you remember why
check-ref-format was introduced instead?  Was it just a matter of
implementation simplicity, since --symbolic-full-name can handle a
broader class of revision specifications like --remotes?  The commit
message to v1.6.3-rc0~29^2~4 (give Porcelain a way to grok branch
shorthand, 2009-03-21) is appropriately apologetic but doesn't give
more clues.

>  - Keep check-ref-format as (or revert it to be) a tool to "check".
>    This would involve split strbuf_check_branch_ref() into two:

Without an example of where this tool would be used, if we consider
"check-ref-format --branch" to be a mistake then I'd rather deprecate
it with a goal of removing it completely.

Ok, time to look in more detail.

Thanks for your thoughtfulness,
Jonathan
