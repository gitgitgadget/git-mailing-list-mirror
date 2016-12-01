Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065AE1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 23:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757940AbcLAXMz (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 18:12:55 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:24945 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757476AbcLAXMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 18:12:54 -0500
Received: from PhilipOakley ([92.22.76.48])
        by smtp.talktalk.net with SMTP
        id CaX4cMhPTg5ctCaX4c6UjT; Thu, 01 Dec 2016 23:12:52 +0000
X-Originating-IP: [92.22.76.48]
X-Spam: 0
X-OAuthority: v=2.2 cv=bdMpa6HB c=1 sm=1 tr=0 a=vRWDVfjl5WB+WvFCAxwqDQ==:117
 a=vRWDVfjl5WB+WvFCAxwqDQ==:17 a=8nJEP1OIZ-IA:10 a=1XWaLZrsAAAA:8
 a=2oZe82ojvCiqqbUOpIgA:9 a=wPNLvfGTeEIA:10 a=nJcEw6yWrPvoIXZ49MH8:22
Message-ID: <2297C36B9A1441748D7E68363A05F8C5@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Brandon Williams" <bmwill@google.com>,
        "Ramsay Jones" <ramsay@ramsayjones.plus.com>
Cc:     "Jeff King" <peff@peff.net>, <git@vger.kernel.org>,
        "Jann Horn" <jannh@google.com>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net> <20161201090414.zgz7pimgpctghbwu@sigill.intra.peff.net> <331124b5-aa2b-773c-23ac-975ad3f50dbf@ramsayjones.plus.com> <20161201225331.GH54082@google.com>
Subject: Re: [PATCH 2/6] http: always update the base URL for redirects
Date:   Thu, 1 Dec 2016 23:12:49 -0000
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
X-CMAE-Envelope: MS4wfPzKH3oaEYFsxElcjuUewqbh4izAKxzV0Hx/dtuLXav44X3xuz4nk+TmLp47Nr8MSjACS29v+RFy47TNTJ5XrJW4ELsRNUGSIE/1PYK5pAIEm84By/pS
 funp0wZOa4nZQb1dJjDsPJ/2LzvtzwJLXvBdd7E6brHwizDljzlSYcVMSNoyEmCEEOzetTLW655u2j5RvhFdU+JvhOj7ou1miv8UYDW5vQiZMhg16kqoE5h+
 9TQZ2l7DabDDwvut7WqNGH1SNLK34OELiOqjaC5yH9NL2Qg0xQ8q2R1Stvnd+zPK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Brandon Williams" <bmwill@google.com>
> On 12/01, Ramsay Jones wrote:
>>
>>
>> On 01/12/16 09:04, Jeff King wrote:
>> > If a malicious server redirects the initial ref
>> > advertisement, it may be able to leak sha1s from other,
>> > unrelated servers that the client has access to. For
>> > example, imagine that Alice is a git user, she has access to
>> > a private repository on a server hosted by Bob, and Mallory
>> > runs a malicious server and wants to find out about Bob's
>> > private repository.
>> >
>> > Mallory asks Alice to clone an unrelated repository from her
>> -----------------------------------------------------------^^^
>> ... from _him_ ? (ie Mallory)
>>
>> > over HTTP. When Alice's client contacts Mallory's server for
>> > the initial ref advertisement, the server issues an HTTP
>> > redirect for Bob's server. Alice contacts Bob's server and
>> > gets the ref advertisement for the private repository. If
>> > there is anything to fetch, she then follows up by asking
>> > the server for one or more sha1 objects. But who is the
>> > server?
>> >
>> > If it is still Mallory's server, then Alice will leak the
>> > existence of those sha1s to her.
>> ------------------------------^^^
>> ... to _him_ ? (again Mallory)
>>
>> ATB,
>> Ramsay Jones
>
> Depends, I only know Mallorys who are women so her seems appropriate.
>
> -- 
> Brandon Williams
>
In a British context "Mallory and Irvine" were two (male) climbers who died 
on Everest in 1924 (tales of daring...), so it's easy to expect (from this 
side of the pond) that 'Mallory' would be male. However he was really George 
Mallory.

Meanwhile that search engine's images shows far more female Mallorys, so 
I've learnt something.
--
Philip

