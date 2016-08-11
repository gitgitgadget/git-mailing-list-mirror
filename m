Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E8520193
	for <e@80x24.org>; Thu, 11 Aug 2016 19:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbcHKTLq (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 15:11:46 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:60017 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbcHKTLp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 15:11:45 -0400
Received: from PhilipOakley ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id XvOJbUS640KuvXvOJbHxzP; Thu, 11 Aug 2016 20:11:43 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=pGLkceISAAAA:8 a=xtxXYLxNAAAA:8 a=P86X7i9WwggY1kuPCiMA:9
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=6kGIvZw6iX1k4Y-7sg4_:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <75D9C1DBD21648F0B2511AA183C20CCD@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>,
	"Jacob Keller" <jacob.keller@gmail.com>
Cc:	"Git List" <git@vger.kernel.org>
References: <D8F2D8316A4C4E198C6847C1165A8811@PhilipOakley><CA+P7+xpyCQLsEHE-Hqqob5mQisW=aw1gC+5f6Qq3q01etjX2Ng@mail.gmail.com><CA+P7+xrBegRdS-HXi2SfO0Uu6N=gUVVp_F29GCb1rQn9cnxnHQ@mail.gmail.com> <xmqq4m6r2npv.fsf@gitster.mtv.corp.google.com>
Subject: Re: Can cc's be included in patches sent by send-email
Date:	Thu, 11 Aug 2016 20:11:42 +0100
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
X-CMAE-Envelope: MS4wfDsSYg1i8uCu8pn2Km3w+XC3519iFqVsiJ7CKfUflloWEoHdZZbCd+cOwHIIdtBiA9anDA68Ih2rC3lZ9MLd3HCgFDo3SgvLrd2ICxCtlTD9SvKU+brL
 +3yIXFUbhIRkpbk4XYXJAAr91EzXHbWo2ZmoNcJNfRdDcTblx7E4VwR/33I8PT7PlfPheTdyUGk3A21/CQjs+T3kE55p0UcppSu2bEceMkNyDpNwLNoKJs/X
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> On Thu, Aug 11, 2016 at 12:58 AM, Jacob Keller <jacob.keller@gmail.com> 
>> wrote:
>>> On Thu, Aug 11, 2016 at 12:32 AM, Philip Oakley <philipoakley@iee.org> 
>>> wrote:
>>>> While 'git send-email' can have multiple --cc="addressee" options on 
>>>> the
>>>> command line, is it possible for the "cc:addressee<a@b.c>" to actually 
>>>> be
>>>> included in the patches that are to be sent, so that different patches 
>>>> can
>>>> have different addressee?
>>>>
>>>> The fortmat-patch can include appropriate from lines, so it feels as if 
>>>> the
>>>> sender should be able to add cc: lines at the same place. Maybe its 
>>>> just
>>>> part of th docs I've missed.
>>>>
>>>
>>> Yes, just put them in the body as tags below the signed-off-by. It
>>> should be on by default unless you change supresscc or signedoffbycc
>>> configuration.
>>>
>>> Thanks,
>>> Jake
>>>
>>
>> See --suppress-cc or --signed-off-by-cc help in git help send-email.
>
> Also, those who do not want to see Cc: in headers (like me) can
> instead edit the header part of the format-patch output to add Cc:
> lines and they should be picked up.
> --
When done via git gui, it looks like the Cc: is also included in the commit 
message (first initial tries)

I'd probably place them after a --- break so that they don't get into the 
applied commit message, but will carry around during my rebasing. I've still 
to test if it works though.

Philip 

