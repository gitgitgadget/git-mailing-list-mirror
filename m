Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D8AC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 22:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiCAWDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 17:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiCAWDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 17:03:39 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B503C480
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 14:02:56 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44D87111725;
        Tue,  1 Mar 2022 17:02:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=3i69EEmkz0TlFCRZTFcMT+hUEcknWbeLvmhOexctkyE=; b=W275
        mdQZdKKIyNDqY3Oj83SLWpS1zHEdawEkbXZSwkRTE90RCqU8I+kabBjJektGQYDH
        vno/dfCfNIxlmHxYIBWZiIr+/D4VmAsw/GLjSUuJvdzufso1KxZgP3Q79FYeo3Ni
        TmjS2rCki2tOZ1lWsfsKaXYq48siIcz70+y/V/0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D51C111724;
        Tue,  1 Mar 2022 17:02:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A88F9111723;
        Tue,  1 Mar 2022 17:02:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/5] fetch: more optimizations for mirror fetches
References: <cover.1645619224.git.ps@pks.im> <cover.1646127015.git.ps@pks.im>
Date:   Tue, 01 Mar 2022 14:02:53 -0800
Message-ID: <xmqqv8wxnxf6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58A10A96-99AB-11EC-AE02-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> this is another patch series with the aim to speed up mirror fetches. It
> applies on top of e6ebfd0e8c (The sixth batch, 2022-02-18) with
> 3824153b23 (Merge branch 'ps/fetch-atomic' into next, 2022-02-18) merged
> into it to fix a conflict.

Thanks for clearly describing a base.  Except that a merge on 'next'
(e.g. 3824153b23) is not what we want a new topic to depend on; use
the tip(s) of individual topic(s), i.e. 583bc419 (fetch: make
`--atomic` flag cover pruning of refs, 2022-02-17), instead.

