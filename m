Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5A7C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F281A60F23
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhJKP0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 11:26:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53949 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhJKP0t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 11:26:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1C21F80E0;
        Mon, 11 Oct 2021 11:24:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zDu3lYFZUbce+So2QVaqyO/D5yW2ZGuT24XCg/
        MruSA=; b=hCLcHkxZA9b8hViRt6AGNVVZT6rcK3UcyqhrzlA3z+gCedcAbyB6ri
        PKoGaNsvU2kb0fG51L3sPZkKwXHK0samvNLPgUgxjKibUehzWuq5g/YSXXEfJ0q+
        9ea/1etZkcc4bd7z+fWKp5lc6M+LR1RW0AMVOggz5p1WK6jR+U3PE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9E5EF80DF;
        Mon, 11 Oct 2021 11:24:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4126DF80DE;
        Mon, 11 Oct 2021 11:24:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 3/8] update-index: add --force-full-index option for
 expand/collapse test
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <014a408ea5d9894197c60f8d712749ea3cc39c9d.1633641339.git.gitgitgadget@gmail.com>
        <xmqq35pcm6m9.fsf@gitster.g>
        <72f4df1e-54ef-6bdb-ef71-1f115e92c9a5@github.com>
        <xmqqily7l9i5.fsf@gitster.g>
        <cc60c6e7-ecef-ae22-8ec7-ab290ff2b830@gmail.com>
Date:   Mon, 11 Oct 2021 08:24:47 -0700
In-Reply-To: <cc60c6e7-ecef-ae22-8ec7-ab290ff2b830@gmail.com> (Derrick
        Stolee's message of "Mon, 11 Oct 2021 10:12:24 -0400")
Message-ID: <xmqq5yu3eg8w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EF7A968-2AA7-11EC-80B8-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Junio, would it be better to change the config setting, and then
> update this test to use the config setting over a command-line flag?
> This would allow us to punt on the --force-full-index flag until we
> have time to focus on the 'git update-index' command and interactions
> like this.

I do not have a strong opinion on where we add the feature; as long
as we have a way to let us avoid having to unnecessarily change this
particular test, that's perfectly fine, and if we can reuse it as a
way for end-users to help those who are debugging their issues, that
would be an added bonus.

Thanks.

