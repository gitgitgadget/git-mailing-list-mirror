Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7504B1F424
	for <e@80x24.org>; Thu, 19 Apr 2018 11:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeDSL2h (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 07:28:37 -0400
Received: from mail.javad.com ([54.86.164.124]:34018 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbeDSL2f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 07:28:35 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 9F6583E992;
        Thu, 19 Apr 2018 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524137315;
        bh=CMQga1+7z8EZqWrY/t0ZjJ2nZeH+HPy1YRJSDqI/rXE=; l=3031;
        h=Received:From:To:Subject;
        b=YREFdSxq2jEqKxKOpcl5mISiWVBO6F1yGwoul2XZpCgSSplEcBiafexadVee071Ec
         c3JYdiOdk3cfOJXH1Ui1NSk68Yvr5OqnrSHPtYt5otxThmvNKWCZ9X8hWeE4k/z92F
         lhZkwBpLh/WicImlq9SkOSooGXmDC01KImhNvm00=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524137315;
        bh=CMQga1+7z8EZqWrY/t0ZjJ2nZeH+HPy1YRJSDqI/rXE=; l=3031;
        h=Received:From:To:Subject;
        b=YREFdSxq2jEqKxKOpcl5mISiWVBO6F1yGwoul2XZpCgSSplEcBiafexadVee071Ec
         c3JYdiOdk3cfOJXH1Ui1NSk68Yvr5OqnrSHPtYt5otxThmvNKWCZ9X8hWeE4k/z92F
         lhZkwBpLh/WicImlq9SkOSooGXmDC01KImhNvm00=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524137315;
        bh=CMQga1+7z8EZqWrY/t0ZjJ2nZeH+HPy1YRJSDqI/rXE=; l=3031;
        h=Received:From:To:Subject;
        b=YREFdSxq2jEqKxKOpcl5mISiWVBO6F1yGwoul2XZpCgSSplEcBiafexadVee071Ec
         c3JYdiOdk3cfOJXH1Ui1NSk68Yvr5OqnrSHPtYt5otxThmvNKWCZ9X8hWeE4k/z92F
         lhZkwBpLh/WicImlq9SkOSooGXmDC01KImhNvm00=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524137315;
        bh=CMQga1+7z8EZqWrY/t0ZjJ2nZeH+HPy1YRJSDqI/rXE=; l=3031;
        h=Received:From:To:Subject;
        b=YREFdSxq2jEqKxKOpcl5mISiWVBO6F1yGwoul2XZpCgSSplEcBiafexadVee071Ec
         c3JYdiOdk3cfOJXH1Ui1NSk68Yvr5OqnrSHPtYt5otxThmvNKWCZ9X8hWeE4k/z92F
         lhZkwBpLh/WicImlq9SkOSooGXmDC01KImhNvm00=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524137315;
        bh=CMQga1+7z8EZqWrY/t0ZjJ2nZeH+HPy1YRJSDqI/rXE=; l=3031;
        h=Received:From:To:Subject;
        b=YREFdSxq2jEqKxKOpcl5mISiWVBO6F1yGwoul2XZpCgSSplEcBiafexadVee071Ec
         c3JYdiOdk3cfOJXH1Ui1NSk68Yvr5OqnrSHPtYt5otxThmvNKWCZ9X8hWeE4k/z92F
         lhZkwBpLh/WicImlq9SkOSooGXmDC01KImhNvm00=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524137315;
        bh=CMQga1+7z8EZqWrY/t0ZjJ2nZeH+HPy1YRJSDqI/rXE=; l=3031;
        h=Received:From:To:Subject;
        b=YREFdSxq2jEqKxKOpcl5mISiWVBO6F1yGwoul2XZpCgSSplEcBiafexadVee071Ec
         c3JYdiOdk3cfOJXH1Ui1NSk68Yvr5OqnrSHPtYt5otxThmvNKWCZ9X8hWeE4k/z92F
         lhZkwBpLh/WicImlq9SkOSooGXmDC01KImhNvm00=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524137315;
        bh=CMQga1+7z8EZqWrY/t0ZjJ2nZeH+HPy1YRJSDqI/rXE=; l=3031;
        h=Received:From:To:Subject;
        b=YREFdSxq2jEqKxKOpcl5mISiWVBO6F1yGwoul2XZpCgSSplEcBiafexadVee071Ec
         c3JYdiOdk3cfOJXH1Ui1NSk68Yvr5OqnrSHPtYt5otxThmvNKWCZ9X8hWeE4k/z92F
         lhZkwBpLh/WicImlq9SkOSooGXmDC01KImhNvm00=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524137315;
        bh=CMQga1+7z8EZqWrY/t0ZjJ2nZeH+HPy1YRJSDqI/rXE=; l=3031;
        h=Received:From:To:Subject;
        b=YREFdSxq2jEqKxKOpcl5mISiWVBO6F1yGwoul2XZpCgSSplEcBiafexadVee071Ec
         c3JYdiOdk3cfOJXH1Ui1NSk68Yvr5OqnrSHPtYt5otxThmvNKWCZ9X8hWeE4k/z92F
         lhZkwBpLh/WicImlq9SkOSooGXmDC01KImhNvm00=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524137315;
        bh=CMQga1+7z8EZqWrY/t0ZjJ2nZeH+HPy1YRJSDqI/rXE=; l=3031;
        h=Received:From:To:Subject;
        b=YREFdSxq2jEqKxKOpcl5mISiWVBO6F1yGwoul2XZpCgSSplEcBiafexadVee071Ec
         c3JYdiOdk3cfOJXH1Ui1NSk68Yvr5OqnrSHPtYt5otxThmvNKWCZ9X8hWeE4k/z92F
         lhZkwBpLh/WicImlq9SkOSooGXmDC01KImhNvm00=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524137314;
        bh=CMQga1+7z8EZqWrY/t0ZjJ2nZeH+HPy1YRJSDqI/rXE=; l=3031;
        h=Received:From:To:Subject;
        b=IcsF4TYmGuESkoQtAACqzpbtSgSM9oEZzVtOGHyNVyf+FeHsImIjI6rnOLqJj4yZ7
         FbrfnZdb2iMH9kdsIaZCo4b03Cn0logDdZUSiDLnkxKnd77NHvPgye+CrKcNATB8fk
         qMvS1ATiTxcuVRY5lfMJAdby8LqySwqdVXrIL0Y4=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f97js-0005N3-V8; Thu, 19 Apr 2018 14:28:32 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
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
        <87fu3r257z.fsf@javad.com>
        <CA+P7+xrv54RBFx1eYbvgVyqQ88uxT73vOf3jazCVsvuXwvd-gA@mail.gmail.com>
Date:   Thu, 19 Apr 2018 14:28:32 +0300
In-Reply-To: <CA+P7+xrv54RBFx1eYbvgVyqQ88uxT73vOf3jazCVsvuXwvd-gA@mail.gmail.com>
        (Jacob Keller's message of "Thu, 19 Apr 2018 01:23:06 -0700")
Message-ID: <87bmefzb8f.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Apr 18, 2018 at 9:24 PM, Sergey Organov <sorganov@gmail.com> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> Hi Phillip,
>>>
>>> On Fri, 13 Apr 2018, Phillip Wood wrote:
>>>
>>>> On 12/04/18 23:02, Johannes Schindelin wrote:
>>>> >
>>>> > [...]
>>>> >
>>>> > So: the order of the 3-way merges does matter.
>>>> >
>>>> > [...]
>>>>
>>>> Those conflicts certainly look intimidating (and the ones in your later
>>>> reply with the N way merge example still look quite complicated). One
>>>> option would be just to stop and have the user resolve the conflicts
>>>> after each conflicting 3-way merge rather than at the end of all the
>>>> merges. There are some downsides: there would need to be a way to
>>>> explain to the user that this is an intermediate step (and what that
>>>> step was); the code would have to do some book keeping to know where it
>>>> had got to; and it would stop and prompt the user to resolve conflicts
>>>> more often which could be annoying but hopefully they'd be clearer to
>>>> resolve because they weren't nested.
>>>
>>> I thought about that. But as I pointed out: the order of the merges *does*
>>> matter. Otherwise we force the user to resolve conflicts that they
>>> *already* resolved during this rebase...
>>
>> How it's relevant to what Phillip suggested? How the order of taking 2
>> steps, A and B, affects an ability to stop after the first step? It's
>> still either "A,stop,B" or "B,stop,A", depending on the chosen order.
>>
>> What's the _actual_ problem here, if any?
>>
>> -- Sergey
>
> I believe the order of the merges changes which ones cause conflicts,
> but it's possible to generate pre-images (i.e. a set of parents to
> merge) which cause conflicts regardless of which ordering we pick, so
> I'm not sure there is a "best ordering".

I totally agree, but this still does not address the problem of
recursive conflicts, and it's this particular problem that Phillip's
suggestion addresses. Just stop after _every_ conflict and let user
resolve it, whatever the order is. Recursive conflicts are simply
showstoppers. Whatever cleverness is invented to represent them, it will
still outsmart most of the users.

As for your statement, it should be clear the absolute "best ordering"
simply can't exist, as merges are inherently symmetric in the DAG. One
can try all orders in turn and select one that brings less conflicts
though. Comparing conflicts is a problem by itself here. Recursive vs
non-recursive and conflict vs no-conflict are obvious and could be the
only checks adopted, all other cases being considered equal.

If we do select fixed order method, or can't find the best order, the
default order should simply match the natural one, first parent first.
Besides, it's the change to the mainline that is most important for an
actual Git merge, so letting it come first sounds most reasonable.

-- Sergey

