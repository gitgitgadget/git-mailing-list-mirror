Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EFB1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 20:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeK1Hvj (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 02:51:39 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:29225 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeK1Hvj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 02:51:39 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id RkLLgEb1lwhzSRkLLg8IuF; Tue, 27 Nov 2018 20:52:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1543351948;
        bh=wZCw65+35YF4bP3Nx2ksig9lR166H98sboDf1BtQgfs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EfjSwew/5qeMPvyOL7eFg0nAT7A1BTKEi+2ra80i2QOvS37cWKwEM47gan7YFGgEE
         KECLfr/86QoB8aaYsJ9wMe329Yrnk8n3ZbFIqoB5BdUJiBJrh+YVBr9P2QetOwlFAH
         k56l3kfIAVNCGCpixmUh11JvkPjGmWNXMlV3qsPM=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=VO0pIsrMZkuqgFNfChMA:9 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/9] diff --color-moved-ws fixes and enhancment
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181123111658.30342-1-phillip.wood@talktalk.net>
 <CAGZ79kZXW3YoptBzG_Bhjpnh6-7AYTWwT5tcrow2SDwNoF65ZA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <c69d55b6-a4c6-86b6-bea0-0b11c3c5b8e8@talktalk.net>
Date:   Tue, 27 Nov 2018 20:52:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZXW3YoptBzG_Bhjpnh6-7AYTWwT5tcrow2SDwNoF65ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMj8P0Y2mOznpHyr69VHNx1Bn5bbq9bvIcVuFnVT7mssW2DukJfkLlhpS6odxdxLUVAhSX+kOAgnK+BSTQoo+fvXsaHAZrkq9CZwqgHSJdK1+b4F1fIT
 V1wsaw4iWW3JZ85mVoZd/GLBV0jC7jvg92/QUxK/14XUuXuS4hd9FAkwhV6HGvHp6iLnQ6H7V0khvJnWRDnP4Nr9/FxWXlf7Vjms/+gopm5gjP8gg74ogkiX
 VuziLhC8Sg9G3ZPdn07ixGK03EKojpf/0J7vbZ3Fi8g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 26/11/2018 21:20, Stefan Beller wrote:
> On Fri, Nov 23, 2018 at 3:17 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Thanks to Stefan for his feedback on v1. I've updated patches 2 & 8 in
>> response to those comments - see the range-diff below for details (the
>> patch numbers are off by one in the range diff, I think because the
>> first patch is unchanged and so it was used as the merge base by
>> --range-diff=<old-head>.
> 
> `git range-diff` accepts a three dotted "range" OLD...NEW
> as an easy abbreviation for the arguments
> "COMMON..OLD COMMON..NEW" and the common element is
> computed as the last common element. It doesn't have knowledge
> about where you started your topic branch.

I was using the new --range-diff option to format-patch, I think I 
should have given --range-diff=@{u}..<old-head>.

>> For some reason the range-diff also includes
>> the notes even though I did not give --notes to format-patch)
> 
> This is interesting.
> The existence of notes.rewrite.<command> seems to work well
> with the range-diff then, as the config would trigger the copy-over
> of notes and then range-diff would diff the original notes to the new
> notes.

Yes, but I think with format-patch it should only diff the notes when 
--notes is given.

>> When trying out the new --color-moved-ws=allow-indentation-change I
>> was disappointed to discover it did not work if the indentation
>> contains a mix of spaces and tabs. This series reworks it so that it
>> does.
>>
> 
> The range-diff looks good to me.

That's good, thanks for your comments on the previous iterations.

Best Wishes

Phillip
> Thanks,
> Stefan
> 

