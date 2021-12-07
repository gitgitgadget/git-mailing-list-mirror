Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ADAC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 21:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbhLGV7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:59:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63399 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhLGV7l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:59:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C9C1E27FC;
        Tue,  7 Dec 2021 16:56:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mw2qdOy62HcMYsUDJSvULsS3fdrsmrDAKkX7h9
        8aHhI=; b=rNkvCvkpYjWQ8iiYEYV2EnulltxDC/BISyfFGl1Ee3b4jcNcQCZO3Q
        pKVXg7K9pj6NzpNIYy6jTmxEG09wew74wASQtylYSI3w3kb3jloNcSD3qBDVWzLO
        owuPfxNuepbgnCzBkX0snuEBTLfDFO1NOdKsuDm3Hboc6mgIIeJGQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23EBBE27FB;
        Tue,  7 Dec 2021 16:56:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D345E27FA;
        Tue,  7 Dec 2021 16:56:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 10/10] reftable: make reftable_record a tagged union
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 13:56:07 -0800
In-Reply-To: <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Tue, 07 Dec 2021
        17:45:24 +0000")
Message-ID: <xmqqlf0w5bbc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C666092-57A8-11EC-8572-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct reftable_record {
> +	uint8_t type;
> +	union {
> +		struct reftable_ref_record ref;
> +		struct reftable_log_record log;
> +		struct reftable_obj_record obj;
> +		struct reftable_index_record idx;
> +	};
> +};

error: ISO C99 doesn't support unnamed structs/unions [-Werror=pedantic]
