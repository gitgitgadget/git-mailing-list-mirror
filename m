Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A9CC433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 01:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A13E64F71
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 01:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhCPBQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 21:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhCPBPh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 21:15:37 -0400
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Mar 2021 18:15:37 PDT
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD2C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 18:15:37 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1615856736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VCOcwuUm2Hlka/TS8/RaM4EEosdJfwQrO9uN6K7PAsI=;
        b=OZ7WigxovkrnQWbsmgmvRUntUY1OovmhWxIyIBseFsUVx4DTQ4pN1pG/QRk41tZ4XhCGD7
        F9ilz6dG633tndCBBLCYWZziLKSI8UbsfmlGPX4tDzkGjv167DgLEteDss0+YOiwPMrxL8
        qWfL2xTIDQN2J2gn/3ZZEMxuHdE+j94wMInGtwmhzpK7RqonMviyJAad44PsJdrUj4kZ+G
        x9YOPC2zOeVZpxEHEBGROSBQ6ergWexbcppRuNFBSF5egXFDbyMV/PpN4nD9IbEEFVhpW5
        PFaiR+003qi+i5YnWieUNpha3yM+o3/kzKmTYReDVwTFC50ySMLdgwyLPV+/dQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 15 Mar 2021 21:05:34 -0400
Message-Id: <C9YDEO8Z8J96.262IOS9IW6F39@taiga>
To:     "Jonathan Nieder" <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
In-Reply-To: <YFADuptwV7iR76g5@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Mar 15, 2021 at 9:02 PM EDT, Jonathan Nieder wrote:
> I'm not sure it's a disconnect; instead, it just looks like we
> disagree. That said, with more details about the use case it might be
> possible to sway me in another direction.
>
> To maintain the URI analogy: the URI does not tell me the content-type
> of what I can access from there. Until I know that content-type, I
> may not know what the best tool is to access it.

git isn't a content type, it's a protocol. git over HTTP or git over SSH
is a protocol in its own right, distinct from these base protocols, in
the same sense that SSH lives on top of TCP which lives on top of IP
which is transmitted to your computer over ethernet or 802.11. It's
turtles all the way down.

> The root of the disagreement, though, is "Git URLs" looking like a URI
> in the first place. They're not meant to be universal at all. They
> are specifically for Git.

At worst I would call this a happy coincidence. We have this convenient
universal format at our disposal, and we would be wise to take advantage
of it. Rejecting it on the premise that we never wanted to have it
doesn't make sense when we consider that (1) we do have it and (2) it
can be of good use to us.
