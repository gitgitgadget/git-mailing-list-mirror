Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6134F20C2E
	for <e@80x24.org>; Wed, 18 Jan 2017 20:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdARUQm (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:16:42 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:33527 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdARUQl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:16:41 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id TwWecmf1u0KuvTwWecPiE1; Wed, 18 Jan 2017 20:08:09 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=olItXKtLRfRg-Hn26N8A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=avl4LiGQNoF5OB0DmCJ7:22 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <254445096AD0412287CBB994E8BCA043@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Jacob Keller" <jacob.e.keller@intel.com>
Cc:     <git@vger.kernel.org>, "Johannes Sixt" <j6t@kdbg.org>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Jacob Keller" <jacob.keller@gmail.com>
References: <20170118000930.5431-1-jacob.e.keller@intel.com>        <20170118000930.5431-2-jacob.e.keller@intel.com> <xmqq37gg9moc.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v3 1/5] doc: add documentation for OPT_STRING_LIST
Date:   Wed, 18 Jan 2017 20:08:09 -0000
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
X-CMAE-Envelope: MS4wfJ54MoDSLNbpX39Zreul4vyXF4TF/qTBHazx11o9bmDiJqG4PvYnw/yLsXtSc2i+PjWh5KD2y7fYcU+bUhwIh0O2Nd7tdio4zIDilmusUYFhCPegVBld
 IejBcy8tAhxG3eqgNToMyjDS1mSOtprT1FuaypGCFtfnHoxfhnUPIw+x69AI/z6tFYB3OcpIhXO9zQS+oDJO3ysYk9mu+JSfFKzYrv+DnDH9J+IXihLMbjVm
 0jIIpDaoVrVH6LGNVxML+xi7p2lKaj9oxGwiHNdfkNd3yurr2Nq8exbCb8/KA/y75gPAdHs2V217kpPktGNWDBC5hMjkLGU+8fqBBcjPj9Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
v3 1/5] doc: add documentation for OPT_STRING_LIST


> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Commit c8ba16391655 ("parse-options: add OPT_STRING_LIST helper",
>> 2011-06-09) added the OPT_STRING_LIST as a way to accumulate a repeated
>> list of strings. However, this was not documented in the
>> api-parse-options documentation. Add documentation now so that future
>> developers may learn of its existence.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>>  Documentation/technical/api-parse-options.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/technical/api-parse-options.txt 
>> b/Documentation/technical/api-parse-options.txt
>> index 27bd701c0d68..6914f54f5f44 100644
>> --- a/Documentation/technical/api-parse-options.txt
>> +++ b/Documentation/technical/api-parse-options.txt
>> @@ -168,6 +168,11 @@ There are some macros to easily define options:
>>  Introduce an option with string argument.
>>  The string argument is put into `str_var`.
>>
>> +`OPT_STRING_LIST(short, long, &list, arg_str, description)`::
>> + Introduce an option with string argument.
>> + The string argument is stored as an element in `&list` which must be a
>> + struct string_list. Reset the list using `--no-option`.
>> +
>
> I do not know if it is clear enough that 'option' in the last
> sentence is a placeholder.  I then wondered if spelling it as
> `--no-<long>` would make it a bit clearer, but that is ugly.

Bikeshedding:: `--no-<option>` maybe, i.e. just surround the option word 
with the angle brackets to indicate it is to be replaced by the real 
option's name.

>
> The "Reset the list" is an instruction to the end-users who interact
> with a program written by readers of this document using
> OPT_STRING_LIST(), and it feels a bit out of place.  Perhaps
>
> End users can reset the list by negating the option,
> i.e. passing "--no-<long>", on the command line.
>
> I dunno.
>
> Anyway, thanks for adding a missing doc here.
>
>>  `OPT_INTEGER(short, long, &int_var, description)`::
>>  Introduce an option with integer argument.
>>  The integer is put into `int_var`.
>
--

Philip 

