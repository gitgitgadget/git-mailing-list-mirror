Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A61C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 21:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiGUV4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGUV4k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 17:56:40 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE331C93D
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:56:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C24881377AA;
        Thu, 21 Jul 2022 17:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UOGdXAWUy7VO6LdrQcOzD0QEMn0nyOFGxAG5zw
        GTNvU=; b=Iul1Le20HOj5bSaq1u5hKf+69KGc5kVJLN5mYXcRgdmlgUHlegra8e
        RVg1KIl5nVTkUD4GlGITvdc3hv6R2CylTxP0Dts2Ziot0PSte7dUUOQ98p/Cqx1H
        HstbuUI4bn5ygiMNN5noGSId1UaOe4PD0I8AcE18mNl9zoD6OHsIU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B84E51377A9;
        Thu, 21 Jul 2022 17:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 298D51377A8;
        Thu, 21 Jul 2022 17:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/6] bundle URIs: design doc and initial git fetch
 --bundle-uri implementation
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
        <YtnJvmcDpaZ6T3sH@google.com>
Date:   Thu, 21 Jul 2022 14:56:37 -0700
In-Reply-To: <YtnJvmcDpaZ6T3sH@google.com> (Josh Steadmon's message of "Thu,
        21 Jul 2022 14:48:46 -0700")
Message-ID: <xmqqa692dt9m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEDDEC9A-093F-11ED-AD39-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Thanks for the series! I think this is a very promising design with just
> a few clarifications and minor cleanups needed.

Thanks for reviewing.  I agree with the points you raised in your
messages.

