Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A7C1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 16:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbdEPQ7F (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 12:59:05 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34243 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdEPQ7E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 12:59:04 -0400
Received: by mail-oi0-f42.google.com with SMTP id b204so33272516oii.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K+4JSv/kLf2LH0j6tE9HU+HKlxhQba97nJa3wYsH4jM=;
        b=KeHhF4CG+M6c54/qsX6sa3zmnnHrT5YEXTUXT2pvqIyyuVIyI13+TidepR4GBbBMG0
         wGNuI21J/mdDXOGSAmxkMeSYbs+qUyk1iZgSZtGmKUz8dHI0V+ho+Gk52bDUde06rOdt
         dLx3oaF6EXnpVorm5O1HTBMh3rTXrBbHn7vBDNs1eAgyNlnuAIFywGkSoMxLmRZtY8ZR
         VB7+YFNKfexM9KOZ/ZAg0fhw2oAv3fPmSW+o4r+My3MK1trqEltgECsREHRGceEDA705
         w1sf87/BDcC/G1SQpa8asgDIscs4uZ8Vq+wavRRl6xYX2b9UVd2o6ufAnbeBv4ao0dvn
         zjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K+4JSv/kLf2LH0j6tE9HU+HKlxhQba97nJa3wYsH4jM=;
        b=Yi7Y/k2rQ6dgplRboG5BiLs+n3+G4QOk9C+n6SxSHKr4t+JVF9ekITLKVpPQTlqCkn
         /YiVWLtVuR9ZNfflXgDA4Sy43cmMNRfp6Lmvkv+kmo5SbZk4NZ010L/QJg2lMQaTIMzX
         UXIJDgXQ1WvYnaEG6iiSf97LP20D/+WwiKtnUxIoijHxTVi0nyGqnghIxcE6hi3qTp2b
         9x7lNXUibPcJghZjnyVbx2tgk8gHdSCCKLYPvOfvhQqWEqjaGZ/Abe/3tHjivF+rsy1U
         076u52SuWRyyMFe3fobBYJr2ypEgub801UHoAtguXeC2Z21R77cgCIRbsW8grBtgJZLj
         PKlg==
X-Gm-Message-State: AODbwcCBquI0OibPK4FrLo9egK4gt6E6yeV/iGU2IH+a2m7ysRCoMUnc
        wre7q4rNXVrL+YjzDcIvQIf505IGSA==
X-Received: by 10.202.73.9 with SMTP id w9mr2321788oia.147.1494953944003; Tue,
 16 May 2017 09:59:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.54.53 with HTTP; Tue, 16 May 2017 09:59:03 -0700 (PDT)
In-Reply-To: <20170516161858.stp4ylwfmbgc4oid@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <alpine.DEB.2.21.1.1705161220230.3610@virtualbox> <20170516161858.stp4ylwfmbgc4oid@sigill.intra.peff.net>
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Tue, 16 May 2017 09:59:03 -0700
Message-ID: <CA+zRj8Uxh1SGdVW=zz29Q4m4OnDcs665T0XtV6FiZ_qZSiG-8g@mail.gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly to --exec
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeremy Serror <jeremy.serror@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 9:18 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 16, 2017 at 12:23:02PM +0200, Johannes Schindelin wrote:
>> It would appear to me that you used a side effect of an implementation
>> detail: that `git rebase -i` was implemented entirely as a shell script.
>
> I don't think that's true at all. He expected the user-provided "--exec"
> command to be run by a shell, which seems like a reasonable thing for
> Git to promise (and we already make a similar promise for most
> user-provided commands that we run).  What happens in between, be it

As a "user", my expectation was simply that the command would be run
not just in "a shell", but in *my* shell (or the shell that calls git,
maybe). So I don't see any portability question with respect to Git.
My script that uses git rebase --exec may not be portable, but that's
my problem.

When I use "git rebase --exec <cmd>" I'm basically writing a "foreach
commit in range { <cmd> }" in my shell. Same idea with git bisect run.

A transparent optimization that tries execve() then falls back to the
user's shell sounds like a good idea.
