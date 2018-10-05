Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E9C1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 16:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeJEXr6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 19:47:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38849 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJEXr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 19:47:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so2523358wme.3
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=5yIeF4WhNatscZ5xSeBBifNxSsc+5ip4T7IvQ5WMPv8=;
        b=RxcNfeqaoG2qkMzUwS8i4hxbCKULlaUgOn1YxXjs/W9YOUuFtUqaGc9XT9ArQBIPJK
         HDPPM/B4L2qX/s1Itv5y7S61f0/fCJBtKx0rqnYkahz83DD7nBAZoQlxfH8Jf4f5rvSZ
         ILiV2UvSNJyFWXS/uwfCYrUEMv+ggkzLCJ7MebcGVWWRRcgpL2TMtBhS+dG23tbIn1Po
         6vndrWZ53Jqra3ZzakcvZtNbsJnDJhScN00xNB32MXlYOSWhbW1EmE9PF9hBnMI+Ge71
         Q3OztNTlXsP2eRrEDihTHi8ME+Q85ckaH8MHph97PacVq9o7yHtJRS3JB4FVBu2CXinx
         f6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=5yIeF4WhNatscZ5xSeBBifNxSsc+5ip4T7IvQ5WMPv8=;
        b=kL/JYVYCEY/1r2yfJyifT9xoQs6wI24ap5RhiU1/tyggnLUQDYykm2C9YGe44FNdwr
         PGNpWUSaWf/Jj5KYBS5AotgR73VgOO91U2iTuThe0bB5mtK5eWZRbhhK7dJTDpMfn5aY
         VJf5PXGoXXbY0gcwpSRhu3H/6flEv+T1ZUoUqGIF7o0abD6eSVH9vHo+smkz/dDBIpk1
         4drDCCMyTrhIal5x8HsaMJiwoDdzar32yhbDUoCChSQeAh9bb9oSH/v5h2X8EnqNGv4c
         d/Vvn5k7uXC4kJHJFbA4xip386yR1T/yZrKMSArP3RS8Rl9qpUHYhyWuFH2/tCgDegsA
         LBAw==
X-Gm-Message-State: ABuFfojQjWq3SrqGzcNhcB6F5OMFgtffw6zCzk/0HV8oOrkm4M53SF1O
        6xAwNFN1d2k5Z/8J3hD6uZ8=
X-Google-Smtp-Source: ACcGV60+sUnbPnSg0UaOGKw0aV7e2+oC5Q9EIEbZSukxxusYuCdymNqw2dhVPUqpktW3cKlPjSBQ8Q==
X-Received: by 2002:a7b:c151:: with SMTP id z17-v6mr8943502wmi.39.1538758104981;
        Fri, 05 Oct 2018 09:48:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c13-v6sm9915307wrm.50.2018.10.05.09.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 09:48:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrn@google.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 2/7] Documentation: add shell guidelines
References: <cover.1536969438.git.matvore@google.com>
        <cover.1538581868.git.matvore@google.com>
        <a45b646fced228e5a7fab4db7a35c1c6084e58d0.1538581868.git.matvore@google.com>
Date:   Fri, 05 Oct 2018 09:48:23 -0700
Message-ID: <xmqq5zygwd9k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> Add the following guideline to Documentation/CodingGuidelines:
>
> 	&&, ||, and | should appear at the end of lines, not the
> 	beginning, and the \ line continuation character should be
> 	omitted

"should be omitted" sounds as if it is the norm to have such a
character, but it is not.  The text in the actual patch body does a
much better job than this.

Perhaps

	Break overlong lines after "&&", "||", and "|", not before
	them; that way the command can continue to subsequent lines
	without backslash at the end.

> And the following to t/README (since it is specific to writing tests):
>
> 	pipes and $(git ...) should be avoided when they swallow exit
> 	codes of Git processes

Good.

> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  Documentation/CodingGuidelines | 18 ++++++++++++++++++
>  t/README                       | 28 ++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 48aa4edfb..72967deb7 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -118,6 +118,24 @@ For shell scripts specifically (not exhaustive):
>  		do this
>  	fi
>  
> + - If a command sequence joined with && or || or | spans multiple
> +   lines, put each command on a separate line and put && and || and |
> +   operators at the end of each line, rather than the start. This
> +   means you don't need to use \ to join lines, since the above
> +   operators imply the sequence isn't finished.

Correct.  Even though I wonder if we need to say the last sentence,
which is rather obvious, patch is already written and I do not see
much point editing this further.

> +	(incorrect)
> +	grep blob verify_pack_result \
> +	| awk -f print_1.awk \
> +	| sort >actual &&
> +	...
> +
> +	(correct)
> +	grep blob verify_pack_result |
> +	awk -f print_1.awk |
> +	sort >actual &&
> +	...
> +
>   - We prefer "test" over "[ ... ]".
>  
>   - We do not write the noiseword "function" in front of shell
> diff --git a/t/README b/t/README
> index 85024aba6..9a71d5732 100644
> --- a/t/README
> +++ b/t/README
> @@ -466,6 +466,34 @@ And here are the "don'ts:"
>     platform commands; just use '! cmd'.  We are not in the business
>     of verifying that the world given to us sanely works.
>  
> + - Don't use Git upstream in the non-final position in a piped chain, as
> +   in:

"upstream in the non-final position" is a bit redundant, isn't it?

  - Don't feed the output of 'git' to a pipe, as in:

> +
> +     git -C repo ls-files |
> +     xargs -n 1 basename |
> +     grep foo
> +
> +   which will discard git's exit code and may mask a crash. In the
> +   above example, all exit codes are ignored except grep's.

Good.

> +   Instead, write the output of that command to a temporary
> +   file with ">" or assign it to a variable with "x=$(git ...)" rather
> +   than pipe it.
> +
> + - Don't use command substitution in a way that discards git's exit
> +   code. When assigning to a variable, the exit code is not discarded,
> +   e.g.:
> +
> +     x=$(git cat-file -p $sha) &&
> +     ...
> +
> +   is OK because a crash in "git cat-file" will cause the "&&" chain
> +   to fail, but:
> +
> +     test "refs/heads/foo" = "$(git symbolic-ref HEAD)"
> +
> +   is not OK and a crash in git could go undetected.

Good.

>   - Don't use perl without spelling it as "$PERL_PATH". This is to help
>     our friends on Windows where the platform Perl often adds CR before
>     the end of line, and they bundle Git with a version of Perl that
