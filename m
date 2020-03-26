Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C478C2D0E7
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 01:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECBB20714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 01:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCZBJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:09:53 -0400
Received: from sunset.tt-solutions.com ([82.240.17.225]:51643 "EHLO
        smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbgCZBJx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 21:09:53 -0400
X-Greylist: delayed 1529 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 21:09:53 EDT
Received: from [192.168.17.86] (helo=Twilight.zeitlins.org)
        by smtp.tt-solutions.com with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.92)
        (envelope-from <vz-git@zeitlins.org>)
        id 1jHGdD-00079b-06; Thu, 26 Mar 2020 01:44:23 +0100
Date:   Thu, 26 Mar 2020 01:44:23 +0100
From:   Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re: [PATCH] fetch: allow running as different users in shared repositories
To:     johannes.schindelin@gmx.de
cc:     git@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: nycvar.QRO.7.76.6.2003252001560.46@tvgsbejvaqbjf.bet
References: nycvar.QRO.7.76.6.2003252001560.46@tvgsbejvaqbjf.bet
X-Mailer: Mahogany 0.68.0 'Cynthia', running under Windows 7 (build 7601, Service Pack 1), 64-bit edition
Message-Id: <E1jHGdD-00079b-06@smtp.tt-solutions.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 25 Mar 2020 20:04:09 +0100 Johannes Schindelin wrote:

JS> Hi Vadim,

 Hello Johannes and thanks for your reply!

JS> On Thu, 19 Mar 2020, Vadim Zeitlin wrote:
JS> 
JS> > The function fopen_for_writing(), which was added in 79d7582e32 (commit:
JS> > allow editing the commit message even in shared repos, 2016-01-06) and
JS> > used for overwriting FETCH_HEAD since ea56518dfe (Handle more file
JS> > writes correctly in shared repos, 2016-01-11), didn't do it correctly in
JS> > shared repositories under Linux.
JS> >
JS> > This happened because in this situation the file FETCH_HEAD has mode 644
JS> 
JS> I wonder why that is. In a shared repository, it should have mode 664, I
JS> thought.

 This file is created using a simple fopen("w") and so is subject to umask.
With the usual default umask value (022) its mode would be 644, regardless
of the repository settings.

[...snip my original description...]
JS> That rationale makes sense to me, as does the patch.

 Sorry for a possibly stupid question, but what is the next thing to do
now? The instructions in Documentation/SubmittingPatches indicate that I
should wait until the "list forms consensus that [...] your patch is good",
but it's not quite clear what indicates that a consensus has been reached.
Is your comment above enough or should I wait for something else? And
if/when it has been reached, do I really I need to resend the patch to
the maintainer and cc the list as written in that document? I'm a bit
surprised by this because I don't see (most) patches being resent to this
list.

 This is obviously very non-urgent, but I'd just like to understand what,
if anything, is expected from me.

 Thanks in advance for your guidance!
VZ
