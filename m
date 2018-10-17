Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E689B1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 18:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeJRCQh (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 22:16:37 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:47006 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeJRCQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 22:16:36 -0400
Received: by mail-ua1-f53.google.com with SMTP id z8so5137345uap.13
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1lZIG3/TPnsLBJXbQEzY6lApwL2+13GiWHQ7StBtf4I=;
        b=e/+rxMeUUilkjGd8V/W9rnPJJjbnHlWXymOnvMsqQP85oRexC5HknjaaoP4mveDg4Y
         Vv1xmg5uNpi9n9WyKaVZ8OZS6IRFXxN3RDjQYzw1kKP6qKEeVTGCBOgznTwTBlAtamiv
         VC9R3AqFzbNruR6wq2mRJWDqT76gcV9A1I4o0m7Wuvjfs3WOiZq3LIc8BTxOq38rd4tZ
         OMyyaczRsMrvCppTOj1h93+MpHFLUaWl+Xf0kl06XeeYlWwRD6ufX11sqvoyIhXsaNwV
         MlqKWfheRWZ0BSiNqBhwDGhOb/8+3QAD5PH7/zSmseEzVrr1dGteMwDcBOALmYsa1dzj
         ZMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1lZIG3/TPnsLBJXbQEzY6lApwL2+13GiWHQ7StBtf4I=;
        b=jmJEFahPBYNIRs1KEncKI7kzjsszwCPSGhzJASllpCDTaQxl/FT59rC95XaC9i7V6a
         vb6yb+NKKYxIMyo+f96envTcD9ldS1o7cKJuNxR/f9Z3lkgZHJLeHiyCn6oEBKRfqTOL
         iN/J3j/totSrp7PxC4Q76pfgA7VbysondFcKLglT0asEsXQBaihNukUsIe9QJaKTSlBt
         42QiDVZ0rCr3NzN4f97Z1p44HlteEGTi8kHQb8xF4/QX3BcuUJcpsmsjRAFgq1ywmoRJ
         iIEG966chnN9GqDauGA4Nbm1EM7NfHqgGnGAjnpHsQo5UbPsnVKTX2tubAhWmUwmkd38
         Y0Vw==
X-Gm-Message-State: ABuFfojCA1fHKmMB+iFI8awqPNOEPrQF01cse29qwVsRRZPz/emBag6v
        A1fBKb1MVsFaRr4/9MRyy4UTU8FT
X-Google-Smtp-Source: ACcGV62kBPG4lbTnbfeusCZ/rvkisOKQ3+rSB4MHMM0EwSOMrQgY3mu3oijaLgvmZ+k/AE0jkYW4vw==
X-Received: by 2002:ab0:3381:: with SMTP id y1mr5517875uap.2.1539800382497;
        Wed, 17 Oct 2018 11:19:42 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c079:83d:1a9:9f46? ([2001:4898:8010:0:a9af:83d:1a9:9f46])
        by smtp.gmail.com with ESMTPSA id i128-v6sm3736556vkg.42.2018.10.17.11.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 11:19:41 -0700 (PDT)
Subject: Re: commit-graph is cool (overcoming add_missing_tags() perf issues)
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1d52a566-e7f5-9b7f-4bb1-cac5a50ebcb6@gmail.com>
Date:   Wed, 17 Oct 2018 14:19:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:63.0) Gecko/20100101
 Thunderbird/63.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/2018 2:00 PM, Elijah Newren wrote:
> Hi,
>
> Just wanted to give a shout-out for the commit-graph work and how
> impressive it is.  I had an internal report from a user that git
> pushes containing only one new tiny commit were taking over a minute
> (in a moderate size repo with good network connectivity). After
> digging for a while, I noticed three unusual things about the repo[1]:
>    * he had push.followTags set to true
>    * upstream repo had about 20k tags (despite only 55k commits)
>    * his repo had an additional 2.5k tags, but none of these were in
>      the history of the branches he was pushing and thus would not be
>      included in any pushes.
>
> Digging in, almost all the time was CPU-bound and spent in
> add_missing_tags()[2].  If I'm reading the code correctly, it appears
> that function loops over each tag, calling in_merge_bases_many() once
> per tag.  Thus, for his case, we were potentially walking all of
> history of the main branch 2.5k times.  That seemed rather suboptimal.

Thanks for the report. I made a note to inspect add_missing_tags() for 
more improvement in the future.

> Before attempting to optimize, I decided to try out the commit-graph
> with a version of git from pu.  While I expected a speed-up, I was a
> bit suprised that it was a factor of over 100; dropping the time for
> local dry-run push[2] to sub-second.  A quick look suggests that
> commit-graph doesn't fix the fact that we call in_merge_bases_many() N
> times from add_missing_tags() and thus likely need to do N merge base
> computations, it just makes each of the N much faster.  So, perhaps
> there's still another scaling issue we'll eventually need to address,
> but for now, I'm pretty excited about commit-graph.

Without the commit-graph, you are getting a quadratic problem (N commits 
* T tags), but with the commit-graph you are also getting the benefit of 
generation numbers, so the "N commits" is actually likely _zero_ for 
most tags, because the tags have strictly lower generation number. In 
those cases, we can terminate without any walk at all.

Thanks!
-Stolee

