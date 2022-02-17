Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F25C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 17:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbiBQRec (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 12:34:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiBQReb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 12:34:31 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220B916040B
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 09:34:16 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0D4B185175;
        Thu, 17 Feb 2022 12:34:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E3PbUckoxgQzT5flmsJXphZhm2NOzi7dG2GppB
        wLEiw=; b=H02RMh5GbkxWTtRZaiyvpfhJkYjRu23AXHwH2LaZMnSxVsDx8vA4EO
        bXu0Z3gneSsmw/UpITVdtxQfeEBiV1Qhz6NXmuKYCxj6xBWtdf8qans5bVzTUICN
        4+EED/TD4MxWnAON9mmtBRpmNPdr7a1k7Sni2JaOs6bl9M6oppxDM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9147185174;
        Thu, 17 Feb 2022 12:34:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E7C9185173;
        Thu, 17 Feb 2022 12:34:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 5/5] sparse-checkout: reject arguments in cone-mode
 that look like patterns
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
        <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
        <2008542d0c718bbe43388297307a791f94bc73e1.1644985283.git.gitgitgadget@gmail.com>
        <220216.8635kjuob0.gmgdl@evledraar.gmail.com>
        <CABPp-BEBX4tWwqkG=7+rcZa_EJzOC2+Rg214av_+-yymHTQGQw@mail.gmail.com>
        <af439020-8314-9171-4300-94a5102c8a38@github.com>
        <xmqqpmnmsl2n.fsf@gitster.g>
        <CABPp-BH2Jy8esb52JBZvFOk9CcBMk41oDzDZX6t3G+M9tiao4w@mail.gmail.com>
Date:   Thu, 17 Feb 2022 09:34:11 -0800
In-Reply-To: <CABPp-BH2Jy8esb52JBZvFOk9CcBMk41oDzDZX6t3G+M9tiao4w@mail.gmail.com>
        (Elijah Newren's message of "Wed, 16 Feb 2022 17:46:25 -0800")
Message-ID: <xmqqbkz5bdnw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D28280B2-9017-11EC-B03B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> After reading up on it, I think you mean strcspn() rather than

Yeah, strcspn() have many existing uses in our codebase.  Thanks.

