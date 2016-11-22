Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 528DC1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933068AbcKVR0L (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:26:11 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34084 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932642AbcKVR0K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:26:10 -0500
Received: by mail-qk0-f169.google.com with SMTP id q130so34970448qke.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 09:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NadCXBWcb26oZ84iN/LE1h6lZneMDORoVz1iBqE+EMY=;
        b=gfEyDmUcsnb3+dg3wRHP629w4OpFd7uzWQ+/+AGpiam90GCocU2sbD+UfAOM6MkNBd
         sehtAzu8S32O78OmSM3euzhP+a3UB/V4kLSfQ6VJczQm9gsEDvl+LDeziUR4Oz+Pq9qn
         NDTWaI8mr9uhjSpOPQP+b6i+p4mJfgQxgrZvRGxIGnne7K+lMBMkdlM1jrkJEojyaROJ
         gKPLyFiS5Nm3cvf9sFBG1pRJq4yYXZregbn3pYDKIgiczgPlHJcXyeca5zyYYLp35q2x
         6pD1uDA5NxpjqguiiPbdM7TCQEyWlitDQbDe6cNbQskHeH8cDwbBiB14cktf2cvsnIan
         ztow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NadCXBWcb26oZ84iN/LE1h6lZneMDORoVz1iBqE+EMY=;
        b=JNtJxKbEBdvAS5HxYRnmyQYZ/drMa3eBhfPGEG5UfOwpP09yLhqacjLSt3yI3CEql5
         ok+Q5gpP3+JViZlu+fxEHDzRte9Z76r3f1alBZhupKvfkZyx5sDDPFI8JVeObTBczQco
         N5sC72pI20k6e30l3OA1B0jl7TyQRqLSKmDf7TrQPQ14HMI4usVfl6FbI1Vnqile886T
         ZdkmM65CxLAaY5CO9E+0znj6oZzxJAUZI+r5C7ueud0WG39SS1CbnSVZW5eVdBen+NLk
         fVabucXkXinKD5/gBl7OG53mj6qB0e/PreP+bcaT4r9r9Ak07qnu06n5vIF2yQ/MuyFM
         pZeA==
X-Gm-Message-State: AKaTC03hyFUlEERuOBjYJOBCi85zlkhh4g0CvBUQeNsZFW05pMB2eS8e47ao3IgVK+U5NPKXhWhitADZRegs9daT
X-Received: by 10.55.186.3 with SMTP id k3mr26126225qkf.47.1479835567869; Tue,
 22 Nov 2016 09:26:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 22 Nov 2016 09:26:07 -0800 (PST)
In-Reply-To: <CACsJy8BXjYOza_1mPCJJw+Mk1zksLLJMBNKvbAk8+1-bdAGJMw@mail.gmail.com>
References: <20161110203428.30512-1-sbeller@google.com> <20161110203428.30512-32-sbeller@google.com>
 <CACsJy8BXjYOza_1mPCJJw+Mk1zksLLJMBNKvbAk8+1-bdAGJMw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Nov 2016 09:26:07 -0800
Message-ID: <CAGZ79kYm4LfXK=1j-ayLawt+BojnkyM4h2RLQ=kfpPgMQbdBag@mail.gmail.com>
Subject: Re: [PATCH 31/35] pathspec: allow querying for attributes
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 2:41 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Nov 11, 2016 at 3:34 AM, Stefan Beller <sbeller@google.com> wrote:
>> @@ -139,7 +140,8 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
>>                        PATHSPEC_LITERAL |
>>                        PATHSPEC_GLOB |
>>                        PATHSPEC_ICASE |
>> -                      PATHSPEC_EXCLUDE);
>> +                      PATHSPEC_EXCLUDE |
>> +                      PATHSPEC_ATTR);
>
> Hmm.. common_prefix_len() has always been a bit relaxing and can cover
> more than needed. It's for early pruning. Exact pathspec matching
> _will_ be done later anyway.
>
> Is that obvious?

Yes it is.
Not sure what your concern is, though.

Given the pathspec ":(attr:plumbing)Documentation/", the common_prefix_len
is still able to figure out that any match has a prefix of
strlen("Documentation/"),
no matter what attr stuff is involved, because the attr stuff is also
just reducing the
matching set.

Now if we have such a pathspec it is easier to claim common_prefix_len supports
attr as it is a correct thing to ignore the attrs completely, than to
rewrite the call to
common_prefix_len to be without attrs involved.

You *may* be able to improve it with knowledge of the attrs:
":(attr:internal-technical-api)Documentation/" may restrict the results to match
only "Documentation/technical/", but as you said, we don't have to be
exact here.

> I'm wondering if we need to add a line or two in the
> big comment code before this statement. I'm thinking it is and we
> probably don't need more comments...

Do I misunderstand the code completely here?

Thanks,
Stefan

> --
> Duy
