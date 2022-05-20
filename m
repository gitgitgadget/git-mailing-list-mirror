Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A543C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 16:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347402AbiETQWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiETQWF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 12:22:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8E6381B5
        for <git@vger.kernel.org>; Fri, 20 May 2022 09:22:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A41A419B32E;
        Fri, 20 May 2022 12:22:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7DM4yhVqTSG4
        jTrQTD1Wv/ko9l/gO/O4Wyfoi/xEnjA=; b=Q3i3DySKil8TKtHsGgSO3D9xAEVr
        QSILcatAJI65bYcYxNFO7ri8omsVYibnPVXGjApMp8Z+btODHJhW6sK93QZARjns
        qbbSDtxqwvfT1+OuEM6RnXbyUNxK4k1f2aBsI1bpVDLSinWV3i69gYRWCb0+y+EI
        RfLAn9RF0/0LI3E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CDD419B32D;
        Fri, 20 May 2022 12:22:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4410E19B328;
        Fri, 20 May 2022 12:22:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 1/7] archive: optionally add "virtual" files
References: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <42e73fb0aaca1f2498ed817c517859103d72d32b.1652984283.git.gitgitgadget@gmail.com>
        <99ffe394-42bb-6c04-b8ab-2d67c38d7756@web.de>
Date:   Fri, 20 May 2022 09:21:59 -0700
In-Reply-To: <99ffe394-42bb-6c04-b8ab-2d67c38d7756@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 20 May 2022 16:41:07 +0200")
Message-ID: <xmqqmtfcjhso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F9E61DE2-D858-11EC-A31F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 19.05.22 um 20:17 schrieb Johannes Schindelin via GitGitGadget:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> With the `--add-file-with-content=3D<path>:<content>` option, `git
>             ^^^^^^^^^^^^^^^^^^^^^^^
> That's still the old option name.  Same in the subject of patch 2.

Good eyes, and thanks for catching what I missed---the risk of
relying too much on the range-diff X-<.
