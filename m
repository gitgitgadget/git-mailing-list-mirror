Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40BD120437
	for <e@80x24.org>; Mon, 16 Oct 2017 12:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbdJPMgg (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 08:36:36 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:9432 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdJPMge (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 08:36:34 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 44dEe25C3Ap1744dEe459V; Mon, 16 Oct 2017 13:36:32 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=L4Vzn0sPV8JG4VmkfugA:9 a=wPNLvfGTeEIA:10
Message-ID: <17346CCF8DEF41E790C96248408E07D2@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Ralf Thielow" <ralf.thielow@gmail.com>, <git@vger.kernel.org>
References: <20171013175157.13634-1-ralf.thielow@gmail.com> <20171015170742.8395-1-ralf.thielow@gmail.com> <xmqqfuajuae8.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710161331290.40514@virtualbox>
Subject: Re: [PATCH v2] sequencer.c: fix and unify error messages in rearrange_squash()
Date:   Mon, 16 Oct 2017 13:36:35 +0100
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
X-Antivirus: AVG (VPS 171016-2, 16/10/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfN8G9st2QHk0esAPuYAsgK6ugRfKcIBDxu0k+6lC6+LIAE1jYT49xpYNTZ/rIVb4TlKSbQkONAN0ka8n2Zp7kzG4dpDzLkGzfnstYaR6686EyqArqar/
 XmgozynWYOK1DvDwvJXTOAAfGw7uvFl7y3cG5t7ak9z+mQ1aRe8n1pfK/uFFxIye9/VfnhXoNK3G+F5Ipt6P2KjCKmkeI/aXdcdtiBl/mv6GcxbMrJx75N9D
 D68kltn8Y+b047dnYEqSqtT/eFphovbu8gEP78j1YCk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> On Mon, 16 Oct 2017, Junio C Hamano wrote:
>
>> Ralf Thielow <ralf.thielow@gmail.com> writes:
>>
>> > When the write opertion fails, we write that we could
>> > not read. Change the error message to match the operation
>> > and remove the full stop at the end.
>> >
>> > When ftruncate() fails, we write that we couldn't finish
>> > the operation on the todo file. It is more accurate to write
>> > that we couldn't truncate as we do in other calls of ftruncate().
>>
>> Wouldn't it be more accurate to say we couldn't ftruncate, though?
>
> This is an end-user facing error message, right? Should we not let users
> who are happily oblivious of POSIX nomenclature remain happily oblivious?
>
> In other words, I would be finer with "truncate" than with "ftruncate...
> wait, huh? Is that even English?"
>
Hi, 'Truncate' is real English, but it is not that common in normal usage.

My dictionary suggests that it means 'cut off at the tip' such as a 
truncated cone. However the thesaurus is far more relaxed about the common 
idioms that truncate at the tail such as: clip, crop, cut short, trim, 
abbreviate, curtail, etc.

So perhaps "could not trim '%s'".

--
Philip

