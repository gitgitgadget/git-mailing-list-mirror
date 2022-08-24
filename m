Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD34C00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 18:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbiHXSNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 14:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbiHXSNl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 14:13:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F76D9E5
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 11:13:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c13-20020a17090a4d0d00b001fb6921b42aso2311174pjg.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc;
        bh=I9I6DgsClOZCEeoT8KsCUPcKOF4wFvm9oq5R4rFWgnk=;
        b=prNU/wRwc0fmYPTnk0Z0k6dQNVB4qnfDSiy2+7YkV7dz9psAB/LTvSw6NqrpXeswtb
         0YRB3zKkV7lTmWbhp2xI9BA90k5T02fTi5gK78OBIDwj7ROOuGpd09Hti1odMm7/OnR4
         MpgnfIbd+9k5wzPgNKySeYzv6FwK52YTa3AUdOVuINCKzDUOJVq0BwogdmBsY0mgwuhv
         OGB2VpNDLHnIpQtU+qGKDUMF0qStekms8i89tuG4VyIlgkiwczPzpMCdFvC8KGgHcn+T
         U3g17F3GTN68DRw9x2bYWpORbV4A6paSwqUMS6sfqY5FAj5uAxYtPHX/HMgExt66ciA8
         hjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=I9I6DgsClOZCEeoT8KsCUPcKOF4wFvm9oq5R4rFWgnk=;
        b=zWBDtAoC/tW8sWZe4oICyYKUIp392JhkSdq7aMnhEq4BTtVRdY4qH+62YYg1c6LWKz
         Se+L/04iSuER1fGGfeQ/KuI7hcvZJHYRBI2csjLjcQOPQpfEO6b1DJUflfrlJqABkdYP
         3o+XObBDzRmzCWGMqY//fFXhwJ7Wxly1HuQFVQdoU7NYlR76aS0nq3yQKtpqV7mA6GBB
         Y7iCIRsv8Z1DuHjLehumnlOFrlQfvyvj8gXM1WGshBcQQxqoEe7waJ6bvlTy3OyNhgML
         VWbqDzgqmWXh3MnJLkjWMPn2xoSkjloKNqlhE8K88+fuOr+e+8qnXPGfptM7ePvqpprs
         m1Ng==
X-Gm-Message-State: ACgBeo1dn9p5uAcs4ymQbfjJHs/GwgJc29gdCMKoFRGb/7ga5y1XR0h1
        Ak+Lv4WtIR/REOP1mwQtU4k=
X-Google-Smtp-Source: AA6agR5oG6gaEvZVMpzA8kMa7IJATJqHeBRN/e0x+4MTZRoYOIPxUFiOS5MG5BGPpU0IZ2aWQihl1w==
X-Received: by 2002:a17:90b:4d12:b0:1f7:a6d1:24c1 with SMTP id mw18-20020a17090b4d1200b001f7a6d124c1mr367050pjb.15.1661364819336;
        Wed, 24 Aug 2022 11:13:39 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g18-20020aa796b2000000b0053725e331a1sm2563900pfk.82.2022.08.24.11.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 11:13:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Maxwell Bernstein <tekk.nolagi@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: clarify whitespace rules for trailers
In-Reply-To: <20220823140630.159718-1-christian.couder@gmail.com> (Christian
        Couder's message of "Tue, 23 Aug 2022 16:06:30 +0200")
References: <CAP8UFD2kMXHxvg1tKVNLhY0Gweq2YrD7+tHmZXKwguYzRQ1Qpg@mail.gmail.com>
        <20220823140630.159718-1-christian.couder@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
Date:   Wed, 24 Aug 2022 11:13:38 -0700
Message-ID: <xmqq4jy18q7h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Commit e4319562bc (trailer: be stricter in parsing separators, 2016-11-02)
> restricted whitespaces allowed by `git interpret-trailers` in the "token"
> part of the trailers it reads. This commit didn't update the related
> documentation in Documentation/git-interpret-trailers.txt though.

OK.

> Also commit 60ef86a162 (trailer: support values folded to multiple lines,
> 2016-10-21) updated the documentation, but didn't make it clear how many
> whitespace characters are allowed at the beginning of new lines in folded
> values.
>
> Let's fix both of these issues by rewriting the paragraph describing
> what whitespaces are allowed by `git interpret-trailers` in the trailers
> it reads.
> ---
>  Documentation/git-interpret-trailers.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Missing sign-off.


> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 956a01d184..0e125d795b 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -60,10 +60,12 @@ non-whitespace lines before a line that starts with '---' (followed by a
>  space or the end of the line). Such three minus signs start the patch
>  part of the message. See also `--no-divider` below.
>  
> -When reading trailers, there can be whitespaces after the
> -token, the separator and the value. There can also be whitespaces
> -inside the token and the value. The value may be split over multiple lines with
> -each subsequent line starting with whitespace, like the "folding" in RFC 822.
> +When reading trailers, there can be no whitespace inside the token,
> +and only one regular space or tab character between the token and the
> +separator.

That may have been the intent, but does it match the behaviour?

        static ssize_t find_separator(const char *line, const char *separators)
        {
                int whitespace_found = 0;
                const char *c;
                for (c = line; *c; c++) {
                        if (strchr(separators, *c))
                                return c - line;
                        if (!whitespace_found && (isalnum(*c) || *c == '-'))
                                continue;
                        if (c != line && (*c == ' ' || *c == '\t')) {
                                whitespace_found = 1;
                                continue;
                        }
                        break;
                }
                return -1;
        }

When parsing "X  :", first we encounter 'X', we haven't seen
whitespace, 'X' passes isalnum(), and we continue.  Then we
encounter ' ', we haven't seen whitespace but it is neither isalnum
or dash, so we go on without hitting the first continue.  We are not
at the beginning of the line, we are seeing a space, so we remember
the fact that we saw whitespace and continue.  Next we see another ' ',
we do not hit the first continue, we are not at the beginning of the
line, and we are looking at ' ', so we again continue.  Finally, we see
':' that is a separator and we return happily.

The code seems to be allowing zero or more space/tab before the
separator.

Stepping back and reading the original again, I think the original
was almost correct.  There can be whitespaces after the token.
There can be whitespaces after the separator.  There can be
whitespaces after the value.  The only thing it got wrong was that
it pretended to allow whitespaces inside the token, while in reality
we allow whitespaces inside the value but not inside the token.

So, a minimum fix would be to s/token and the value/value/; I do not
mind a more extensive rewriting if it improves clarity and correctness,
but "only one between the token and the separator" is not quite correct.
Besides, that phrasing gives a false impression that the whitespace is
mandatory, but you wanted to express "zero or one" optionality, no?

> There can be whitespaces before, inside or after the
> +value. The value may be split over multiple lines with each subsequent
> +line starting with at least one whitespace, like the "folding" in RFC
> +822.
>  
>  Note that 'trailers' do not follow and are not intended to follow many
>  rules for RFC 822 headers. For example they do not follow
