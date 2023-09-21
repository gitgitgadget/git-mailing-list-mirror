Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D17E7D0A4
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 17:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjIURvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjIURvI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 13:51:08 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED5B6CCBC
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 10:30:41 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id F0D9A23F67;
        Thu, 21 Sep 2023 08:41:25 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qjH73-Iiq-00; Thu, 21 Sep 2023 12:40:49 +0200
Date:   Thu, 21 Sep 2023 12:40:49 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Message-ID: <ZQwdsfh1GQX0IOQs@ugly>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>
 <ZQlspgfu7yDW0oTN@ugly>
 <f778bc6f-dbe1-4df6-95ff-c9e9f36a3cc9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f778bc6f-dbe1-4df6-95ff-c9e9f36a3cc9@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2023 at 10:18:10AM +0200, René Scharfe wrote:
> MSVC warns about all combinations.
>
yes, though that's not a problem: after we established that the 
underlying type is int, we can just have a cast in the initializer 
macro.

>> so how about simply adding a (configure) test to ensure that there is 
>> actually no problem, and calling it a day?

> If we base it on type size then we're making assumptions that I find 
> hard to justify.
>
the only one i can think of is signedness. i think this can be safely 
ignored as long as we use only small positive integers.

regards
