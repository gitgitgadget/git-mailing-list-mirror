Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFDB41F407
	for <e@80x24.org>; Sun, 10 Dec 2017 23:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbdLJXRo (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 18:17:44 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35111 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdLJXRm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 18:17:42 -0500
Received: by mail-wm0-f66.google.com with SMTP id f9so11177365wmh.0
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 15:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Og8PaQcYZTLfhyYqyMmdnL+1FA6lHxm37P/G+L47oe4=;
        b=imnKugpmuSPiJgzrSKy5RjtjvdKNgZMN8JgMJgF3OJPsfG8Xg0Edj1tg1n1cs+roRO
         74FAfnsPhgHvqANgPehKZwv66BgIS0mJ1BncxY/eNjWK5SbIO9g9yAdwkxX+6G7dVcTh
         hyqk6fyiuM/6qr2184i5+G1KGaKmbJU8ry30dwZ32FO7mzb8QuIHQV4AKoCl0iv3LY/f
         snX3e4SC20nTq3g6F2BB1kNuR3gvAB4CfT5PjjVCcCXIR+WrWUaHjvqI56yMESrJTHzm
         MS6MUtwuA0IeIzlxdQuphpdTDp4LMvUrtPZOiGlloMtjF1mgaXqkRtJYVrXH/lvkNfDo
         KpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Og8PaQcYZTLfhyYqyMmdnL+1FA6lHxm37P/G+L47oe4=;
        b=DpatBe4KDWoVkPvM5EETNbLICM1I/GAKdDgPIg7SbDf9n+8/A7zqhps2RRBuBH7F8j
         Af/u0svvwtTRjUEhkhm0FCoTjLZpmRav42gOfJRDwX6Fsy6DrT37mdJ/Q/T2bLQ/R0g4
         J3RZqO3fLxhQT7l8pnGVi338pR+YqRdDDTWxqu766ESpXPx41lfDIKtCbzY4UUkzS/NO
         30N2w+VaPbDpXi6gS3c+eIsMJpyxT4a6LEAjMPdZHG8SmhacYRzroquyXX0m1W70SyCr
         O9zj8+SZWGJPrtTAODz/D5dYiK2422Wcrihp0Dv31ysgA1+hNXGAEIXe4yeUNKr/a1S+
         JHBA==
X-Gm-Message-State: AKGB3mKzEJxw7LVBQpH09oWogf4q1Gl5pc2St3y7iAL+heyjS1f1f8IB
        2R6GulyiKo1kkzODPtAZXP8=
X-Google-Smtp-Source: AGs4zMbSFzsX+LXVK6UEkuJSA1e2rVuHBdS/CexwcmPUtBGPjKILPJ8M5T+QX1YVUsVQPkKqefUlTA==
X-Received: by 10.28.120.19 with SMTP id t19mr9888728wmc.64.1512947861266;
        Sun, 10 Dec 2017 15:17:41 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id i65sm8573140wme.20.2017.12.10.15.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Dec 2017 15:17:40 -0800 (PST)
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way
 merge,noworking tree file changes)
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
 <da74fb2c-c452-4716-91d2-182f945b4254@gmail.com>
 <82da4317-6b50-f60d-6d8f-50fc47579c56@talktalk.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <36d2b05b-8b68-a157-99ed-44050ac34ab6@gmail.com>
Date:   Mon, 11 Dec 2017 00:17:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <82da4317-6b50-f60d-6d8f-50fc47579c56@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On 10/12/2017 13:22, Phillip Wood wrote:
> 
> Sorry I should have been clearer. The point I was somewhat obliquely 
> making was that 'rebase --onto' succeeds where 'rebase --autosquash' 
> fails not because it is smarter but because it is doing something 
> different. Specifically it avoids the conflicting merge to create A'
> as the user has already created that commit in the temporary branch

No problem, and thanks for clarifying, I understand and agree to all 
that with you. I was just pointing that it wasn`t something I was 
commenting to (nor specially interested in), because of what Alexei 
actually wrote - here`s his quote (emphasis mine):

  "And then I often find that "rebase -i --autosquash" _fails to apply
  the commit B_ because it expects slightly different context around
  the changed lines."

From there, it seemed pretty clear he perceived the failure not 
coming from creating A', but applying B on top of it, and that is 
what got my attention. But, read below...

> > - but you`re mentioning `git _commit_ --onto` instead, comparing it
> > with `rebase`... and which one of the two ("--autosquash", I
> > assume)?
> 
> Yes because in an earlier message you said
> 
> > If you mind enough to be bothered testing it out, might be even 
> > existing/initial state of originally proposed `git commit 
> > --onto-parent` script would work for you, as it does incorporate
> > some trivial three-way merge resolution.
> >
> > In your starting situation:
> >
> >     ---A---B
> >
> > .... you would just do something like:
> >
> >     git commit --onto-parent A
> >
> > .... hopefully ending up in the desired state (hopefully =
> > conflicts automatically resolved):
> >
> >     ---A---C---B'
> 
> and I was pointing out that this would involve performing the same
> merge as 'rebase --autosquash' which has conflicts

Yeah, what I assumed (and agreed to), thanks for confirmation. What 
made me a bit uncertain was that you left that part of my earlier 
message quoted _after_ your inline reply to it, thus making overall 
context a bit difficult to be exactly sure in :P

> I understood Alexei to mean that it was merging the f!A into A that 
> caused conflicts due to the fact that f!A has conflicting context
> that was introduced in B. After all B' the rebased B is merge A A' B
> whether it is created by 'rebase --autosquash' or 'rebase --onto'. A'
> must be the same in both cases or one is applying a different fix.

Yes, I understand and agree you might be right, what you are talking 
about being what he actually _meant_, but because that is not what he 
_wrote_, I wanted to see an example of it, (still?) hoping that he 
really did mean what he wrote (commit B being the problematic one), 
as then there would be a possibility for improvement.

And your analysis seems correct, and that`s what I was afraid of as 
well - but wasn`t really sure, especially as I seem to remember 
something similar from my own (humble) experience, thus leaving a 
possibility for an example to prove differently.

But if that is absolutely impossible, as you claim, like not even due 
to some commit squashing, some edge case, or something - and I don`t 
feel like I have enough knowledge/experience to judge that myself at 
the moment - then you have to be right, and what he wrote is really 
not what he meant... nor what I thought I remembered from my own past 
experience, either :/ Nor there is any chance for improvement here, 
unfortunately, I guess.

Still, I hope for that example...! :D

> I've found conflicts arising from moving fixups can be quite common,
> so these days I tend to edit the commit to be fixed up directly. I
> have a script git-amend that does something like
> 
> target=$(git rev-parse --verify "$1") && GIT_SEQUENCE_EDITOR="sed -i
> s/^pick $target/edit $target/" rebase -ik $target^
> 
> so I can just type 'git amend <commit>' to make this easier

This is useful, thanks. I have something like `git commit --amend 
<commit>` on my wish list for quite some time :) Still not getting to 
look into it, though.

> > In that (very?) specific case, proposed `git commit
> > --onto-parent`[1] doesn`t suffer from this, as once f!A is
> > successfully applied onto A (either squashed in with --amend, or on
> > top of it), we take original f!A _snapshot_ (not patch!) made on
> > top of B, and just "declare" it B` (being equal to B + f!A, which
> > we already know, and being correct), without a need to (try to)
> > apply B patch on top of fixed-up A to create B', as `rebase` does
> > (and fails).
> 
> Ah I understand, but that only works when you're fixing up HEAD~1.
> If you had A-B-C-f!A you have to recreate B with a merge.

Yes, and thus the notion of what he mentioned as being a "(very?) 
specific case" ;) That initial/draft version of "git commit 
--onto-parent" script I sent to the list[1] operates on the first 
parent commit only, indeed, though its main point/purpose had nothing 
to do with smarter merges, but just not touching the working tree 
while at it, if possible.

> > > I don't think there is any way for 'git rebase --autosquash' to 
> > > avoid the conflicts unless it used a special fixup merge
> > > strategy that somehow took advantage of the DAG to resolve the
> > > conflicts by realizing they come from a later commit. However I
> > > don't think that could be implemented reliably as sometimes one
> > > wants those conflicting lines from the later commit to be moved
> > > to the earlier commit with the fixup.
> >
> > I think I agree on this part being tricky (if possible at all), but
> > I also think this is not what Alexei was complaining about, nor
> > what we were discussing (as I tried to explain above) - but please
> > do correct me if I misunderstood you.
> 
> No, I don't think Alexei was complaining about that directly, but if 
> such a solution existed he (and everyone else) wouldn't have to
> bother with the --onto approach in the case where merging the fixup
> creates conflicts.

Yes, I think we understand each other now (unfortunately, I guess, as 
that also means there is nothing more to add to it, in terms of 
improving existing situation). Thank you for your thoughts :)

Regards, Buga

[1] https://public-inbox.org/git/4a92e34c-d713-25d3-e1ac-100525011d3f@talktalk.net/T/#m72f45ad7a8f1c733266a875bca087ee82cc781e7
