Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B10DC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 17:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiG1RmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 13:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiG1Rl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 13:41:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B9E743EC
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 10:41:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E03C3197C69;
        Thu, 28 Jul 2022 13:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IJP4seyse66w
        6FZZPrwNuz7eXb3TQRcgD3sg0GoWA98=; b=JY261Vixy5IDob69bOK3ISqJJipt
        wHoz6XxZcKV1uGBT1HV5UPpZGPpR7Egov0C6nhvs9kAjXnfAm3xo43rcp4RHwQ5E
        4Tnlj7H478krkxqYxZSvOaNPHOisop90d5+pUORPsNS2ZneuHVvN+2w7HrA9zcwu
        +sd0eaq9vRtW2ro=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8CD4197C68;
        Thu, 28 Jul 2022 13:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69265197C64;
        Thu, 28 Jul 2022 13:41:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Glen Choo <chooglen@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] CI: add SANITIZE=[address|undefined] jobs
References: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
        <d4dcb1f6-6076-3725-d479-7e9f1fece2a3@github.com>
        <xmqqilnityp0.fsf@gitster.g>
        <220728.86sfmljhyx.gmgdl@evledraar.gmail.com>
Date:   Thu, 28 Jul 2022 10:41:53 -0700
In-Reply-To: <220728.86sfmljhyx.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 28 Jul 2022 18:52:25 +0200")
Message-ID: <xmqq4jz1cexq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91F00638-0E9C-11ED-8399-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm fine with it either way, but to add a prep patch to this series to
> do s/linux-leaks/SANITIZE=3Dleak/g would cause a semantic conflict with=
 my
> in-flight
> https://lore.kernel.org/git/cover-v3-00.15-00000000000-20220727T230800Z=
-avarab@gmail.com/;
> It refers to "linux-leaks" in newly added documentation.

If you mean "in-flight" something that is not in 'next', it may have
to be rerolled on top of this new topic.

If something is already in 'next' and we are committed to see it
through down to 'master', then this new topic may need to depend on
it.
