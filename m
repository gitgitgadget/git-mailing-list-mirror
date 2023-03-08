Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DFFC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 22:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCHWjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCHWjO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 17:39:14 -0500
Received: from qproxy3-pub.mail.unifiedlayer.com (qproxy3-pub.mail.unifiedlayer.com [67.222.38.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5D55ADF9
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 14:39:12 -0800 (PST)
Received: from outbound-ss-820.bluehost.com (outbound-ss-820.bluehost.com [69.89.24.241])
        by qproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id 5B8D28027BA5
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:39:12 +0000 (UTC)
Received: from cmgw14.mail.unifiedlayer.com (unknown [10.0.90.129])
        by progateway2.mail.pro1.eigbox.com (Postfix) with ESMTP id E6D71100478A7
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:39:11 +0000 (UTC)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with ESMTP
        id a2RDpj6FoWuSqa2RDpCcV8; Wed, 08 Mar 2023 22:39:11 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=Vqrmv86n c=1 sm=1 tr=0 ts=64090e8f
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=k__wU0fu6RkA:10:nop_rcvd_month_year
 a=3EOfIcITIxQA:10:endurance_base64_authed_username_1 a=tsIoxU2LizdRE0QKq6cA:9
 a=QEXdDO2ut3YA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:Date:To:Reply-To:From:Subject:Message-ID:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=29+ErIzRLGbiTOgK7gC6A+NBhzJ7An30yMCJ8eN9q98=; b=Roc6qSg4x0ICaeAwOK4+SSKli2
        Wj6L2kuSOJbQ8b5keZDi3cAJH4XNR2GND3glcru8VT9pQzpNrMF1P4gW+ECfy9ImmWzPpYcjNtfP4
        CkCvQZ3E5eh7qmTI1l2+Cddrj;
Received: from [160.231.0.90] (port=58308 helo=llin-psh13-dsa.dsone.3ds.com)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <paul@mad-scientist.net>)
        id 1pa2RD-0026zY-Il
        for git@vger.kernel.org;
        Wed, 08 Mar 2023 15:39:11 -0700
Message-ID: <6215dde710670fdf0da3ba0549429eaa32db257b.camel@mad-scientist.net>
Subject: Fetching everything in another bare repo
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org
Date:   Wed, 08 Mar 2023 17:39:07 -0500
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (by Flathub.org) 
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 160.231.0.90
X-Source-L: No
X-Exim-ID: 1pa2RD-0026zY-Il
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.0.90]:58308
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies if this is the wrong list.

I have a tool that wants to preserve every commit and never garbage
collect (there are references that need to be maintained to older
commits/branches that have been deleted).  This tool keeps its own bare
clone, and disables all GC and maintenance on it.

Unfortunately a month or so ago, by accident someone re-cloned the
primary copy of the repo that everyone else uses as this bare clone,
which lost the old history.

The good news is that I have a copy of the original bare clone with all
the history intact.

So now what I want to do is fetch the old data into the current bare
clone (since the old clone doesn't have the newest stuff).  And, I need
to be sure that all commits are pulled, and kept, and nothing is
cleaned up.  I would also like any deleted branches to re-appear, but I
don't want to change the location of any existing branches in the new
repo.

Is it sufficient to run something like this:

  git fetch --no-auto-maintenance --no-auto-gc <path-to-old-clone>

??  Are there other options I should consider?  Is it better to fetch
the NEW clone into the OLD clone, than to fetch the old clone into the
new clone (the new data is much more important to preserve)?

Since this is a one-off operation I don't care so much about making the
fetch fast.

Thanks!
