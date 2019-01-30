Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2839B1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 11:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfA3LlQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 06:41:16 -0500
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:53926 "EHLO
        nwk-aaemail-lapp01.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728720AbfA3LlP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 06:41:15 -0500
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
        by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0UBagRj014109;
        Wed, 30 Jan 2019 03:41:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : subject : from : in-reply-to :
 date : cc : message-id : references : to; s=20180706;
 bh=zpZtYTB9vgShPipAJ7eS4hzVpDJVI3nJLIqFDAmPsVE=;
 b=fhVqO2d81n8YXmZkUEsZQ+pSgu95S1TGNZP75uo+7rOmwi3XcXACtlLi2T8YBbX9LmE7
 dLki6Q9u68pAH5PVJ687S6UwxxbqU82TkuYB9srrT5FzZoXVLBh71kp8E+qAAOV57OOg
 MOPJJZWjF+uhvfIr2Hn+8DYcd9IhvBx7LpnTkMyef7lCydl3ml6LATpY1X9VwHKZGBgl
 +jXIj7crdBg4Io3KD52cFMhIXAzZ+s4a6ikA2NkocZZJ9v45M/YeW9v/vW9nPtYixJgZ
 EDJ+DY/cZQtOolUIvrQF8ZMfs8j8jUV9LylWD2hP/r/zFCpCl/8+BbHf0FaYr0YQ2hss hw== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com [17.40.76.7])
        by nwk-aaemail-lapp01.apple.com with ESMTP id 2q8qc821cb-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 30 Jan 2019 03:41:08 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM500BZZ74G9H90@ma1-mtap-s03.corp.apple.com>; Wed,
 30 Jan 2019 03:41:08 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM5000006UNDC00@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 03:41:07 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 1d4b20a60f75d9bb77c59cc55fa1c1c2
X-Va-E-CD: 4b191ea47c869588dbea83c34d5f132f
X-Va-R-CD: de96b9fcc174794f3cefb75163f7efd9
X-Va-CD: 0
X-Va-ID: a295a4bd-c322-47f3-aec2-2127d154784c
X-V-A:  
X-V-T-CD: 1d4b20a60f75d9bb77c59cc55fa1c1c2
X-V-E-CD: 4b191ea47c869588dbea83c34d5f132f
X-V-R-CD: de96b9fcc174794f3cefb75163f7efd9
X-V-CD: 0
X-V-ID: 4be6cd70-7996-4ab9-ba39-2528ca5161b0
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM5000006UICD00@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 03:41:07 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-30_09:,, signatures=0
Received: from [17.234.17.81] (unknown [17.234.17.81])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM5007IA74ICU10@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 03:41:07 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 09/13] Use symbolic links rather than hard
 links for files in libexec
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <20190130095006.GC24387@genre.crustytoothpaste.net>
Date:   Wed, 30 Jan 2019 03:41:06 -0800
Cc:     git@vger.kernel.org, peff@peff.net
Message-id: <230CA858-D709-4142-9563-20A4887F2ED8@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-10-jeremyhu@apple.com>
 <20190130095006.GC24387@genre.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_09:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 30, 2019, at 01:50, brian m. carlson <sandals@crustytoothpaste.net> wrote:
> 
> On Tue, Jan 29, 2019 at 11:38:15AM -0800, Jeremy Huddleston Sequoia wrote:
>> See <rdar://problem/10573201>
> 
> It's my understanding that Radars aren't public. Could you summarize the
> reasons behind this change in the commit message for those of us who
> don't have access to view this issue?

There was a bug in some tool in our packaging pipeline that resulted in hardlinks not being preserved.  That was fixed, but I decided to leave these as symlinks anyways in case users did a file operation on Xcode.app that didn't preserve hard links.

The point here is that it would probably be nice to have hard vs soft be a configuration option.
