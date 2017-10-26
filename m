Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D59A2055E
	for <e@80x24.org>; Thu, 26 Oct 2017 00:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdJZAoV (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 20:44:21 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:51041 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751911AbdJZAoU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 20:44:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id b6so1223151pfh.7
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 17:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uu89sQaU/9+A9mRtZ6jPZf/37RD4WnCbLVK4rI5LmSE=;
        b=bG1hu1A++GpKaH3B25RcMKxnjLE/nzgfKnuvD5wNuaLFNIVHp3zH/ymZv9jSCxgNdh
         Abf/GrbvftbP2o89PopcCFFR5WYVkh6K0dQBjcl3330gzaOPpMda3o0vTypRLnGa8epE
         d9i7H/ATmkx3L1jhWOBJL9DQHL9uClUNX4ysY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uu89sQaU/9+A9mRtZ6jPZf/37RD4WnCbLVK4rI5LmSE=;
        b=dPpthHaH9DVcMt7L7idh0xNr8BzHqbq6t07oZVaH4fM+/H6AvGk3rFcrJ9somRRvlw
         cFQks81tL3qACMcMVW1AkzIjkT9DxVP9etwrLwaNDBWjZvoet/5ZreEhCjGmsmn7d+cE
         IfyW9TO7OTP+rVrqtiG0k/aQoDyN2zwCWmEhsAP/xi7HguQ9lAOpER19TI8eIUHk1Bo4
         YHKqKblKZri28bMSZxlBa6jcM3kOlXHdcjwqRSJHf7FGn2r90iyKysL2aEz8BliybdRn
         G43ZciOWsh7VDSTPZ6ZwruYiF6AOmBRginlNdX7Sr0/0Ic6jNt/im46hA8Tb7/qeRhq4
         cIdQ==
X-Gm-Message-State: AMCzsaWpUF5+unOi3yxLgUidBs3EJvuv4jZ2hmwh6tXzQ7k5uo2tc26v
        00iw/2NoY/Cmp5xby9x6Hj6AWg==
X-Google-Smtp-Source: ABhQp+RZ3ER/1jpgJPWh8UQ/Ti30+V/du5OlErWhX7X2J9nmCoZdo0UyeJSbYJiwIQEldEhkuvAMYg==
X-Received: by 10.98.32.212 with SMTP id m81mr3800518pfj.227.1508978659133;
        Wed, 25 Oct 2017 17:44:19 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id e22sm5850440pgn.28.2017.10.25.17.44.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 17:44:18 -0700 (PDT)
Date:   Wed, 25 Oct 2017 17:44:10 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Ben Peart <peartben@gmail.com>
cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/4] fsmonitor: Don't bother pretty-printing JSON from
 watchman
In-Reply-To: <c43315f3-4155-6b07-bde2-5855dceacf80@gmail.com>
Message-ID: <alpine.DEB.2.10.1710251722310.9817@alexmv-linux>
References: <20171020011136.14170-1-alexmv@dropbox.com> <6887851348e177728849964cc95ae783b0feb971.1508461850.git.alexmv@dropbox.com> <alpine.DEB.2.21.1.1710201459020.40514@virtualbox> <c43315f3-4155-6b07-bde2-5855dceacf80@gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Oct 2017, Ben Peart wrote:
> > While I am very much infavor of this change (I was not aware of the
> > --no-pretty option), I would like to see some statistics on that. Could
> > you measure the impact, please, and include the results in the commit
> > message?
> > 
> > Ciao,
> > Johannes
> > 
> 
> I was also unaware of the --no-pretty option. I've tested this on Windows
> running version 4.9.0 of Watchman and verified that it does work correctly.
> I'm also curious if it produces any measurable difference in performance.

On a repository with ~160k files, the following test harness, which
requests all files inside the repository and parses that output:

--------------8<-----------
#!/usr/bin/perl

use strict;
use warnings;
use IPC::Open2;

my $pid = open2(\*CHLD_OUT, \*CHLD_IN, "watchman -j @ARGV")
    or die "open2() failed: $!\n" .
    "Falling back to scanning...\n";

my $query = qq|["query", "$ENV{PWD}", {}]|;

print CHLD_IN $query;
close CHLD_IN;
my $response = do {local $/; <CHLD_OUT>};

my $json_pkg;
eval {
    require JSON::XS;
    $json_pkg = "JSON::XS";
    1;
} or do {
    require JSON::PP;
    $json_pkg = "JSON::PP";
};

my $o = $json_pkg->new->utf8->decode($response);
--------------8<-----------

...run with dumbbench[1], produces:

    $ dumbbench -- ./test.pl
    cmd: Ran 22 iterations (2 outliers).
    cmd: Rounded run time per iteration: 5.240e+00 +/- 1.1e-02 (0.2%)
    $ dumbbench -- ./test.pl --no-pretty
    cmd: Ran 21 iterations (1 outliers).
    cmd: Rounded run time per iteration: 4.866e+00 +/- 1.3e-02 (0.3%)

...so a modest 8% speedup.  I note that those numbers are for a perl
with JSON::XS installed; without it installed, the runtime is so long
that I gave up waiting for it.

Anyways, I'll put that in the commit message in the re-roll.
 - Alex


[1] https://metacpan.org/release/Dumbbench
