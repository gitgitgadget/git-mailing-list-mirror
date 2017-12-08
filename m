Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41B8A1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 23:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbdLHXyN (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 18:54:13 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37009 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753378AbdLHXyM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 18:54:12 -0500
Received: by mail-wr0-f195.google.com with SMTP id k61so12216165wrc.4
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 15:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+t5R7BLHX3MGt++hW7C+8eSyNKrJ8iTqhXjL7Mx7qU=;
        b=BdvIpt8XoeJpV4cpsfz7y0VKaldSqjv9vp+Tl84Dl7xrHq0GryDUSv2Siymp+XdWIc
         QsfM4h26pvFCLKC6hHPUUNnHvsi/AIAM5zIYMOc4OZqxrqPx7muUL9iTyP1KCnHycpSV
         fIK22QpAb65ZzYaBwIkJDQ+quo+JXRd+3vWAqq+dxUwZT7MeQhhIx5/7eL12zZbXetEL
         pUzSM0SsW5U9TTMBNdt8v3AlWnYlg8l2ltvWDti33Ad9rM28O5huzQinO2AmV7LZ6/Cc
         IOoff/LsfyYLTI4zJsHpIGkdupm/6YRwGysbiVjrFLZ7YicDLqRKggx9ZAoHmsdU+2Rw
         MB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+t5R7BLHX3MGt++hW7C+8eSyNKrJ8iTqhXjL7Mx7qU=;
        b=jhVTgdNBDPZaGdJjSfZpZH8HifUdOi/dYbFmGZnoEA9faznIpaDSFqz2J5LVHCFWMj
         UUHlEWUud08w33CAIgJimzHIup0SO46KXj9g2LuujEE96GCOoWopRtrl5kRaVSUaimFk
         vWgZd/XV8UE8GhMJXqAMgUmCCC+JLInIo8ynKU52OnYCaALT2Wbz6tXOb3WlQA9PsTlo
         7yBb1TJZJlMy3htC+9qXJXQWxeFOAoAaLmS8Ji7jDSiVewtuwNacXG8jhtuQhkYAR0B3
         r03rYudoldxjAfMtXum90wrGTTIpUGOOUqHrFZhYGoGBhZkyJgljSyg5SRiI8mV5mHG+
         5iBQ==
X-Gm-Message-State: AKGB3mKP3RM5VyYgNevpHPGuadi45w2UatDX/zE1TXM6zeKO+2tEo1iG
        tTftCxSJ3j/Tkm7x8qo+5Sc=
X-Google-Smtp-Source: AGs4zMYf1R9qRNufv/Di/fziE5YCRZ/IDzwhKsz/g13AAFu/SCb+mv0OFRchcEI3Ojvv0T/XpBHB1Q==
X-Received: by 10.223.180.69 with SMTP id v5mr14085808wrd.193.1512777251374;
        Fri, 08 Dec 2017 15:54:11 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id c2sm10350718wrg.57.2017.12.08.15.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2017 15:54:10 -0800 (PST)
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
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
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <a3510c14-23e9-d1d9-0847-b60451f8e15d@gmail.com>
Date:   Sat, 9 Dec 2017 00:54:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9n99ohc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/12/2017 17:24, Junio C Hamano wrote:
> 
> > To get back on track, and regarding what`s already been said,
> > would having something like this(1) feel useful?
> >
> > (1) git commit --onto <commit>
> 
> Are you asking me if _I_ find it useful?  It is not a very useful
> question to ask, as I've taken things that I do not find useful
> myself.

It was also (kind of shy and subtle) "would you take it?", indeed, 
but I do value your personal opinion here, too, being a recognized 
developer, and one really knowing the Git (mailing list) community on 
top of it, so I appreciate you addressed both sides of the question.

And it was partly addressed to Hannes, but more for a confirmation, I 
guess, him being the one to favor such a flow in the first place, 
over what I initially suggested.

> Having said that, I do not see me personally using it. You keep
> claiming that committing without ever materializing the exact state
> that is committed in the working tree is a good thing.
> 
> I do not subscribe to that view.  

No - and I find it an important difference to note - just that it 
might be acceptable / more preferable _in certain situations_, where 
the only alternative seems to be wasting (significant) amount of time 
on needless rebuilds of many files (just because of branch switching, 
otherwise untouched by the changes we`re interested in).

If this is perceived a too uncommon/exotic case to worth addressing 
is a different matter, though.

> I'd rather do a quick fix-up on top (which ensures that at least the
> fix-up works in the context of the tip), and then "rebase -i" to
> move it a more appropriate place in the history (during which I have
> a chance to ensure that the fix-up works in the context it is
> intended to apply to).

Chris reported in this very topic[1] that sometimes, due to conflicts 
with later commits, "checkout > commit > [checkout >] rebase --onto" 
is "much easier to do", where "commit --fixup > rebase -i" "breaks" 
(does not apply cleanly).

> I know that every time I say this, people who prefer to commit
> things that never existed in the working tree will say "but we'll
> test it later after we make these commit without having their state
> in the working tree".  But I also know better that "later" often do
> not come, ever, at least for people like me ;-).

No comment here ;)

> The amount of work _required_ to record the fix-up at its final
> resting place deeper in the history would be larger with "rebase -i"
> approach, simply because approaches like "commit --onto" and "git
> post" that throw a new commit deep in the history would not require
> ever materializing it in the working tree.  But because I care about
> what I am actually committing, and because I am just lazy as any
> other human (if not more), I'd prefer an apporach that _forces_ me
> to have a checkout of the exact state that I'd be committing.  That
> would prod me to actually looking at and testing the state after the
> change in the context it is meant to go.

All that I agree with, too.

But that said, I do find `git add --patch` invaluable (for example), 
where one can still opt to commit right away (and test later ;)), or 
do a proper `git stash push --keep-index` first in order to actually 
check/test the exact state/context before committing.

One of the biggest advantages I see in using Git is that it provides 
so many possibilities, where there is not necessarily a single 
"correct" way to do something - depending on the (sub)context, the 
decision on "_the_ correct" way can be deferred to the user himself.

Git (usually) does not judge, except in cases where something is 
considered "plain wrong" - still different than "might not be the 
best approach", but not necessarily a wrong one, either.

But I do realize it also means more chances for beginner users to 
shoot themselves in the foot, blaming it on Git, so even if just a 
matter of personal taste, a more restrictive preference from the Git 
maintainer is understandable :)

Regards, Buga

[1] https://public-inbox.org/git/CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com/T/#m989306ab9327e15f14027cfd74ae8c5bf487affb
