Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67F8C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 22:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbiCBWHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 17:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiCBWHK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 17:07:10 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71608C9920
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 14:06:26 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9865611BEF9;
        Wed,  2 Mar 2022 17:06:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8DeGscqMFWEt
        UuYppBtkTv+WicxEJehxTacuIu//vWQ=; b=VivR8urYzeOwlhay/IHJWlbpoU5j
        +Xkv85rsm+nj7puPT3hqnB5juXF11gAipzsGnj3rNiUJa128Ei2Yek/xq+dgEJiW
        SEeUgU5byjpESPEUDuIy5r3vBnW5JgO7COfMUtKKuu+PLTKNRPptV645b6vVu65x
        FOw1pHy//X0lwpo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CFDD11BEF8;
        Wed,  2 Mar 2022 17:06:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFB3311BEF7;
        Wed,  2 Mar 2022 17:06:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/10] tests: change "mkdir -p && write_script" to use
 "test_hook"
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
        <patch-09.10-1802158b14d-20220302T131859Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 14:06:23 -0800
In-Reply-To: <patch-09.10-1802158b14d-20220302T131859Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 14:22:28
        +0100")
Message-ID: <xmqqwnhcggbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00594784-9A75-11EC-B6D3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change tests that used a "mkdir -p .git/hooks && write_script" pattern

Hmph, it is a bit sad that "mkdir -p" weren't removed as part of
an earlier [03/10].

The end result looked sensible.
