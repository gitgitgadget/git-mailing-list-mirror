Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB02201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 20:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdBSUlC (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 15:41:02 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:6907 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdBSUlB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 15:41:01 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id fYHyc1gOb46SJfYHyc3uq3; Sun, 19 Feb 2017 20:40:59 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=Pc-lDKLFxtHrjyiF4uMA:9 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22
Message-ID: <8147218721BE4F239D00CBFAFD9B495D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jeff King" <peff@peff.net>
Cc:     "Michael Haggerty" <mhagger@alum.mit.edu>,
        "Damien Regad" <dregad@mantisbt.org>, <git@vger.kernel.org>
References: <c27d7861-b161-a3eb-fcfc-bf766fc7b20b@gmail.com> <2116CBFFB78A482D8FA176BC680B3B9C@PhilipOakley> <20170219022756.pwxhjluxizuedf46@sigill.intra.peff.net>
Subject: Re: [PATCH] git-check-ref-format: fix typo in man page
Date:   Sun, 19 Feb 2017 20:40:59 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfJqheMe7D8Q7WzRSqRjw6Z5SW6IB/eyuknDxxMoJlMKbOUI2mCfITaBtqxZHxjbX0CAHqtGDlc1JfbXcsR/lJNPBbNxuKA3Y+kIgGPCOR6zuVw/g00fZ
 ro59MIzNep24rEx91OR/k1OIWniMYyEf3q8+6jikYJzdJl+tqdrXPxQEE38fBeGxuHzxzd/ee4GET1rwIMSUwUg5XnCdwg0Xh7IIE++hsXoC/GnTrnTbLUXm
 QDYvIRkKv1Sx2sai9ITnrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff King" <peff@peff.net>
> On Sun, Feb 19, 2017 at 12:20:33AM -0000, Philip Oakley wrote:
>
>> >  Normalize 'refname' by removing any leading slash (`/`)
>> >  characters and collapsing runs of adjacent slashes between
>> > - name components into a single slash.  Iff the normalized
>> > + name components into a single slash.  If the normalized
>> >  refname is valid then print it to standard output and exit
>> >  with a status of 0.  (`--print` is a deprecated way to spell
>> >  `--normalize`.)
>> > -- 
>>
>> Could that be an 'iff' == 'If and only if' (which is common in 
>> mathematics)?
>> Still could be spelling error though.
>
> When we're not sure what the intent of a change is, a good first step is
> to dig up the original commit via `git blame` or similar. In this case,
> it comes from a40e6fb67 (Change check_refname_format() to reject
> unnormalized refnames, 2011-09-15).

Oops, blaming a bit of code feels 'obvious' but I just hadn't thought to 
blame the doc, though it does feel as though code and the docs don't always 
go hand in hand.

>
> The commit message doesn't mention it (not that I really expected it
> to), but it does tell you who the author is. And a good second step is
> to cc them on the patch. :)
>
> I suspect it _was_ intended as "iff" here. In my opinion, we probably
> don't need to be so rigorous in this instance. However, I note that we
> do not describe the "else" half of that "if". So maybe an overall
> improvement would be something like:

I read the commit message the same, that is, only if the given ref name 
normalises to a true (properly formatted) ref will it be printed (sucess).

For those not familiar with 'iff', then a change to the doc is worthwhile.

>
>  If the normalized refname is valid then print it to standard output
>  and exit with a status of 0. Otherwise, exit with a non-zero status.
>
> -Peff
>
Thanks, Philip. 

