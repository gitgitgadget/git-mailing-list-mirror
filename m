Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C49E1FAE2
	for <e@80x24.org>; Wed, 14 Mar 2018 11:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeCNLDD (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 07:03:03 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:24831 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeCNLDC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 07:03:02 -0400
Received: from [192.168.2.201] ([89.242.187.47])
        by smtp.talktalk.net with SMTP
        id w4BOeGmqwHCoww4BPesdhk; Wed, 14 Mar 2018 11:03:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521025380;
        bh=Vb487fxAawMaeMtZICDLJqFsx9uQMBwcQoUaWl2V3tk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YL81k/Dj1lQSrwuCZSvNl34M/Jiwj9/8g2zD7qXn5iNsoIKkDPSnR0C+b/cuWzkw9
         PhJHaFxbGqpLdR4c5LFwLZx+xyqTA5PkVjGeh7yzy4sczyRfxJjlWj0G6S+OUAcVVL
         ViVE5cnq8ep92QRLZMNiyL24VG3OeEdy7HZeZljQ=
X-Originating-IP: [89.242.187.47]
X-Spam: 0
X-OAuthority: v=2.3 cv=SfXZiMZu c=1 sm=1 tr=0 a=xTMdeSjPtcrjTRwaJcecEQ==:117
 a=xTMdeSjPtcrjTRwaJcecEQ==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=N5IzSbAmBNIq2Jeogc4A:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] add -p: allow line selection to be inverted
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180306101750.18794-1-phillip.wood@talktalk.net>
 <20180306101750.18794-3-phillip.wood@talktalk.net>
 <xmqq371d3rjz.fsf@gitster-ct.c.googlers.com>
 <6476d776-dbf7-09cf-1c65-e413798b9987@talktalk.net>
 <xmqq371axxm5.fsf@gitster-ct.c.googlers.com>
 <ea4f645f-5cf2-ef84-24cf-fb585f96039d@talktalk.net>
 <xmqqsh942ayf.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <59492efe-f455-1214-86e4-7a48bbe8f556@talktalk.net>
Date:   Wed, 14 Mar 2018 11:02:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqsh942ayf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfG1xldWlJ/RPRnd9iCg7rxKmINzlMLnWU65RMkves842A8AmZEW1PiCYrXTRojNCSyaBMZvOziW48Wi31aSTeoQRl/T9u4XD1TP1i6lZWuENmzxQ8v/T
 iEn1iEHrJOcmdYaZIXxukDD56f64BJ7H6YiUxs/Z1BLqpi+/vBCLGhz6UO241u8azf2aNABKMN/rUO7oTbuK/0zOs+kyv+4LZ8L4i3Nt71HqZHpnPTxZ3qZz
 XhsWwiAp3n02pyvHN/nY/ltv18uAL3pY8aWPdfaungZvDw2pS1NcCTl4BKwzMdYS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/03/18 16:32, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> On 08/03/18 17:53, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>>
>>>> and use a leading '-' for inversion. I'm tempted to keep supporting 'n-'
>>>> to mean everything from 'n' to the last line though.
>>>
>>> Thanks for double checking.  It would be a better endgame to follow
>>> up with an update to existing "range selection" code to also support
>>> "n-", if you go that route.
>>>
>> I'm afraid I'm not sure exactly what you're suggesting. At the moment
>> the range selection code is in the first patch and supports incomplete
>> ranges. Are you suggesting that support for incomplete ranges should be
>> in a separate patch or have I misunderstood?
> 
> My observation of the situation behind my reasoning is:
> 
>  - There is an existing UI that uses "-X" to mean "exclude what
>    matches X" and that was the reason why you decided to follow suit
>    instead of using "^X" for inversion of X.
> 
>  - Such an existing UI would not have used "-X" to mean "the first
>    possible choice thru X".  You will lose that from your new thing
>    and you accepted that.
> 
>  - It is likely (I did not check, though) that the existing UI would
>    not have used "Y-" to mean "starting from Y all the possible
>    choices thru to the end", but that is merely for symmetry with
>    the lack (inability to use) of "-X".  There is no fundamental
>    reason why "Y-" cannot mean that, and you are tempted to allow do
>    so in your new thing for the same reason.
> 
> So if we are going to have "N-" to mean "everything from N to the
> last line", then the same "Starting at N to the end of the all the
> possible choices" should be allowed in the existing UI (i.e. the one
> that forced you to give up "^X" for the sake of consistency) for the
> same consistency reasons, no?
> 
> For that, if you want to keep the "n-" you did in your first patch,
> the most logical thing is to have a preparatory enhancement to teach
> "N-" to list_and_choose(), and then build your series on top.  Or
> you can do without such a change to list_and_choose() in your series,
> in which case, you drop "n-" support and then at the very end after
> the series settles, add "n-" support to the new code in this series
> and to list_and_choose() at the same time in a follow-up patch.
> 
> 
Thanks for taking the time to clarify that, I hadn't twigged you were
talking about changing list_and_choose() before. I think it would make
sense for that and 'git clean' to match the line selection with "n-". I
just opened it up my editor to do that and was pleasantly surprised to
discover that "n-" is already implemented for both list_and_choose() and
'git clean' so there's nothing that needs doing on that front. I'll
reroll this series with the other changes and send it later this week or
next week

Best Wishes

Phillip
