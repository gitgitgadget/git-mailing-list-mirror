Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3669A1FCA9
	for <e@80x24.org>; Sat, 17 Sep 2016 19:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754217AbcIQTME (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 15:12:04 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:2102 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbcIQTMD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 15:12:03 -0400
Received: from PhilipOakley ([92.22.56.161])
        by smtp.talktalk.net with SMTP
        id lL1sbwZBJ0KuvlL1sbgb9T; Sat, 17 Sep 2016 20:12:01 +0100
X-Originating-IP: [92.22.56.161]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=jHxjN4OXtc1iyzOC0JcFMQ==:117
 a=jHxjN4OXtc1iyzOC0JcFMQ==:17 a=8nJEP1OIZ-IA:10 a=Se5wIYXLAAAA:8
 a=dpXF_-RtjDwth1KOWLcA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=wPNLvfGTeEIA:10
 a=lbW8yuQPzwA5_v1K6RW9:22
Message-ID: <0B172DDC12B24525AF5FCEC4216B69E3@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Fredrik Gustafsson" <iveqy@iveqy.com>,
        "Andrew Johnson" <ajohnson388@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CAM_5GX48gDAZSvAWnxO5n8uhYf8vmfAJ88_31_ewsQxyPfF7iA@mail.gmail.com> <20160917183919.GJ20666@paksenarrion.iveqy.com>
Subject: Re: Why are there multiple ways to get the manual in Git?
Date:   Sat, 17 Sep 2016 20:12:01 +0100
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
X-CMAE-Envelope: MS4wfI2lF9MZCWdapAHA4wvb4XgnlvGzi8HNC4tZuzgYzuUzamTTSJl1+tZ1NN18rCRe5xn9r5g1O07RLedQaobd8usPR31FsodNnjMvdJ8hM1Cov5N85ByO
 rO66i8j2gVCUKBR9A0ulF2QokvYjNywhApgdOeXSEjXoNIJ7o+rVu9EJeWUfYuIYjZcY0ZD3Ime4NJfbBS7WZEUnZgtqOgoV2qb6QpBg6r5NLuJkaxvNM0P1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Fredrik Gustafsson" <iveqy@iveqy.com>
> On Sat, Sep 17, 2016 at 01:47:52PM -0400, Andrew Johnson wrote:
>> $ git help <verb>
>> $ git <verb> --help
>> $ man git-<verb>
>>
>> I tested all three to confirm they were equivalent.

It is (IIUC) in a general sort of way "by design", and a little bit of 
accident.

>
> While I'm not able to answer your question, I can shred a little light
> about them not being equal. For example using a windows machine
>
> $ man git <verb>
>
> does not work and
>
> $ git help <verb>
>
> opens a webbrowser instead of a man page. Using a unix system I would
> however assume that
>
> $ man git <verb>
>
> would work since it's the standard way of getting help on those systems.
>
> -- 

Historically git was a set of shell scripts named git-*, so each stood 
alone.

Then there was the great consolidation (around V1.6?) which created the 
modern `git <cmd>' approach, with every command normally having  -h 
and --help options for short form usage and long form man pages.

The option capability became standardised. Also a `git help <cmd>` command 
was created. Underneath there are still the (backward compatible) git-* 
forms. The help command allowed selection of display type, so that on 
Unix/Linux man was the norm, while an --html (or --web) option is available 
for those who like the pretty browser view

The help commnad just converts the parameters to achieve the expected 
display (with various fallbacks if the command or guide is missing, etc)

Meanwhile on Windows, the man facility was not ported as part of git, so it 
defaults to the --web version. If you are on Windows, and download the SDK 
as well you can install the man viewer and other goodies

--
Philip

