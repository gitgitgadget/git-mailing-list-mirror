Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5177C1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932820AbeCFKwj (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:52:39 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:60237 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932589AbeCFKwi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:52:38 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id tACyem2FRlYtptACyexGBK; Tue, 06 Mar 2018 10:52:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520333557;
        bh=dqIiREgvrAeClef4Lwi0FJjiRj52WeTSBfjSSOOpGU8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DFY9cTi3LVJQ2OqfOmn241Ya9gQbXgxmJLANXr3wIR+Vbx+bPLpHhehG956TqNh0B
         E7FiOTk/KnFH4TSSIdy5ssqKscWNl+4BTk1o+jO9zInwvtZ6KTEYuUojlrLNss/Fsa
         HsYcAxOSZZJHNOM9r72S1T1B+EgI9IK/vILkxU9o=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JZeSU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=_WpT9o1msJLSheK39U8A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
 <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com> <87h8pvm7zz.fsf@javad.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <ebc73962-8dff-520c-e19d-8fcc1ef63ab0@talktalk.net>
Date:   Tue, 6 Mar 2018 10:52:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87h8pvm7zz.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAkYWKQQE3ZBZYLh0QZAQ2EBDQJfKbte+2mCpo6FJ+FhfNu1aez5me4esFl22yL0HLnXniDMik3yO5NiWnyP7nIlIa+g45thWpHJuPsRYsk+Xpg7bf4x
 IU0c++uAUaJfU9oRe9uujAtkXOmsYyH3EuhVJc/R1uqwkQQ5Bjog2V3K8Sa8fpkR5fOV+Kf3G01dnDwttiNK/I2RyW5BNAUFzTCDs1b1Iyujbhhx85I/wk5Q
 9tovzjpJM4tfkWdGayXFimgx37VXv5EYE2pfwxgYZ4riJhoNAnSUVfONGKz1yu28hSgRECew/NK2qAX9EapbpMbmIymbf/sFar5tMtLihIs74Cu4mGCS3PnZ
 mvbPCqzMtMU1JtAkFxKVcPndn5WNOjcif7Rss2Yz0TcMnRrHjieMg1rOGJFAc+WAXCTRBqgl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/03/18 05:00, Sergey Organov wrote:
> Hi Plillip and Igor,
> 
> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>> Hi Phillip,
>>
>> On 02/03/2018 12:31, Phillip Wood wrote:
>>>
>>>> Thinking about it overnight, I now suspect that original proposal had a
>>>> mistake in the final merge step. I think that what you did is a way to
>>>> fix it, and I want to try to figure what exactly was wrong in the
>>>> original proposal and to find simpler way of doing it right.
>>>>
>>>> The likely solution is to use original UM as a merge-base for final
>>>> 3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty natural
>>>> though, as that's exactly UM from which both U1' and U2' have diverged
>>>> due to rebasing and other history editing.
>>>
>>> Hi Sergey, I've been following this discussion from the sidelines,
>>> though I haven't had time to study all the posts in this thread in
>>> detail. I wonder if it would be helpful to think of rebasing a merge as
>>> merging the changes in the parents due to the rebase back into the
>>> original merge. So for a merge M with parents A B C that are rebased to
>>> A' B' C' the rebased merge M' would be constructed by (ignoring shell
>>> quoting issues)
>>>
>>> git checkout --detach M
>>> git merge-recursive A -- M A'
>>> tree=$(git write-tree)
>>> git merge-recursive B -- $tree B'
>>> tree=$(git write-tree)
>>> git merge-recursive C -- $tree C'
>>> tree=$(git write-tree)
>>> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB' -pC')
>>>
>>> This should pull in all the changes from the parents while preserving
>>> any evil conflict resolution in the original merge. It superficially
>>> reminds me of incremental merging [1] but it's so long since I looked at
>>> that I'm not sure if there are any significant similarities.
>>>
>>> [1] https://github.com/mhagger/git-imerge
>>
>> Interesting, from quick test[3], this seems to produce the same 
>> result as that other test I previously provided[2], where temporary 
>> commits U1' and U2' are finally merged with original M as a base :)
> 
> Looks like sound approach and it's interesting if these 2 methods do in
> fact always bring the same result. Because if we look at the (now fixed)
> original approach closely, it also just gathers the changes in merge
> parents into U1' and U2', then merges the changes back into the original
> M (=U1=U2=UM).
> 
> Overall, this one looks like another implementation of essentially the
> same method and confirms that we all have the right thought direction
> here.
> 

Yes, I think they are doing the same thing. If there are no conflicts
then U1' is the should as "git merge-recursive A -- M A'". My patch
algebra isn't very good, but I think one ought to be able to show that
in the absence of conflicts the two approaches are equivalent.

>>
>> Just that this looks like even more straight-forward approach...?
>>
>> The only thing I wonder of here is how would we check if the 
>> "rebased" merge M' was "clean", or should we stop for user amendment? 
>> With that other approach Sergey described, we have U1'==U2' to test
>> with.
> 
> That's an advantage of the original, yes.

I wonder if just having a predicable result rather than forcing the
rebase to stop if the user just squashes a fixup commit into a topic
branch that is the parent of a merge might be more convenient in practice.

Best Wishes

Phillip

> -- Sergey
> 

