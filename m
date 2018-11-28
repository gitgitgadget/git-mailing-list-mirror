Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F00401F609
	for <e@80x24.org>; Wed, 28 Nov 2018 11:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeK1Wcx (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 17:32:53 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:46512 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727690AbeK1Wcw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 17:32:52 -0500
Received: from app06-neu.ox.hosteurope.de ([92.51.170.140] helo=null); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1gRy42-0005mx-Mx; Wed, 28 Nov 2018 12:31:30 +0100
Date:   Wed, 28 Nov 2018 12:31:30 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Message-ID: <992623969.1654.1543404690644@ox.hosteurope.de>
In-Reply-To: <xmqq4lc3uyuh.fsf@gitster-ct.c.googlers.com>
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
 <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
 <CAGZ79kaaLeaffMnkyd7Z1gF5yxq=GDH_Fy_PG1=FfcL=9b9nRQ@mail.gmail.com>
 <xmqq4lc3uyuh.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH v1 1/2] log -G: Ignore binary files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev42
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1543404692;316a905a;
X-HE-SMSGID: 1gRy42-0005mx-Mx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Junio C Hamano <gitster@pobox.com> hat am 27. November 2018 um 01:51 geschrieben:
> 
> 
> Stefan Beller <sbeller@google.com> writes:
> 
> > On Wed, Nov 21, 2018 at 1:08 PM Thomas Braun
> > <thomas.braun@virtuell-zuhause.de> wrote:
> >>
> >> The -G <regex> option of log looks for the differences whose patch text
> >> contains added/removed lines that match regex.
> >>
> >> The concept of differences only makes sense for text files, therefore
> >> we need to ignore binary files when searching with -G <regex> as well.
> >
> > What about partial text/partial binary files?
> 
> Good point. You'd use "-a" (or "--text") to tell the diff machinery
> to treat the contents as text, and the new logic must pay attention
> to that command line option.

Yes exactly. Either use -a for the occasional use or a textconv filter
for permanent use.

Coming from the opposite side: I usually mark svg files as binary as the
textual diff is well, let's say uninspiring.
