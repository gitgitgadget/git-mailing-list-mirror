Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23508C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiGRTEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGRTEG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:04:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37362BC2D
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:04:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D44E520798;
        Mon, 18 Jul 2022 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658171044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2CFXqR7rLl7pIrk8Dl2gsg/cC6VWJtryS4x8xRIsxg=;
        b=ud0tQBOK09JCTj+xXYOPD/g4kcj9d/f90ZwztXkO2nHEmBCvzyWoPdyMhRlMVuI2vzpT0w
        xpA7eAPIJQshuBW+FnMmjWvJOtak7k883AV/Mr3qmmbMDM5wOYVc0Zbi/QZFWaZLfu6Y7J
        +031tiX2MlVcUiXRm0Cjxq24vCKx/nI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658171044;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2CFXqR7rLl7pIrk8Dl2gsg/cC6VWJtryS4x8xRIsxg=;
        b=2+2rYjZjlkcWuK3tg31R3nmldbiCTrBRsucDrvE7Lsagr+tz/jE8r3617M3DJRe7xC55xh
        9E4m+Wx+TMFAIUCQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B85D22C141;
        Mon, 18 Jul 2022 19:04:04 +0000 (UTC)
Date:   Mon, 18 Jul 2022 21:04:03 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Stephen Finucane <stephen@that.guru>, git@vger.kernel.org
Subject: Re: Feature request: provide a persistent IDs on a commit
Message-ID: <20220718190403.GT17705@kitsune.suse.cz>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <20220718173511.rje43peodwdprsid@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220718173511.rje43peodwdprsid@meerkat.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 01:35:11PM -0400, Konstantin Ryabitsev wrote:
> On Mon, Jul 18, 2022 at 06:18:11PM +0100, Stephen Finucane wrote:
> > ...to track evolution of a patch through time.
> > 
> > tl;dr: How hard would it be to retrofit an 'ChangeID' concept à la the 'Change-
> > ID' trailer used by Gerrit into git core?
> 
> I just started working on this for b4, with the notable difference that the
> change-id trailer is used in the cover letter instead of in individual
> commits, which moves the concept of "change" from a single commit to a series
> of commits. IMO, it's much more useful in that scope, because as series are
> reviewed and iterated, individual patches can get squashed, split up or
> otherwise transformed.

You can turn that around and say that IDs of individual commits are more
powerful because they are preserved as series are reviewed, split,
merged, and commits cherry-picked.

Thanks

Michal
