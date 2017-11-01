Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66E7520450
	for <e@80x24.org>; Wed,  1 Nov 2017 00:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbdKAA1H (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 20:27:07 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:63739 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdKAA1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 20:27:06 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 9gs4eVHFnlmqO9gs4eJpHg; Wed, 01 Nov 2017 00:27:05 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=H+Sr+6Qi c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=pGLkceISAAAA:8 a=5rxgeBVgAAAA:8 a=1XWaLZrsAAAA:8 a=wa-yz7NzkRbO4_WDCWAA:9
 a=wPNLvfGTeEIA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <2A1B66E868594FC984FED8F0EDEAF900@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Yubin Ruan" <ablacktshirt@gmail.com>
Cc:     <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
References: <ab9b5c63-ca38-6157-6732-78aa5d5f291f@gmail.com> <xmqqd1542b5r.fsf@gitster.mtv.corp.google.com>
Subject: Re: Meaning of two commit-ish hash in git diff
Date:   Wed, 1 Nov 2017 00:27:02 -0000
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
X-Antivirus: AVG (VPS 171031-4, 31/10/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfBACQjoznBp6Jy2HabU0YoGZGYkFmagZbZNNJEmaPudOoZCF7fp87Z5BAVki3yNWg5uC7KIJE0BjnkjZyIafYv+Ba/A0B6SLtNKe8AyPhquw6SZOOfep
 7L+DnmTfGMrLSNk9/CTpjIotYxI2k7HASF3U/Ns8Puo65sJ+PWWzIP4erlvSJHba9WQ3hYoNOP0CJG+RlUg8ClaAMGkp7SYMMHARyC8c+mV+44kn8H30lGRr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yubin ,

From: "Junio C Hamano" <gitster@pobox.com>
> Yubin Ruan <ablacktshirt@gmail.com> writes:
>
>> diff --git a/path/somefile b/path/somefile
>> index f8886b4..a1c96df 100644
>> --- a/path/somefile
>> +++ b/path/somefile
>> <snip>
>>
>> This is output by a `git diff` between two adjacent commits but they are
>> not any commit hash. I grep through the whole $(git log) but still cannot
>> find those hash.
>
> The f8886b4 you see on the left is the name of the blob object on
> the left hand side of the comparison that produced this output;
> similarly a1c96df is the name of the blob object on the right hand
> side of the comparison.
>
> IOW, if you have the contents of the blob whose object name is
> f8886b4, by applying this patch, you will get a blob whose object
> name is a1c96df.
>
> The information is used by "git am -3" when the patch does not apply
> cleanly to fall back to the 3-way merge.

The ability to 'git describe` those blob object IDs is currently the subject 
of a patch series
https://public-inbox.org/git/20171031211852.13001-1-sbeller@google.com/

Maybe see if would have helped ;-)

Philip 

