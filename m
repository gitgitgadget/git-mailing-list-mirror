Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4719C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 17:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbiBQRxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 12:53:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243919AbiBQRxi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 12:53:38 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA9F2B1039
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 09:53:23 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1AB4818545A;
        Thu, 17 Feb 2022 12:53:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NyFYmSJceU/q0VvA6g4YbfhfUS6eJ5mXgpurZv
        y3gXw=; b=l/QPUPm/E0W4ASFEWl1/kaDhRtUPUHy5ETyWaz2ejT/Ly3CeZE6obY
        WO68Ehz6nVHJ1lBz5Yt9hekrVqMG+OO77RAZSBV5t0cieI4SIFth2SbgfmcRg4JY
        I+Y4a6phRjjWb/w1yhKLhpAPfAumyrcc3lJlr3hrhzLm2j9pujjqA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F23D2185459;
        Thu, 17 Feb 2022 12:53:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 59E0F185458;
        Thu, 17 Feb 2022 12:53:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 3/5] sparse-checkout: pay attention to prefix for
 {set, add}
References: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
        <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
        <e68b0a37ff37feb94850bec66a716145c9468ff8.1645080889.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 09:53:19 -0800
In-Reply-To: <e68b0a37ff37feb94850bec66a716145c9468ff8.1645080889.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 17 Feb 2022
        06:54:47 +0000")
Message-ID: <xmqq35khbcs0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E47D3C8-901A-11EC-BA48-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		for (i = 0; i < argc; i++)
> +			argv[i] = prefix_path(prefix, prefix_len, argv[i]);

Looks sensible.

