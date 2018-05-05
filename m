Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6546A1F42E
	for <e@80x24.org>; Sat,  5 May 2018 06:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbeEEGtr (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 02:49:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40061 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeEEGtq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 02:49:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id j5-v6so8128873wme.5
        for <git@vger.kernel.org>; Fri, 04 May 2018 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wD/C2quOVyYptuOl4M9tvDIMOBX5OcdocOkf4reoHeg=;
        b=L3k221DBULgo/I2LrWmQDvvdflpyFpbxcvopQpAovEyTGXYTN8QjMFzVdx5H1h1k5x
         inMBoAUEctcnUMmEpsannc3M2m8EA6GZ1aUBnSx6WQxvl3Tz5F9b9w2Y1gLOqA6CfCMV
         m/CNWBBNBIknNeR0H6mXYj958t9At2caMQL69Fp/qsOcSIQlhGjkIq1Siha0MyYDBFEC
         5SbBYDMzMA5UASpkrT85gcoYfK8b1C8qPq3mIG10Qcr1E/4TSEagCEJWvvlGL9nz0V+m
         2lapT48gL9HqqhIqWHPjDSn8kpwvvqQsq+FZGp+YNNBQtOpDuTiJjv5LYKBcRwX3mFif
         QIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wD/C2quOVyYptuOl4M9tvDIMOBX5OcdocOkf4reoHeg=;
        b=e/5vR2rxsg7vj+LmhCSMpHntALlAVKWmZpkfQcFd/AYkgqsnsiTeHbLHSZjJGG59d3
         dbH3Kyqg+v4FIzhgYo1HMe84y98ijdvDW+eCWeLjHZzK498HBHNOQ8+ME5RRR6j44Y2F
         Y2vHlXMq9sFJ7OsujephFrtDR0qfA5sOjUzDmRylzC7CeWRl20N3ijaqMt+MQM1dudfl
         reB/9QLI0mPhLt8hxAvCbO2P2zfVNbBotVpfjWjWhOTmy8OT1NPcdBWK53xMsnJJ3DtH
         ooXmPj/yB7WEtp6UkuuoL0nexTPQEnG+FC0hIuLscOp+35oYQQMdhIHp9Dz2ludGEMSp
         PA1w==
X-Gm-Message-State: ALQs6tAurbpa1OJKvJNwB4Ftz8cuobxN8gv7QVRH59j2muye/TLsAdF+
        otJuxn6FLr925reYHMza598=
X-Google-Smtp-Source: AB8JxZqfjbW68fzUyhYd0LlpEDuQnNGk3pwrz5gIDRFF3LR4szvjD9VrcMH4SSSmfBI9uvua1bALdg==
X-Received: by 2002:a50:97d8:: with SMTP id f24-v6mr39376606edb.256.1525502985060;
        Fri, 04 May 2018 23:49:45 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y63-v6sm247929edy.63.2018.05.04.23.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 May 2018 23:49:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 2/2] builtin/grep.c: teach '-o', '--only-matching' to 'git-grep'
References: <cover.1525492696.git.me@ttaylorr.com> <c8b527c5de3b0e5422d2c1afb91d454d1e46fff4.1525492696.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <c8b527c5de3b0e5422d2c1afb91d454d1e46fff4.1525492696.git.me@ttaylorr.com>
Date:   Sat, 05 May 2018 08:49:43 +0200
Message-ID: <87fu36y4u0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 05 2018, Taylor Blau wrote:

> +--o::
> +--only-matching::
> +	Show only the matching part of the lines.
> +

Makes sense to steal GNU grep's description here:

    Print only the matched (non-empty) parts of a matching line, with
    each such part on a separate output line.

> +			if (!opt->only_matching)
> +				output_color(opt, bol, match.rm_so, line_color);

This should also have braces, see "When there are multiple arms to a
conditional" in Documentation/CodingGuidelines.


>  '
>
> +cat >expected <<EOF
> +file:1:5:mmap
> +file:2:5:mmap
> +file:3:5:mmap
> +file:3:14:mmap
> +file:4:5:mmap
> +file:4:14:mmap
> +file:5:5:mmap
> +file:5:14:mmap
> +EOF

This should be set up as part of the test itself, see e.g. my c8b2cec09e
("branch: add test for -m renaming multiple config sections",
2017-06-18) for how to do that.

> +test_expect_success 'grep --only-matching' '
> +	git grep --only-matching --line-number --column mmap file >actual &&
> +	test_cmp expected actual
> +'
> +
> +cat >expected <<EOF
> +file
> +1:5:mmap
> +2:5:mmap
> +3:5:mmap
> +3:14:mmap
> +4:5:mmap
> +4:14:mmap
> +5:5:mmap
> +5:14:mmap
> +EOF
> +
> +test_expect_success 'grep --only-matching --heading' '
> +	git grep --only-matching --heading --line-number --column mmap file >actual &&
> +	test_cmp expected actual
> +'
> +
>  cat >expected <<EOF
>  <BOLD;GREEN>hello.c<RESET>
>  4:int main(int argc, const <BLACK;BYELLOW>char<RESET> **argv)

We should test this a lot more, I think a good way to do that would be
to extend this series by first importing GNU grep's -o tests, see
http://git.savannah.gnu.org/cgit/grep.git/tree/tests/foad1 they are
license-compatible. Then change the grep_test() function to call git
grep instead.

It should also be tested with the various grep.patternType options to
make sure it works with basic, extended, perl, fixed etc.
