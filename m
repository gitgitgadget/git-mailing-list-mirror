Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B98551F404
	for <e@80x24.org>; Sat, 17 Mar 2018 03:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeCQDEu (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 23:04:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40659 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbeCQDEt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 23:04:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id t6so6292456wmt.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 20:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ufn6CiL8KJg5lc8p9wokGyTAXRt2NFd/zfT5JnD3nls=;
        b=quPjWodFMXBjKdvRx6HnHlzjV4+Bs8EktPmP31Po1G1U4Wo8C6xlY63mxoXaMVtC+F
         XxppDZjvef08fSI6YvTvQyn0IjxjF3bIW/iBWfxJKtDSRMyALQ3BUGyWY5YGJeluJ/oA
         XpubfkNXT5JGfuiaGJsY3K/uuc5yEOMKJuuW2xqkEaoHf+nikJ5swqfTDDxvIr/I9OU9
         aLSZc1V4ZUYsMaKDLgbiXU59oxG0xLcBx7hI9FcoI6KYqlPrMw7KTlPuB+RtEETu7Zky
         Yqf30ngWW4ziw5KyFNPtaaIoS1P1hCt6kpQ/8b9GVAWLm9cElEUZnyOedtebRgKMLgNe
         W0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ufn6CiL8KJg5lc8p9wokGyTAXRt2NFd/zfT5JnD3nls=;
        b=EqnUQbxE0AdYNRv7hKHYSJJTOJL1V+Sf8L1Ub2+NnabBdB1Rn4NB7DluiEjykqF1TZ
         ZEQ3j8h11Lw8ojGrcBbSW8NT28rWvD0Np1LMUG6liaJ0HwhgHRB4e3scyZDGSxxQ9a7j
         g31K2/uQSc7QHCEHcKhMpGiCl7wfRdHLFSrzt7QUcy2AD8IADyZiIQhhX/08EGIQgUr+
         IhBVTmP+ncc9R/7fBQ9ItSisEH8QXiHVDPPq9pONIzKS9e5Nx1T4JYlvU2ILIuMC6vuz
         LRV1yGjT5HV8At75FeA+r7bbQLkEXUtO6MlmoQC+UL8bwx41E71pSz0wG/CQZesSpffd
         RIPQ==
X-Gm-Message-State: AElRT7H0YIU4KiLXmYw23KruC3dBhW4cpD2o9Dysi+eY7K8bNbDL18h9
        K+6plWrLhfUc8Zx7dXqE76c=
X-Google-Smtp-Source: AG47ELuWR3fD0eihIEszPxXbLTN1flTH6bVukRskg/eAzxg49/+aQ7761qjCLGuRhgJO2q94nJfrnA==
X-Received: by 10.28.85.193 with SMTP id j184mr3153404wmb.109.1521255888084;
        Fri, 16 Mar 2018 20:04:48 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id c24sm1261210wmi.37.2018.03.16.20.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 20:04:47 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
 <877eqgardi.fsf@javad.com> <3f2209e0-c560-5384-c589-3aa83615d688@gmail.com>
 <87efkn6s1h.fsf@javad.com> <de063fba-2882-6194-a889-ad3e9b6b02b9@gmail.com>
 <87lget7p2g.fsf@javad.com> <3dbf86bc-cae9-8d6c-a206-cac685938f3d@gmail.com>
 <87vadw3297.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <095bbfe2-e095-a4b6-d337-740553acd9ec@gmail.com>
Date:   Sat, 17 Mar 2018 04:04:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87vadw3297.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 16/03/2018 08:31, Sergey Organov wrote:
> 
> > > As I said, putting myself on the user side, I'd prefer entirely
> > > separate first step of the algorithm, exactly as written, with
> > > its own conflict resolution, all running entirely the same way as
> > > it does with non-merge commits. I'm used to it and don't want to
> > > learn something new without necessity. I.e., I'd prefer to
> > > actually see it in two separate stages, like this:
> > >
> > > Rebasing mainline of the merge...
> > > [.. possible conflicts resolution ..]
> > > Merging in changes to side branch(es)...
> > > [.. possible conflicts resolution ..]
> > >
> > > And if the second stage gives non-trivial conflicts, I'd like to
> > > have a simple way to just do "merge -s ours <heads>" on top of
> > > already rebased mainline of the merge and go with it. Note that
> > > the latter is significantly different than re-merging everything
> > > from scratch, that would be the only choice with "all-in-one"
> > > approach, and it essentially gives me back those simple "rebase
> > > first parent and just record other parents" semantics when
> > > needed.
> > 
> > [...]
> > 
> > Also note that, for example, in case side branch(es) dropped some 
> > commits (interactively or otherwise), first step alone would still 
> > reintroduce those dropped changes, thus later possible `merge -s ours 
> > <heads>` would be a pretty bad "evil merge" case and a wrong thing to 
> > do in general.
> 
> Except that my presumption is that the second step has been run already
> and has stopped due to conflicts, so I see the conflicting result of
> dropping those commits on side branch(es), check the previous state of
> the right side of the conflicting merge, and decide those state, being
> the result of the fist step after possibly demanding conflicts
> resolution, is fine after all. Thus I just re-merge -x ours the
> branch(es), instead of re-merging everythig from scratch only to finally
> get back to the same result, be it evil or not, the hard way.

Might be my comment missed the point here, it should have been more 
about what you said regarding "first step having its own conflict 
resolution" - in case of dropped commits on side branch(es), you would 
be trying to resolve conflicts using one tree that doesn`t/shouldn`t 
even exist anymore (rebased merge commit first parent changes), which 
might be pretty confusing, only to find the "second stage" later 
removing changes that you might have actually picked as "first stage" 
conflict resolution, making it all even worse.

Only once "huge merge" is done completely (meaning all steps involved 
in merge commit rebasing), user can have a more realistic overview of 
(possibly nested, even) conflicts to resolve (and knowing his resolution 
will actually stick).

Regarding `merge -s ours <heads>` you mention, as you say it would 
happen only after "huge merge" is complete (with possible conflicts), 
I guess it`s unrelated to having "merge commit rebasing" happen in 
one go ("huge merge"), or iteratively, in stages (from user`s 
perspective, unrelated to underlying implementation)...?

Thus I`m questioning use-case for step-by-step merge commit rebasing 
where each stage has its own conflict resolution, in the face of it 
possibly being more confusing than helpful.

Otherwise, I see the point in what you would like to accomplish with 
that `merge -s ours <heads>` (not from scratch), but I`m not sure 
what would be the most sane way to allow it, and if it would be worth 
it in the first place, seeming to be a pretty exotic use case.

Regards, Buga
