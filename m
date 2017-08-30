Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285E420285
	for <e@80x24.org>; Wed, 30 Aug 2017 20:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdH3U2X (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 16:28:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:55543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbdH3U2W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 16:28:22 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M20Jj-1dX7iZ0MlH-00ty2E; Wed, 30
 Aug 2017 22:28:20 +0200
Date:   Wed, 30 Aug 2017 22:28:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Sebastian Schuberth <sschuberth@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Commit dropped when swapping commits with rebase -i -p
In-Reply-To: <oo62vr$pvq$1@blaine.gmane.org>
Message-ID: <alpine.DEB.2.21.1.1708302223510.7424@virtualbox>
References: <oo62vr$pvq$1@blaine.gmane.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g/59SjK+egfLHtjvXhs6Ij0jSnkvIjX839BZatxS1RKENAV4d84
 4xA6YXNU8lKJRWT+JOnHszmyydOyE+gQB58TNKiEfH+FC0abVICRGmuzk+N7XMXEjieCsLP
 r3n7Hqp86mFlPYK+6s89+rjXchiJvTmt/UryU7CTAI3UlAl448t9Bn7cFjAF2SrljKb84Q9
 OMaKYc+aeK7pOpFySUypg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OUFymTfv/Zo=:iGe/qk6NofY2TbSyJnbihi
 OXsBxvGr84lOk+0npNjWuMKpb8k9DF4JF04fbCtNlC53B5O9GXzWRDsDqBPiGDJjw6psL2zZr
 s14NKDPvaGSdtsU+g1Pv+EiG40cTheZulEPfnOd1rQg4i9IbBDsE2yTU/0KWqDQtuywfSmdoO
 F4imu8t2CRg7uLiJdjpRuhvlwPAneP2NvOZuz9ppVcHp0PRkLtwa7fbLeovNlFPdfMauRTtfL
 rds6AtouYAkZxslDIUYiDvE+HsByAxojuRDPHkkpJeA0l20VH7WbzIC8QqH7tvZPjCnM0+h1p
 eIeBGaIE5p+dABIvHYnRlnM05PkJDzOHr7CGW8I3r+GMGH4GQDDbAEMVr6qMNNe57oBJWrNP0
 1hotO6dz/WN8r6e7tZ6dnD8KbTcHUDj6mOkPApOaGOFzDG3Dk2E+Ec5UwgoVBwrL0/stwX1bk
 EYoQWLOpcBsLIG48Kbdf4L2vYCeP5G7KcZ50uFTJGDXsMRs8OHyIF+RPrw4bVj/VT3FRHnYfv
 ghDHClbplIKKIJ8t1G+5ASdutG6PofYYZq8UZn1hwM9QzsMeVfkLx3X+vVH6UbklQ7AmzE0Oi
 lFGthSbDOEGSg4J3wOTbGGeZOvDQIHVC/I7zJykkzzQGE27vvcFC2WcaxIvg0a66J2xDy+0OC
 wQg7C3FtSfGVmixWofYWRC5WP9aG97neAj0dQUukT+2LC14bWcatlG56VZFNgFWZVO3ivDQSs
 /JeKY04Trz6yZ9VOS2m8JVWpCY2Uu6iH/apLgLWw4v6ZW6WjeapmbPjrKKcfstp92CZw4wO4q
 QNYhlm/lPWqODVYKTF4VTZ2Etm6mFyWRVRTqmmgdoHRb+IHa2Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sebastian,

On Wed, 30 Aug 2017, Sebastian Schuberth wrote:

> I believe stumbled upon a nasty bug in Git: It looks like a commits gets
> dropped during interactive rebase when asking to preserve merges.

Please see 'exchange two commits with -p' in t3404. This is a known
breakage, and due to the fact that -p and -i are fundamentally
incompatible with one another (even if -p's implementation was based on
-i's). I never had in mind for -p to be allowed together with -i, and was
against allowing it because of the design.

Short version: do not use -p with -i.

Ciao,
Johannes
