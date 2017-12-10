Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB901F406
	for <e@80x24.org>; Sun, 10 Dec 2017 01:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbdLJBUW (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 20:20:22 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46920 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdLJBUV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 20:20:21 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so8718341wme.5
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 17:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UHW8Tfm40YbexXnnz2d88+JUsWdfkG4escI9wwMEYiE=;
        b=huEupUPsuaXe2YHLaroKlPg0l3mO1FkQEj6zYrQGvDvYiYSpintJsgAURu08qaapa4
         J2Sg5kZMEt5x945elmDJFZeBQC3z70NXoUYFKyZbFZ66j3J+GR7nvlGeVHEL7d8Za0zP
         eOStnDOiYb0nHnE70Jvm8Av1OPiANq4QwDe/fH/4D5g8uxGO6rKz76uHqStY0fD8U84S
         oFYy77zzviRMxQ+nLdFEXp377kWKLjIt8BCHkA7QVRpBkpQElpG+qviXmGPtMO5E6lyk
         jfgkryh0QuxLhOHk809MhIauI57g+1r8WQf3di+h0I1e6j4EIgd5dfWGKtEWAj5GDw8r
         tzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UHW8Tfm40YbexXnnz2d88+JUsWdfkG4escI9wwMEYiE=;
        b=It4ccA487ZVsm59OKR11ua7/5e968o8utl5bWtBKHsaZmFLzjSQSYnWdY+NnmPP3Ft
         9FTT6H+K1fpyLenQseFw+QDecJByLzxlnWxSJeMNEJGqDBUYXdBVqj7KKtR1e6snO26t
         m9fJ6wdD0Vx0fLiLCd0kKEVhX/DpYRFib2FZdkROsUir+YxsUATNGqQaMNublBgulum7
         dS6VerDjN2oBPYOPWQrt5YSPdcBg674XoH3g3EsAC3tXqcr7YfD2rcCGYcsFPxeG75wN
         mhsVu8tB5LgbrB+nbkSRFrPQiTA7eaItklnqUDEzmUGDsi1jfRlJzLKmGHKF9jLC1VTR
         98WA==
X-Gm-Message-State: AKGB3mJmteMnISbBpvYJ5fIQy8Gnb9/9Qc5YtqT54G3Om/n4OIMQFIk5
        h4TzSSTee62qFdF9oqH3ifA=
X-Google-Smtp-Source: AGs4zMavYX981RDlevu9O0jkQV9vX02E0COhurRQhugfbe0420ZOAz9LXzZH+gn91ujNHN/+h/UYWQ==
X-Received: by 10.28.66.11 with SMTP id p11mr7715426wma.114.1512868820380;
        Sat, 09 Dec 2017 17:20:20 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id j125sm5805074wmd.24.2017.12.09.17.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Dec 2017 17:20:19 -0800 (PST)
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge,
 noworking tree file changes)
To:     phillip.wood@dunelm.org.uk, Alexei Lozovsky <a.lozovsky@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
 <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
 <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
 <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
 <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org>
 <7ae3ffd5-147d-55d2-9630-da12c429d631@gmail.com>
 <39323748-282c-5881-2bfa-de622bb8b765@kdbg.org>
 <CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com>
 <f9a94a62-9541-e019-8ab3-9fc9cfe2c43f@gmail.com>
 <xmqqo9n99ohc.fsf@gitster.mtv.corp.google.com>
 <a3510c14-23e9-d1d9-0847-b60451f8e15d@gmail.com>
 <D842B04A-9331-4F26-8F19-B61F6F13FC79@gmail.com>
 <92643df4-f54e-cd31-da4a-138ec314655a@gmail.com>
 <4a92e34c-d713-25d3-e1ac-100525011d3f@talktalk.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <da74fb2c-c452-4716-91d2-182f945b4254@gmail.com>
Date:   Sun, 10 Dec 2017 02:20:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <4a92e34c-d713-25d3-e1ac-100525011d3f@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On 09/12/2017 20:01, Phillip Wood wrote:
> 
> > But thanks for clarifying, anyway, it does feel like `git rebase
> > -i --autosquash` could be smarter in this regards, if `git rebase 
> > --onto` does it better...?
> 
> Creating the fixup directly on A rather than on top of B avoids the 
> conflicting merge B f!A A. Creating the fixup on top of B and then
> using git commit --onto A would suffer from the same conflicts as
> rebase does.

I`m a bit confused here, as you`re replying to the part where we 
strictly discussed `rebase --autosquash` versus `rebase --onto`, 
having the latter succeed where the former fails - but you`re 
mentioning `git _commit_ --onto` instead, comparing it with `rebase`... 
and which one of the two ("--autosquash", I assume)?

Even further, while I do seem to understand (and agree with) what 
you`re talking about with `commit --onto` and `rebase --autosquah` 
suffering from the same conflicts in attempt to take f!A, originally 
created on top of B, and apply it on top of A - the thing is that 
Alexei actually pointed to B being the problematic one, failing to 
rebase on top of already (successfully) autosquashed A' (where A' = A 
+ f!A, fixup applied through --autosquash), while it doesn`t fail 
rebasing --onto f!A when f!A is being committed on top of A directly 
(and not through --autosquash).

In that (very?) specific case, proposed `git commit --onto-parent`[1] 
doesn`t suffer from this, as once f!A is successfully applied onto A 
(either squashed in with --amend, or on top of it), we take original 
f!A _snapshot_ (not patch!) made on top of B, and just "declare" it 
B` (being equal to B + f!A, which we already know, and being 
correct), without a need to (try to) apply B patch on top of fixed-up 
A to create B', as `rebase` does (and fails).

> I don't think there is any way for 'git rebase --autosquash' to
> avoid the conflicts unless it used a special fixup merge strategy
> that somehow took advantage of the DAG to resolve the conflicts by
> realizing they come from a later commit. However I don't think that
> could be implemented reliably as sometimes one wants those
> conflicting lines from the later commit to be moved to the earlier
> commit with the fixup.

I think I agree on this part being tricky (if possible at all), but I 
also think this is not what Alexei was complaining about, nor what we 
were discussing (as I tried to explain above) - but please do correct 
me if I misunderstood you.

That said, and what I mentioned already, we might really benefit from 
simple test case(s), showing "rebase --autosquash" failing where 
"rebase --onto" works, as Alexei explained, giving some more (and 
firm) context to the discussion.

I *think* I`ve experienced this in the past myself, but now I can`t 
seem to wrap my head around a reproducible example just yet... :$

Regards, Buga

[1] https://public-inbox.org/git/4a92e34c-d713-25d3-e1ac-100525011d3f@talktalk.net/T/#m72f45ad7a8f1c733266a875bca087ee82cc781e7
