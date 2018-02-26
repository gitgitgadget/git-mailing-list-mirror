Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD6F1F576
	for <e@80x24.org>; Mon, 26 Feb 2018 11:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeBZLFL (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 06:05:11 -0500
Received: from titan.plasma.xg8.de ([85.10.203.189]:37844 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbeBZLFK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 06:05:10 -0500
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w1QB4q4F022906
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 26 Feb 2018 12:04:52 +0100
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w1QB4qsO022905;
        Mon, 26 Feb 2018 12:04:52 +0100
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w1QB4aLb023694;
        Mon, 26 Feb 2018 12:04:36 +0100
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w1QB4Zji023693;
        Mon, 26 Feb 2018 12:04:35 +0100
Date:   Mon, 26 Feb 2018 12:04:35 +0100
From:   "'Peter Backes'" <rtc@helen.PLASMA.Xg8.DE>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason'" <avarab@gmail.com>,
        "'Derek Fawcus'" <dfawcus+lists-git@employees.org>,
        git@vger.kernel.org, "'Theodore Ts'o'" <tytso@mit.edu>
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180226110435.GA23573@helen.PLASMA.Xg8.DE>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <20180221210339.GA43094@accordion.employees.org>
 <87bmgif2pa.fsf@evledraar.gmail.com>
 <20180221221420.GA7743@helen.PLASMA.Xg8.DE>
 <87a7w2ezeq.fsf@evledraar.gmail.com>
 <20180221231234.GA8509@helen.PLASMA.Xg8.DE>
 <007d01d3ab6f$e5439f10$afcadd30$@nexbridge.com>
 <20180222020535.GA11063@helen.PLASMA.Xg8.DE>
 <20180226105642.GA6549@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226105642.GA6549@inner.h.apk.li>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 11:56:42AM +0100, Andreas Krey wrote:
> > The bigger issue is usually to copy with those pesky leap seconds. It 
> > makes a difference whether one uses solar seconds ("posix" style; those 
> > are more commonly seen) or atomic seconds ("right" style) for the UNIX 
> > timestamp.
> 
> Is there any system, unix or otherwise, that uses 'right'-style seconds,
> i.e. TAI, as its base?

Most certainly there is. This depends on the individual configuration 
of the system. On my Fedora system, the commonly used tzdata package 
off the shelf contains support for 'right' style versions of all 
timezones in /usr/share/zoneinfo/right If the user links one of those 
timezones to /etc/localtime or manually specifies them (like 
TZ=right/Europe/Berlin ls -l) they will be used.

You don't find a lot of those systems today, but those who used to use 
the 'right' timestamps might for legacy reasons explicitly configure 
their system to use those timezone variants. I personally did this for 
a number of years, but then converted the filesystems timestamps to 
'posix' and I am now exclusively using 'posix' ones.

Best wishes
Peter
-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
