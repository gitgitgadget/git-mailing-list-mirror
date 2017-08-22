Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A7B20899
	for <e@80x24.org>; Tue, 22 Aug 2017 10:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932449AbdHVKys (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 06:54:48 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:22210 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbdHVKyr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 06:54:47 -0400
Received: from [192.168.2.201] ([92.22.15.146])
        by smtp.talktalk.net with SMTP
        id k6pYdGWxFAp17k6pZdWLSZ; Tue, 22 Aug 2017 11:54:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1503399285; bh=6HmfcR48Dx0UJiStj26dW4XCw49IzC1wcFv6IBqAeiU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=arxxFy/9ojo5k9qNuQA7vOl+NLjdKP3tdmHCsNh0TPtAf/OZDrGHDyS0LhDDTGBwr
         0TtZn3EJz10g2oAlOVVVZJpattVvMlgCU8GZrOKnjHQvN1O33gQWbC6OP1uqTnWkWF
         kCU9egpCJZMnODpIJC2vg5Fy1ydpfr5l8ihyPXmo=
X-Originating-IP: [92.22.15.146]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=PRKyDR6jJsLBrgZYJ8A23w==:117
 a=PRKyDR6jJsLBrgZYJ8A23w==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=KofD4PeGWZFy2NQTSzkA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a
 rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
 <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
 <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com>
 <xmqq60eeq24l.fsf@gitster.mtv.corp.google.com>
 <8cdda835-0b4f-6ffb-31bf-6192999818be@talktalk.net>
 <6a71f802-b20c-f6bc-7bb5-8d81db3353d8@talktalk.net>
 <xmqqpocloqcp.fsf@gitster.mtv.corp.google.com>
 <a3b7af29-8b3a-5253-21da-957920212a6e@talktalk.net>
 <xmqqinhg5ysf.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d1eaed1c-5e62-0a93-f65d-06be43812617@talktalk.net>
Date:   Tue, 22 Aug 2017 11:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqinhg5ysf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKpzGxhkuBvFX6qg2dUY2wftdmbYzqfAaQL2jqFRjRrgfYEvKKdpxoZszApua1u8Zg4AAq/hRQ+r+nyzxMHJuHGfcSlpKQTFabvQ1R0/5j8qq+/Ee07G
 T8j+N1FTso3XtTS62MHR9N4QhTj5/FVQVKU+OARkPuFof2+wmIWKvYXzkyshCfFF81TbvOaZlpg2LVmjwU4c1GHT5i27uiBLZ7yO4VnePPmDqLQLpjVCDRg3
 xwG1Osx2bO+FjWEVyGpk/TfceKYNrhmysFRlKYv2BW4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/08/17 23:41, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> ... I prefer
>> having to pass --autostage with --continue so that it is a concious
>> decision by the user to stage unstaged changes when they continue rather
>> than rebase just doing it each time it continues.
> 
> In other words, instead of
> 
> 	git add -u && git rebase --continue
> 
> you would want a quicker way to say
> 
> 	git rebase --continue $something_here 

Exactly

> If that is the case, that is understandable to me.  Is the "-u" (I
> think "git add -u" is short for "--update" but I didn't check) taken
> as a valid option to "git rebase"?  If not, that $something_here could
> be "-u".

At the moment $something_else is -a/--autostage but -u/--update (I've
checked the add man page and you're right) could be good as well.

rebase --continue -a

behaves like commit -a in that it commits all updated tracked files and
does not take pathspecs, if we go for -u then there is a difference with
'git add -u' as that can take an optional pathspec.


Did you have any further thoughts on what checks if any this new option
should make to avoid staging obviously unresolved files?

> Thanks for pinging the thread; otherwise I would have forgotten,
> especially because not many other people were involved in the
> discussion to begin with.

Yes it would be interesting to hear if this would be useful for others too.

Best Wishes

Phillip



