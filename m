Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6702C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 10:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A5A208DB
	for <git@archiver.kernel.org>; Sun, 10 May 2020 10:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgEJKyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 06:54:50 -0400
Received: from ciao.gmane.io ([159.69.161.202]:35048 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgEJKyu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 06:54:50 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1jXjbc-000GdU-Lc
        for git@vger.kernel.org; Sun, 10 May 2020 12:54:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Achim Gratz <Stromeko@nexgo.de>
Subject: Re: [PATCH] bisect: fix replay of CRLF logs
Date:   Sun, 10 May 2020 12:54:43 +0200
Organization: Linux Private Site
Message-ID: <87tv0o5abw.fsf@Rainer.invalid>
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
        <20200507222510.GA42822@coredump.intra.peff.net>
        <xmqq5zd72vjp.fsf@gitster.c.googlers.com>
        <20200508130831.GB631018@coredump.intra.peff.net>
        <xmqqh7wq1n52.fsf@gitster.c.googlers.com>
        <xmqq8si2z8zb.fsf@gitster.c.googlers.com>
        <20200508171232.GA637136@coredump.intra.peff.net>
        <20200509221730.GG7234@camp.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Cancel-Lock: sha1:U3nhfBPVf1br1aPDAobF/cw/v7c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson writes:
> Cygwin allows configurable behavior for line endings, but I don't know

That's restricted to handling files in text mode based on a mount
option.

https://cygwin.com/faq.html#faq.api.cr-lf

> whether any configuration it allows handles CR in the shell.  I'm sure
> Cygwin will do the right thing with LF only lines regardless, so it's
> probably safe to just assume LF-only behavior in the shell.

A handful of tools had patches to recognize and deal with CRLF in input,
but most of these patches have been dropped a long time ago.  The better
assumption is that Cygwin behaves like Linux, so CR only input/output on
text.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptations for Waldorf Q V3.00R3 and Q+ V3.54R2:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada

