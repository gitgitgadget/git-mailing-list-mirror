Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F19C433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 17:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiBNRvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:51:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346837AbiBNRvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 12:51:46 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795D32AC6
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:51:38 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4F701866C4;
        Mon, 14 Feb 2022 12:51:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4UUHf+r90Nw4U9N9KJEnu1+YSRybs1iEkriCzE
        cI4fI=; b=Dz16UwIhMJ89NhOTsP9TET8cv9cwfcqN7esbq3rFET/6lxw2tF48RT
        KCsYEf/Dd2wThssVyCv67wn0NDZzWnGSf2EXvDL+LfsQOCguY9DGrw/N73WyxHeI
        wKSKe93XVGf6ITzLegSEiylOJV/Y4azQi4BrAsVoMfhlfOmsUY+hY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D75ED1866C3;
        Mon, 14 Feb 2022 12:51:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 461B418669E;
        Mon, 14 Feb 2022 12:51:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v4 04/12] merge-tree: implement real merges
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
        <d7b51da94e65db79aa59ca331e178741d3c50bc2.1644698093.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Feb 2022 09:51:33 -0800
In-Reply-To: <d7b51da94e65db79aa59ca331e178741d3c50bc2.1644698093.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 12 Feb 2022
        20:34:45 +0000")
Message-ID: <xmqqwnhx2v6i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C06944AC-8DBE-11EC-9BF6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +<branch1>.  The result of this second form is is similar to what

I haven't read the rest of the patches, but this like somehow stood
out in the interdiff.

