Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC6E1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 19:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeBBTqI (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 14:46:08 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34271 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbeBBTqH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 14:46:07 -0500
Received: by mail-wm0-f66.google.com with SMTP id j21-v6so4066192wmh.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 11:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nBa28nAHF4xfpuRQ74bsf7iqsMIi7ccilEQTdSbUCFk=;
        b=J9MAXLwOEAkobwESQksrmt1+ys6BcF2WJXmRkJioqwo2GLzZmq4vBP5rB72KFImy1E
         k4kcu/UlIpo4ortHlnZvx56B59U7QyIHEXJeoof2UdCH4DLenhXYdhSX/owihzmzg2Bv
         1BqLGjjKSsE0VRfXoPjClqzjZXdjEiE+dXGVPrUIBW8dA+arBiZSnItNuoQFxp4DzrdU
         KkVxDKueX3ivcwWWkCAmwsy/dX29BbHFOYclD/NYzYkzjToZVcKJ4nXrvmU+ZGmJEuT/
         VJlociBfRxanTWnkxW4hjh2VqpVhwCkUydvi/Mf6VFXxjCRqN4O0A4PnHOU1ZzyYTSqc
         eRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nBa28nAHF4xfpuRQ74bsf7iqsMIi7ccilEQTdSbUCFk=;
        b=C1S3K/bveNC8tI4HZ90jKyzFaYrFUYNq2dyqJv3/Oa5c9/nBkZWlBq1ghTdtRh7Iy6
         1GXDNbQstEXLe5OW5501wg1kkv1tFa1DT5qqoGpPtsNMfw/V+HXE3Q296BCTP1MK/zcy
         Jzq0KXz7c2Mg47wgmwEocOUYyH/boqjhaFswopIvMm9zFNodDzI7qakIW28rfDWKrwCW
         9uceVrlynqu9rrRnMv4trMSyuKN0hYpEW27wtxZvcUTA/fwzG8ofycFm9wGm0mxFwePh
         eMF1ytMxw5vmWqvhc1SQVRxbRotDMH4SG915PWWLpIvcNRzOC/WL092rD1qlLfxrNchn
         zkbw==
X-Gm-Message-State: AKwxytds6Adhd4/0zgP76ORd4Wxm29b4YugP2HTNEk07YcZ2gpXZjq8/
        NhtYCOXwRcdEmxzUrcPxvbA=
X-Google-Smtp-Source: AH8x225po5SUqwVFRok2AJv0ArZOUzTtt0HzYu164Jc5CtJLHTCIBFVwFhgZc0Kpx94czIE05Joizw==
X-Received: by 10.28.208.142 with SMTP id h136mr33074588wmg.133.1517600765539;
        Fri, 02 Feb 2018 11:46:05 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 74sm2502482wmf.38.2018.02.02.11.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 11:46:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/12] object_id part 11 (the_hash_algo)
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
Date:   Fri, 02 Feb 2018 11:46:03 -0800
In-Reply-To: <20180201021848.533188-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 1 Feb 2018 02:18:36 +0000")
Message-ID: <xmqqinbfcgzo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series includes various changes to adopt the use of the_hash_algo
> for abstracting hash algorithms away.
>
> Changes from v1:
> * Fix comments referring to SHA-1.
> * Switch hash function wrappers to take git_hash_ctx *.
> * Use a const int variable for a constant value.
> * Wrap an overly long line.

Thanks for working on this.  All changes looked sensible (even
though I spotted one nit in the original, which was moved as-is,
which does not count as a "change" ;-)).

