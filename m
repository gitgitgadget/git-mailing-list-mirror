Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AE21F404
	for <e@80x24.org>; Mon,  2 Apr 2018 12:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeDBMR0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 08:17:26 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:50509 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeDBMRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 08:17:25 -0400
Received: by mail-wm0-f41.google.com with SMTP id t67so5170961wmt.0
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EVMY0R9KHWf9PuvMqVYzffvo8sjjDjaj6G1nmucqfQc=;
        b=vJvL5jOW4nUsA43/pKdLsya3WJmKfh7ImqTZeiCIMfPPTKoXD+lHlBHwGl3T97nMGb
         YuXQWyWWFNf+L5vtV9xCh6U0sdIe6EFRkXZMEgOIqsun1tSm134NIosA3SypGu3GfZQi
         6wFjGrsaCjCwUL9/XG88JZzZkS0aoWu5oK9wprzaGtbjvsMyAocTdicGA0hlERfV0ahK
         wR9blQjMJWWNdULDvE2ANIZDn5aITBqGbn3yKr6bbz8KTnyQSICd/J/LIGI2X3XYrvhG
         AkJS2IzQU4QR1B46I+V0rIgn+dKIwV1ucTHvinEy+aOvG2a1Ep/j/yFeIY/dm6lFYx0S
         z7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EVMY0R9KHWf9PuvMqVYzffvo8sjjDjaj6G1nmucqfQc=;
        b=i28ouF6MFGmY626305e5HvnUw4+tz0Q940zlP8J0j5bv4+eyeIASzU962oUjQa+pSf
         /zognT56uMys1+u0QMHNtYIbnrkwHc7BljweBgFXJ4/AZ+RzlRrCNtKltvsBOWcbq3vu
         88qk0hFnzJ7Z88j79G3McLaqdkksrLnoU1+H0dlfdbSkWlrMwDMMqGQD3WZN5zubKCSD
         8zxMA4nrsCfDN6ZfBV6CE1ZD1ITxYqBewXUnnL7LTwVp3ci40UZbuj8x7p2zQ+La/fRZ
         DcKf60AMZmU8Ls/lJY2eDqBcHgDxk+1H1Qcu6lPlmS7EY0MzdviZwJDGV5YWB/ahuHrh
         fAdg==
X-Gm-Message-State: AElRT7Hm6K6Ycaw4HaTeidBYHgAfg6XWIz45DDhInv/YVG22bcuIvQm/
        kP8Hw+tzDLtyQ71s3/jOA44=
X-Google-Smtp-Source: AIpwx4+zLVrvvQMC6h0QXl1aaRILMHKh9xWZ81gVKyNtNm/bLQaNLKspER75LSfajF3323D0NajS6A==
X-Received: by 10.80.241.6 with SMTP id w6mr12499742edl.62.1522671444650;
        Mon, 02 Apr 2018 05:17:24 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b47sm319235ede.13.2018.04.02.05.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 05:17:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     David Hoyle <davidghoyle@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible bug in git log with date ranges
References: <CAFGVh0yh-w3=s5WBK-HqHQd+dWKgpnqytF4E3mXv_HxrC1i78Q@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAFGVh0yh-w3=s5WBK-HqHQd+dWKgpnqytF4E3mXv_HxrC1i78Q@mail.gmail.com>
Date:   Mon, 02 Apr 2018 14:17:22 +0200
Message-ID: <871sfxx0od.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 02 2018, David Hoyle wrote:

> Hi,
>
> Hopefully I've read the readme file correctly for submitting something
> that might be a bug.
>
> I've recently migrated projects from an old version control system
> (JEDI VCS) to Git (which I really like BTW). The way this was done was
> by extracting the files from the original database and saving them to
> a folder layout and then running git add / commit on the files. When
> using the commit command I've used the --date switch to commit the
> files using their original dates. However if I run git log with say
> --since=date it seems as if this command uses the actual date the
> commit was entered not the date given for the commit. The same seems
> to apply to the other date filtering switches.

The --date=* switch to git-commit sets the author date, but the date
narrowing options to git-log use the committer date. See if when you
run:

    git log --pretty=format:"%aD - %cD"

Whether what you're getting doesn't make sense in terms of the second
date.

You can use GIT_COMMITTER_DATE to get what you want, see "DATE FORMATS"
in git-commit(1).
