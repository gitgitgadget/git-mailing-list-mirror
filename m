Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A397F203BD
	for <e@80x24.org>; Fri, 12 Aug 2016 22:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbcHLWXb (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 18:23:31 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:52594 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbcHLWXa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 18:23:30 -0400
Received: from PhilipOakley ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id YKrQbWauGY8RwYKrQbsbNj; Fri, 12 Aug 2016 23:23:29 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=N659UExz7-8A:10 a=8q6LdnVOAAAA:8
 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8 a=1XWaLZrsAAAA:8 a=nIOBjO_3uPItlqc74vkA:9
 a=jNYSTCpFY2gkngftge3H:22 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22
 a=nJcEw6yWrPvoIXZ49MH8:22
Message-ID: <75C139198D66446D8DEE561855DE8D4E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Marc Branchaud" <marcnarc@xiplink.com>
References: <20160720211007.5520-1-philipoakley@iee.org> <20160812070749.2920-1-philipoakley@iee.org> <20160812070749.2920-7-philipoakley@iee.org> <a3acb1fe-a1c2-cc66-315d-0dffb1291e8e@xiplink.com>
Subject: Re: [PATCH v5 06/12] doc: revisions: single vs multi-parent notation comparison
Date:	Fri, 12 Aug 2016 23:23:28 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfFw1M98OKt/q1P78Tm1iRI9JFfgyi5Aqzk/LYjCKevnYPoXiujY99plf8kHo0SsnGu3wEQmq1g9THI4ufCVUWIrQuKq/0tbtBtIHsksk8rIxv1QYtSIM
 OcLIVufyPOHBg5uURO5p49vSei1+kAy45FIJz9lTVw+gPTOiTZUOXjK4DvdL5s9/BLKkVGz6xzvhPDbzIsgYQ10+kMjxOq6zhMSEh0fi670QDnT9tfhnwjRj
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Marc Branchaud" <marcnarc@xiplink.com>
> On 2016-08-12 03:07 AM, Philip Oakley wrote:
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> new
>> Junio's final comment 
>> https://public-inbox.org/git/xmqqwpkq6b4d.fsf%40gitster.mtv.corp.google.com/
>> ---
>>  Documentation/revisions.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index 0b5044d..934d071 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -284,6 +284,10 @@ The 'r1{caret}@' notation means all parents of 'r1'.
>>  'r1{caret}!' notation includes commit 'r1' but excludes all of its 
>> parents.
>>  This is the single commit 'r1', if standalone.
>>
>> +While '<rev>{caret}<n>' was about specifying a single commit parent, 
>> these
>> +two notations consider all its parents. For example you can say
>> +'HEAD{caret}2^@', however you cannot say 'HEAD{caret}@{caret}2'.
>
> That ^ should be {caret}, right?
>
Yes (I think so - will change).

I had planned to change it but it looks like I missed it.

In an earlier version I hadn't changed any of them (or maybe just one) and 
the asciidoc barfed. I suspect that the ^ ^ symbols have to be paired 
properly, and a bad pairing around / across the quotes makes the parsing 
fail. it looks like singletons (which clearly never pair) are accespted 'as 
is'

I think the later examples are inside some form of a block quote with no 
expansions at all.

--
Philip


> M.
>
> 

