Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2666B2055B
	for <e@80x24.org>; Mon, 23 Oct 2017 18:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbdJWSfm (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 14:35:42 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:43819 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbdJWSfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 14:35:42 -0400
Received: by mail-yw0-f173.google.com with SMTP id y75so12921645ywg.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HD2BIRD1FT3ZhgFmFQFAltHrDFC3cPjWaHUQ9wVyY94=;
        b=qVof/uPE/OzlumZ8N6QZ4uQQ3Ajp1MRR3R2PY8x5c+HzkW+N2gVFgw5qJ9IRrCdFaV
         Yo3cIMx2/MsStrPEaM9XO1qsd6oqjYnJoG5nsIxOm9smX17RWP4knM5iSijYLXV/sg39
         9kD7q18H9C/IY3GsUwoqfnreeMKL+p/NPIsJiYC6ObkWZfw47E9Wob9mTyP4n8H/yGOC
         tP9HVs7aSeZ160f1DsQ3KiRkMKDmb0zoHSS2l4JXPbjR+OMpjTeKFv0+3k5ZcXLyfp0b
         O1VaYYPjH8Bt9Cnkx1qGxWbGOzLwPkMVz1NFDjAMdVhyJH/Up1dIzOI1zU6GGybjzIlN
         /Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HD2BIRD1FT3ZhgFmFQFAltHrDFC3cPjWaHUQ9wVyY94=;
        b=RhRq0g3iJ9BjF8J3AaPFzLiMTZh90dzXbj2GEUIR6gNWV/gnx+O8r1vqcoyxrhxEJO
         6AwZXXb0KHutdFS3X6q55agEpOrUkdoHa8CouwVnhkPdj1xMZRBgv7twPQwh8C7rVpV6
         S8OCoFpkXvao89SJTuiRT8a0FlJi7QjS2ibc0BO9E6z1ufnLirZu/a1phV1s1x2nuIfE
         uXUdHGBPyt+CEw0qyJz0QnJothJarGbgry0PADZO9Zy7/K152vchvJlp3K6kJMihpY7T
         LlQ+ocaVMC1d8ZFkWXNLxpH6BwpoqaJiRpbXwZrb/lvaaupV9LZFxIJe0Bpz69M3bOko
         u+Ug==
X-Gm-Message-State: AMCzsaWLYF9Eysm9cwCZSduuDVIaaqDFzwh5GjoXDJAWOmMXNHupFxQP
        OiFq4jeyqgRP+AZunsZi2r7gcgv3TdQFICyvDtE=
X-Google-Smtp-Source: ABhQp+RfxnaLEcraNkjpntDHjwBTplQEoaSKarfq099jnnZu0Qmkd1U5JKFEnNHpdmM8T47cFDDgszFdyIPCZDPUNWs=
X-Received: by 10.37.110.214 with SMTP id j205mr6026969ybc.65.1508783741340;
 Mon, 23 Oct 2017 11:35:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.19.3 with HTTP; Mon, 23 Oct 2017 11:35:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710231308200.6482@virtualbox>
References: <20170528165642.14699-1-joel@teichroeb.net> <alpine.DEB.2.21.1.1710231308200.6482@virtualbox>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Mon, 23 Oct 2017 11:35:20 -0700
X-Google-Sender-Auth: -I9ltjUVpbZ2nLkkyFEKRJSEzKk
Message-ID: <CA+CzEk8RrE0AiaaNxmyio=FO+noR_qRLOgzUotJSdqOpJn4Q3Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Implement git stash as a builtin command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

I fixed all the tests at that time, but another one was added that I
could not figure out how to fix. I was planning to break the commit up
into smaller parts and only convert one stash command at a time
calling them still from the shell script. I haven't had time to do
that yet though.

My latest change is here:
https://github.com/klusark/git/tree/rfc-c-stash

The test commits have already been merged, so just the last two are
needed. I haven't been keeping history of my changes, although I have
sent it to the mailing list around 4 times.

Joel

On Mon, Oct 23, 2017 at 4:09 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Joel,
>
> On Sun, 28 May 2017, Joel Teichroeb wrote:
>
>> I've rewritten git stash as a builtin c command. All tests pass,
>> and I've added two new tests. Test coverage is around 95% with the
>> only things missing coverage being error handlers.
>
> I am embarrassed to say that I never found the time to have a detailed
> look at this, and it has been 5 months since you sent this. Sorry about
> that.
>
> Do you have an easy-to-fetch branch with this somewhere?
>
> Thanks,
> Dscho
