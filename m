Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441001FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 13:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbcH2NVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 09:21:18 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:9168 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933249AbcH2NVR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 09:21:17 -0400
Received: from PhilipOakley ([92.22.21.140])
        by smtp.talktalk.net with SMTP
        id eMV0bpg4zxR4beMV0bl1J1; Mon, 29 Aug 2016 14:21:15 +0100
X-Originating-IP: [92.22.21.140]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=uWzTMUt4AHB+CZJDH1c8sA==:117
 a=uWzTMUt4AHB+CZJDH1c8sA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=k9Qg70HxLSt6Jf4FsT4A:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <EDA7BA88AB1D42C7B4228D71CC28145B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "GitList" <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
References: <20160720211007.5520-1-philipoakley@iee.org> <20160812070749.2920-1-philipoakley@iee.org> <20160812070749.2920-10-philipoakley@iee.org> <494c1bd2-19c8-e2af-da1c-ff1331f91c4f@gmail.com>
Subject: Re: [PATCH v5 09/12] doc: revisions - define `reachable`
Date:   Mon, 29 Aug 2016 14:21:14 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfMpQb/ARCNNXte9D9YgbDozPoHvYPK67zhNpGlJhtjKBsDbOO7F7NxiP9FLh/oXKdvks+ZBTRnhx6RoNzgau53jJqW4STdLxUZWOZd9U3t3a6vsseYB8
 ClxgLQXSpO3NcYWUPqaDtghtuBCXlrPKeIMha3Lh1HJMnzeYfxtqx3bU7dfsBiUFBVlH7nFg+NO8CC8FLUPYqdwYsxsRMGI0VALbF+NrZCaa5WW4et040g6R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jakub Narębski" <jnareb@gmail.com>
Sent: Sunday, August 28, 2016 2:01 PM
>W dniu 12.08.2016 o 09:07, Philip Oakley pisze:
> [...]
>
>>  History traversing commands such as `git log` operate on a set
>> -of commits, not just a single commit.  To these commands,
>> -specifying a single revision with the notation described in the
>> -previous section means the set of commits reachable from that
>> -commit, following the commit ancestry chain.
>> +of commits, not just a single commit.
>> +
>> +For these commands,
>> +specifying a single revision, using the notation described in the
>> +previous section, means the set of commits `reachable` from the given
>> +commit.
>
> Why such strange formatting?  Is it to keep original contents
> for better blame / word diff?

Strange as in 'not reflowed'? - yes that was the reason. It can be hard to 
see the wood from the trees if there is a lot of reflow going on, as it can 
hide the issue behind the key change.

I did slightly abuse notation by quoting `reachable` to indicate that it's a 
term with a precise definition that can be confusing to those that don't 
know. I also split out the reachability parts into their own paragraphs.

>
>> +
>> +A commit's reachable set is the commit itself and the commits in
>> +its ancestry chain.
>> +
>
> It is all right, but perhaps it would be better to just repeat:
>
>  +Set of commits reachable from given commit is the commit itself
>  +and all the commits in its ancestry chain.

It's very easy to go around in circles here. The original issue was the A..B 
notation for the case where A is a direct descendant of B, such that new 
users, or users more familiar with range notations from elsewhere, would 
expect that the A..B range is *inclusive*, rather than an open / closed 
interval. It was the addressing of that problem that lead to the updating of 
the 'reachability' definition.

The main part of my sentence formation was to make the 'reachable' part the 
defining element, rather than being a feature of the set. Maybe it's using 
the 'set' viewpoint that is distracting?
>
> -- 
> Jakub Narębski
>
> 

