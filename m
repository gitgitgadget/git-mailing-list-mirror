Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4F0C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 06:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhKXGPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 01:15:21 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:40988 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234912AbhKXGPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 01:15:20 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1F1B41F953;
        Wed, 24 Nov 2021 06:12:11 +0000 (UTC)
Date:   Wed, 24 Nov 2021 06:12:10 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, workflows@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
Message-ID: <20211124061210.GA3059@dcvr>
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211123185237.M476855@dcvr>
 <xmqq4k825o6r.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4k825o6r.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > git send-email's capitalization does annoy me and I've looked
> > into changing it; but there's a bunch of tests and probably
> > dependent code that also need to be updated...
> 
> It does annoy me, too, and I do not mind if it gets "fixed", but I
> do not know if the cost for vetting a bulk update like that is worth
> it.  There is another one outside send-email in log-tree.c that is
> responsible for output from format-patch.

I support updating the documentation in git, first; then perhaps
making tests case-insensitive (which could be a complex
change...).

Unfortunately, changing the send-email + log-tree.c code would
break existing users of the applypatch-msg hook sample in
linux/Documentation/maintainer/configure-git.rst which has
been case-sensitive for around for 2 years:
https://lore.kernel.org/r/20191118223019.81708-1-linus.walleij@linaro.org

:<
