Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9D01F404
	for <e@80x24.org>; Thu,  8 Mar 2018 12:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754981AbeCHMQp (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 07:16:45 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:13850 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbeCHMQo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 07:16:44 -0500
Received: from [192.168.2.201] ([89.242.187.47])
        by smtp.talktalk.net with SMTP
        id tuTReKZ9IwheatuTRejWMA; Thu, 08 Mar 2018 12:16:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520511402;
        bh=9fm/UiKgZAYOwxP0VUjAwmnfjYc6YkK1gyTatkEx3I0=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=PxT9Nm829WbwNDum8nT2kUY3Sj8Bcq67eJzSFTvJcodGSENV3ga3sBqgyl+es5Ef3
         LQdhcabAHqGtuvcVWgEsdkYC1DlwNhVNG2NzHZ7dIQtvgofaBM4u57BSkSxKSwuaiH
         PetMlEIUGxmyZntSzI/ds7xLHlv9akWGasPlBGhs=
X-Originating-IP: [89.242.187.47]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=xTMdeSjPtcrjTRwaJcecEQ==:117
 a=xTMdeSjPtcrjTRwaJcecEQ==:17 a=IkcTkHD0fZMA:10 a=Y3bEpHQy9W0PXTHyFQQA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
Message-ID: <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net>
Date:   Thu, 8 Mar 2018 12:16:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGDip+lYHKUTSIDs+/f4TBe7IwPuOXUf+XY42YjDhtZqQyn5MnOG07yp6ButZRScdCRKcuT0ocrg+e49kn81cX49GkFT+0cp0bPwbBrs3lMHklAOEgdD
 Blpvj54beJvNho2Zrb4/ZX4xEA6BpX6PlLCnr7GV61NjNGI6uVBDDot5Pb+VR3JtQA/yJob3+HG/R5Ryg+RYV7bLAu751E/0YCV63WueRDZ1jA7LPpOSybXr
 dcZXCBMYN7n1B6Efg+gJLgJAAIR+w1hUyaQRU9apWVEWNArUtbS6gFn5TMY/OdJPmQ+IhFk9urrIMJ9crXq+aU/ncmwsaLAxkTa8gXjrnpiy3vYPF6NP0y0N
 90z4Gfb2/Th5GpWsAu9x6wcZ+wL/vxGbpBtw3jY+EV3bcgTlU4oTAECBLjSqwhutB6ArOllz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/18 11:20, Phillip Wood wrote:
> On 07/03/18 07:26, Johannes Schindelin wrote:
>> Hi Buga,
>>
>> On Tue, 6 Mar 2018, Igor Djordjevic wrote:
>>
>>> On 06/03/2018 19:12, Johannes Schindelin wrote:
>>>>
>>>>>> And I guess being consistent is pretty important, too - if you add new
>>>>>> content during merge rebase, it should always show up in the merge,
>>>>>> period. 
>>>>>
>>>>> Yes, that should make it easy for the user to know what to expect from
>>>>> rebase.
>>>>
>>>> [...]
>>>>
>>>> It will be slightly inconsistent. But in a defendable way, I think.
>>>
>>> I like where this discussion is heading, and here`s what I thought 
>>> about it :)
>>>
>>> [...]
>>>
>>> Here`s a twist - not letting `merge` trying to be too smart by 
>>> figuring out whether passed arguments correspond to rewritten 
>>> versions of the original merge parents (which would be too 
>>> restrictive, too, I`m afraid), but just be explicit about it, instead!
>>
>> That's the missing piece, I think.
>>
>>> So, it could be something like:
>>>
>>> 	merge -C deadbee 123abc:cafecafe 234bcd:bedbedbed
>>
>> I like where this is heading, too, but I do not think that we can do this
>> on a per-MERGE_HEAD basis. The vast majority of merge commits, in
>> practice, have two parents. So the `merge` command would actually only
>> have one revision to merge (because HEAD is the implicit first parent). So
>> that is easy.
>>
>> But as soon as you go octopus, you can either perform an octopus merge, or
>> rebase the original merge commit. You cannot really mix and match here.
>>
>> Unless we reimplement the octopus merge (which works quite a bit
>> differently from the "rebase merge commit" strategy, even if it is
>> incremental, too), which has its own challenges: if there are merge
>> conflicts before merging the last MERGE_HEAD, the octopus merge will exit
>> with status 2, telling you "Should not be doing an octopus.". While we
>> will want to keep merge conflict markers and continue with the "rebase the
>> original merge commit" strategy.
>>
>> And it would slam the door shut for adding support for *other* merge
>> strategies to perform a more-than-two-parents merge.
>>
>> Also, I do not think that it makes a whole lot of sense in practice to let
>> users edit what will be used for "original parent". If the user wants to
>> do complicated stuff, they can already do that, via `exec`. The `merge`
>> command really should be about facilitating common workflows, guiding the
>> user to what is sane.
>>
>> Currently my favorite idea is to introduce a new flag: -R (for "rebase the
>> original merge commit"). It would look like this:
>>
>> 	merge -R -C <original-merge> <merge-head> # <oneline>
>>
>> This flag would of course trigger the consistency check (does the number
>> of parents of the original merge commit agree with the parameter list? Was
>> an original merge commit specified to begin with?), and it would not fall
>> back to the recursive merge, but error out if that check failed.
>>
>> Side note: I wonder whether we really need to perform the additional check
>> that ensures that the <merge-head> refers to the rewritten version of the
>> original merge commit's parent.
>>
>> Second side note: if we can fast-forward, currently we prefer that, and I
>> think we should keep that behavior with -R, too.
> 
> I think that would be a good idea to avoid unpleasant surprises.

Oops that was referring to the first side note. I think fast forwarding
is a good idea. I'm not so sure about checking that <merge-head> refers
to the rewritten version of the original merge commit's parent any more
though. Having thought some more, I think we would want to allow the
user to rearrange a topic branch that is the parent of a merge and that
would require allowing a different parent as the old parent could be
dropped or swapped with another commit in the branch. I can't think of a
way to mechanically check that the new parent is 'somehow derived from'
the old one.

>> If the user wants to force a new merge, they simply remove that -R flag.
>>
>> What do you think?
> 
> I did wonder about using 'pick <original-merge>' for rebasing merges and
> keeping 'merge ...' for recreating them but I'm not sure if that is a
> good idea. It has the advantage that the user cannot specify the wrong
> parents for the merge to be rebased as 'git rebase' would work out if
> the parents have been rebased, but maybe it's a bit magical to use pick
> for merge commits. Also there isn't such a simple way for the user to go
> from 'rabase this merge' to 'recreate this merge' as they'd have to
> write the whole merge line themselves (though I guess something like
> emacs' git-rebase.el would be able to help with that)

Scrub that, it is too magical and I don't think it would work with
rearranged commits - it's making the --preserve-merges mistake all over
again. It's a shame to have 'merge' mean 'recreate the merge' and
'rebase the merge' but I don't think there is an easy way round that.

> Best Wishes
> 
> Phillip
> 
> 
>> Ciao,
>> Dscho
>>
> 

