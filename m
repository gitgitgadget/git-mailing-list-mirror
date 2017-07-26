Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B81C2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 14:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbdGZOhX (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 10:37:23 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:22449 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdGZOhV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 10:37:21 -0400
Received: from [192.168.2.240] ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id aNR8dJOTdQ527aNR8dcfsF; Wed, 26 Jul 2017 15:37:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501079839; bh=kF08pPLCgLyx6rh8SzR4nzvCWtZHSVAxImK83cBG2sI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VyK1b4WvituYPN+NUPF2QGFfYDqQxXGVqetUihZKSYKEQOzEJyDhiFYD/LHceF1NZ
         eOJmlHWVBsSZhUEJ6/Q7oLMhFD43dp+v6tnQ5a4NdWO/SUSRthbWsTlnUIN59K82Uc
         Eyv4aXyY2w/rByxunvZ3bE58RmRE1BoyaIfk85Ek=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=MI8io4Rl c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=5rxgeBVgAAAA:8 a=sGNl7xXa4WReAld_jdcA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH/RFC] rebase: make resolve message clearer for
 inexperienced users
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        William Duclot <william.duclot@gmail.com>, git@vger.kernel.org
References: <20170709202520.21739-1-william.duclot@gmail.com>
 <xmqqvan06yo8.fsf@gitster.mtv.corp.google.com> <20170710183101.GA13122@Haydn>
 <xmqq4luh1gzw.fsf@gitster.mtv.corp.google.com>
 <7E67FF115BB146A49D486E77404882F2@PhilipOakley>
 <fd665e9d-e46a-c9f1-f4ec-3407dd18ab36@talktalk.net>
 <xmqqmv7td0a5.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <96c186b0-84ca-d97f-d745-099a730745c8@talktalk.net>
Date:   Wed, 26 Jul 2017 15:37:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqmv7td0a5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMiTX/H/qPTzLLI20FJS+w8//Fp/Fc5PcThJzjN/vq2P/3VQ103MEsSb/VLmBSo5ql2+rfq7tCd4/UoLZM7jYfdZIQ+cdFoXLBWr38UWvvT1ay9RA+zg
 L5KwvsQmN3fw7mYBjg33WzosLv3coVVLKSaCLIs49tFoRst+UblVNSbyu135+cIZJJh3T8oNAWuzKGrsccEX96LfLqsKiw9brVVo/20+m7JNFs6PtkGpoYGa
 luOqsNtColkfZioa7NeDIqoW/RzpGP8NCWW/3AiPuPQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/07/17 21:53, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> git rebase --continue requiring one to git add first confuses/annoys me
>> too. I started a patch to autostage unstaged changes if they don't
>> contain conflict markers a couple of weeks ago, I'll clean it up and
>> post it later this week.
> 
> As long as "git rebase" will keep refusing to start in a working
> tree with dirty files and/or index, this could be a good change.
> 
> But people _may_ be annoyed because they expect "--continue" to
> remind them that some conflicts are not concluded with an explicit
> "git add", and they would even feel that you made the command unsafe
> if "--continue" just goes ahead by auto-adding their change that is
> still work-in-progress.  Lack of conflict markers is not a sign that
> a file is fully resolved (which they are used to signal by "git
> add", and they do so per set of paths).

Thanks for your comments, I've tried to address them in the message with 
the patches I sent earlier today [1]. In summary autostaging is opt-in 
and the conflict marker check isn't perfect but it's better than nothing 
and covers an important case where the user has simply overlooked a 
conflict.

>> I also find it confusing that it asks me to edit the commit message for
>> picks, fixups and non-final squashes after conflicts. I can see that
>> perhaps one might want to amend the message to reflect any changes that
>> were made while resolving the conflicts but I've never had too. I'd
>> rather be able to pass --edit to rebase --continue if I needed to edit
>> the message in those cases. Looking through the code I think it would
>> require saving some extra state when rebase bails out on conflicts so
>> rebase --continue could tell if it should be asking the user to amend
>> the message.
> 
> This is disruptive if done without a careful transition plan and
> you'll annoy existing users who expect to be able to edit by
> default.  Especially since "rebase" keeps going and potentially
> rebuild many commits on top, by the time they realize the mistake of
> not passing "--edit", it is too late and they will hate you for
> forcing them rebase many commits again.

I agree, I was imagining the new behaviour would be opt in via a config 
variable. Then if in the future there is a consensus to enable the new 
behaviour by default there would be a transition phase where users of 
the old behaviour would get a message telling that the behaviour is 
going to change in the future and what value to set the config variable 
to in order to keep the old behaviour if that's what they want.

> If these suggestions above were given while "rebase -i" was
> developed, it might have made the end-user experience a better one
> than what it currently is, but transitioning after the current
> behaviour has long been established makes it much harder.

Sadly I didn't even know git existed at the time rebase was first added.

Best Wishes

Phillip


[1] 
https://public-inbox.org/git/20170726102720.15274-2-phillip.wood@talktalk.net/T/#u

