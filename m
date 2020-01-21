Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B146C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 19:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A63A21835
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 19:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jc4EgSEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgAUTOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:14:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63085 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgAUTOd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 14:14:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A454E363D1;
        Tue, 21 Jan 2020 14:14:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GZj4IhXlezWTSns/RLRkoc0YF48=; b=Jc4EgS
        EsJRwFYq6pBBW6oBV+fMqCcnM/1pfgFyjq6tt1ZLEAT59vWe9xZXKCV50yRzDcHi
        Q2SloSg8WliUvuLkG34bmab/7YPpNy88Tr24ao2mLN8WhPqB93jeTsE4AWlZ6qQ1
        CmFyN/T9Cn7a4nP2MiQfDmGiVnYndYkMpAEtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bBNTN7rAQxsUmyeM0IYagAunesTSqE8C
        iPwhc9njjFpgFapIxDVVFGp1C+pHFr+pDk9RZyZ8Mo9zxjlHBbx75fO0I2XEaDOJ
        WRM0bOHnb2XQcFSS6Ezy4ADBZEZkjD3hDljLd9BB99JWsMPWiklIQUpq9290HAd7
        H7oj6SujK5M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9ADDE363D0;
        Tue, 21 Jan 2020 14:14:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0399363CF;
        Tue, 21 Jan 2020 14:14:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 1/8] doc: rm: synchronize <pathspec> description
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <23387f83912d1f5aef17a28d466db162f50fd722.1579190965.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 11:14:29 -0800
In-Reply-To: <23387f83912d1f5aef17a28d466db162f50fd722.1579190965.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Thu, 16 Jan 2020
        16:09:18 +0000")
Message-ID: <xmqqk15kaaga.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4046C6C6-3C82-11EA-8E1E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> This patch continues the effort that is already applied to
> `git commit`, `git reset`, `git checkout` etc.
>
> 1) Changed outdated descriptions to mention pathspec instead.
> 2) Added reference to 'linkgit:gitglossary[7]'.
> 3) Removed content that merely repeated gitglossary.
> 4) Merged the remainder of "discussion" into `<patchspec>`.

Thanks.  Will queue.
