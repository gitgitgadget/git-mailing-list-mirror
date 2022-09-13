Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75530C6FA83
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 00:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIMA24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 20:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIMA2y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 20:28:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6D11C909
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:28:52 -0700 (PDT)
Received: (qmail 29475 invoked by uid 109); 13 Sep 2022 00:28:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Sep 2022 00:28:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19710 invoked by uid 111); 13 Sep 2022 00:28:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Sep 2022 20:28:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Sep 2022 20:28:51 -0400
From:   Jeff King <peff@peff.net>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
Message-ID: <Yx/Ow7EIi04CVWYE@coredump.intra.peff.net>
References: <Yxf9yETBi3k6Wasl@danh.dev>
 <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
 <YxjhQ8xVI4YtA7xb@coredump.intra.peff.net>
 <CA+4x=b9upd2uTihZK5hXDULkCz6y+CX-dS7p65Pfhn0zh0eMiA@mail.gmail.com>
 <YxkI2zqCheqTv/wc@coredump.intra.peff.net>
 <CA+4x=b-SqzGfeTu4c8akk3quYF7ORZ5jYCpey5221H8=+_PfRg@mail.gmail.com>
 <Yxow7zrYF/xOijVr@coredump.intra.peff.net>
 <CA+4x=b_eOO=ThnSkMARPXBH6cJLeuYPfF-PZNy4Vjpbk=BWQYw@mail.gmail.com>
 <xmqqr10kjtcu.fsf@gitster.g>
 <CA+4x=b8kqc=_osrghenGU96jGRGX=NKbpCjheRS4yjgom8t8og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+4x=b8kqc=_osrghenGU96jGRGX=NKbpCjheRS4yjgom8t8og@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2022 at 10:58:53AM -0400, Lana Deere wrote:

> Thanks for the info.  That sounds kind of like this fix, even if
> accepted, would miss rc0 but would be not unlikely to make rc1.  Is
> there any way to "watch" the issue so I can know which git release
> gets the fix?  I would like to be an early adopter of that release
> since I would want to test the change works for me.

Thanks. Early testing, especially of release candidates, is very
welcome. There's no tracking for a specific issue, but you can check the
status of the commit. The fix has been merged to 'next' now, so the
commit id will remain stable. You can periodically fetch any of the
usual Git mirrors[1] and check:

  git tag --contains 49ca2fba393fa277ab70253337c53c7831597c3a

Likewise, you can see when it hits master with "git branch -a
--contains".

You can also see the progress of topics in Junio's "What's cooking"
emails. If you're not a regular list reader, you can hit the recent ones
here:

  https://lore.kernel.org/git/?q=f%3Ajunio+s%3Acooking

Likewise, when -rc0, etc, are released, the release notes should mention
(or not) this fix. You can see those announcements in the archive like
this:

  https://lore.kernel.org/git/?q=f%3Ajunio+t%3Avger+s%3Aannounce

-Peff

[1] e.g., https://git.kernel.org/pub/scm/git/git.git/
