Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD2DA1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 06:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeDKGRX (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 02:17:23 -0400
Received: from mail.javad.com ([54.86.164.124]:51746 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751823AbeDKGRW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 02:17:22 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 3E9FF3FECB;
        Wed, 11 Apr 2018 06:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523427441;
        bh=+Sl/OpMnVmD/lZkHkp0LqLCbjx+rWKa+d0wQcQXpZQk=; l=747;
        h=Received:From:To:Subject;
        b=iXIK0g985DWmxs2xKddG0e2hEfspBur0lLsbxapKm0jvOjWiIwqZQfisw+z8/mn0a
         fcW+wTYu6KHvbDrd2wyn7qBB6pJPFycdwyn/jV8SbKPLd+3I23CTiZJ7eSqlFPeEAw
         rDGB+CFbfzjkToL2ZlQhnOZ1v19yThj1pdpCh2qE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523427441;
        bh=+Sl/OpMnVmD/lZkHkp0LqLCbjx+rWKa+d0wQcQXpZQk=; l=747;
        h=Received:From:To:Subject;
        b=iXIK0g985DWmxs2xKddG0e2hEfspBur0lLsbxapKm0jvOjWiIwqZQfisw+z8/mn0a
         fcW+wTYu6KHvbDrd2wyn7qBB6pJPFycdwyn/jV8SbKPLd+3I23CTiZJ7eSqlFPeEAw
         rDGB+CFbfzjkToL2ZlQhnOZ1v19yThj1pdpCh2qE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523427441;
        bh=+Sl/OpMnVmD/lZkHkp0LqLCbjx+rWKa+d0wQcQXpZQk=; l=747;
        h=Received:From:To:Subject;
        b=iXIK0g985DWmxs2xKddG0e2hEfspBur0lLsbxapKm0jvOjWiIwqZQfisw+z8/mn0a
         fcW+wTYu6KHvbDrd2wyn7qBB6pJPFycdwyn/jV8SbKPLd+3I23CTiZJ7eSqlFPeEAw
         rDGB+CFbfzjkToL2ZlQhnOZ1v19yThj1pdpCh2qE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523427441;
        bh=+Sl/OpMnVmD/lZkHkp0LqLCbjx+rWKa+d0wQcQXpZQk=; l=747;
        h=Received:From:To:Subject;
        b=iXIK0g985DWmxs2xKddG0e2hEfspBur0lLsbxapKm0jvOjWiIwqZQfisw+z8/mn0a
         fcW+wTYu6KHvbDrd2wyn7qBB6pJPFycdwyn/jV8SbKPLd+3I23CTiZJ7eSqlFPeEAw
         rDGB+CFbfzjkToL2ZlQhnOZ1v19yThj1pdpCh2qE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523427441;
        bh=+Sl/OpMnVmD/lZkHkp0LqLCbjx+rWKa+d0wQcQXpZQk=; l=747;
        h=Received:From:To:Subject;
        b=iXIK0g985DWmxs2xKddG0e2hEfspBur0lLsbxapKm0jvOjWiIwqZQfisw+z8/mn0a
         fcW+wTYu6KHvbDrd2wyn7qBB6pJPFycdwyn/jV8SbKPLd+3I23CTiZJ7eSqlFPeEAw
         rDGB+CFbfzjkToL2ZlQhnOZ1v19yThj1pdpCh2qE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523427441;
        bh=+Sl/OpMnVmD/lZkHkp0LqLCbjx+rWKa+d0wQcQXpZQk=; l=747;
        h=Received:From:To:Subject;
        b=iXIK0g985DWmxs2xKddG0e2hEfspBur0lLsbxapKm0jvOjWiIwqZQfisw+z8/mn0a
         fcW+wTYu6KHvbDrd2wyn7qBB6pJPFycdwyn/jV8SbKPLd+3I23CTiZJ7eSqlFPeEAw
         rDGB+CFbfzjkToL2ZlQhnOZ1v19yThj1pdpCh2qE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523427441;
        bh=+Sl/OpMnVmD/lZkHkp0LqLCbjx+rWKa+d0wQcQXpZQk=; l=747;
        h=Received:From:To:Subject;
        b=iXIK0g985DWmxs2xKddG0e2hEfspBur0lLsbxapKm0jvOjWiIwqZQfisw+z8/mn0a
         fcW+wTYu6KHvbDrd2wyn7qBB6pJPFycdwyn/jV8SbKPLd+3I23CTiZJ7eSqlFPeEAw
         rDGB+CFbfzjkToL2ZlQhnOZ1v19yThj1pdpCh2qE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523427441;
        bh=+Sl/OpMnVmD/lZkHkp0LqLCbjx+rWKa+d0wQcQXpZQk=; l=747;
        h=Received:From:To:Subject;
        b=iXIK0g985DWmxs2xKddG0e2hEfspBur0lLsbxapKm0jvOjWiIwqZQfisw+z8/mn0a
         fcW+wTYu6KHvbDrd2wyn7qBB6pJPFycdwyn/jV8SbKPLd+3I23CTiZJ7eSqlFPeEAw
         rDGB+CFbfzjkToL2ZlQhnOZ1v19yThj1pdpCh2qE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523427441;
        bh=+Sl/OpMnVmD/lZkHkp0LqLCbjx+rWKa+d0wQcQXpZQk=; l=747;
        h=Received:From:To:Subject;
        b=iXIK0g985DWmxs2xKddG0e2hEfspBur0lLsbxapKm0jvOjWiIwqZQfisw+z8/mn0a
         fcW+wTYu6KHvbDrd2wyn7qBB6pJPFycdwyn/jV8SbKPLd+3I23CTiZJ7eSqlFPeEAw
         rDGB+CFbfzjkToL2ZlQhnOZ1v19yThj1pdpCh2qE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523427441;
        bh=+Sl/OpMnVmD/lZkHkp0LqLCbjx+rWKa+d0wQcQXpZQk=; l=747;
        h=Received:From:To:Subject;
        b=iXIK0g985DWmxs2xKddG0e2hEfspBur0lLsbxapKm0jvOjWiIwqZQfisw+z8/mn0a
         fcW+wTYu6KHvbDrd2wyn7qBB6pJPFycdwyn/jV8SbKPLd+3I23CTiZJ7eSqlFPeEAw
         rDGB+CFbfzjkToL2ZlQhnOZ1v19yThj1pdpCh2qE=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f694J-0007oW-JL; Wed, 11 Apr 2018 09:17:19 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 04/15] sequencer: introduce new commands to reset the revision
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
        <cover.1523362469.git.johannes.schindelin@gmx.de>
        <fb797f32b7385317b9dc18524e3863ba627f6c98.1523362469.git.johannes.schindelin@gmx.de>
Date:   Wed, 11 Apr 2018 09:17:19 +0300
In-Reply-To: <fb797f32b7385317b9dc18524e3863ba627f6c98.1523362469.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 10 Apr 2018 14:29:41 +0200
        (DST)")
Message-ID: <878t9u5ksw.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

[...]

> We disallow '#' as label because that character will be used as separator
> in the upcoming `merge` command.

Please consider to use # not only in `merge` and `reset`, but in the rest
of the commands as well, to unify this new syntax. I.e., right now it
seems to be:

pick  abcd A commit message
merge beaf # B commit message

I suggest to turn it to:

pick  abcd # A commit message
merge beaf # B commit message

So that the # is finally universally the start of comment.

While we are at this, I couldn't find any even semi-formal syntax
description of the entire todo list. Is there one already? Are you going
to provide one?

-- Sergey
