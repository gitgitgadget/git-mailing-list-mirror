Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6713BECAAD2
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 07:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245755AbiHZH6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 03:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245695AbiHZH6j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 03:58:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEEFD39AD
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:58:38 -0700 (PDT)
Received: (qmail 18069 invoked by uid 109); 26 Aug 2022 07:58:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Aug 2022 07:58:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4652 invoked by uid 111); 26 Aug 2022 07:58:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Aug 2022 03:58:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Aug 2022 03:58:37 -0400
From:   Jeff King <peff@peff.net>
To:     Zang <zealot0630@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Considering add log.format and show.format configure option
Message-ID: <Ywh9LUOf9sNlVy4a@coredump.intra.peff.net>
References: <CAOrge3pTP5WU3Z1HRLz7xqExwt7_n33FUkh9KQP2m6VyuA9sJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOrge3pTP5WU3Z1HRLz7xqExwt7_n33FUkh9KQP2m6VyuA9sJw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2022 at 03:12:34PM +0800, Zang wrote:

> Can we consider add such option to git-config
> 
> [format]
>     mylogformat = <...>
>     myshowformat = <...>
> [log]
>     format = mylogformat
> [show]
>     format = myshowformat
> 
> Which should work same as
> 
> git log --format=mylogformat
> git show --format=myshowformat

I don't think there is any reason not to add something like that. As you
note, we already allow overriding the default for all of the log-family
commands. So doing it for individual ones is not a stretch.

(I'm not sure if you know, the first half of your suggestion is already
available as pretty.*, so this would just be adding log.format, etc, to
override format.pretty. Possibly your "format' is just a typo of
"pretty" there).

-Peff
