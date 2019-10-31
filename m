Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9011F454
	for <e@80x24.org>; Thu, 31 Oct 2019 20:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfJaUEF (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 16:04:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37313 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfJaUEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 16:04:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id q130so7143143wme.2
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 13:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Vpme1XVRK7sFiGrANLyPP+0iv/2Y369lAGi9hCZduE=;
        b=WtUto5NBi/rICNmi//Sy/MyASpFpvwe/wpHl7UITIq7N0LBF59XiKEUqh1b/3eEWqH
         GKauuh4ODXSrDNN1+yl6sSRlCNsxsy6dXAGSnoMUKYYQSl2ybvCkoBjy9xeouNOld5dT
         SZbxF9SuFltx2sbSyh8gk7EBHGcmNbGl6raMhpIzACLo2SN2x4kZjLjjZoE2zUrhWy7J
         7rc6fHP0nuXg+G4yU+AWhBm6nTSyDwT8GdnvGsycYkJSJeRwIZUot3xYM275fGaNrnmo
         YGEpVtNVK95bpGw7UR0sTP1VA4oUWHqF1JA6eVlX+Ozk4cEXnkAG1XRWQFdaJnFwGtus
         KCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8Vpme1XVRK7sFiGrANLyPP+0iv/2Y369lAGi9hCZduE=;
        b=WDy4IpXbpxee94PZSiZ34oIl1mTIhX+sJRuBJEa4GBdpnsqVhGIvHeDpLtwReAVAM/
         RBe8Qkx8PtzDnXmDHZUyNa+/mt+zLi3ng3nsnxYT1H8bCy9mKmqz76s/4/yYTEKbKzv+
         8r2BsEAsiPpEWs2Yv6cq4bkDbtW/bnIGCA5cvrgWjvr0M1NEXXS67n3axyjO5WSMqnA7
         jE5sXOa3Bz2ejKMmlgrT30hYU00GCrtv+Kw+Lqn5jfXRui4oDk7e2pdgHDJ75QPgZ9dU
         tifpV9dxPLYszYAcZ0qK7kUUNZPNcL9hc4rjQ71e3Z7BmhkMeCB8b7kTZa7ZEYPXrZJS
         EmhA==
X-Gm-Message-State: APjAAAVG18i1PkIPGA5wQ9+893GtrDA+/I5UZT/TAdPVbOSBFwOMxQzz
        8foQGlErmYPh7dh8jze2of40gtHcXdY=
X-Google-Smtp-Source: APXvYqxBDMbh6KRBYLNWiGzo3pYaJwGbVGpBYL4fO2o6b10gA1Umw/newHq/+2cRIxWxU5jgjLXJOg==
X-Received: by 2002:a05:600c:1150:: with SMTP id z16mr7115732wmz.153.1572552242822;
        Thu, 31 Oct 2019 13:04:02 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.gmail.com with ESMTPSA id z10sm4630469wrw.12.2019.10.31.13.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 13:04:01 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] xl command for visualizing recent history
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        Matthew DeVore <matvore@gmail.com>, matvore@comcast.net,
        jonathantanmy@google.com, jrnieder@gmail.com, steadmon@google.com
References: <20191029003023.122196-1-matvore@google.com>
 <20191031003929.GA22855@google.com>
 <nycvar.QRO.7.76.6.1910310851300.46@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b0169b2b-0d8a-ee27-d0f4-6c7a6df55b5d@gmail.com>
Date:   Thu, 31 Oct 2019 20:04:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910310851300.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On 31/10/2019 08:26, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 30 Oct 2019, Emily Shaffer wrote:
> 
>> On Mon, Oct 28, 2019 at 05:30:23PM -0700, Matthew DeVore wrote:
>>> From: Matthew DeVore <matvore@gmail.com>
>>> [...]
> 
> In addition, I would think that the introduction of ephemeral refs
> should deserve its own patch. Such ephemeral refs might come in handy
> for more things than just `xl` (or whatever better name we find).
> 
> The design of such ephemeral refs is thoroughly interesting, too.

I agree the ephemeral refs are interesting and could be really useful

> One very obvious question is whether you want these refs to be
> worktree-specific or not. I would tend to answer "yes" to that question.

If we go for a per-terminal namespace as you suggest below I'm not sure 
if we want/need them to be per worktree as well. I don't have a clear 
idea how I'd want to use ephemeral refs if I changed worktree but kept 
working in the same terminal.

> Further, another obvious question is what to do with those refs after a
> while. They are _clearly_ intended to be ephemeral, i.e. they should
> just vanish after a reasonably short time. Which raises the question:
> what is "reasonably short" in this context? We would probably want to
> come up with a good default and then offer a config setting to change
> it.

Maybe keep them around for a couple of days? Even that might be longer 
than we need.

> Another important aspect is the naming. The naming schema you chose
> (`h/<counter>`) is short-and-sweet, and might very well be in use
> already, for totally different purposes. It would be a really good idea
> to open that schema to allow for avoiding clashes with already-existing
> refs.
> 
> A better alternative might be to choose a naming schema that cannot
> clash with existing refs because it would not make for valid ref names.
> I had a look at the ref name validation, and `^<counter>` might be a
> better naming schema to begin with: `^1` is not a valid ref name, for
> example.

That's an interesting idea, it's short and wont tread on anyone's toes.

> Side note: why `h/`? I really tried to think about possible motivations
> and came up empty.
> 
> Another aspect that I think should be considered: why limit these
> ephemeral refs to `git xl`? I cannot count how often I look through
> some `git log <complicated-options> -- <sophisticated-magic-refspecs>`
> to find a certain commit and then need to reference it. I usually move
> my hand to move the mouse pointer and double click, then Shift-Insert
> (which is awkward on this here keyboard because Insert is Fn+Delete, so
> I cannot do that with one hand), and I usually wish for some better way.
> 
> A better way might be to introduce an option for generating and
> displaying such ephemeral refs, in my case it would be good to have a
> config setting to do that automatically for every `git log` call that
> uses the pager, i.e. is interactive.

Having them as a feature of the rev listing machinery rather than 
specific to a particular command sounds like a good way to go.

> Finally, I could imagine that in this context, we would love to have
> refs that are purely intended for interactive use, and therefore it
> would make sense to try to bind them to the process ID of the process
> calling `git`, i.e. the interactive shell. That way, when I have two
> terminal windows, they would "own" their separate ephemeral refs.

I like that idea, though I think it should probably be based around 
getsid() rather than getppid() (I'm not sure how that translates to windows)


Best Wishes

Phillip

>>> The test cases show non-trivial output which can be used to get an idea
>>> for what the command is good for, though it doesn't capture the
>>> coloring.
>>>
>>> The primary goals of this command are:
>>>
>>>   a) deduce what the user wants to see based on what they haven't pushed
>>>      upstream yet
>>>   b) show the active branches spatially rather than as a linear list (as
>>>      in "git branch")
>>>   c) allow the user to easily refer to commits that appeared in the
>>>      output
>>>
>>> I considered making the h/# tags stable across invocations such that a
>>> particular hash will only be tagged with a different number if ~100
>>> other hashes are tagged since the hash was last tagged. I didn't
>>> actually implement it this way, instead opting for always re-numbering
>>> the hashes on each invocation. This means the hash number is
>>> predictable based on the position the hash appears in the output, which
>>> is probably better that encouraging users to memorize hash numbers (or
>>> use them in scripts!).
>>
>> If you're worried about folks using something like this in a script (and
>> I would be, given that it's dynamically assigning nicknames to hashes)
>> then you probably ought to mark it as a porcelain command in
>> command-list.txt.
> 
> I would like to caution against targeting scripts with this. It is too
> easy for two concurrently running scripts to stumble over each other.
> 
> Scripts should use safer methods that already exist, like grabbing the
> hash while looking for a specific pattern (`sed`'s hold space comes to
> mind).
> 
> Ciao,
> Dscho
> 
