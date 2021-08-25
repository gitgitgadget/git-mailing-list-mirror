Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D05C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB719611EF
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhHYAQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:16:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59377 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhHYAQA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 20:16:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 805B2152DCD;
        Tue, 24 Aug 2021 20:15:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+SVkZI08ZeQqIDWhC37n9l/anm3y2uWh8BV+SU
        HK+Yo=; b=HL7jsIN+kyfl0V5fQHBzL9IUHmih4gzTQhBhPZlgtth3PkgAYd8F/g
        AeuJ9oPDceOGgZogc3FCr86LnpE0LoSy3/q7GFQcHCvpuEXnjcZYdjXKH7hKAJJr
        qQYiYQK3rZXTZzxRel02mZbDoCT2y/TlXwhALfBuI3HFDwknUDuBo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79AE4152DCC;
        Tue, 24 Aug 2021 20:15:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C57A6152DCB;
        Tue, 24 Aug 2021 20:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        steadmon@google.com, emilyshaffer@google.com
Subject: Re: What's cooking in git.git (Aug 2021, #08; Mon, 23)
References: <xmqqo89nq1sa.fsf@gitster.g>
        <20210824175105.200959-1-jonathantanmy@google.com>
Date:   Tue, 24 Aug 2021 17:15:11 -0700
In-Reply-To: <20210824175105.200959-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 24 Aug 2021 10:51:05 -0700")
Message-ID: <xmqq7dgal6r4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 840B3762-0539-11EC-9265-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> * jt/grep-wo-submodule-odb-as-alternate (2021-08-13) 8 commits
>>  - t7814: show lack of alternate ODB-adding
>>  - submodule-config: pass repo upon blob config read
>>  - grep: add repository to OID grep sources
>>  - grep: allocate subrepos on heap
>>  - grep: read submodule entry with explicit repo
>>  - grep: typesafe versions of grep_source_init
>>  - grep: use submodule-ODB-as-alternate lazy-addition
>>  - submodule: lazily add submodule ODBs as alternates
>> 
>>  The code to make "git grep" recurse into submodules has been
>>  updated to migrate away from the "add submodule's object store as
>>  an alternate object store" mechanism (which is suboptimal).
>
> For what it's worth, Emily Shaffer [1], Josh Steadmon [2], and Matheus
> Tavares [3] have reviewed this patch set.
>
> [1] Reviewed-bys in reply to the patches in
> https://lore.kernel.org/git/cover.1628618950.git.jonathantanmy@google.com/
> except for patch 6
> [2] https://lore.kernel.org/git/YRRT4I3MPoZXJZEl@google.com/
> [3] https://lore.kernel.org/git/CAHd-oW6Va31PaTQeoSrwi09wjHk63S-Xd_PYtW1trhSokoKizQ@mail.gmail.com/

Thanks.
