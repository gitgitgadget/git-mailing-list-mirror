Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6857202A0
	for <e@80x24.org>; Sat,  4 Nov 2017 21:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbdKDVP2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 17:15:28 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:26041 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbdKDVP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 17:15:27 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id B5mmeb7sqbjdZB5mmext3Y; Sat, 04 Nov 2017 21:15:25 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=rVMzeJTJGKSMC2muom8A:9 a=wPNLvfGTeEIA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <BFE987312194406AAAEA8DAC7EC5BFF5@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Stefan Beller" <sbeller@google.com>
Cc:     "git" <git@vger.kernel.org>, "Kevin Daudt" <me@ikke.info>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
References: <20171028004419.10139-1-sbeller@google.com>        <20171031003351.22341-1-sbeller@google.com>        <20171031003351.22341-7-sbeller@google.com>        <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>        <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com>        <xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com>        <CAGZ79kYC4=rDSWC7WCGVL4n4OC8BpvMJFwxx+LV9GqoGnSHFSA@mail.gmail.com>        <xmqqinetsayr.fsf@gitster.mtv.corp.google.com> <xmqq375xs3zr.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
Date:   Sat, 4 Nov 2017 21:15:18 -0000
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
X-Antivirus: AVG (VPS 171104-0, 04/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfBsfmv/6NVhS4C8IkvsIG4lsxeRnkJNGrsYTGVwtg4hUc4cWI9BpAKN0qFSBNO3K4i0+f6j/e9GXbUIk0p4gW4s11E21u9G9UUCwbxqFcTtbr4XeyS4a
 EuTb7pM8ukwuNyt0Kp6KVcFjcEurv2Hse+dtlTIy9bxfjc8r33RrP/a95mI3vZsst56CXx6/MvHmNkRNG0QFNeB96adPD5oLlIFxKD2daZErVvbfHU9Hb3ez
 M9Ut7w/YXHXW9j7jxE1Tv3A1TjWe7MFvLZO/VGkNihyIQzaz65ojEiC3buR1Pb8MQ+V4hTnJILKQ53NEwVOj8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Thursday, November 02, 2017 4:23 AM
> Junio C Hamano <gitster@pobox.com> writes:
>
>> The reason why we say "-ish" is "Yes we know v2.15.0 is *NOT* a
>> commit object, we very well know it is a tag object, but because we
>> allow it to be used in a context that calls for a commit object, we
>> mark that use context as 'this accepts commit-ish, not just
>> commit'".
>
> Having said all that, there is a valid case in which we might want
> to say "blob-ish".

Is this not also an alternative case, relative to the user, for the scenario 
where the user has an oid/sha1 value but does not know what it is, and would 
like to find its source and type relative to the `describe` command.

IIUC the existing `describe` command only accepts <commit-ish> values, and 
here we are extending that to be even more inclusive, but at the same time 
the options become more restricted. Thus the synopsis terminology would be 
more about suggesting the range of options available (search style/start 
points) that are applicable to blobs, than being exactly about the 
'allow-blobs' parameter.

Or have I misunderstood how the fast commit search and the slower 
potentially-a-blob searching are disambiguated?
--
Philip

>
> To review, X-ish is the word we use when the command wants to take
> an X, but tolerates a lazy user who gives a Y, which is *NOT* X,
> without bothering to add ^{X} suffix, i.e. Y^{X}.  In such a case,
> the command takes not just X but takes X-ish because it takes a Y
> and converts it internally to an X to be extra nice.
>
> When the command wants to take a blob, but tolerates something else
> and does "^{blob}" internally, we can say it takes "blob-ish".
> Technically that "something else" could be an annotated tag that
> points at a blob object, without any intervening commit or tree (I
> did not check if the "describe <blob>" code in this thread handles
> this, though).
>
> But because it is not usually done to tag a blob directly, it would
> probably be not worth to say "blob-ish" in the document and cause
> readers to wonder in what situation something that is not a blob can
> be treated as if it were a blob.  It does feel like we would be
> pursuing technical correctness too much and sacrificing the readability
> of the document, at least to me, and a bad trade-off.
>
> 

