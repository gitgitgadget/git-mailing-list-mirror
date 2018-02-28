Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4FF31F404
	for <e@80x24.org>; Wed, 28 Feb 2018 06:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeB1GOk (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 01:14:40 -0500
Received: from mail.javad.com ([54.86.164.124]:49847 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751646AbeB1GOj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 01:14:39 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 431B6407C5;
        Wed, 28 Feb 2018 06:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519798478;
        bh=ZPXxaVzNbY7ShYr3MWTKs0DjOq3j3HgPytnG4nqLqJg=; l=2045;
        h=Received:From:To:Subject;
        b=HyBP+cs57biTRhSgV+GmDPD25LX38OgOBlTNZIRQ6OLMQA/RJM/8eN358dl7xXlCb
         ssT4dZ90AWP11DN22g9f3YenMD2ANVRnigWkbEF3KwpDlEcESlx8cTAlnysxgaZTzx
         77QFquAi9DWMcsr8wShxyJiO90yUQ8fqogGcJDQc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519798478;
        bh=ZPXxaVzNbY7ShYr3MWTKs0DjOq3j3HgPytnG4nqLqJg=; l=2045;
        h=Received:From:To:Subject;
        b=HyBP+cs57biTRhSgV+GmDPD25LX38OgOBlTNZIRQ6OLMQA/RJM/8eN358dl7xXlCb
         ssT4dZ90AWP11DN22g9f3YenMD2ANVRnigWkbEF3KwpDlEcESlx8cTAlnysxgaZTzx
         77QFquAi9DWMcsr8wShxyJiO90yUQ8fqogGcJDQc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519798478;
        bh=ZPXxaVzNbY7ShYr3MWTKs0DjOq3j3HgPytnG4nqLqJg=; l=2045;
        h=Received:From:To:Subject;
        b=HyBP+cs57biTRhSgV+GmDPD25LX38OgOBlTNZIRQ6OLMQA/RJM/8eN358dl7xXlCb
         ssT4dZ90AWP11DN22g9f3YenMD2ANVRnigWkbEF3KwpDlEcESlx8cTAlnysxgaZTzx
         77QFquAi9DWMcsr8wShxyJiO90yUQ8fqogGcJDQc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519798478;
        bh=ZPXxaVzNbY7ShYr3MWTKs0DjOq3j3HgPytnG4nqLqJg=; l=2045;
        h=Received:From:To:Subject;
        b=HyBP+cs57biTRhSgV+GmDPD25LX38OgOBlTNZIRQ6OLMQA/RJM/8eN358dl7xXlCb
         ssT4dZ90AWP11DN22g9f3YenMD2ANVRnigWkbEF3KwpDlEcESlx8cTAlnysxgaZTzx
         77QFquAi9DWMcsr8wShxyJiO90yUQ8fqogGcJDQc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519798478;
        bh=ZPXxaVzNbY7ShYr3MWTKs0DjOq3j3HgPytnG4nqLqJg=; l=2045;
        h=Received:From:To:Subject;
        b=HyBP+cs57biTRhSgV+GmDPD25LX38OgOBlTNZIRQ6OLMQA/RJM/8eN358dl7xXlCb
         ssT4dZ90AWP11DN22g9f3YenMD2ANVRnigWkbEF3KwpDlEcESlx8cTAlnysxgaZTzx
         77QFquAi9DWMcsr8wShxyJiO90yUQ8fqogGcJDQc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519798478;
        bh=ZPXxaVzNbY7ShYr3MWTKs0DjOq3j3HgPytnG4nqLqJg=; l=2045;
        h=Received:From:To:Subject;
        b=HyBP+cs57biTRhSgV+GmDPD25LX38OgOBlTNZIRQ6OLMQA/RJM/8eN358dl7xXlCb
         ssT4dZ90AWP11DN22g9f3YenMD2ANVRnigWkbEF3KwpDlEcESlx8cTAlnysxgaZTzx
         77QFquAi9DWMcsr8wShxyJiO90yUQ8fqogGcJDQc=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1eqv0e-0001TM-15; Wed, 28 Feb 2018 09:14:36 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <3b562b51-2f1a-48f6-d6b4-8e0fbddd3a40@gmail.com>
        <b4367bca-79a0-879b-9503-ed4e667d8a64@gmail.com>
Date:   Wed, 28 Feb 2018 09:14:36 +0300
In-Reply-To: <b4367bca-79a0-879b-9503-ed4e667d8a64@gmail.com> (Igor
        Djordjevic's message of "Wed, 28 Feb 2018 05:35:16 +0100")
Message-ID: <87k1uxmyib.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> On 28/02/2018 03:12, Igor Djordjevic wrote:
>> 
>> Would additional step as suggested in [1] (using R1 and R2 to "catch" 
>> interactive rebase additions/amendments/drops, on top of U1' and 
>> U2'), make more sense (or provide an additional clue, at least)?
>> 
>> [1] https://public-inbox.org/git/8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com/
>
> Heh, no sleeping tonight :P
>
> Anyway, from (yet another) ad hoc test, additional step mentioned in 
> [1] above seems to handle this case, too (merge with `-s ours` 
> dropping B* patches, plus B1 cherry-picked between X1..X2):
>
> On 28/02/2018 00:27, Johannes Schindelin wrote:
>> 
>> - One of the promises was that the new way would also handle merge
>>   strategies other than recursive. What would happen, for example, if M
>>   was generated using `-s ours` (read: dropping the B* patches' changes)
>>   and if B1 had been cherry-picked into the history between X1..X2?
>> 
>>   Reverting R would obviously revert those B1 changes, even if B1' would
>>   obviously not even be part of the rebased history!
>> 
>> Yes, I agree that this `-s ours` example is quite concocted, but the point
>> of this example is not how plausible it is, but how easy it is to come up
>> with a scenario where this design to "rebase merge commits" results in
>> very, very unwanted behavior.
>
> And not just that - it worked with additional interactive rebase 
> adding, amending and removing commits, on top of all this still 
> preserving original `-s ours` merge commit evil-merge amendment, too, 
> all as expected (or so it seems) :P

Great! I do believe that once we start from some sensible approach, many
kinds of improvements are possible. I'll definitely need to take close
look at what you came up with, thanks!

I'd like to say though that nobody should expect miracles from automated
rebasing of merges when we get to complex history editing. It will need
to retreat to manual merge, sooner or later.

-- Sergey
