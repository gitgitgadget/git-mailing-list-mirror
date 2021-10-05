Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D4EC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 08:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8DD6136F
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 08:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhJEIhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 04:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhJEIhB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 04:37:01 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B2C061745
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 01:35:11 -0700 (PDT)
Received: from [2400:4160:1877:2b00:410a:fd15:2718:8b5d] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1mXfuj-0007nY-Gy; Tue, 05 Oct 2021 08:35:08 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mXfue-002fh6-41; Tue, 05 Oct 2021 17:35:00 +0900
Date:   Tue, 5 Oct 2021 17:35:00 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Use mingw.h declarations for gmtime_r/localtime_r on
 msys2
Message-ID: <20211005083500.jd7byba4abupdub5@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20211005063936.588874-1-mh@glandium.org>
 <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 05, 2021 at 12:12:12AM -0700, Carlo Arenas wrote:
> On Mon, Oct 4, 2021 at 11:57 PM Mike Hommey <mh@glandium.org> wrote:
> > A possible alternative fix would be to e.g. add `#define _POSIX_C_SOURCE
> > 200112L` to git-compat-util.h and add `ifndef __MINGW64_VERSION_MAJOR`
> > around the definitions of `gmtime_r` and `localtime_r` in
> > compat/mingw.c, since, after all, they are available there.
> 
> something like that was merged to "main"[1] a few months ago, would
> that work for you?

This seems very close to what I was suggesting, so I would guess so :)
I'm wondering if there's a reason not to set _POSIX_C_SOURCE everywhere,
along the other _*_SOURCE's.

Mike
