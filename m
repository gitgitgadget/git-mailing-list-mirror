Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6026C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786EF2076C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="x8yXsTx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHLUyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgHLUyL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 16:54:11 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E2C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 13:54:10 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1597265643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=J3nBth4RvUyVRzdKUped8HNvUvBufFqqG2fyF3y/hEg=;
        b=x8yXsTx6QKSUI5vK8wVhvv4B4zbxojgnPTTfbjX0gwv/tcudwb91HFlpkLOo82GKalnS7g
        hR4YAbL/E4ZK8KiGTWYSmZq827+cp/tKK3HpKE9XmoFWpd+XqaTh2xgsKQarZgoyfq3xfn
        uv/Uh6Bhyqy/aJPjmUiHB4gK+LrecKE=
Content-Type: text/plain; charset=UTF-8
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>, <git@vger.kernel.org>,
        "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] git-apply.txt: correct description of --cached
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Phillip Wood" <phillip.wood123@gmail.com>
Date:   Wed, 12 Aug 2020 16:52:51 -0400
Message-Id: <C4VBE1MG0QCG.3LQF9NB19E45T@ziyou.local>
In-Reply-To: <xmqqzh6z654a.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed Aug 12, 2020 at 3:23 PM EDT, Junio C Hamano wrote:
> An error is raised if the file in the working tree being patched
> has contents different from what is registered in the index.
>
> captures most of it, but still misses the "cached stat information
> also must match" part.

As a point of pedantry, it checks the preimages (don't want docs readers
to be worried it might somehow touch something and *then* error out).

I'll see if I can think of a succinct wording while I'm updating some of
the other patches.
