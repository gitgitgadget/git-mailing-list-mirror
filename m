Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36E8E1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 20:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbeHPXik (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 19:38:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39788 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeHPXik (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 19:38:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so5505750wmq.4
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 13:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H98EhzapXFmRvZB8p3fecQsK5w4PJPBXdAZh7q3HQiM=;
        b=P9IumcijaWbcpTSGJrqJv5d6QVk4qC+kvq4qsfRnyoCpT764PH8Msk/QPC2Ar8v4MN
         Yw9UhhPUXEur5M51L7qLyEoc/yIbjP/ExJebqHVORhw6RdiVAGt0tpmhFpKyDuyBEiw5
         GRbQiYqAlQElEX9OPz+HrWclaCsu7pBnIsbOSrmnGB0WrvMYCgEiQN75KKTO8KgzGx4O
         wfZ5gEcvXXx8rGqwh55h1iem43wdV0ph9m3yLRNa8EHzI1xDXl9JtbGuMZBx70dYmjt/
         0+5atDDuLrlKWGqXCyRzL5U2VdHcB9lEtm0DHVFn5hwk2JUufZJtdE9ODUm6gOKzUR6Y
         4PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H98EhzapXFmRvZB8p3fecQsK5w4PJPBXdAZh7q3HQiM=;
        b=OcVKgEhNOJwJrCpzfcHsokt4IhLdLqB/1F92bdzji4FVDJLjMMbM+1+w+aPvhFI2hY
         IaWphDBkBcuxf155nLxcGTX3RSUE8b6eGjH8jYjONvbHwHJU7x2irKQauN9Urr/sjN4s
         G4UnhnOEaTKHz9+l3+KsqcyWlaXMx9I5RAjWUR86Fz6s7xiOyQxTWLd5FnbcRZTp/HWF
         MOFBiS9sRuRLe1krBNhzmywzF174LC4u0jlu/s3YJWzVJr4sSvq5k73FoY+06lCabkdQ
         5EQcOo4p4luqE5pqkmbn9ahiKacd18SgggfOuNpzpoET16kURimQL0WlcULRfBDPuS2q
         3gqA==
X-Gm-Message-State: AOUpUlHohNRxA0RP9yNz0bCCC33kcLZ0hGx26fmU5tYeh697e7hAPGs4
        GycZhvGAaXuqBHRLGmv3lnM=
X-Google-Smtp-Source: AA+uWPwx7l/lI/kU927QLQPkeoFChpDBi/cFCPYY0ts+8cISTfbJLTlmIWUeTEHz28Ed4PFfQAuuzQ==
X-Received: by 2002:a1c:3545:: with SMTP id c66-v6mr17340351wma.120.1534451883512;
        Thu, 16 Aug 2018 13:38:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z141-v6sm2385339wmc.3.2018.08.16.13.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 13:38:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com, pclouds@gmail.com,
        sunshine@sunshineco.com, karen@codesynthesis.com
Subject: Re: [PATCH v2] worktree: add --quiet option
References: <20180815205630.32876-1-gitter.spiros@gmail.com>
Date:   Thu, 16 Aug 2018 13:38:02 -0700
In-Reply-To: <20180815205630.32876-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Wed, 15 Aug 2018 20:56:30 +0000")
Message-ID: <xmqqftzedp3p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index be6e09314..658647d83 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -252,6 +252,11 @@ test_expect_success 'add -B' '
>  	test_cmp_rev master^ poodle
>  '
>  
> +test_expect_success 'add --quiet' '
> +	git worktree add --quiet ../foo master >expected 2>&1 &&
> +	test_must_be_empty expected
> +'

That's misnomer.  Unless existing tests in this file are already
bogus, I'd like to see it called 'actual', which is the name we use
to store the actual output (to be compared with another file we
create to hold the expected output, typically called 'expect', like
"test_cmp expect actual").

I noticed the breakage after merging this to 'pu'; it seems to die
with "fatal: ../foo already exists" which comes from die().

Oh, more seriously, since when is it OK to muck with stuff _outside_
the $TRASH_DIRECTORY, e.g. "../foo", which would contaminate t/
directory by creating a direct subdirectly under it?

Ahh, and I suspect that it is exactly why I am seeing a failure you
did not see---from a previously failed test cycle, "t/foo" is left
behind because "make distclean" would not clean it (of course).

Do not ever touch anywhere outside $TRASH_DIRECTORY.  Is this
something we could enforce in our test harness, I wonder...

>  test_expect_success 'local clone from linked checkout' '
>  	git clone --local here here-clone &&
>  	( cd here-clone && git fsck )
