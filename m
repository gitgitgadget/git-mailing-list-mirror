Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DE91F424
	for <e@80x24.org>; Tue, 24 Apr 2018 19:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbeDXTlp (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 15:41:45 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:29989 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDXTln (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 15:41:43 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id B3oof78Kq4ZqzB3oofniX5; Tue, 24 Apr 2018 20:41:41 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=xP4qXboQvojKe6j4mRgA:9
 a=wPNLvfGTeEIA:10
Message-ID: <2494D111781E4353B9522D5FFA3D8F0E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "Git List" <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Stefan Beller" <sbeller@google.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Phillip Wood" <phillip.wood@dunelm.org.uk>,
        "Igor Djordjevic" <igor.d.djordjevic@gmail.com>,
        "Johannes Sixt" <j6t@kdbg.org>,
        "Sergey Organov" <sorganov@gmail.com>,
        =?iso-8859-1?Q?Martin_=C5gren?= <martin.agren@gmail.com>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de> <7360a072f6fdd276d30839613434329b645e2cce.1524306546.git.johannes.schindelin@gmx.de> <9270DF86352B4E3493AADA159E7FFE33@PhilipOakley> <nycvar.QRO.7.76.6.1804231401130.15174@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <0E6803122A5241F98148087A045993BC@PhilipOakley> <nycvar.QRO.7.76.6.1804241006230.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
Date:   Tue, 24 Apr 2018 20:41:38 +0100
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
X-Antivirus: AVG (VPS 180424-4, 24/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfJ1m+CObmXlC2kcb6PJEMSPla9kZHPGVGozSxTYwclPFgn1YSC6Kt0Wf507xCYr2emuibrylFk+ndJ7K/oy4MzItmdpeJ0OFquVolDbwC7hSSCGq3UfY
 F3IPmuPX1pQYCZCpOnDI6h5xbzxvfQUclKaezjAgsqcq1dH6+sAVkK1hBwoIGVx+YB9XQIGg1+KrSCaTDu8g8D3TK+BGv+MAeqcoTSqGRhYD96VI/+qvIqbO
 o8Enn1vnv54GsuZYGj3LtO7Yggcm3+wpJpDz81ArPz7MxtDuBUATLPywRy+PEt0LI4C6t4dcoOZVpO70iT5LTJUuZqEPVDVJQnDs6AYSfK6LAC98dJD8gSgz
 qu0cuVDCADuz+7CgKjKyol5JCGTRhxdpDEfCUi1phCKc2k8URdmZaShZh7k9OLIpVka8QsXHdftvwmzW0XGr6w0SsAdGJq/W6blCfWq63VuFiEkkzXP4p2kK
 CCw7uzzoKbIknjX5ICotoWQi+NEd6gupLB5hmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> On Mon, 23 Apr 2018, Philip Oakley wrote:
>
>> From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de> : Monday, April 
>> 23,
>> 2018 1:03 PM
>> Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
>>
>> [...]
>> >
>> > > > label onto
>> > > >
>> > > > # Branch abc
>> > > > reset onto
>> > >
>> > > Is this reset strictly necessary. We are already there @head.
>> >
>> > No, this is not strictly necessary, but
>>
>> I've realised my misunderstanding. I was thinking this (and others) was
>> equivalent to
>>
>> $  git reset <thatHead'onto'> # maybe even --hard,
>>
>> i.e. affecting the worktree
>
> Oh, but it *is* affecting the worktree. In this case, since we label HEAD
> and then immediately reset to the label, there is just nothing to change.
>
> Consider this example, though:
>
> label onto
>
> # Branch: from-philip
> reset onto
> pick abcdef something
> label from-philip
>
> # Branch: with-love
> reset onto
> pick 012345 else
> label with-love
>
> reset onto
> merge -C 98765 from-philip
> merge -C 43210 with-love
>
> Only in the first instance is the `reset onto` a no-op, an incidental one.
> After picking `something` and labeling the result as `from-philip`,
> though, the next `reset onto` really resets the worktree.
>
>> rather that just being a movement of the Head rev (though I may be having
>> brain fade here regarding untracked files etc..)
>
> The current way of doing things does not allow the `reset` to overwrite
> untracked, nor ignored files (I think, I only verified the former, not the
> latter).
>
> But yeah, it is not just a movement of HEAD. It does reset the worktree,
> although quite a bit more gently (and safely) than `git reset --hard`. In
> that respect, this patch series is a drastic improvement over the Git
> garden shears (which is the shell script I use in Git for Windows which
> inspired this here patch series).
>
thanks for clarifying. Yes my reasoning  was a total brain fade ... Along 
with the fact that it's a soft/safe/gentle reset.
--
Philip 

