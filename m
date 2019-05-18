Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B551F461
	for <e@80x24.org>; Sat, 18 May 2019 19:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfERTot (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 15:44:49 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:45259 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfERTos (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 15:44:48 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id S5G9hoWPknuQZS5GAhC1sS; Sat, 18 May 2019 20:44:46 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=3rmH6Jhg6BXpqsnTiloA:9 a=QEXdDO2ut3YA:10
Subject: Re: Command to list <pattern> Branches on a specific Remote (i.e.
 select from rtb's)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <dcdff07d-77c7-8cb8-fa06-82acda5fe9ec@iee.org>
 <87lfz3vcbt.fsf@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <720a0b5f-cc20-5b75-8222-68eed77beeea@iee.org>
Date:   Sat, 18 May 2019 20:44:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87lfz3vcbt.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfCK8BWFGfwr9J/Foi+y+ipB8PieZpx8MKiBNo99hrY76CToitx+fTV1Qhdnajjf5EqUweibn8FHWSqtzp0UL/T7lkBYKBUbTXQAeIHFpuGKwMgIuA4h4
 D2IyjcTGlwtNQHSCV+KCp7yGzR/OFVLxJK3JkQualb8GXO9V+TyENX1UctJN3GPEla3cqZxg5QvcyvjUtO5hQSb+w1zLugpwHu8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On 18/05/2019 19:37, Ævar Arnfjörð Bjarmason wrote:
> On Sat, May 18 2019, Philip Oakley wrote:
>
>> Hi,
>> I'm unsure if there is a command for this.
>>
>> Currently I have 1600+ remote tracking branches (rtb) for my Git repo
>> as it covers both git.git and git-for-windows and some other
>> contributors.
>>
>> Finding a specific rtb for a particular remote looks like there ought
>> to be a simple command ready to do the job, but I haven't found
>> anything.
>>
>> Is there a command or simple simple invocation of branch, show-ref,
>> for-each-ref, etc that can be give a branch pattern and remote name to
>> quickly filter down the list of potential branches to just one or two
>> 24-line screens?
> That's:
>
>      git for-each-ref 'refs/remotes/<remote>/<pattern>'
>      git branch -a -l '<remote>/<pattern>'
>
> The latter will conflate <remote> with any local branches you happen to
> have prefixed with <remote>.
>
> The reason this isn't some easy mode in some command is because there's
> no hard notion that a given remote "owns" a given set of RTB's. It's
> just convention, but they can and do overlap sometimes.
>
> See the logic in 'git remote remove' that needs to decide if a deletion
> of a remote should delete its remote tracking refs: 7ad2458fad ("Make
> "git-remote rm" delete refs acccording to fetch specs", 2008-06-01)
Thanks, that's magic. I was also conflating the 'pattern' with a grep 
style sub-string search in my exploration.

So, as long as one uses the RTB 'remote name', rather than the remotes 
'remote name' it should all be golden.

I'll add the answer to one on the stackoverflow Q&A's I'd looked at. I 
hadn't put the branch -a and -l options together.
--
Philip
