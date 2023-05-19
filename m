Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E88C77B7A
	for <git@archiver.kernel.org>; Fri, 19 May 2023 09:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjESJJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjESJJo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 05:09:44 -0400
Received: from zucker.schokokeks.org (zucker.schokokeks.org [IPv6:2a01:4f8:121:1ffe:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99432B0
        for <git@vger.kernel.org>; Fri, 19 May 2023 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hboeck.de; s=key1;
        t=1684487378; bh=6w6zhjUOajQsYKSkA30+PuAVJ3qLVxBAZullW5C/VPs=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=JuY/MctCaUy8zrzjzoRGLzeGuE4WwcAeMj5tkHjWrxiK1apq2VlesVvi3ChwIn//4
         jks0YoK00DCCehmv4HJMfCYpbeqXuE+BZ4RPhYmlE9iRK0iA55SVkUUZ9chWV7GPtc
         n2Bt9QOOyVMUxO7i6dUxdaeM+SYnTuTY/O2iAKJoEgELXuNlKHAmV70T948RuiPvGv
         Lg8WPCTaXoeCBod0DNDbdORSqBIXbrwVsfDC4rl/Pf9KiGtKNTFcFjUKvDla0LKzYW
         Ed53zmJd+NyTNi+tUxmAX1diBl2kY//NLzA0LPvE6sa+/1gyYC8QWNbMuWTESqravk
         a2BGyWtaJEiQQ==
Original-Subject: Re: git push --quiet is not quiet
Author: Hanno =?UTF-8?B?QsO2Y2s=?= <hanno@hboeck.de>
Original-Cc: Taylor Blau <me@ttaylorr.com>, "brian m. carlson"
 <sandals@crustytoothpaste.net>, git@vger.kernel.org
Date:   Fri, 19 May 2023 11:09:37 +0200
From:   Hanno =?UTF-8?B?QsO2Y2s=?= <hanno@hboeck.de>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git push --quiet is not quiet
Message-ID: <20230519110937.7df62fd7.hanno@hboeck.de>
In-Reply-To: <20230519090559.GA3515410@coredump.intra.peff.net>
References: <20230519101505.416d0963.hanno@hboeck.de>
        <20230519090559.GA3515410@coredump.intra.peff.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 May 2023 05:05:59 -0400
Jeff King <peff@peff.net> wrote:

> As a guess, I wondered if you might be pushing to GitHub.

Yes.

> So I think this is a bug / lack of feature in GitHub's server
> implementation.  It used to be a thin proxy around Git (and Git has
> supported "quiet" since c207e34f7733 in 2012). But I suspect they may
> have recently replaced it with something more custom (based on the
> agent field).

Ok, interesting. Maybe add to this: it appears github sometimes uses
this channel to send relevant messages, e.g. dependabot alerts. Which I
guess is a good thing, but it probably shouldn't send status messages
for normal commits when the user asks for "quiet".

--=20
Hanno B=C3=B6ck
https://hboeck.de/
