Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECEF42023D
	for <e@80x24.org>; Thu,  2 Mar 2017 06:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbdCBGMl (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 01:12:41 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:35857 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdCBGMk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 01:12:40 -0500
Received: by mail-ot0-f173.google.com with SMTP id i1so45677279ota.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 22:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FwT4gqNH26Z22fcQ6QPc5aTun5lTnF9JdXa+6fKDbEM=;
        b=VuEKhj9K0Oe9TRrHn9uspksT7RZWYuIfMsKyNaHQZlse1lxC13lWRaYj2JOo4VCaV+
         GuvrSHNjTeFtRK/5zwvDARNnOHyRiwBQTMslTeULz6bay3CP9kkdtTVcuXo6FGujdom/
         MzZwKvd8+kDAPQzKU3sEJ/ergcSTu1xb053J4pP6FtdMJ8JWCxAieahbjPFAnb+4Twrd
         kjRcEGIzq6B/50d6ksPgfjuxdsEfPC91I2XCWBsHQSIp9m/hBjtyVWQd+DLG0qEuMZMb
         3JiVMQlwBZE7MUmvt4EOH3/WOXm++9HH012NfX2FaloZFNIZWKxB1XNaBVs85RXNjHJi
         Mf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FwT4gqNH26Z22fcQ6QPc5aTun5lTnF9JdXa+6fKDbEM=;
        b=cFNz1aEduPeN7Kfm2UA7NNY9ym1ou8vzo6el/PiT1c6b/UaxIBbJqpVWoqI2ClcVOh
         R0t96rXUTepkJ65DY8l4PbObEMKK7llJdGhKMc5a0elorJ+x7Z2S2GD0dAJuBN4cPdY1
         b8InFEPbVMieDa6p5DCFB3BRQXo5ybfIZSfmsY3slAMBdVvmyoEut1e1b7Oo/OFBKZRw
         W1iogQ7Nwxv9oKHZymJQQ5Z1BX2kYIpnQUkyx4ktcKLVARYEWA5rkgqUmXtqENje5pit
         Nh1yQUMVRLgmrmZOFiIUIxYNB16lnfcOQzFJV1vVwlLwVIDpmqaUmpV0iQhsdyVJ+GH1
         c0Bw==
X-Gm-Message-State: AMke39k36ucGJc9unmoupZWGMnKeOiihC+hWpYJ43B78iNspcfjlwEgNpSaWQnvtHmYFEcyJ2F48/dWh+0OLVQ==
X-Received: by 10.157.20.151 with SMTP id d23mr2601733ote.37.1488435054578;
 Wed, 01 Mar 2017 22:10:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Wed, 1 Mar 2017 22:10:23 -0800 (PST)
In-Reply-To: <20170301231921.2puf7o7jkrujscwn@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703012227010.3767@virtualbox>
 <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com>
 <alpine.DEB.2.20.1703012334400.3767@virtualbox> <CA+55aFy9=jBJT36FC2HiAeabJBssY=jE=zLxwrXWzhpiFkMUXg@mail.gmail.com>
 <20170301231921.2puf7o7jkrujscwn@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Mar 2017 13:10:23 +0700
Message-ID: <CACsJy8D3h1KAaKi_Esc98za3LqXaB=YeW0Yu+VAV9UnX5vmttg@mail.gmail.com>
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 6:19 AM, Jeff King <peff@peff.net> wrote:
> You have to remember that some of the Git for Windows users are doing
> horrific things like using repositories with 450MB .git/index files, and
> the speed to compute the sha1 during an update is noticeable there.

We probably should separate this use case from the object hashing
anyway. Here we need a better, more reliable crc32 basically, to
detect bit flips. Even if we move to SHA-something, we can keep
staying with SHA-1 here (and with the fastest implementation)
-- 
Duy
