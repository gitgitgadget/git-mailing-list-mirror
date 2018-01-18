Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A28B1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754882AbeARVYc (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:24:32 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:14211 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753928AbeARVYa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:24:30 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id cHffeTdTqAp17cHffeDX4a; Thu, 18 Jan 2018 21:24:27 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=7BKP_PJc6Qcrf2-FrQ0A:9 a=QEXdDO2ut3YA:10
Message-ID: <F2A95961E128479484699EC5DDC9243D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jacob Keller" <jacob.keller@gmail.com>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>
Cc:     "Git mailing list" <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de> <CA+P7+xozcQD2xuys6mh8MsfcYZ_nb2c9yxhDxkc7FTN2SfoofQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the revision
Date:   Thu, 18 Jan 2018 21:24:28 -0000
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
X-Antivirus: AVG (VPS 180118-34, 18/01/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfC4jBaKJeMZX8xeTgoamXC/wEBPrOTopwQ4Z+acv1oIhPYDn2jJ6k20/7SE34kDGSh46MCLdyT2ejOxPIh8hYA1TNkTEU4fGxvNkGXB3ONfXWGdSpZ8B
 eGYqksalqWWqXnrGoEeFH7+JBwGqlOHir5HArkQDGOw8P/Odmw7qOSvTPUOFIKQhKbuUOmsLuNkN8AuEGanGUsg9MgUZqUdayl7UY+5cnV3ZCYTKVy/eMctF
 5TB3p6AR/RrGLiy6GclMZgrKvKd7CQT7+Iswqd8P4Is=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jacob Keller" <jacob.keller@gmail.com>
> On Thu, Jan 18, 2018 at 7:35 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> This commit implements the commands to label, and to reset to, given
>> revisions. The syntax is:
>>
>>         label <name>
>>         reset <name>
>>
>> As a convenience shortcut, also to improve readability of the generated
>> todo list, a third command is introduced: bud. It simply resets to the
>> "onto" revision, i.e. the commit onto which we currently rebase.
>>
>
> The code looks good, but I'm a little wary of adding bud which
> hard-codes a specific label. I suppose it does grant a bit of
> readability to the resulting script... ? It doesn't seem that
> important compared to use using "reset onto"? At least when
> documenting this it should be made clear that the "onto" label is
> special.
>
> Thanks,
> Jake.

I'd agree.

The special 'onto' label should be fully documented, and the commit message 
should indicate which patch actually defines it (and all its corner cases 
and fall backs if --onto isn't explicitly given..)

Likewise the choice of 'bud' should be explained with some nice phraseology 
indicating that we are growing the new flowering from the bud, otherwise the 
word is a bit too short and sudden for easy explanation.

Philip 

