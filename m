Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F8DC55178
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751AC20867
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cOb9JZaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgKFTeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 14:34:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61393 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFTdy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 14:33:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F11886699;
        Fri,  6 Nov 2020 14:33:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=reGW6jf7dhCx
        L4h87z5kH0a29Tk=; b=cOb9JZaYIBT3M6SlogQLXWJejanvfxA/cYdqxB2ue+k+
        EdRVFep8ynTjK5nWVf8mcIePXiTJZ6ry4NVbzuHl6q3l6k4y5hpZFg94qV2NcV2a
        z2ORld6UvuW1Eo8VEFvxeV8GfvX1i0kUpoKTOjVhM6yCHbwjPP8/vyxXqG2BPF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P39h11
        xP7xE7h3cwgN8TIvXElaYmKkbjfVbcHfcwha1AsnpM+tGrvco++JFT4fwwihHjgJ
        ra4YBV1xfD7ARQYAtBSKY0jt5NnUyGEEDgxZ80g57bf/Qu2WzVUvEasCEVe6NvR4
        BEp3mdBuMZ3bOhgccanNM11yxSkuYmBsNfbKE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2635786696;
        Fri,  6 Nov 2020 14:33:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4B4A86695;
        Fri,  6 Nov 2020 14:33:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Extending and updating gitglossary
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
        <85r1pjzejg.fsf@gmail.com> <20201103114432.GA3577@Abhishek-Arch>
        <85pn4tnk8u.fsf@gmail.com>
        <efa3488a-3983-3435-e5e4-2eb71e76a33a@iee.email>
        <xmqqtuu3k6jf.fsf@gitster.c.googlers.com>
        <85zh3ujq9c.fsf_-_@gmail.com>
Date:   Fri, 06 Nov 2020 11:33:51 -0800
In-Reply-To: <85zh3ujq9c.fsf_-_@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of
        "Fri, 06 Nov 2020 19:26:23 +0100")
Message-ID: <xmqqa6vufffk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FFE61932-2066-11EB-ACE0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> I don't think adding technical terms that the user won't encounter in
> the documentation or among messages that Git outputs would be not a goo=
d
> idea.  It could confuse users, rather than help them.
>
> Conversely, perhaps we should add Documentation/technical/glossary.txt
> to help developers.

Thanks for a thoughtful suggestion to help the target audience.  I
agree 100% with the above two paragraphs.
