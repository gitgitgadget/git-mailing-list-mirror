Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88211F461
	for <e@80x24.org>; Fri, 23 Aug 2019 07:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfHWH3h convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 23 Aug 2019 03:29:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729116AbfHWH3h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 03:29:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75911AD23;
        Fri, 23 Aug 2019 07:29:36 +0000 (UTC)
Date:   Fri, 23 Aug 2019 09:29:34 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Giuseppe =?UTF-8?B?Q3JpbsOy?= <giuscri@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190823092934.5fd986c3@naga>
In-Reply-To: <CAGV3M54RZn9pWe=R-qfm0UCU6TOhLc7-6H60Zf03gOe5Sq6wzw@mail.gmail.com>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
        <20190822150614.o25g37pwfcaos2zn@localhost.localdomain>
        <xmqqy2zlp3qn.fsf@gitster-ct.c.googlers.com>
        <CAGV3M54RZn9pWe=R-qfm0UCU6TOhLc7-6H60Zf03gOe5Sq6wzw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 23 Aug 2019 09:20:47 +0200
Giuseppe Crinò <giuscri@gmail.com> wrote:

> On Thu, Aug 22, 2019 at 6:24 PM Junio C Hamano <gitster@pobox.com> wrote:
> > The logic there exists in order to remove cruft around the name on a
> > typical e-mail header (remember, most of the very core-ish part of
> > the Git was written and got solidified back when the Linux kernel
> > was the primary client of the system, and many commits were created
> > via "am"), e.g. sender's mail client may send something like this:
> >
> >     From: 'Foo bar Baz' <my@name.xz>
> >
> > and we do not want to take surrounding sq pair as part of the name.  
> 
> I see but _standard_ rules to escape characters should apply as I
> understand this. 'Foo bar Baz\'s' should be allowed as it should "Foo
> bar Baz's". They should resolve to the same name too

It would not be removed in this case regardless of the qouting. It is
neither at the start nor at the end.

Thanks

Michal
