Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34CDE1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 22:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfBHWND convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 8 Feb 2019 17:13:03 -0500
Received: from elephants.elehost.com ([216.66.27.132]:16544 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBHWND (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 17:13:03 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18MCoOj097005
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 17:12:50 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com> <20190208165052.GC23461@sigill.intra.peff.net> <001101d4bfd6$b9430230$2bc90690$@nexbridge.com> <20190208180321.GB27673@sigill.intra.peff.net> <002501d4bfde$b26e6050$174b20f0$@nexbridge.com> <20190208191519.GF27673@sigill.intra.peff.net> <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com> <20190208193157.GA30952@sigill.intra.peff.net> <20190208220714.GG11927@genre.crustytoothpaste.net>
In-Reply-To: <20190208220714.GG11927@genre.crustytoothpaste.net>
Subject: RE: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Date:   Fri, 8 Feb 2019 17:12:43 -0500
Message-ID: <005901d4bffb$6d0c34c0$47249e40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE5rFddSF2c8coPnbFiKb9P+8bdAwH0igmPAiNgz5YBSIw84wKJiaU9Aj0+V9MB8y1xFgJaeDVqApzvLgCmhA6QgA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 8, 2019 17:07, brian m. carlson wrote:
> On Fri, Feb 08, 2019 at 02:31:57PM -0500, Jeff King wrote:
> > > It is available AFAIK on Linux, POSIX, and Windows under Cygwin.
> > > That's more than /dev/zero has anyway. I have the patch ready if you
> > > want it.
> >
> > Is it POSIX? Certainly truncate() is, but I didn't think the
> > command-line tool was. If it really is available everywhere, then
> > yeah, I'd be fine with it.
> 
> It's not. POSIX doesn't specify the command, and macOS lacks it, I believe.

I'm happy to modify the test (it is in one spot), to make a decision based on:
a) whether /dev/zero exists
b) whether the system is a NonStop
c) something else

What would you all prefer? It doesn't matter to me one way or another, as long as I can get the dependency to /dev/zero removed so tests will run here.

Thanks,
Randall

