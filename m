Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BF7C4332F
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbiCGVkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiCGVi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:38:27 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC45590279
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:36:27 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DDA9A192869;
        Mon,  7 Mar 2022 16:36:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/JHaDJPrHp0VAiPn623x6UsUReZQKFD3en2gih
        o+x3s=; b=WIhKfgWR2v/+Rri3BM314mlsux1Pi5tAO+ahss0BbC/Vz4GjUbzeeJ
        JER47xOWeqr2c2f4cDQuav0G7/IZk2T/TOzkWxPMlqF+SUjm4f82m5QCki71q5zr
        RDrK28Poxtdofzta2wGn08u4afqkMQHex4j4dDUfIOs0YFJFDMd9M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D5A5E192868;
        Mon,  7 Mar 2022 16:36:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 53E1619283F;
        Mon,  7 Mar 2022 16:35:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
Subject: Re: [PATCH 11/11] bundle: unbundle promisor packs
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
        <xmqqzgm5wafu.fsf@gitster.g>
        <ee6c7a5b-63e8-af1c-fdb7-75dca9cd798d@github.com>
        <xmqqv8wpu2fq.fsf@gitster.g>
        <85d434f8-0eb1-c6f7-dfd4-99bffbfbba57@github.com>
        <xmqq8rtlsg9h.fsf@gitster.g>
        <51fabaef-4849-2d9f-285a-3f442f803717@github.com>
        <xmqq35jtsfm9.fsf@gitster.g>
        <24c277cc-5649-2de6-854a-8d87bbfd7b91@github.com>
Date:   Mon, 07 Mar 2022 13:35:57 -0800
In-Reply-To: <24c277cc-5649-2de6-854a-8d87bbfd7b91@github.com> (Derrick
        Stolee's message of "Mon, 7 Mar 2022 15:20:21 -0500")
Message-ID: <xmqqlexlqwci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93B0A7CE-9E5E-11EC-9828-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> Hmph, and we won't see it when going over ssh to the same
>> repository?  That is puzzling.
>
> Of course, it's not an issue with file://, but an issue with the
> defaults. In order to test partial clones, I need to enable these
> config options in the server repo:
>
> 		test_config uploadpack.allowfilter 1 &&
> 		test_config uploadpack.allowanysha1inwant 1 &&
>
> Sorry for taking so long to realize this.

No, thanks for finding that out---the fact that I left it at
"puzzling" without offering that is a strong evidence that I didn't
think of it, either ;-)

