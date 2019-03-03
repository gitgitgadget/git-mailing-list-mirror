Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D5320248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfCCBSQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:18:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40449 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:18:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id g20so1452741wmh.5
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E+2kezAub79t8cZTPEmDPSOE26FJOuX8BB5HkoqnA8k=;
        b=DYEdRB3R9NRV85Q/YqNjHDe/FPbDDiN19mMw+eoJ1Ef1KsNUowevtgDsLpAjD+c9Eo
         UZmqkrRFfz3VVnHitCWhQoHRq8hrjjXIkeN7vMGi18FNwQQMWf/otBpCqacGHmIjDEJR
         HugwIf2rlIFQ4Oo/NosSjc9jC6ydLclsjbq0jWkRkkTwJOyQUO45I+wr4Ha9rvFlsGPU
         XewW1r64mU0vz/8d1u8E8dVRfBs0rhHfj1VGLoc8tJPXbQlHJ9L+VvPPCK460+nnnak8
         3gJxSg/iodvPvT7Od9OppQuF7Gutjb6FyEqpAJPHD4rjDGzS5y1L/JepfsY3P+HEEXns
         Verw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E+2kezAub79t8cZTPEmDPSOE26FJOuX8BB5HkoqnA8k=;
        b=INjc+noT+YsNIziB24Zlf/gWeaPeeIyXRNupKS4QEj4W/2xwl3VvLu6UoLoW2+tvhV
         tZLVVPU9ZgPkef4hMIb5IhQvUf8oFIjC/emYpfkgVwC9GynmBIQ6NtbnPbz0sP9Oh9Zp
         YFBfrSZ4nMUGh1mmQ8UhlKBeAyaAqTGQhXnCZhR/3ZOSf7CzIptRifbiGWAOqb2Cxz4H
         26uBuhtJ5FKL3oi05YUlIdsNKMgNeJ2dAFFMzBnKqUffeRNdmCHkId/faqt3fOpK+LgH
         tJUKdcYHQKsoGiJN15QAHOHetDLzRZxlzPjS+FgcuR5gjcs5FzMkoKRHefSVfx1zB5+I
         8RCA==
X-Gm-Message-State: AHQUAuaZhrZFixyuS1FgeK7LhdgVxr50iCcxcAxsrUACizpiz6gO3tJ2
        7T9qfEwyE/8t4RrHQZs1akXndWND2iY=
X-Google-Smtp-Source: AHgI3IZIILF6QRF04lKL+5LueI9QYW8FJeqrIbr+0YsITm2SHRlRWMkFQx8B0nVW0Tdvi1AdCyLSyA==
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr7195947wma.147.1551575893535;
        Sat, 02 Mar 2019 17:18:13 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v6sm6117561wme.24.2019.03.02.17.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:18:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
Date:   Sun, 03 Mar 2019 10:18:11 +0900
In-Reply-To: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 1 Mar 2019 16:40:53 -0800")
Message-ID: <xmqqtvgk69ik.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Invocations of 'git config <name>' print a trailing newline after
> writing the value assigned to the given configuration variable.
>
> This has an unexpected interaction with 63e2a0f8e9 (builtin/config:
> introduce `color` type specifier, 2018-04-09), which causes a newline to
> be printed after a color's ANSI escape sequence.
>
> In this case, printing a terminating newline is not desirable. Callers
> may want to print out such a configuration variable in a sub-shell in
> order to color something else, in which case they certainly don't want a
> newline.
>
> This bug has survived because there was never a test that would have
> caught it. The old test used 'test_decode_color', which checks that its
> input begins with a color, but stops parsing once it has parsed a single
> color successfully. In this case, it was ignoring the trailing '\n'.

The output from "git config" plumbing command were designed to help
people writing shell scripts Porcelain around it, so the expected
use for them has always been

	ERR=$(git config --type=color --default=red ui.color.error)
	... some time later ..
	echo "${ERR}this is an error message"

where the first assignment will strip the final LF (i.e. the value
of the $ERR variable does not have it).

An interesting aspect of the above is that this is *NOT* limited to
colors.  Regardless of the type you are reading, be it an int or a
bool, VAR=$(git config ...) will strip the trailing LF, and existing
scripts people have do rely on that, i.e. when people write

	VAR=$(git config ...)
	echo "var setting is $VAR"

they rely on VAR=$(...) assignment to strip trailing LF and echo to
add a final LF to the string.

So if we are going to change anything, the change MUST NOT single
out "color".  IOW, the title of the patch already tells us that it
is giving a wrong solution.

Whether you limit it to color or not, to Porcelain writers who are
writing in shell, I suspect that the code after the proposed change
will not be a huge regression.  VAR=$(git config ...) assignment,
when the output from the command ends without the final LF (i.e. an
incomplete line), will keep the string intact, so the behaviour of
these shell scripts would not change.

If an existing Porcelain script were written in Perl and uses chop
to strip the last LF coming out of "git config", however, the
proposed change WILL BREAK such a script.

Needless to say, "using chop in Perl is wrong to begin with" misses
the point from two directions---(1) 'chop in Perl' is a mere
example---scripts not written in Perl using chop may still rely on
the existing behaviour that the output always has the final LF, and
(2) even if we agree that using chop in Perl is a bad idea, such a
script has happily been working, and suddenly breaking it is a
regression no matter what.

So, I am not hugely enthused by this change, even though I am
somewhat sympathetic to it, as it would help one narrow use case,
i.e. "interpolation".

	cat <<EOF
	$(git config ...)Foo Bar$(git config ...)
	EOF

or

	(
		git config ...
		echo Foo Bar
                git config ...
	)

would lack LF before Foo automatically, and forcing those who want
to have LF to add it manually would sound easier than forcing those
who want to strip LF when they do not want it.

But when you are making a list, getting the final LF for free is a
feature, so it cuts both ways.
