Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD285ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 21:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiISVnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 17:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiISVnG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 17:43:06 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383122F646
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 14:43:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A91915048E;
        Mon, 19 Sep 2022 17:43:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=r2ds5PnfXt1FZkd8wmWsDU22y2QFGB42E00yccES/1A=; b=NUcW
        0GmWbhn0w/B2u5JT7tBGsVS66UBmg1yq3NRZ3eDnAp/lV2cDlHPmej3tfsnAUja8
        dFKBRXrr6DJVfk+c/8Dk69S8RpemZEkmQEkwc34kFmqo7Cq5U7voDtAoBqyYBdDj
        IVBfzX/b36rUosruEfmg4SbuZZeokxGZgMEwUUU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C67F15048C;
        Mon, 19 Sep 2022 17:43:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FD9015048A;
        Mon, 19 Sep 2022 17:43:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] refs: unify parse_worktree_ref() and ref_type()
References: <pull.1325.git.git.1663002096207.gitgitgadget@gmail.com>
        <xmqq1qsge71x.fsf@gitster.g> <xmqq35cwcpws.fsf@gitster.g>
        <xmqqillrb7qs.fsf@gitster.g>
        <CAFQ2z_PBWbdKgbaqLO6iXB8WEhG=CTjetrEgm7wHacDi_n8VHw@mail.gmail.com>
Date:   Mon, 19 Sep 2022 14:43:03 -0700
Message-ID: <xmqqwn9z82hk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AAEE31E-3864-11ED-9622-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Tue, Sep 13, 2022 at 5:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>> then a better approach would be to have a small helper
>> parse_local_worktree_ref() and make the primary one into something
>> like
>>...
>
> Thanks, good idea. I'm sending you a v2.

Hmph, is that "v2" <pull.1325.v2.git.git.1663605291172.gitgitgadget@gmail.com>
or is there another version of it?
