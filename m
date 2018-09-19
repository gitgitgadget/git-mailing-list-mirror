Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D7F11F453
	for <e@80x24.org>; Wed, 19 Sep 2018 17:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeISXSP (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 19:18:15 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37485 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeISXSP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 19:18:15 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so5856647oic.4
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7Bu2vB+/3WAqGw+dceLF+qRQD3NnsjWmGGGUEwEo5A=;
        b=OOcaZGN0Emrf247rQ43/JYotL6LTOhxhJ9DCctv7NHrfMJzq8WQs/JXmV7FMzygddw
         M41s0m2NuVOKCR1fxr+BOMLGCMr6XkjojUqrvoz+rbBAG2Zqjk8rhld8sIlsv/5RjVwz
         YWXejkL1X0OWyUkuC+Vzkafzb9XglMYfwoRc/akiZJu6ap5ADNbMOWFD3oygYcTKLzXG
         8lzPgEZa63giOPk18ZEJm81uPkg1Hrs43WQrk+HXwmuz+l9XWs6aCsD9hf14uTePq0ip
         JfRO0OcsrDqnSuAzf+b0z+Yqi0tYs7dLW5sDH53lm6KP2+BC+cIpO1TxFvZ71oYtsiq4
         5gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7Bu2vB+/3WAqGw+dceLF+qRQD3NnsjWmGGGUEwEo5A=;
        b=nh+5ZAWJxdAB9tlWESqHRHfeTdFnKLOHUUBPWzJxHVkuWNFNiCI/fZZqCMQSk4PBmp
         ldVbL4M1wgu9pZuC12qRwTUm1isAIETTsYSe2tVbKQQ/O7RTJL98LKv3+naHTtDtPt0M
         q/2c6NeWdD8fA0jDItW91n4YnbUko5TXijuY0rx0B4HyKT22caMrhuFGBaX8wD27iH8G
         sDD5bGpnyRNTpkiatBfi1FfjzbxrwBSeLOXzcusBEzfix5MrAuF6R4A4Ssw6V2kfwpL7
         KSawIUwJHCmh/hn3esEF0hf09WinYxZGP/fgcJQkAMqvLqGCpxgIdlc8zNPLpS5aTcNw
         PsTA==
X-Gm-Message-State: APzg51Amv2HWZSDule1Q20lIN2W15yhWaXucUzZLzE9gDxG5OYUdqzIr
        gU7O6xlimY45w6TQHgKUWJueEXXGKzOSfhnQjqxjCosYNKqo
X-Google-Smtp-Source: ANB0VdZF/GgiHFOmTrdKy2bdwhPgS803kViQO0xaJUmW655tkxCAM5g5waqvMuQ8TgnrZyYgM5gyv/PGbMT/ed3m2Vc=
X-Received: by 2002:aca:d605:: with SMTP id n5-v6mr2417473oig.287.1537378756191;
 Wed, 19 Sep 2018 10:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537222670.git.matvore@google.com>
 <44ee2bd27b510d4216525e24aa1734a1f5edbd95.1537222670.git.matvore@google.com> <CAPig+cTO=BJ+-6+73fDmdWX7axCZvsyKMxE0E1bhGX-YUFrR-w@mail.gmail.com>
In-Reply-To: <CAPig+cTO=BJ+-6+73fDmdWX7axCZvsyKMxE0E1bhGX-YUFrR-w@mail.gmail.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 19 Sep 2018 10:39:03 -0700
Message-ID: <CAMfpvhJ21ZtpjcJvOH7s=5r496z4Fz+tw94ymGD54xe=0RJ8Eg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] tests: Add linter check for pipe placement style
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 5:34 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Sep 17, 2018 at 6:25 PM Matthew DeVore <matvore@google.com> wrote:
> > tests: Add linter check for pipe placement style
>
> Until now, the various "lint" checks have been for genuine portability
> problems (except perhaps 'test-lint-duplicates'). This new lint check
> makes style violations worthy of failing "make test". Is the indeed
> the direction we want to go? (Genuine question. I can formulate
> arguments for either side.)
>
> > ---
> > diff --git a/t/Makefile b/t/Makefile
> > @@ -101,6 +101,16 @@ test-lint-filenames:
> > +test-lint-pipes:
> > +       @# Do not use \ to join lines when the next line starts with a
> > +       @# pipe. Instead, end the prior line with the pipe, and allow that to
> > +       @# join the lines implicitly.
> > +       @bad="$$(${PERL_PATH} -n0e 'm/(\n[^\n|]+\\\n[\t ]+\|[^\n]*)/ and \
> > +             print qq{$$ARGV:$$1\n\n}' $(T))"; \
> > +               test -z "$$bad" || { \
> > +               printf >&2 "pipe at start of line in file(s):\n%s\n" "$$bad"; \
> > +               exit 1; }
>
> If we're going in the direction of linting style violations, then
> maybe generalize this by calling it "test-lint-style" rather than
> "test-lint-pipes", and perhaps move the body of the test to a new
> script check-shell-style.pl (or something), much as portability
> violations are housed in check-non-portable-shell.pl.

I agree with moving this code to a separate file. I also notice that
there is logic in a file called t/chainlint.sed which normalizes
scripts for the purpose of lint checks (e.g. it removes heredocs) and
I ought to be re-using this logic in order to make the new lint check
robust.

I think I'd like to shelve this particular commit and come back to it
once I have the time and I'm more familiar with the code base. It is
not critical to this patchset.
