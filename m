Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093B1C433DB
	for <git@archiver.kernel.org>; Sat, 26 Dec 2020 22:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C63221E9
	for <git@archiver.kernel.org>; Sat, 26 Dec 2020 22:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgLZW2q convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 26 Dec 2020 17:28:46 -0500
Received: from nibbler.ldn-fai.net ([80.67.188.164]:41688 "EHLO
        nibbler.ldn-fai.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgLZW2p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Dec 2020 17:28:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by nibbler.ldn-fai.net (Postfix) with ESMTP id 488288ED5A7;
        Sat, 26 Dec 2020 23:28:04 +0100 (CET)
Received: from nibbler.ldn-fai.net ([127.0.0.1])
        by localhost (nibbler.ldn-fai.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 20OVONp7ThXz; Sat, 26 Dec 2020 23:28:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.ldn-fai.net (Postfix) with ESMTP id B656C8ED5A8;
        Sat, 26 Dec 2020 23:28:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at nibbler.ldn-fai.net
Received: from nibbler.ldn-fai.net ([127.0.0.1])
        by localhost (nibbler.ldn-fai.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t-RHhWV7QaA0; Sat, 26 Dec 2020 23:28:03 +0100 (CET)
Received: from pica (82-64-239-100.subs.proxad.net [82.64.239.100])
        by nibbler.ldn-fai.net (Postfix) with ESMTPSA id 42D3D8ED5A7;
        Sat, 26 Dec 2020 23:28:03 +0100 (CET)
Date:   Sat, 26 Dec 2020 23:28:01 +0100
From:   =?iso-8859-1?Q?J=E9r=E9mie?= Detrey <Jeremie.Detrey@altu.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Shulhan <m.shulhan@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-remote: load config whenever create_symref() might
 be called
Message-ID: <X+e48UEE4wf3fMNI@pica>
References: <20201226134420.722643-1-Jeremie.Detrey@altu.fr>
 <xmqqeejcqlpq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xmqqeejcqlpq.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the feedback!

Junio C Hamano:
> My gut feeling says that the best place to call git_config() on
> git_default_config would actually be in cmd_remote(), immediately
> before we call parse_options() to parse the main options shared by
> all subcommands of "git remote".  Is there a reason why codepaths
> other than the three you singled out should *not* be affected by the
> basic set of configuration variables?

No, none that I can think of. I'll leave more knowledgeable people
than me confirm this, but if that's the way to go, I'll be happy to
submit a revised patch following your suggestion :)

Cheers,
Jérémie.
