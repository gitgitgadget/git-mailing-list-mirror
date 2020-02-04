Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF94C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698B220674
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBDTyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:54:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:52352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727314AbgBDTyC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 14:54:02 -0500
Received: (qmail 11051 invoked by uid 109); 4 Feb 2020 19:54:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Feb 2020 19:54:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2314 invoked by uid 111); 4 Feb 2020 20:02:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Feb 2020 15:02:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Feb 2020 14:54:01 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Message-ID: <20200204195401.GB12705@coredump.intra.peff.net>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
 <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
 <20200128073100.GA563058@coredump.intra.peff.net>
 <CAFQ2z_MXDODBmsCVPdvNQzhFSYchq77mJCxw9P0kPSmSnsTZqQ@mail.gmail.com>
 <20200129104754.GE4218@coredump.intra.peff.net>
 <CAFQ2z_O3DhLbVtpGBWERnwGawtvE-iZNKRDGg_sfMhOX6g=Wpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_O3DhLbVtpGBWERnwGawtvE-iZNKRDGg_sfMhOX6g=Wpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 08:06:57PM +0100, Han-Wen Nienhuys wrote:

> On Wed, Jan 29, 2020 at 11:47 AM Jeff King <peff@peff.net> wrote:
> 
> > That said, it might make for easier debugging if the reftables file
> > declares the size it assumes.
> 
> If there is a mismatch in size, the reftable will look completely
> corrupted data.  I think this will be a bad experience.

Yes, but I think it would take a bunch of other failures to get there.
And it's true of all of the other parts of Git, too; the master switch
is a config setting that says "I'm a sha-256 repository".

That said, I'm not at all opposed to a header in the reftables file
saying "I'm a sha-256 reftable". We shouldn't ever see a mismatch there,
but that's what I meant by "easier debugging".

-Peff
