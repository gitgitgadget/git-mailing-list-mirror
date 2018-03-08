Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A6C1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934860AbeCHLIa (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:08:30 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:20759 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933352AbeCHLI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:08:29 -0500
Received: from [192.168.2.201] ([89.242.187.47])
        by smtp.talktalk.net with SMTP
        id ttPOeKQiLwheattPOejU7S; Thu, 08 Mar 2018 11:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520507308;
        bh=qPvPJ1LWUYLMBCm5Y/1jGivRVeli2RzX+HBY1HffhFs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aPhmHwqKboUL7A9dnHKh+z75s95jvAxQ/UZHEkY6CKK1Fv8ir9XNSKMc1sReK6MMi
         6ghiTfj+FHyA5DR1lncugnZt26Txg1Bys2b0iWsAX3RbjkQj+ziIshp2lE3fIxSmjb
         kz93WRr1PSDO0xQWjq3HR+ewQqFN3KNt/nYsRyOo=
X-Originating-IP: [89.242.187.47]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=xTMdeSjPtcrjTRwaJcecEQ==:117
 a=xTMdeSjPtcrjTRwaJcecEQ==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=l21tQKRs0AWjmsGCpfAA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
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
 <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
 <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net>
 <nycvar.QRO.7.76.6.1803061829460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <aef84393-d980-81b3-8d8f-3525819bcdc3@talktalk.net>
Date:   Thu, 8 Mar 2018 11:08:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803061829460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF0+OYmTpzJHY5TilhHCXTKTl0kXeEDGWvbOnHOHaltorXNX8ZLaOQSQ2ieTk053R7DEeRt4+oJMvecXXuBVaPbs5gxVV+DucefALN+ERUEbPuRnNkMe
 hca4qbUWOA9OKeaCt6CM0drrvFOLCq2WKBi2V1KrzJDRJPy3r1uwTdft1APf9mSr/lkWBQPctkOBcDy5ahS88KUrb6FR/x73QJZDGI6LzOAOl96I1EjaadE/
 hPlN73WSmzYd6IJRwsBk0jDdRJ8784nA/w94tXrhK6XAhTBsCiRaQ+Af6eF+5AyVmOtbyO8iYNq378aX5jhdrX2Sv4UOFCt+mrq6InOzmKWlzBa3Hp14SB67
 ePA98ukv+6fVcmpZps2B/5JYpJmUczMaq3eTPYrpK3ybgt4NhOxX8cXFRcK2//jddG/TYa7m
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/18 18:12, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Tue, 6 Mar 2018, Phillip Wood wrote:
> 
>> On 03/03/18 00:29, Igor Djordjevic wrote:
>>>
>>> On 02/03/2018 12:31, Phillip Wood wrote:
>>>>
>>>>> Thinking about it overnight, I now suspect that original proposal
>>>>> had a mistake in the final merge step. I think that what you did is
>>>>> a way to fix it, and I want to try to figure what exactly was wrong
>>>>> in the original proposal and to find simpler way of doing it right.
>>>>>
>>>>> The likely solution is to use original UM as a merge-base for final
>>>>> 3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty
>>>>> natural though, as that's exactly UM from which both U1' and U2'
>>>>> have diverged due to rebasing and other history editing.
>>>>
>>>> Hi Sergey, I've been following this discussion from the sidelines,
>>>> though I haven't had time to study all the posts in this thread in
>>>> detail. I wonder if it would be helpful to think of rebasing a merge
>>>> as merging the changes in the parents due to the rebase back into the
>>>> original merge. So for a merge M with parents A B C that are rebased
>>>> to A' B' C' the rebased merge M' would be constructed by (ignoring
>>>> shell quoting issues)
>>>>
>>>> git checkout --detach M
>>>> git merge-recursive A -- M A'
>>>> tree=$(git write-tree)
>>>> git merge-recursive B -- $tree B'
>>>> tree=$(git write-tree)
>>>> git merge-recursive C -- $tree C'
>>>> tree=$(git write-tree)
>>>> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB' -pC')
>>>>
>>>> This should pull in all the changes from the parents while preserving
>>>> any evil conflict resolution in the original merge. It superficially
>>>> reminds me of incremental merging [1] but it's so long since I looked at
>>>> that I'm not sure if there are any significant similarities.
>>>>
>>>> [1] https://github.com/mhagger/git-imerge
>>>
>>> Interesting, from quick test[3], this seems to produce the same 
>>> result as that other test I previously provided[2], where temporary 
>>> commits U1' and U2' are finally merged with original M as a base :)
>>>
>>> Just that this looks like even more straight-forward approach...?
>>>
>>> The only thing I wonder of here is how would we check if the 
>>> "rebased" merge M' was "clean", or should we stop for user amendment? 
>>> With that other approach Sergey described, we have U1'==U2' to test with.
>>
>> I think (though I haven't rigorously proved to myself) that in the
>> absence of conflicts this scheme has well defined semantics (the merges
>> can be commuted), so the result should be predicable from the users
>> point of view so maybe it could just offer an option to stop.
> 
> I am not so sure that the result is independent of the order of the
> merges. In other words, I am not necessarily certain that it is impossible
> to concoct A,A',B,B' commits where merging B'/B before A'/A has a
> different result than merging A'/A before B'/B.
> 
> Remember, when constructing counter-examples to hypotheses, those
> counter-examples do not really *have* to make sense on their own. For
> example, A' could introduce *completely different* changes from A, and the
> same is true for B' and B.
> 
> I could imagine, for example, that using a ton of consecutive empty lines,
> and using patches that insert something into these empty lines (and are
> thusly inherently ambiguous when said set of empty lines has changed),
> could even introduce a merge conflict in one order, but no conflict in the
> other.

Yes I should have thought of that given I've just been working on making
'add -p' more robust when there are lots of identical lines.

> Even so, I think that merging in the order of the parents makes the most
> sense, and that using that strategy makes sense, too, because you really
> have to try hard to make it fail.
> 
> Ciao,
> Dscho
> 

