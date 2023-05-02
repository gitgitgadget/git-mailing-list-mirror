Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88589C77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 10:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjEBK2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 06:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjEBK12 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 06:27:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044A46A75
        for <git@vger.kernel.org>; Tue,  2 May 2023 03:25:13 -0700 (PDT)
Received: (qmail 24926 invoked by uid 109); 2 May 2023 10:25:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 May 2023 10:25:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9339 invoked by uid 111); 2 May 2023 10:25:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 May 2023 06:25:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 May 2023 06:25:12 -0400
From:   Jeff King <peff@peff.net>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v2] credential: new attribute oauth_refresh_token
Message-ID: <20230502102512.GB1180695@coredump.intra.peff.net>
References: <pull.1394.git.1678776364753.gitgitgadget@gmail.com>
 <pull.1394.v2.git.1682070479816.gitgitgadget@gmail.com>
 <20230425064758.GD4061254@coredump.intra.peff.net>
 <CAGJzqsmAESKYd5AYoZ17pg0F9Oe2sK_Odwpk4niQK9njtpCkTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGJzqsmAESKYd5AYoZ17pg0F9Oe2sK_Odwpk4niQK9njtpCkTg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 08:19:40PM +0100, M Hickford wrote:

> > > Add support for the new attribute to credential-cache. Eventually, I
> > > hope to see support in other popular storage helpers.
> >
> > At least your optimism is documented. :)
> 
> I have a draft patch for credential-libsecret
> https://github.com/gitgitgadget/git/pull/1524 which I could add to
> this patch series if you like. Helpers credential-wincred and
> credential-osxkeychain would be easy to update following the same
> approach.

Good, thanks for doing that work. I don't think it needs to be part of
this series. Knowing that it's being worked on gives a sense that this
patch is going in a useful direction.

I do find the "shove extra data into the password field" strategy a
little gross, but that may be the best that can be done when interfacing
with existing stores. And at least the details are all contained inside
the helper itself (though I guess a user looking at it with other wallet
management tools would see the weird field).

-Peff
