Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4B11F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751046AbeDXVe2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:34:28 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:38977 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDXVe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:34:27 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id B5Zof7Udi4ZqzB5ZvfnqR8; Tue, 24 Apr 2018 22:34:26 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=BCjA09oAAAAA:8
 a=fAg4IBucyuwCp2N5FAMA:9 a=wPNLvfGTeEIA:10 a=jYKBPJSq9nmHKCndOPe9:22
Message-ID: <538CF27C224E4AE0A1C45374AE367C3A@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
        "Jakub Narebski" <jnareb@gmail.com>,
        "Stefan Beller" <sbeller@google.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Christian Couder" <christian.couder@gmail.com>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de> <853b0a445ab1d78e8cbe19dacd09e70892b34b03.1524262793.git.johannes.schindelin@gmx.de> <52C2C5A51FE7400E937F06B7641F4319@PhilipOakley> <nycvar.QRO.7.76.6.1804242106220.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Subject: Re: [PATCH v3 09/11] technical/shallow: describe the relationship with replace refs
Date:   Tue, 24 Apr 2018 22:34:16 +0100
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
X-CMAE-Envelope: MS4wfCBFPTnAjCeSQjMwTvnLTgfgFtKAcgNoViKhv0SAw4oM5fcH8KDV8XuRw6m87VRbv6Tt1ZsceROlfoU/Qs89IN7JLUyiYlDC/VyPUhJoTG8PWvIEfxLh
 aN5EWCcP/4a/Zs1Clduhxqgd7wkogz4Qppw5rh/1xcXFhG7eZZkUbU/uXji0JYTbIbYsvr3lldYAILq3sUGSS1BXpABuk/rQsu+F+s4LFIpfnjGTvtdYbTmP
 OFwUamiTepo1J/qN9bDm9uN8jK4mzFWfSocpmizHis5xFs2W6McDrr0I+N4LN6n5JJKDbBmio4XHPTe+STtDUJFkaa2YtvIYEwchHFsLQiPYKn3+DYMNduLm
 jNVZA6h8AxxUHF2oOp9rafNMvVo5bw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi dscho

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de> : Tuesday, April 
24, 2018 8:10 PM
> On Sun, 22 Apr 2018, Philip Oakley wrote:
>
>> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
>> > Now that grafts are deprecated, we should start to assume that readers
>> > have no idea what grafts are. So it makes more sense to describe the
>> > "shallow" feature in terms of replace refs.

Here we say we should drop the term "grafts"
>> >
>> > Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> > Documentation/technical/shallow.txt | 19 +++++++++++--------
>> > 1 file changed, 11 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/Documentation/technical/shallow.txt
>> > b/Documentation/technical/shallow.txt
>> > index 5183b154229..b3ff23c25f6 100644
>> > --- a/Documentation/technical/shallow.txt
>> > +++ b/Documentation/technical/shallow.txt
>> > @@ -9,14 +9,17 @@ these commits have no parents.
>> > *********************************************************
>> >
>> > The basic idea is to write the SHA-1s of shallow commits into
>> > -$GIT_DIR/shallow, and handle its contents like the contents
>> > -of $GIT_DIR/info/grafts (with the difference that shallow
>> > -cannot contain parent information).
>> > -
>> > -This information is stored in a new file instead of grafts, or
>> > -even the config, since the user should not touch that file
>> > -at all (even throughout development of the shallow clone, it
>> > -was never manually edited!).
>> > +$GIT_DIR/shallow, and handle its contents similar to replace
>> > +refs (with the difference that shallow does not actually
>> > +create those replace refs) and
>>
>> If grafts are deprecated, why not alse get rid of this mention and simply
>> leave the 'what it does' part.
>
> Internally, shallow commits are implemented using the graft code path, and

however the change here is just to the documentation, independent of th code 
path's name.

> they always will be: we will always need a list of the shallow commits,
> and we will always need to be able to lift the "shallow" attribute
> quickly, when deepening a shallow clone.
>
> So it makes sense to mention that here, because we are deep in technical
> details in Documentation/technical/.
>
>> >                                               very much like the 
>> > deprecated
>> > +graft file (with

I was looking to snip this 'graft' reference, as per the commit message..

>>
>> >                           the difference that shallow commits will
>> > +always have their parents grafted away, not replaced by
>> s/their parents grafted away/no parents/ (rather than being replaced..)

Then I botched this substitution

>
> But the commits will typically have parents. So they really will have
> their parents grafted away as long as they are marked "shallow"...

OK, maybe I mis-used the figurative 'no parents', when it means the literal 
'parents not present'.

Perhaps something like:
+$GIT_DIR/shallow, and handle its contents similar to replace
+refs (with the difference that shallow does not actually
+create those replace refs) with the difference that shallow commits will
+always have their parents not present.

--
Philip 

