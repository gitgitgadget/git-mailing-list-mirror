Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7079E1F407
	for <e@80x24.org>; Sun, 10 Dec 2017 12:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbdLJMWm (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 07:22:42 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:25750 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbdLJMWk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 07:22:40 -0500
Received: from [192.168.2.201] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id O0cue8ErHmITaO0cuei504; Sun, 10 Dec 2017 12:22:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1512908558;
        bh=BC/uOQ72TYuug0Q1Huydu2fthVRYi71bKYiXoeMRRqE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nZvRCXHPunKdbVAORcUEYHCob4VMWGeT/P1xJEIH76ZSDQSUNxYqXXQU0gw7cSMw9
         iDRo/VzACZl7Y/WD0hcqtkRdZiQHqRdT4ySfEYCvemXbbPFHJ99Asa0Q2nso0AgfJx
         l06QAaaBNtx8rjc+LYzpxl5LWj4L+sR48dPjEa7I=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=nN7BH9HXAAAA:8 a=ZgNugiVed41o-w91cMEA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way
 merge,noworking tree file changes)
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Alexei Lozovsky <a.lozovsky@gmail.com>
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
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <82da4317-6b50-f60d-6d8f-50fc47579c56@talktalk.net>
Date:   Sun, 10 Dec 2017 12:22:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <da74fb2c-c452-4716-91d2-182f945b4254@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD4NuXPOjvDkp+W1jjrn9B8ZscrYcxtzFPEd4U0kQnm7q7+0uvSN95KSY/7RcfcCRXIt8Z/ifFogDv4fdKYbRRkQ/4MQ+FRs3NTrYPrQPcXj3bvoas8Y
 7TjZjW73KwOYJlVFeP82bwN+z+R6vlAUGGei/05RbcDU9WAqBFOwTfta7E75EulB0knyYJTjfdSJ+0TOI2Z/hUmVUr50TyQHvKXqcw84xD1rWb1RRQNHJgb7
 EQg4jduY6U2jJC+p5ZXQ6xQf06Y+WhZlzcz+WANPqvTzKLTvWKGwT9AfAkHREGcK9DJhL4jpdkT9aRMfaRtzCd8CNAeZ9o7OKG8rAJxzlmy7QhssOds6rTb2
 sJrhDnTYTJr8qUEWuJy56VDMXm28epkcSihvbAC5hVY/kv4e50N4tDAOF4NGsOkZ5hn9M9jLxsP9b8aaxw1+mMtoHBO6OCypYZQDzVFcLhoDmvIffVUnRsEg
 4WVhB+PWCN1TjoWPOBzdgfyxWo/XZ33Un/wkIg2yBoNDGHcbP4l8NyMyZoFqWpB58vUucU5f2adCehFaupLSlbcc7gZEEnmvR3Pk5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/17 01:20, Igor Djordjevic wrote:
> 
> Hi Philip,
> 
> On 09/12/2017 20:01, Phillip Wood wrote:
>>
>>> But thanks for clarifying, anyway, it does feel like `git rebase
>>> -i --autosquash` could be smarter in this regards, if `git rebase 
>>> --onto` does it better...?
>>
>> Creating the fixup directly on A rather than on top of B avoids the 
>> conflicting merge B f!A A. Creating the fixup on top of B and then
>> using git commit --onto A would suffer from the same conflicts as
>> rebase does.
> 
> I`m a bit confused here, as you`re replying to the part where we 
> strictly discussed `rebase --autosquash` versus `rebase --onto`, 
> having the latter succeed where the former fails

Sorry I should have been clearer. The point I was somewhat obliquely
making was that 'rebase --onto' succeeds where 'rebase --autosquash'
fails not because it is smarter but because it is doing something
different. Specifically it avoids the conflicting merge to create A' as
the user has already created that commit in the temporary branch


> - but you`re 
> mentioning `git _commit_ --onto` instead, comparing it with `rebase`... 
> and which one of the two ("--autosquash", I assume)?

Yes because in an earlier message you said

> If you mind enough to be bothered testing it out, might be even
> existing/initial state of originally proposed `git commit
> --onto-parent` script would work for you, as it does incorporate some
> trivial three-way merge resolution.
>
> In your starting situation:
>
>     ---A---B
>
> .... you would just do something like:
>
>     git commit --onto-parent A
>
> .... hopefully ending up in the desired state (hopefully = conflicts
> automatically resolved):
>
>     ---A---C---B'

and I was pointing out that this would involve performing the same merge
as 'rebase --autosquash' which has conflicts

> 
> Even further, while I do seem to understand (and agree with) what 
> you`re talking about with `commit --onto` and `rebase --autosquah` 
> suffering from the same conflicts in attempt to take f!A, originally 
> created on top of B, and apply it on top of A - the thing is that 
> Alexei actually pointed to B being the problematic one, failing to 
> rebase on top of already (successfully) autosquashed A' (where A' = A 
> + f!A, fixup applied through --autosquash), while it doesn`t fail 
> rebasing --onto f!A when f!A is being committed on top of A directly 
> (and not through --autosquash).

I understood Alexei to mean that it was merging the f!A into A that
caused conflicts due to the fact that f!A has conflicting context that
was introduced in B. After all B' the rebased B is merge A A' B whether
it is created by 'rebase --autosquash' or 'rebase --onto'. A' must be
the same in both cases or one is applying a different fix.

I've found conflicts arising from moving fixups can be quite common, so
these days I tend to edit the commit to be fixed up directly. I have a
script git-amend that does something like

target=$(git rev-parse --verify "$1") && GIT_SEQUENCE_EDITOR="sed -i
s/^pick $target/edit $target/" rebase -ik $target^

so I can just type 'git amend <commit>' to make this easier

> 
> In that (very?) specific case, proposed `git commit --onto-parent`[1] 
> doesn`t suffer from this, as once f!A is successfully applied onto A 
> (either squashed in with --amend, or on top of it), we take original 
> f!A _snapshot_ (not patch!) made on top of B, and just "declare" it 
> B` (being equal to B + f!A, which we already know, and being 
> correct), without a need to (try to) apply B patch on top of fixed-up 
> A to create B', as `rebase` does (and fails).

Ah I understand, but that only works when you're fixing up HEAD~1. If
you had A-B-C-f!A you have to recreate B with a merge.

> 
>> I don't think there is any way for 'git rebase --autosquash' to
>> avoid the conflicts unless it used a special fixup merge strategy
>> that somehow took advantage of the DAG to resolve the conflicts by
>> realizing they come from a later commit. However I don't think that
>> could be implemented reliably as sometimes one wants those
>> conflicting lines from the later commit to be moved to the earlier
>> commit with the fixup.
> 
> I think I agree on this part being tricky (if possible at all), but I 
> also think this is not what Alexei was complaining about, nor what we 
> were discussing (as I tried to explain above) - but please do correct 
> me if I misunderstood you.

No, I don't think Alexei was complaining about that directly, but if
such a solution existed he (and everyone else) wouldn't have to bother
with the --onto approach in the case where merging the fixup creates
conflicts.

Best Wishes


Phillip

> 
> That said, and what I mentioned already, we might really benefit from 
> simple test case(s), showing "rebase --autosquash" failing where 
> "rebase --onto" works, as Alexei explained, giving some more (and 
> firm) context to the discussion.
>
> 
> I *think* I`ve experienced this in the past myself, but now I can`t 
> seem to wrap my head around a reproducible example just yet... :$
> 
> Regards, Buga
> 
> [1] https://public-inbox.org/git/4a92e34c-d713-25d3-e1ac-100525011d3f@talktalk.net/T/#m72f45ad7a8f1c733266a875bca087ee82cc781e7
> 

