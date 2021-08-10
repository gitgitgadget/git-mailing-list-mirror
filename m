Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E50C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 05:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA1E6101D
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 05:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbhHJFOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhHJFOM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 01:14:12 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5539C0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 22:13:50 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:38788)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDK5D-0008AY-Nc; Tue, 10 Aug 2021 01:13:47 -0400
Received: from auth1-smtp.messagingengine.com ([66.111.4.227]:49383)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDK5D-0006fP-KH; Tue, 10 Aug 2021 01:13:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 05E9927C0054;
        Tue, 10 Aug 2021 01:13:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 10 Aug 2021 01:13:47 -0400
X-ME-Sender: <xms:CgsSYftLoEPzWrKtlIDqtQ3oI60tm_ie6s8qJX69Dc7tvMij81MMkA>
    <xme:CgsSYQf43cyrQURa4tj5Zln9iHeonMsnPEPX0ZPaMlce6zJo6sUS9fSWzcIYbQcOF
    SdIeKqy_3ru4A>
X-ME-Received: <xmr:CgsSYSw9LVcoZksvi_eadhXv9u3h5NZDCOadyUy7P0qyVb8pNlbSiXx_txATlNQOVvM-B3kfn0s1kM7o_jjU7XZY2v9NNqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeekgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvufffjgfkgggtsehttdertd
    dtredtnecuhfhrohhmpefvrghsshhilhhoucfjohhrnhcuoehtshguhhesghhnuhdrohhr
    gheqnecuggftrfgrthhtvghrnhepveevieekteekveeigfefffeivdetgeduvdffueeuud
    evgedttdehvdfhueevfffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepthhhohhrnhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqkeeijeefkeejkeegqdeifeehvdelkedqthhsughhpeepghhnuhdrohhrghesfhgrshht
    mhgrihhlrdhfmh
X-ME-Proxy: <xmx:CgsSYeP_q5R4sXtBt0LgwHOufWf0N9jAPEn26JqUh8g_cAgqRKyDvA>
    <xmx:CgsSYf-pqdD1P54r7OBjIspWXbQXfBLvSXi2Mbu0E8APLzGx2aKj7w>
    <xmx:CgsSYeUX86AWWr7ZO47oChBpLNXyXu34EsLGP-y5Ov31GXSF3fi1qQ>
    <xmx:CgsSYcFTfKkI4ee9YD_kg5j4taCrtzNfcDG4gILgv9CfjzvL10Nfdg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Aug 2021 01:13:46 -0400 (EDT)
References: <20210809203308.30128-1-tsdh@gnu.org>
 <YRGXhqW0BmKQdeZu@coredump.intra.peff.net>
User-agent: mu4e 1.6.2; emacs 28.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: improve java regex for generic return types
Date:   Tue, 10 Aug 2021 06:51:12 +0200
In-reply-to: <YRGXhqW0BmKQdeZu@coredump.intra.peff.net>
Message-ID: <87bl65napl.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

Hi Jeff,

> The patch itself looks OK to me, but...

thanks for the detailed comments.  I'll submit a new version of the
patch soon.

Bye,
Tassilo
