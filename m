Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101CDC4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 01:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLPBQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 20:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLPBP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 20:15:59 -0500
Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809243F06C
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 17:15:56 -0800 (PST)
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id 089C3203;
        Fri, 16 Dec 2022 02:15:54 +0100 (CET)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id D0F6D28001EC; Fri, 16 Dec 2022 02:15:53 +0100 (CET)
Date:   Fri, 16 Dec 2022 02:15:53 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: git cherry-pick -x: missing blank line before the "cherry picked
 from commit" line
Message-ID: <20221216011553.GE7846@zira.vinc17.org>
References: <20221202141153.GA5599@cventin.lip.ens-lyon.fr>
 <75e00d43-3184-dcf8-4621-cdf02c9f7320@dunelm.org.uk>
 <20221202170144.GC5599@cventin.lip.ens-lyon.fr>
 <a97758b5-dfdc-9a24-654b-8846a9feb45d@dunelm.org.uk>
 <20221204154927.GF33204@zira.vinc17.org>
 <CAP8UFD1G++GvNxCVdwDqSm4P3SseyOWNh2jKBZ4jm-OTn2Vsmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1G++GvNxCVdwDqSm4P3SseyOWNh2jKBZ4jm-OTn2Vsmg@mail.gmail.com>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.2.9+54 (af2080d3) vl-149028 (2022-12-04)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-05 13:56:02 +0100, Christian Couder wrote:
> On Sun, Dec 4, 2022 at 4:49 PM Vincent Lefevre <vincent@vinc17.net> wrote:
> > I think that what could be interesting there is a
> > trailer.<token>.separators option (assuming that one can
> > use an empty list of separators to disable a token), but
> > that doesn't exist.
> 
> There is the trailer.separators config option. I am not sure if it
> disables trailers completely though if it is empty. If it doesn't,
> that could be an interesting feature to implement for people who don't
> use trailers at all (except for lines added by cherry-pick).

I have not tried yet, but the drawback is that it could be used
only if trailers are not used at all.

> A trailer.<token>.separators option that disables some <token> when
> empty could be another interesting idea, but it might have drawbacks.
> For example you might disable the "note" token, but then find that
> people sometimes use "notes:" or "NB:" or "PS:" or other things like
> that at the end of their commit messages.

Yes, or "References:" or "https:". Like that, which has just happened
to me: :-(

[...]
    References:
      https://sympa.inria.fr/sympa/arc/mpfr/2022-10/msg00001.html
      https://sympa.inria.fr/sympa/arc/mpfr/2022-10/msg00027.html
      https://gmplib.org/list-archives/gmp-bugs/2022-October/005200.html
    (cherry picked from commit 277faface2023449c91c1751630e760d136ae619)

Even when one knows the issue, it is too easy to forget it.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
