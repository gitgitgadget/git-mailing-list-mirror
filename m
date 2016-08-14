Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B16E1FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 23:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbcHNXAR (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 19:00:17 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:54368 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbcHNXAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 19:00:17 -0400
Received: from PhilipOakley ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id Z4O6b41MAcpskZ4O6bC8Fo; Mon, 15 Aug 2016 00:00:15 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=123w7lMHyvjBwUW4oCIA:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <BF74616BD9694719A6C0D6E75ACD9CE6@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"GitList" <git@vger.kernel.org>
References: <20160814214630.1312-1-philipoakley@iee.org><20160814214630.1312-3-philipoakley@iee.org> <xmqqziofj90b.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v1 2/3] doc: rebase: fixup! can take an object name
Date:	Mon, 15 Aug 2016 00:00:15 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfMIAu1kUdxHKut7p4PFVOsfPKlLn6t4dQkHZs1OGIHTAJfLcjFP4V/k7p1dgugN6/H29r8MEu/Jy/kl7Ga/BFc6VwUdwl8oEkUDfqVJFTEs3yC3f2JIw
 VdQmrfpj7wE+ZIxdrRFCo3PFY6ICE3BbblQNwbDGkcBtK75i/EwELuHrIintQk0cKgBJTFhhtOXGQQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Since 68d5d03 (rebase: teach --autosquash to match on sha1 in addition
>> to message, 2010-11-04) the commit subject can refer directly to the
>> destination object hash as a single word.)...
>
> That's not an object hash but an object name (see glossary); you got
> it right in the actual patch text, though ;-).

As noted in 1/3, the glossary also needs a fix (for those who read it) to 
make sure the name-value confusion is distinguished, with the potential 
'object names' (colloquial)  being via (git) 'revisions', while  the 
cannonical object name is the (oid) sha1 hash. Somehow folk need pointing at 
the (broad) ways of spelling commit names rather than just the narrow sha. A 
bit of a finger and the moon problem.

>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 0387b40..66b789a 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -421,7 +421,8 @@ without an explicit `--interactive`.
>>  --no-autosquash::
>>  When the commit log message begins with "squash! ..." (or
>>  "fixup! ..."), and there is a commit whose title begins with
>> - the same ..., automatically modify the todo list of rebase -i
>> + the same "..." message, or a commit object name (standalone),
>> + automatically modify the todo list of rebase -i
>
> What's "(standalone)"?  I can understand the updated text and agree
> that it is better than the original without that part, though.

the 'standalone' is that it must be a single (standalone) word on the 
subject line immediately after the "fixup! "(s).

communicationg that one cannot have any extra textual notes after that word 
was the issue that 'standalone' tried to address.

--
Philip 

