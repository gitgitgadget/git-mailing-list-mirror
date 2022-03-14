Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F78C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 20:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbiCNUN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242151AbiCNUN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 16:13:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F67D314
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 13:12:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94C5E17AE08;
        Mon, 14 Mar 2022 16:12:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lJWFUeunPnn1O2wibBXQI+J3iUCNWjCjIO5mgr
        Bwmv8=; b=esC3u9FfCD/QpX9xVewZ71GUdwBarnG0ryJYFEJ5uutvjpXuK6XqGs
        f76KPorRQSMa7l/NMWuoRdL4F4PtFNm1rhwvAhS6sU/3M+eyO93nF7NdKXTApELQ
        5npKbI3gGYS+W438gHnbRxwijCekkV8UOO+JhfcC5m2G+UtWDZBgU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CF7E17AE07;
        Mon, 14 Mar 2022 16:12:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0CAA017AE03;
        Mon, 14 Mar 2022 16:12:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/9] sparse-checkout: make cone mode the default
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 20:12:42 +0000
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Sat, 12 Mar 2022 03:11:12
        +0000")
Message-ID: <xmqqlexcqon9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BC0C24C-A3D3-11EC-A37A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> == Updates Log ==
>
> Changes since v1:
>
>  * rebased on master, to remove dependence on en/present-despite-skipped
>    (which has since merged to master). Earlier version of series wasn't
>    picked up anyway, so rebasing should be safe.
>  * Wording and code style tweaks suggested by Stolee in his review
>
> == Overview ==
>
> This patch changes the default mode for sparse-checkout from non-cone mode
> to cone-mode, and marks non-cone mode as deprecated. There is no plan to
> remove non-cone mode, we are merely recommending against its use.

Hopefully there are some convincing explanation to help users
understand why the cone mode is recommended in the documentation in
these patches.  Was there a discussion on list to give our unanimous
support for this plan, or is this only preference by a developer or
two who have worked on the sparse-checkout code recently?

