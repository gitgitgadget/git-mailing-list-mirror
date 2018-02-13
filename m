Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4644D1F576
	for <e@80x24.org>; Tue, 13 Feb 2018 06:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbeBMGoz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 01:44:55 -0500
Received: from mail.javad.com ([54.86.164.124]:52846 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933366AbeBMGoy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 01:44:54 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 91E1B3E8B8;
        Tue, 13 Feb 2018 06:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518504294;
        bh=E9KcywdQoz1mCuVqZ3E32LkMac0X54+NcmlM75C7TBg=; l=1518;
        h=Received:From:To:Subject;
        b=IHan9Rz6xQwh5FKm00MZLMlwI0VUOf25pb5tYrLtbJC2MY+btB/VtPHZsMv1bytNy
         EWXaElz3/oh3YFKgxDRTJYtgFwTlMt+OQRnsFH2zbvA7EUEMKnC8/A3uiRxqkGlyzW
         yu9o/XY3TPsLj76oaf/0g48PNMh8q4EQxp0UpipU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518504294;
        bh=E9KcywdQoz1mCuVqZ3E32LkMac0X54+NcmlM75C7TBg=; l=1518;
        h=Received:From:To:Subject;
        b=IHan9Rz6xQwh5FKm00MZLMlwI0VUOf25pb5tYrLtbJC2MY+btB/VtPHZsMv1bytNy
         EWXaElz3/oh3YFKgxDRTJYtgFwTlMt+OQRnsFH2zbvA7EUEMKnC8/A3uiRxqkGlyzW
         yu9o/XY3TPsLj76oaf/0g48PNMh8q4EQxp0UpipU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518504293;
        bh=E9KcywdQoz1mCuVqZ3E32LkMac0X54+NcmlM75C7TBg=; l=1518;
        h=Received:From:To:Subject;
        b=RfyulLm4z1sui1gH6/bthrnfXDMSpp3EXr0kgQsizd2Kvn6HMKMV20s1DrMjhsjgB
         XzkslNqAFh4SWNJyOQwgHPGp0T25rn2rYFnJ09s2aH62VlhIhzJiByasluVrpxjl3R
         h9ohDk/6J06p3o2LyyVzbBh4P1srQnBspnBHCnGM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518504293;
        bh=E9KcywdQoz1mCuVqZ3E32LkMac0X54+NcmlM75C7TBg=; l=1518;
        h=Received:From:To:Subject;
        b=RfyulLm4z1sui1gH6/bthrnfXDMSpp3EXr0kgQsizd2Kvn6HMKMV20s1DrMjhsjgB
         XzkslNqAFh4SWNJyOQwgHPGp0T25rn2rYFnJ09s2aH62VlhIhzJiByasluVrpxjl3R
         h9ohDk/6J06p3o2LyyVzbBh4P1srQnBspnBHCnGM=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1elUKh-0001wO-Ke; Tue, 13 Feb 2018 09:44:51 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <874lmqirma.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <874lmmerdu.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802122118420.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 13 Feb 2018 09:44:51 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1802122118420.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Mon, 12 Feb 2018 21:21:05 +0100
        (STD)")
Message-ID: <87bmgt8k2k.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi Sergey,
>
> On Mon, 12 Feb 2018, Sergey Organov wrote:
>
>> Thanks for explanations, and could you please answer this one:
>> 
>> [...]
>> 
>> >> I also have trouble making sense of "Recreate merge commits instead of
>> >> flattening the history by replaying merges." Is it "<Recreate merge
>> >> commits by replaying merges> instead of <flattening the history>" or is it
>> >> rather "<Recreate merge commits> instead of <flattening the history by
>> >> replaying merges>?
>
> I thought I had answered that one.

No, not really, but now you did, please see below.

>
> Flattening the history is what happens in regular rebase (i.e. without
> --recreate-merges and without --preserve-merges).
>
> The idea to recreate merges is of course to *not* flatten the history.

Sure. Never supposed it is.

> Maybe there should have been a comma after "history" to clarify what the
> sentence means.

That's the actual answer to my question, but it in turn raises another
one: why did you change wording of --preserve-merges description for
this new option?

> The wording is poor either way, but you are also not a native speaker so
> we have to rely on, say, Eric to help us out here.

Likely, but why didn't you keep original wording from --preserve-merges?
Do you feel it's somehow poor either?

Anyway, please also refer to wording suggestion in the another (lengthy)
answer in this thread.

-- Sergey
