Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF72C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56E36105A
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhHKTFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhHKTFo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 15:05:44 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55EC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 12:05:20 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:42680)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDtXS-0006yq-VR; Wed, 11 Aug 2021 15:05:18 -0400
Received: from auth1-smtp.messagingengine.com ([66.111.4.227]:49005)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDtXS-0005nU-Ri; Wed, 11 Aug 2021 15:05:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4B25F27C0054;
        Wed, 11 Aug 2021 15:05:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 11 Aug 2021 15:05:18 -0400
X-ME-Sender: <xms:bR8UYaaDUA1Yb3t-VHqfdxt7v_1Q2E6vFpixdK7wlQ7wOQ4c1zHOEw>
    <xme:bR8UYdZNjZq8U-u6Oy7Jc0EXl6cqK3hyWFtFrTcmGRWAgmm7tAd8ES6Y2bIwa0sRY
    vkqA2IE_Fo0uQ>
X-ME-Received: <xmr:bR8UYU_AwA48ULr3SDqTifkdOVsZGa6mG0fXlt1UrkoBqXIzhzdILn4biDqjK2wbGYtBcVAuHMQ8NSLT5VNj6zXH7Z1LeOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvffuffgjkfggtgesthdtre
    dttdertdenucfhrhhomhepvfgrshhsihhlohcujfhorhhnuceothhsughhsehgnhhurdho
    rhhgqeenucggtffrrghtthgvrhhnpedvhfduveeuvddtveeifeefhedvffeugeehjedtff
    fhieevledvgfehueejgfehffenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhrnhdomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqkeeijeefkeejkeegqdeifeehvdel
    kedqthhsughhpeepghhnuhdrohhrghesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:bh8UYcpHkIQKjUnKK6rzESoJVet4Y56ApGD1e7NzuX0Z6p0CwevW7g>
    <xmx:bh8UYVrRaah5NhWI_yw4Kr3F-INoB722YCfJSdCXPvm_8-x9N3Phcw>
    <xmx:bh8UYaSbA1PAtotn5cjq0CZPiRjV6YdUcvYc6DCzmCzIYiHVX-Aktg>
    <xmx:bh8UYUT4AaNy0HC9SD1zvxJq-ixpzETDOIIxK6wRqdn54Mx__L1PWw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 15:05:16 -0400 (EDT)
References: <20210811145341.43429-1-tsdh@gnu.org>
 <xmqqa6lnaola.fsf@gitster.g> <87im0b6f92.fsf@gnu.org>
 <xmqqo8a397ib.fsf@gitster.g>
User-agent: mu4e 1.6.2; emacs 28.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5] userdiff: improve java hunk header regex
Date:   Wed, 11 Aug 2021 20:55:23 +0200
In-reply-to: <xmqqo8a397ib.fsf@gitster.g>
Message-ID: <87fsvf6bva.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> That leads to the question if you'd welcome a patch adding a
>> .dir-locals.el to the repository with the right settings so that
>> it'll just work for contributors using the One True Editor.  Would
>> you?
>
> If your one true editor honored what is in .editorconfig, perhaps
> there was no need for us to be having this conversation?  I dunno.

Ah, I'm sorry, I wasn't aware of that.  I've installed the editorconfig
Emacs plugin [1] which seems to do the trick.

Bye,
Tassilo

[1] https://github.com/editorconfig/editorconfig-emacs
