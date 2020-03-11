Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BFFC0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D405B20736
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="gQHTBinq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgCKTbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:31:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:50361 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731003AbgCKTbq (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Mar 2020 15:31:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583955105; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=9AzlRaY3FIcD7UTUq2f3Cc8ozGb5iV+80KQW4BuItnA=; b=gQHTBinqSxLo5br1h6HrMK3qK/foyVoLAQ/brCjzcC5Jk9EaiJKt9AgxFRZVtK5GyXAWFys3
 FeqwyeR1E3FUsqfP3xUvDHHrXSNsOosjaGSGRTnHWmElIkkcekUA0ioN9+Bj6eY+UgwNuHyg
 Oq3v61eV+bkYaoAZXW6CNw26lrM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e693ca1.7ff86507aea0-smtp-out-n01;
 Wed, 11 Mar 2020 19:31:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D3A2C43636; Wed, 11 Mar 2020 19:31:44 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 737A8C44788;
        Wed, 11 Mar 2020 19:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 737A8C44788
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Christos Pappas <chrispappas99@gmail.com>
Cc:     git@vger.kernel.org, annulen@yandex.ru
Subject: Re: [Feature request] Give non-unique names to commits for grouping
Date:   Wed, 11 Mar 2020 13:31:41 -0600
Message-ID: <12099923.Cjvj2aPIT9@mfick-lnx>
User-Agent: KMail/5.1.3 (Linux/4.4.0-154-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <CAGa6KtQ2dQWPWxbk2MH8QJxemM8QD_O=B3aYzsP5AH-sN-7PSw@mail.gmail.com>
References: <CAGa6KtSgGOLVjHdubwRW=Bvnjnp2PoP7jJ5_NxNWGFLrVYT9SA@mail.gmail.com> <2001043.V3P9HlvaID@mfick-lnx> <CAGa6KtQ2dQWPWxbk2MH8QJxemM8QD_O=B3aYzsP5AH-sN-7PSw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, March 11, 2020 8:56:44 PM MDT Christos Pappas wrote:
> Thank you for your answers.

FYI: the list preference is inline instead of top-posting.
 
> From what I can deduce, both of your suggestions require that the
> commit messages(or notes) must have some special text for which we can
> search for, which is hacky and would be different on every repository.

By "different", do you mean the mechanism, or the content of the "hashtag" 
itself? I would imagine that you would expect the hashtags to be different,
and that you are concerned that they might be stored differently on each
site, maybe on one site as a note like

 hashtag: awesome

and on another:

 label: awesome

Is that correct?

If so, then it seems like a reasonable suggestion that some tooling be built 
to potentially enforce something like that using git notes and/or commit 
messages?

> What I am suggesting is something like, labels on GitHub, hashtags on
> Social-Media, or Tags in News sites. It's a well known concept so it
> will be easy to understand and use.
> 
> We could initially create the concept of marks/labels/{another name}
> ('tags' is already in use by another git command) and then
> incrementally enhance the git commands to use this functionality (like
> the example I gave above, with git blame).

Right, maybe git notes is just the storage mechanism for such a feature?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
