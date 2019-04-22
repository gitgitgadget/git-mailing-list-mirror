Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ED851F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 14:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfDVOoG (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 10:44:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41952 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfDVOoG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 10:44:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id c12so9891236wrt.8
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DUcNJBEseMK3JVP4zaeTvAIYxBWj1jGiZGenmvWY6qM=;
        b=Q+6zVOeDXM7ZzzD0XhNGrh5KISeJQjo3oSGTzMdzlx6qlCu99r5QwHvKirwSI3VKrE
         KVQlon6pay35Mq16Rdq24Y3QSRv+oWYEdWPCApOlv5AWLItuFwVw6jcCI7Jwn1iKizFq
         L7o7vElrQAqjHODh72VZLE4qXxMMhR2rQpV2unie3pPpu1v7zqwiVMPlJoq8iKAJtGC5
         v3n+Y2FgHVTJov+YyIzkW4NVTfAcbjJke0QCgfgod8NF4U84J+mdrtO1gywE65xULuze
         w1d3OdsbVCmguJJ9TnLfbGlgU323Wz5L411PnR59FI20zqjN0Yi/+aGUKckVgkJooZ7s
         vZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DUcNJBEseMK3JVP4zaeTvAIYxBWj1jGiZGenmvWY6qM=;
        b=GjqarTLwMvVx5KNGSch6189Dpb/rSbHkS/t92U5jxzpCE95qW5HHL/pcaMxmr3Ljgh
         nV5zZw/WclBSUgfVALR7VoOdAKv8MsSZBA98M0DsdJv+q8Xm9VWDCXrtVuoJTkZYtFAF
         ep4Qjg00STk0EI3a5Ya+dmL7zR/lzild3Pzhdi7VgjkWWHzzahCFU5q89lMYA1wPzh7Q
         tWr9yyizUN67jD8KWFus15dj1xXIWFc5ntaJlUpPqfNc+kS4e2l/2e9FKC0X/JGGWulf
         HMoQexL9f05R1F1C6j283KDFaE4P9dPnd8jAm//oVUQAZuYu/K+Xbsb3sJvFQFkLJTk8
         NJzw==
X-Gm-Message-State: APjAAAXVbI3dvhF5oIkteC4TB47zxkyJ8dK6zx7cG+QwypPiLdKUQpaY
        UhFtv1/I7HAwRhjpMZMc/of2kc0A
X-Google-Smtp-Source: APXvYqw73I0yAPPvYiN9XHrCev1WeqED38pSUWPqgDACCUcZ6Dhutc6pX7/Cai2p5Z3LeCulwJhsuQ==
X-Received: by 2002:a5d:5745:: with SMTP id q5mr13684661wrw.118.1555944243566;
        Mon, 22 Apr 2019 07:44:03 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-7-19.as13285.net. [92.22.7.19])
        by smtp.gmail.com with ESMTPSA id g84sm17530368wmf.25.2019.04.22.07.44.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 07:44:02 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH/RFC 0/2] rebase: add switches to control todo-list setup
To:     Junio C Hamano <gitster@pobox.com>, Phil Hord <phil.hord@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
References: <20190422000712.13584-1-phil.hord@gmail.com>
 <xmqqk1fm9712.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <623d6ebd-60c4-916d-6295-4c648dbf3932@gmail.com>
Date:   Mon, 22 Apr 2019 15:44:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqk1fm9712.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/04/2019 02:13, Junio C Hamano wrote:
> Phil Hord <phil.hord@gmail.com> writes:
> 
>> Currently it supports these switches:
>>
>>      usage: git rebase [-i] [options] [--exec <cmd>] ...
>>         :
>>      --break <revision>    stop before the mentioned ref
>>      --drop <revision>     drop the mentioned ref from the todo list
>>      --edit <revision>     edit the mentioned ref instead of picking it
>>      --reword <revision>   reword the mentioned ref instead of picking it
>>
>> I have plans to add these, but I don't like how their "onto" will be
>> controlled. More thinking is needed here.
>>
>>      --fixup <revision>    fixup the mentioned ref instead of picking it
>>      --squash <revision>   squash the mentioned ref instead of picking it
>>      --pick <revision>     pick the mentioned ref onto the start of the list
> 
> Yeah, I can see that it may be very useful to shorten the sequence
> to (1) learn what commits there are and think what you want to do
> with each of them by looking at "git log --oneline master.." output
> and then to (2) look at and edit todo in "git rebase -i master".
 >> I personally would be fine without the step (1), as what "rebase -i"
> gives me in step (2) essentially is "log --oneline master..".  So I
> am not quite getting in what way these command line options would be
> more useful than without them, though, especially since I do not see
> how well an option to reorder commits would fit with the way you
> structured your UI.

Doing "git rebase -i master" and then editing the todo list has the side 
effect of rebasing the branch. Often I find I want to amend or reword a 
commit without rebasing (for instance when preparing a re-roll). To do 
this I use a script that runs something like

GIT_SEQUENCE_EDITOR="sed -i s/pick $sha/edit $sha/" git rebase -i $sha^

and I have my shell set up to interactively select a commit[1] so I 
don't have to cut and paste the output from git log. I've found this 
really useful as most of the time I just want to amend or reword a 
commit or squash fixups rather than rearranging commits. The script 
knows how to rewind a running rebase so I can amend several commits 
without having to start a new rebase each time.

So I can see a use for --edit, --reword & --drop if they selected a 
suitable upstream to avoid unwanted rebases (I'm not so sure about the 
others though). If you want to rebase as well then I agree you might as 
well just edit the todo list.

Best Wishes

Phillip

[1] Something like 
https://public-inbox.org/git/87k3xli6mn.fsf@thomas.inf.ethz.ch/

> Having already said that, if I were to get in the habit of looking
> at "log" first to decide and then running "rebase -i" after I made
> up my mind, using a tweaked "log --oneline" output that looks
> perhaps like this:
> 
> 	$ git log --oneline master.. | tac | cat -n
> 	1 xxxxxx prelim cleanly
> 	2 xxxxxx implement the feature
> 	3 xxxxxx document and test the feature
> 	4 xxxxxx the final step
> 	5 xxxxxx fixup! implement the feature
> 
> I think I may appreciate such a feature in "rebase -i" even more, if
> the UI were done a bit differently, e.g.
> 
> 	$ git rebase -i --edit="1 3 2 b f5 b r4" master.. >
> to mean "pick the first (i.e. bottommost) one, pick the third one
> for testing, pick the second one, then break so that I can test,
> fixup the fifth one, break to test, and finally pick the fourth
> one but reword its log message", to come up with:
> 
> 	pick xxxxxx prelim cleanly
> 	pick xxxxxx document and test the feature
> 	pick xxxxxx implement the feature
> 	break
> 	fixup xxxxxx oops, the second one needs fixing
>          break
> 	reword xxxxxx the final step
> 
> I am guessing that the way you did it, the above would be impossible
> (as it requires reordering) but given that you would leave most of
> the 'pick's intact and only tweak them in-place into drop, edit,
> reword, etc., that may not be too bad, but I suspect that it would
> become very verbose.
> 
> 	$ git rebase -i \
> 		--pick HEAD~4 --pick HEAD~3 --break --fixup HEAD \
> 		...
> 
> The --edit alternative I threw in in the above would make it
> necessary for the user to spell out all the picks, and that would be
> more cumbersome given our assumption that most picks will be left
> intact, but then we could do something like
> 
> 	--edit="1-4 5e 6 8-" master..
> 
> to say "pick 1 thru 4, edit 5, pick 6, drop 7 and pick 8 thru the
> end".
> 
> I dunno.
> 
