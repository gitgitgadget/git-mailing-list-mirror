Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00DBC433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 14:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B6560FD9
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 14:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJ3Oxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 10:53:53 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:53059 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhJ3Oxx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 10:53:53 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mgphZ-000C0I-4V; Sat, 30 Oct 2021 15:51:21 +0100
Message-ID: <c46db4a8-c705-6c6c-bcb3-b2d294120dce@iee.email>
Date:   Sat, 30 Oct 2021 15:51:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/3] protocol v2: specify static seeding of clone/fetch
 via "bundle-uri"
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
 <7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com>
 <211027.86r1c6yh52.gmgdl@evledraar.gmail.com>
 <756524c1-a3b9-29b5-bb72-f75a0c76ea1f@gmail.com>
 <211027.86ilxixoxz.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <211027.86ilxixoxz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An aside:

On 27/10/2021 19:01, Ævar Arnfjörð Bjarmason wrote:
> I don't think you can say "this bundle has no blobs". The
> "prerequisites" hard map to the same thing you could put on a
> "want/have" line during PACK negotiation.
>
> I think we could/should fix that, i.e. we can 

> bump the bundle format
> version and have it encode some extended prerequisites/filter/shallow
> etc information.
If the format is bumped, could we also include the
HEAD=<particular-branch> info within that format.
The `guess the HEAD` algorithm isn't ideal and shows up in user
questions every now and again.

>  You'd then have a 1=1 match between the features of
> git-upload-pack and what you can transfer via the bundle side-channel.
--
Philip
