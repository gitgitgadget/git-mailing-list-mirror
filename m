Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD018208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 19:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbeHFVkD (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 17:40:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38194 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbeHFVkD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 17:40:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so13428802wro.5
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4gks5jY88wSiyNvpATHkjQpxj0jYadVbBfFn8JL/30g=;
        b=PI97DWskC3rZvU7miRJj6s0oTD1A2QWAiJzl5KfJAlTLeT1Fn3zmBDTefNFQx2IAN/
         iieDhTaQBi6VzGUdMTTGUp7m6Ucz46x3plWqJ7uBnD+GfjVNahdVkUfy3QXudSMYJr9I
         lqraAKebFLSIxCDwXGrglq87X0TTUTj2w4+6mmG14fNeiCb8CdRIwxEz81Q++ek/Wv7I
         edJkGjQx3RwBaViXaJfbQkxsxLTc6KU/qgL0YvkzDcYCjY4uoGEa05kXQwO0Mtn7dXUD
         qPFRV97Fy7Si8O1mmju1x7nap/zD/wZ6HDyEngWVwsm4jhn1yldodL0XDp/Xwl+k5M3m
         K01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4gks5jY88wSiyNvpATHkjQpxj0jYadVbBfFn8JL/30g=;
        b=CSunA8tKp7rgtwm8MmiSHd/DAc1TfA+aRxQYHmA8z4in4w0Wz06evjnTLSfdcvg9Us
         l3fqqQkXouLx2cQkc/ACZYkXqDD8bUeYGFaOwGuzYgrfBFcJY3D3bdil8u02s5ltCasS
         nfaBLxwQMu35sHFlObDUuwuBsXBVLy+vtN+GwvgeJE4qYw3vqBnMFv6+xGc0mmETXIXi
         ioCx1iM7eNJxlfzCEtS/QbKToevpNpwIpRjDJGw7LtH/L4OEsKkDYuCCoetv+b2xyIsj
         pzjvyo5Wg6nW2vXbB8j34yvl2d47gbugrZnuC2YmLrUVmZAMM+pyv3IdwyBrr3FCbVBE
         dqYg==
X-Gm-Message-State: AOUpUlE4czzBM3jP5Hq2VCqKodOWVDu9sD9abBmk5vUdUHMy5pMIGUF2
        3N8HQlHOFPCZ7sCb9xRr7v4=
X-Google-Smtp-Source: AAOMgpe7VVfw5QGuYBICvcpKDiQrvOMO0k+NOqpLpTP33E4P3+mBJNuDKJsnjqDKK64sgO+kQOnSAQ==
X-Received: by 2002:adf:db41:: with SMTP id f1-v6mr11432985wrj.212.1533583769315;
        Mon, 06 Aug 2018 12:29:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l5-v6sm5428140wmh.0.2018.08.06.12.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 12:29:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] add a script to diff rendered documentation
References: <20180803205204.GA3790@sigill.intra.peff.net>
        <20180806173720.GA5508@sigill.intra.peff.net>
        <xmqqy3djnyik.fsf@gitster-ct.c.googlers.com>
        <20180806185853.GA18119@sigill.intra.peff.net>
Date:   Mon, 06 Aug 2018 12:29:28 -0700
In-Reply-To: <20180806185853.GA18119@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 6 Aug 2018 14:58:54 -0400")
Message-ID: <xmqqmutznvjb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > +	case "$1" in
>> > +	-j)
>> > +		parallel=${1#-j} ;;
>> 
>> This is curious.  Did you mean "-j*)" on the line above this one?
>
> Hmph, yes, I think this was broken even in the original. And after going
> through "rev-parse --parseopt", we should have a separate argument
> anyway, even for the "stuck" form. Worse, the OPTIONS_SPEC doesn't
> mention the argument, so it barfs on "-j4".

Ah, I forgot (just like somebody else, and even worse is that I
reminded him of this fact that I am forgetting here) that we use the
parseopt thing to normalize the option parsing, so with the correct
spec "-j)" is the right thing to say (but yes then you'd look at $2
and then shift both aawy).

> I think we need to squash this in:

Yup.  Thanks.

> diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> index 5d5b243384..f483fe427c 100755
> --- a/Documentation/doc-diff
> +++ b/Documentation/doc-diff
> @@ -3,7 +3,7 @@
>  OPTIONS_SPEC="\
>  doc-diff [options] <from> <to> [-- <diff-options>]
>  --
> -j	parallel argument to pass to make
> +j=n	parallel argument to pass to make
>  f	force rebuild; do not rely on cached results
>  "
>  SUBDIRECTORY_OK=1
> @@ -15,7 +15,7 @@ while test $# -gt 0
>  do
>  	case "$1" in
>  	-j)
> -		parallel=${1#-j} ;;
> +		parallel=$2; shift ;;
>  	-f)
>  		force=t ;;
>  	--)
>
>> Then "script -j" (no explicit number) would get here and autodetect.
>> Running the script without any "-j" would also get an empty parallel
>> and come here.
>
> Yeah, I think that is the wrong thing. If anything "-j" should behave
> like "make -j". However, it looks like "rev-parse --parseopt" doesn't
> play well with optional arguments for short-only options. You get "-j",
> but then you have no idea whether the next argument is an optional value
> for it, or another option entirely. Arguably it should give a blank
> string or something (if you have long options, then it uses the
> long-stock form, which is fine).
>
>> So "script -j1" would be how a user would say "I want to use exactly
>> one process, not any parallelism", which makes sense.
>
> Right, that was the thing I actually wanted to have happen. :)
>
> -Peff
