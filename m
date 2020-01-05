Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8C6C33C8C
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 15:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A26220801
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 15:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAEP1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 10:27:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:53230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgAEP1f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 10:27:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1BA81ABE9;
        Sun,  5 Jan 2020 15:27:34 +0000 (UTC)
Date:   Sun, 5 Jan 2020 16:27:32 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: ERANGE strikes again on my Windows build; RFH
Message-ID: <20200105152732.GR4113@kitsune.suse.cz>
References: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
 <20191230180653.GA57251@google.com>
 <54522fee-0796-df46-a3cf-4331537ecf59@kdbg.org>
 <20191230184948.GC57251@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230184948.GC57251@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 30, 2019 at 10:49:48AM -0800, Jonathan Nieder wrote:
> Johannes Sixt wrote:
> > Am 30.12.19 um 19:06 schrieb Jonathan Nieder:
> 
> >>                                                                    when
> >> errno is meaningful for a function for a given return value, the usual
> >> convention is
> >>
> >>  (1) it *always* sets errno for errors, not conditionally
> >
> > You seem to understand that errno isn't set somewhere where it should be
> > set.
> 
> On the contrary: this caller is using errno as an error *indicator*
> instead of a way of *distinguishing* between errors (or to put it
> another way, this caller is treating `errno == 0` as a meaningful
> condition).  This means the calling code is buggy.

That works completely fine if the code in question also sets errno to 0
in case there is some other leftover value from a previous library call.

Thanks

Michal
