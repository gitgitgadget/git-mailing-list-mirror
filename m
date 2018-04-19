Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08441F404
	for <e@80x24.org>; Thu, 19 Apr 2018 04:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeDSEYx (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 00:24:53 -0400
Received: from mail.javad.com ([54.86.164.124]:52353 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbeDSEYv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 00:24:51 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 7C7553E966;
        Thu, 19 Apr 2018 04:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524111890;
        bh=2ftMBpXUgAeYUTCSbqvWUyb5bL156pyImdw+/gLv6Fc=; l=1448;
        h=Received:From:To:Subject;
        b=ICMdKN4pz5docHhVv5n4+vAsye6WOxGIGe0SB6lDvF3KbdNojKkSF8hGVglYfrI7v
         Qvj6gCFjyq4J1kbYwNf+t0ywqmnALJ1SW4wUqqU78QROuiHCIryfBMx9NOCSxRNtXf
         jCxaEaQLTaM2Q3xcveQ0/yPE4shLd1fFqKDjNzjs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524111890;
        bh=2ftMBpXUgAeYUTCSbqvWUyb5bL156pyImdw+/gLv6Fc=; l=1448;
        h=Received:From:To:Subject;
        b=ICMdKN4pz5docHhVv5n4+vAsye6WOxGIGe0SB6lDvF3KbdNojKkSF8hGVglYfrI7v
         Qvj6gCFjyq4J1kbYwNf+t0ywqmnALJ1SW4wUqqU78QROuiHCIryfBMx9NOCSxRNtXf
         jCxaEaQLTaM2Q3xcveQ0/yPE4shLd1fFqKDjNzjs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524111890;
        bh=2ftMBpXUgAeYUTCSbqvWUyb5bL156pyImdw+/gLv6Fc=; l=1448;
        h=Received:From:To:Subject;
        b=ICMdKN4pz5docHhVv5n4+vAsye6WOxGIGe0SB6lDvF3KbdNojKkSF8hGVglYfrI7v
         Qvj6gCFjyq4J1kbYwNf+t0ywqmnALJ1SW4wUqqU78QROuiHCIryfBMx9NOCSxRNtXf
         jCxaEaQLTaM2Q3xcveQ0/yPE4shLd1fFqKDjNzjs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524111890;
        bh=2ftMBpXUgAeYUTCSbqvWUyb5bL156pyImdw+/gLv6Fc=; l=1448;
        h=Received:From:To:Subject;
        b=ICMdKN4pz5docHhVv5n4+vAsye6WOxGIGe0SB6lDvF3KbdNojKkSF8hGVglYfrI7v
         Qvj6gCFjyq4J1kbYwNf+t0ywqmnALJ1SW4wUqqU78QROuiHCIryfBMx9NOCSxRNtXf
         jCxaEaQLTaM2Q3xcveQ0/yPE4shLd1fFqKDjNzjs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524111890;
        bh=2ftMBpXUgAeYUTCSbqvWUyb5bL156pyImdw+/gLv6Fc=; l=1448;
        h=Received:From:To:Subject;
        b=ICMdKN4pz5docHhVv5n4+vAsye6WOxGIGe0SB6lDvF3KbdNojKkSF8hGVglYfrI7v
         Qvj6gCFjyq4J1kbYwNf+t0ywqmnALJ1SW4wUqqU78QROuiHCIryfBMx9NOCSxRNtXf
         jCxaEaQLTaM2Q3xcveQ0/yPE4shLd1fFqKDjNzjs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524111890;
        bh=2ftMBpXUgAeYUTCSbqvWUyb5bL156pyImdw+/gLv6Fc=; l=1448;
        h=Received:From:To:Subject;
        b=ICMdKN4pz5docHhVv5n4+vAsye6WOxGIGe0SB6lDvF3KbdNojKkSF8hGVglYfrI7v
         Qvj6gCFjyq4J1kbYwNf+t0ywqmnALJ1SW4wUqqU78QROuiHCIryfBMx9NOCSxRNtXf
         jCxaEaQLTaM2Q3xcveQ0/yPE4shLd1fFqKDjNzjs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524111890;
        bh=2ftMBpXUgAeYUTCSbqvWUyb5bL156pyImdw+/gLv6Fc=; l=1448;
        h=Received:From:To:Subject;
        b=ICMdKN4pz5docHhVv5n4+vAsye6WOxGIGe0SB6lDvF3KbdNojKkSF8hGVglYfrI7v
         Qvj6gCFjyq4J1kbYwNf+t0ywqmnALJ1SW4wUqqU78QROuiHCIryfBMx9NOCSxRNtXf
         jCxaEaQLTaM2Q3xcveQ0/yPE4shLd1fFqKDjNzjs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524111890;
        bh=2ftMBpXUgAeYUTCSbqvWUyb5bL156pyImdw+/gLv6Fc=; l=1448;
        h=Received:From:To:Subject;
        b=ICMdKN4pz5docHhVv5n4+vAsye6WOxGIGe0SB6lDvF3KbdNojKkSF8hGVglYfrI7v
         Qvj6gCFjyq4J1kbYwNf+t0ywqmnALJ1SW4wUqqU78QROuiHCIryfBMx9NOCSxRNtXf
         jCxaEaQLTaM2Q3xcveQ0/yPE4shLd1fFqKDjNzjs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524111890;
        bh=2ftMBpXUgAeYUTCSbqvWUyb5bL156pyImdw+/gLv6Fc=; l=1448;
        h=Received:From:To:Subject;
        b=ICMdKN4pz5docHhVv5n4+vAsye6WOxGIGe0SB6lDvF3KbdNojKkSF8hGVglYfrI7v
         Qvj6gCFjyq4J1kbYwNf+t0ywqmnALJ1SW4wUqqU78QROuiHCIryfBMx9NOCSxRNtXf
         jCxaEaQLTaM2Q3xcveQ0/yPE4shLd1fFqKDjNzjs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524111890;
        bh=2ftMBpXUgAeYUTCSbqvWUyb5bL156pyImdw+/gLv6Fc=; l=1448;
        h=Received:From:To:Subject;
        b=ICMdKN4pz5docHhVv5n4+vAsye6WOxGIGe0SB6lDvF3KbdNojKkSF8hGVglYfrI7v
         Qvj6gCFjyq4J1kbYwNf+t0ywqmnALJ1SW4wUqqU78QROuiHCIryfBMx9NOCSxRNtXf
         jCxaEaQLTaM2Q3xcveQ0/yPE4shLd1fFqKDjNzjs=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f917o-0004cG-RI; Thu, 19 Apr 2018 07:24:48 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
        <cover.1523362469.git.johannes.schindelin@gmx.de>
        <87tvsj6rn2.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <871sfm737e.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87h8oh51jm.fsf@javad.com>
        <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com>
        <87sh810ym4.fsf@javad.com>
        <CA+P7+xq8LOUZxVd832cOQFi4V=2YvydxtT6_y4NLKvFkki4QdA@mail.gmail.com>
        <nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <5d522cc9-3922-9f24-3a1e-0c121c47ca96@talktalk.net>
        <nycvar.QRO.7.76.6.1804140146450.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 19 Apr 2018 07:24:48 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1804140146450.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Sat, 14 Apr 2018 01:48:19 +0200
        (DST)")
Message-ID: <87fu3r257z.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Phillip,
>
> On Fri, 13 Apr 2018, Phillip Wood wrote:
>
>> On 12/04/18 23:02, Johannes Schindelin wrote:
>> > 
>> > [...]
>> > 
>> > So: the order of the 3-way merges does matter.
>> >
>> > [...]
>> 
>> Those conflicts certainly look intimidating (and the ones in your later
>> reply with the N way merge example still look quite complicated). One
>> option would be just to stop and have the user resolve the conflicts
>> after each conflicting 3-way merge rather than at the end of all the
>> merges. There are some downsides: there would need to be a way to
>> explain to the user that this is an intermediate step (and what that
>> step was); the code would have to do some book keeping to know where it
>> had got to; and it would stop and prompt the user to resolve conflicts
>> more often which could be annoying but hopefully they'd be clearer to
>> resolve because they weren't nested.
>
> I thought about that. But as I pointed out: the order of the merges *does*
> matter. Otherwise we force the user to resolve conflicts that they
> *already* resolved during this rebase...

How it's relevant to what Phillip suggested? How the order of taking 2
steps, A and B, affects an ability to stop after the first step? It's
still either "A,stop,B" or "B,stop,A", depending on the chosen order.

What's the _actual_ problem here, if any?

-- Sergey
