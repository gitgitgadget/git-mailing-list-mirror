Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF07A1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbdFJOoL (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 10:44:11 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:49491 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbdFJOoK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 10:44:10 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id JhcVdc24N3fb0JhcVdRVTP; Sat, 10 Jun 2017 15:44:08 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=TerUjlYh c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=Q9fys5e9bTEA:10 a=pGLkceISAAAA:8
 a=WaOnP9b13GN8YlazSqwA:9 a=PUjeQqilurYA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <0E6CC91ED74848B78F9A2DFC7DF48AE5@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, <sandals@crustytoothpaste.net>
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>         <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com> <1497084241.8531.2.camel@gmail.com>
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a parent-less branch
Date:   Sat, 10 Jun 2017 15:44:08 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-15";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170609-4, 09/06/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfIlQ3A7IE8DFmjRU4r83hHeT22nD409sMcjO3ZoPtPZevB2QH4PoR5hZm9V/Ttw8hWr3jaFlg4l8+9bLmn1y3j12uCpX5TU/xhiXbWeuCi3ZEZTZqqXq
 rX8BEmQFHKK/WsEUPEgJ70EafghWzX176BcyDN5P75ERaKRJnoaEijNz7jE62UjZzA7FK8p70WnMycN4G5fuSZVoDZ+6qbkVD+102eDPTtl67auenCtFAf8Y
 KiRvpQlZtETli7Jfp550ppAkJxggzFwbAjIGfvuwUSHlV7mhxY183Qy8+bo6xdwy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>
> On Sat, 2017-06-10 at 11:23 +0900, Junio C Hamano wrote:
>> $ git shortlog -20 --no-merges
>>
>> may help learning the preferred style of writing the title. We do
>> not say "[I] did this". Instead we phrase things in imperative
>> mood, giving an order to the codebase to "become like so". E.g.
> This style is a little new to me thus my commit message turned out to
> be a repercussion of my own style (which, I guess, targets other
> developers who read the log). Will be careful the next time :). Made
> the requested changes except for a few doubts they raised (see comments
> below).
>
>> And it wasn't just "a little" confusing.
>>
>> "git status" indicated "Initial commit" when HEAD points at
>> an unborn branch. This message is shared with the commit
>> log template "git commit" prepares for the user when
>> creating a commit (i.e. "You are about to create the initial
>> commit"),
> I didn't get that, where should I be seeing the line, "You are about to
> create the initial commit" in the commit template ? I just saw "Initial
> commit" in it.
>
>> Does this break "git commit", or is the update limited to "git
>> status"?
> This does seem to be breaking 'git commit' as it seems to be using the
> output of 'git status'. This change results in the following commit
> template for the initial commit,
>
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
> # On branch master
> #
> # Waiting for initial commit

To me this sounds perfectly natural. It is the current status. The line will 
be ignored by the commit message anyway unless the user edits the start of 
the line.

At most it is a feeling that maybe we should provide an imperative 
statement, but even then, it's still stating the obvious (which is normally 
a bad thing). If the user is adding a .gitignore file then the commit 
message should say so, etc. Maybe the "Initial commit" is meant to be the 
default (by convention) separator, or its just a convention we've become 
used to.

> #
> # Changes to be committed:
> # new file: test-file
> #
>
> Looks odd. Not sure how to fix this. Maybe on of the alternatives have
> to be considered. "Your current branch does not have any commits" seems
> a good one.
>
> -- 
> Regards,
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

--
Philip 

