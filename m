Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329C1C77B7A
	for <git@archiver.kernel.org>; Wed, 31 May 2023 23:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjEaXkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 19:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEaXku (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 19:40:50 -0400
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 16:40:49 PDT
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC2E11D
        for <git@vger.kernel.org>; Wed, 31 May 2023 16:40:49 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 492301F542;
        Wed, 31 May 2023 23:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1685576126;
        bh=boelMeiF6DqKv8XDw2O0riILexTXdUSEr7x0+sUnlps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGGuQimrjokuH9Ej8oy7IwQIO40xSyxyEDUJusXWh4xJ8LpDaJPzott9GT4Dq6BPr
         zibQMmp7tvDoXKRjHsBDgSRkRCMxy58EgqIBiSE2j73qa1T4K5QjJI/7aUOuU2IGn3
         kn/oSmpH4LYIHsldLZzeopfJU6rfzIS4yxfznzF4=
Date:   Wed, 31 May 2023 23:35:26 +0000
From:   Eric Wong <e@80x24.org>
To:     Siddharth Singh <siddhartth@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Unit tests for khash.h
Message-ID: <20230531233526.M226883@dcvr>
References: <20230531155142.3359886-1-siddhartth@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230531155142.3359886-1-siddhartth@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Singh <siddhartth@google.com> wrote:
> This RFC patch adds unit tests for khash.h.

I agree with what Taylor said about being skeptical of these
tests being productive.

I'm curious about switching parts of git to use AC's newer `khashl'.
khashl is smaller than the original khash but slower for deletes.
Since git hardly deletes and khash memory use is high (especially on
packing); it should be a benefit all around.

Also, see Documentation/CodingGuidelines for coding style.
