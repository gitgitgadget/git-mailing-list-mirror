Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595581F404
	for <e@80x24.org>; Tue,  6 Feb 2018 14:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBFOwH (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 09:52:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36402 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeBFOwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 09:52:05 -0500
Received: by mail-wm0-f65.google.com with SMTP id f3so4387720wmc.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 06:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aocKjnDMPnOFAJgbZlYEm6OJjo1NZ49PQcQlxF/eP0Q=;
        b=SEbZaOCnDsmnWEOuXO15PEQpKrxTWXY2htuIsQR1l/l95sOmGf2vw+qme1xf+xeVRG
         v2ZNsEDuJ+/ofrzu6D5+wJ4WFjyGy1kyU/FH4Zw1OLCTHLOgDV1neZDbh3gcyPWoTeYL
         eRcCHl9vM5CptFpUYsTZkKiE2krh4jAnFxcjFE/R0d+ogJAnWPi+wfDDqAnS0QLmmxWA
         86JY3IQkw7V2/WVE9f67XUGCvB3Ch6mfbeDKBfDmZOOnZIBEi3NJ3OVINT/s0D01pO9C
         moPyYrmwY91GQ4eJiDwvOcNyKUtk94BH72MH5vwrw4Jzew06/xD/gDUO+5DcCx5gpzv+
         QEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aocKjnDMPnOFAJgbZlYEm6OJjo1NZ49PQcQlxF/eP0Q=;
        b=CYqeqMwSATTLlAMBUB/FVZ+VMIE7TXEqNz5hHefDQHG6O0/JT1aRet2BdlBEMZxLcm
         R1rDAFLv/joBaDpw9Hl2eqirEj4X5hxyKCQC2gcHlAOQXBWSGUhxBVl0huEXmz7g07v+
         ieaFGM69fA6DA48kAPzj0q9gBE24l6ptm7t8FNpIhy2fg9MLVjUvvR3h8K0M9FEc9uyz
         MalUe/HmBIVfgf75B9+0fXKRTwxaj4yNDVOnWTeocKoc5DrCNwvwhEWoG1BmZfBQwbR1
         kr/O2pj4rehOPAIjGuuEPyLJOG1KgUdUTKmQ+5kbcvYvQFI1RikPWG28krub/cnQdbJy
         x5Ug==
X-Gm-Message-State: APf1xPAJw2pRVH0yXLYRDRT5dzgJPEuMcCd3JQv3jrzZLTT1I0RSkIpw
        E9JhSo6si8cQqjpG1gOTsC+CFEVp
X-Google-Smtp-Source: AH8x225eLjKFhxs0mP38irC6q57LU53Umw8JpWXaAlDxu9AqyaqUpvsDnUpHFQ/ug7JTSw0v557nGA==
X-Received: by 10.28.239.19 with SMTP id n19mr2052994wmh.20.1517928724134;
        Tue, 06 Feb 2018 06:52:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 62sm9909186wml.24.2018.02.06.06.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 06:52:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/12] object_id part 11 (the_hash_algo)
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
        <xmqqinbfcgzo.fsf@gitster-ct.c.googlers.com>
        <20180206003359.GB7904@genre.crustytoothpaste.net>
Date:   Tue, 06 Feb 2018 06:52:02 -0800
In-Reply-To: <20180206003359.GB7904@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 6 Feb 2018 00:34:00 +0000")
Message-ID: <xmqq7erq892l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Fri, Feb 02, 2018 at 11:46:03AM -0800, Junio C Hamano wrote:
>> Thanks for working on this.  All changes looked sensible (even
>> though I spotted one nit in the original, which was moved as-is,
>> which does not count as a "change" ;-)).
>
> I forgot to ask: do you want a reroll which fixes this, or just a
> follow-up patch on top to fix the comment?

I do not think it is in scope of the series, so a follow-up would be
sufficient.

Thanks.
