Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDEBC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0232075A
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 15:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SuAbQMZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgD1PbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:31:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60504 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgD1PbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 11:31:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1510F6348E;
        Tue, 28 Apr 2020 11:31:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6pB7bX+JSIhX9S8C3uioad4VlN4=; b=SuAbQM
        ZceU3V/RhIioOXc3rJcSv6DiEfJoYGH5k827prF9q1wAOJjzRk5AciJs22FmU0Kp
        2ZEzH4YUPHQGI1SDhXqp0UXS47BSoEfcWC7Xkgs7TvtkLFpDNgV/wHIJ+MrXHrZO
        OHDdrgzS8c696kMg/MkQelP8kbHTtRWbX2/lA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f47nsF6bzxIiSKhPUbeOgxXFTLnfjg9J
        kK1Hh8d12rXrryt5Z83vtD2evkwJFtMP4vB5N/xOjpwky0OpmDfB8fbsrrwlPGKB
        2XbbUZV+J3kz4jY5QCUIv8THzDQ4a4b8HpCTTSU6Y8UJmTAHyEaBNRhGDSf8XcpI
        u2Bs0wv3H2M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CA836348D;
        Tue, 28 Apr 2020 11:31:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 866296348C;
        Tue, 28 Apr 2020 11:31:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v10 09/12] Add reftable library
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
        <59209a5ad39326cf88966715312922f08f149942.1588018418.git.gitgitgadget@gmail.com>
        <20200428145541.GC31366@danh.dev>
        <xmqq1ro7633k.fsf@gitster.c.googlers.com>
Date:   Tue, 28 Apr 2020 08:31:12 -0700
In-Reply-To: <xmqq1ro7633k.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 28 Apr 2020 08:29:19 -0700")
Message-ID: <xmqqwo5z4ofz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B444046-8965-11EA-B62F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Danh Doan <congdanhqx@gmail.com> writes:
>
>>> +BSD License
>>> +
>>> +Copyright (c) 2020, Google LLC
>>> +All rights reserved.
>>
>> Linking against GPLv2 code will make this code GPLv2, right?
>
> Wrong.  A program (e.g. "git") can have various parts, some of which
> is licensed under GPL, some other parts under BSD, yet some other
> parts under LGPL.  Read the second paragraph of README we ship
> without source.

without --> with our

;-)

>
> I think you are thinking about the obligation a distributor of the
> linked binary compiled from such source has, which is that they need
> to make available not just the GPL part but the rest of the program
> used to compile the whole, including parts licensed under BSD and
> other licenses.
