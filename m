Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B22ECA0FE4
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 16:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbjIAQxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjIAQxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 12:53:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E310F4
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 09:53:22 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7A322687F;
        Fri,  1 Sep 2023 12:53:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=0isOh+JvRzZH5erpecYKZeEW+sF6b5gQOG21NS
        JnjF0=; b=Zi8N0bbagyphLZJMDtk0Mz3G8K1zNwSaLwlYj8b2LGeCLQdXfDxy9P
        xOVLAe26aI6v5eF8+ev3ALL2FBTIv7OWrwQHNCWedMuJMDujivQvbLOlypMxEK/5
        qEJFNz3QH0SKx4DOY1PxovRoDJ294dxM84TMJWkx7hEx6jRuxJcNQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD3152687E;
        Fri,  1 Sep 2023 12:53:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 486AA2687D;
        Fri,  1 Sep 2023 12:53:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     mingli zhang <zmlfoolishfish@gmail.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [bug]fatal: fetch-pack: invalid index-pack output
In-Reply-To: <ZPHHuiFn3v06hhVe@debian.me> (Bagas Sanjaya's message of "Fri, 1
        Sep 2023 18:15:06 +0700")
References: <50B3E989-0405-4B05-9940-D3943C62260A@gmail.com>
        <ZPHHuiFn3v06hhVe@debian.me>
Date:   Fri, 01 Sep 2023 09:53:17 -0700
Message-ID: <xmqqwmx9q1he.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D05BAA8-48E8-11EE-8A41-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Sun, Aug 14, 2022 at 05:09:13AM +0800, mingli zhang wrote:
>> ...
>> I use git 2.36.1 on MacOS Monterey 12.3.1
>> ...
>
> Related discussion is in [1] with the fix for OpenSSL users is in [2].
> Please test.
>
> [1]: https://lore.kernel.org/git/ZPCL11k38PXTkFga@debian.me/
> [2]: https://lore.kernel.org/git/20230901020928.M610756@dcvr/

I somehow think they are not related.  The EVP thing appeared only
in Git 2.42 and the report says 2.36.1, which was released in May
2022 and predates it by more than a year, no?
