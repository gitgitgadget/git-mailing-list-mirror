Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363F1C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099C02464E
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IcQ4daFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBSRCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:02:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62447 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgBSRCM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:02:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A21E93C4D1;
        Wed, 19 Feb 2020 12:02:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yBfMN7l9VkyshoGZsVuQ5BtjoOU=; b=IcQ4da
        Fo71jd1Cec8Lss5hAslXGmQkg0qCEa8sFU+WnVWPUtKyg7E2+q+AVxqOeql86gzA
        f1HCM638gOtzawq94XZycWvbrL+FDGNovr9RnJIpkV+24MdpnSppE1+cZxBQUG78
        uNY/XjHtVNTXppSqiJXku6jBvR9R8rrOtwXok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O/UOBhAGqVhLzVyVTstzMdCLy9Ndtll7
        oaOfBxRQsQKirbsfNxqm+yowVVM/Qilh6gE6pNOfzhQa0iIADCxLRDC+SxHWT35L
        qQhdDtYJnzuTeFDv8UORoHxDRnc638WA01TZxR5ipYn4+h/9AehtxdW/EqRxxggL
        esZD+YYNwfQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BC173C4CF;
        Wed, 19 Feb 2020 12:02:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 776DC3C4CD;
        Wed, 19 Feb 2020 12:02:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwenn@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Reftable support git-core
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
        <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <xmqqy2szip35.fsf@gitster-ct.c.googlers.com>
        <CAOw_e7abpAwTkb6qKZjbxxw7XrAWdhcANbjAWvRxi1_fT5vSDA@mail.gmail.com>
Date:   Wed, 19 Feb 2020 09:02:05 -0800
In-Reply-To: <CAOw_e7abpAwTkb6qKZjbxxw7XrAWdhcANbjAWvRxi1_fT5vSDA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 19 Feb 2020 17:59:40 +0100")
Message-ID: <xmqq36b6h5o2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9033ABEA-5339-11EA-A055-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwenn@gmail.com> writes:

> On Tue, Feb 18, 2020 at 10:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Here is what I got from "git am --whitespace=fix" on these five patches.
>> Does it match your test application?
>>
>> Applying: refs.h: clarify reflog iteration order
>> Applying: create .git/refs in files-backend.c
>> Applying: refs: document how ref_iterator_advance_fn should handle symrefs
>> .git/rebase-apply/patch:145: trailing whitespace.
>>
>> .git/rebase-apply/patch:147: trailing whitespace.
>>
>> .git/rebase-apply/patch:6544: indent with spaces.
>>         left = *destLen;
>> .git/rebase-apply/patch:6545: indent with spaces.
>>         *destLen = 0;
>> .git/rebase-apply/patch:6548: indent with spaces.
>>         left = 1;
>> warning: squelched 15 whitespace errors
>
>
> your checker is tripping over code imported from zlib. I added a /*
> clang-format off */ comment to avoid reformatting this code. What do
> you suggest?

Use zlib from the system instead?
