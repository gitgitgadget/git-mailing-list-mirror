Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173DBC433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF24E64EAD
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhBRQlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbhBRNBD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 08:01:03 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B47CC061786
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 04:59:52 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DhF9v0HRBz1ryX5;
        Thu, 18 Feb 2021 13:57:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DhF9t6tzmz1sP6n;
        Thu, 18 Feb 2021 13:57:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 3UJVpDXizFSr; Thu, 18 Feb 2021 13:57:54 +0100 (CET)
X-Auth-Info: qwXMa5PQD5ntpIWTbcKvEUtNgi7+zeVUe9Iml/ExSao9JHh6OZdeaQGr94YFy1aS
Received: from igel.home (ppp-46-244-187-212.dynamic.mnet-online.de [46.244.187.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 18 Feb 2021 13:57:54 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id AD38B2C3207; Thu, 18 Feb 2021 13:57:53 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Jan =?utf-8?B?4oCcS2hhcmRpeOKAnSBTdGFuxJtr?= <khardix@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-send-email: smtpserver in $HOME
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
        <xmqqo8gksqr4.fsf@gitster.c.googlers.com>
        <CAG+K25NbifB9k9ugU5ZjLAOKxLyfEZcphfZXNS9_Whi6gZcBLA@mail.gmail.com>
        <xmqq7dn7rgi4.fsf@gitster.c.googlers.com>
        <CAG+K25NC3H7L5TpxmR_kCvmqR8GPdCEdTt740F34ON4TWoPCpg@mail.gmail.com>
        <CAPx1Gvf1pXCp9YVQSQ1_-w3-A8qYZD7tsFV80njsXD-+Jap6Xw@mail.gmail.com>
X-Yow:  Are we on STRIKE yet?
Date:   Thu, 18 Feb 2021 13:57:53 +0100
In-Reply-To: <CAPx1Gvf1pXCp9YVQSQ1_-w3-A8qYZD7tsFV80njsXD-+Jap6Xw@mail.gmail.com>
        (Chris Torek's message of "Thu, 18 Feb 2021 02:18:25 -0800")
Message-ID: <878s7lzg6m.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Feb 18 2021, Chris Torek wrote:

> Just a small point here:
>
> On Tue, Feb 16, 2021 at 2:17 PM Jan “Khardix” Staněk <khardix@gmail.com> wrote:
>> Well, unless I'm missing something, shouldn't the tilde above be
>> expanded by the shell before actually being passed as argument?
>
> Maybe.  Some shells do and some don't:
>
> $ echo foo=~/foo
> foo=~/foo
>
> bash$ echo foo=~/foo
> foo=/home/torek/foo

But:

$ echo --foo=~/foo
--foo=~/foo

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
