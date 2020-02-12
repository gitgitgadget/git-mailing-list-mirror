Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A645C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B0521734
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgBLWbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:31:31 -0500
Received: from vuizook.err.no ([178.255.151.162]:41798 "EHLO vuizook.err.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbgBLWbb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 17:31:31 -0500
Received: from p576124-ipngn200707tokaisakaetozai.aichi.ocn.ne.jp ([122.31.139.124] helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1j20XX-0003cn-NX; Wed, 12 Feb 2020 22:31:28 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1j20XS-000XQb-SH; Thu, 13 Feb 2020 07:31:22 +0900
Date:   Thu, 13 Feb 2020 07:31:22 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: SHA1dc on mac
Message-ID: <20200212223122.svthiwmh3js7i47b@glandium.org>
References: <20200212085646.hgq3nv2lf4brbb3j@glandium.org>
 <CAPig+cTfMx_kwUAxBRHp6kNSOtXsdsv=odUQSRYVpV21DnRuvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTfMx_kwUAxBRHp6kNSOtXsdsv=odUQSRYVpV21DnRuvA@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 11:46:31AM -0500, Eric Sunshine wrote:
> On Wed, Feb 12, 2020 at 3:57 AM Mike Hommey <mh@glandium.org> wrote:
> > If I'm not mistaken in my reading of the various files involved, it
> > looks like for some reason, building git on mac leads to using Apple
> > Common Crypto for SHA1, rather than SHA1dc, which seems unfortunate.
> > Is that really expected?
> 
> There was a discussion on this topic a while back[1], and it does seem
> that the behavior you describe is intentional[2].

That discussion predates SHA1dc, though.

> > More generally, at this point, should anything
> > other than SHA1dc be supported as a build option at all?
> 
> The conclusion [2,3] was that it likely would make sense to drop
> support for Apple's CommonCrypto altogether, although nobody has yet
> stepped up to do the work.

I wasn't explicit in my question, but I meant more broadly than Apple
Common Crypto. There is still opt-in support for openssl sha1 and PPC
sha1.

Mike
