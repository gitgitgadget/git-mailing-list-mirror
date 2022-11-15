Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858B3C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 18:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiKOSBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 13:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbiKOSBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:09 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E135139
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:00:47 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1668535245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxB5waFtfNURSybt8bIMnNNKSryP1F6rat/Q/y7L8ho=;
        b=fgfr4jDwvSmbbwW0kQux/SF6SgbR9FO9xT7dtkYUPpoS+0GNkqoyRe6rdxZiIJwJnJvpTw
        WwHhcYIC6lKSItCd6ZaGCrp+3Cu3l26J62z25l5loPtOvJy4/kzXhhnTxIQBzXPp4nt3Ir
        3NSCq5YoEwWKI0ow5omaXQhk0PO41n4=
Date:   Tue, 15 Nov 2022 18:00:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   ronan@rjp.ie
Message-ID: <d66fad29eb4c80fd1e9db4cfe5077085@rjp.ie>
Subject: Re: [PATCH v2] maintenance --unregister: fix uninit'd data use &
 -Wdeclaration-after-statement
To:     "Taylor Blau" <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?=" <avarab@gmail.com>,
        Johannes.Schindelin@gmx.de
In-Reply-To: <Y3PN4K1ULrvGCEEE@nand.local>
References: <Y3PN4K1ULrvGCEEE@nand.local>
 <patch-v2-1.1-f37e99c9d59-20221115T160240Z-avarab@gmail.com>
 <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com>
 <1ab6aa0e8178c88689f26b8df9ec75cb@rjp.ie>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

November 15, 2022 10:35 AM, "Taylor Blau" <me@ttaylorr.com> wrote:=0A=0A>=
 It was human error on my part. Please let me know if the result in=0A> '=
next' now is OK to you.=0A=0AHad a look and I'm just wondering if we're s=
ure it's alright to clear=0Athe configset before using the list we found =
in it. Doesn't that list=0Apoint into the configset?
