Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56283C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A8660F46
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhKATLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:11:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49860 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhKATLj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:11:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EA5B61F953;
        Mon,  1 Nov 2021 19:09:05 +0000 (UTC)
Date:   Mon, 1 Nov 2021 19:09:05 +0000
From:   Eric Wong <e@80x24.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     users@linux.kernel.org, tools@linux.kernel.org, git@vger.kernel.org
Subject: Re: b4: unicode control characters -- warn or remove?
Message-ID: <20211101190905.M853114@dcvr>
References: <20211101175020.5r4cwmy4qppi7dis@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211101175020.5r4cwmy4qppi7dis@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> Hi, all:
> 
> Per exhibit a, what should we do in the situation where we discover unicode
> control characters in an email?
> 
> 1. Warn and strip these chars out, because they are extremely unlikely to be
>    doing anything legitimate in the context of a patch (unless someone is
>    sending patches for docs actually written in RTL languages)
> 2. Warn and error out, refusing to produce an mbox
> 3. Just warn and produce an mbox anyway
> 
> I'd normally do #3, but with many people piping things to git-am, I'm not sure
> if it's the safest choice.
> 
> Exibit a: https://lwn.net/Articles/874546/

+Cc: git@vger

IMHO, defense for this belongs in git-am (which already checks
things like whitespace).
