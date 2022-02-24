Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8830CC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 23:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiBXXjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 18:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiBXXjC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 18:39:02 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9A428AD9B
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:38:31 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61F7AF9451;
        Thu, 24 Feb 2022 18:38:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QhuwU17/QvZk
        hBZneUo2EFhsb5wuqzrk2nQeoRLDvK0=; b=KNYLG+/u+yp0zz2VIkNHoqpMtoah
        Qczq7AcPElo5yMuvPpZHJkXv2TsNQcZMlrCxT0ym15nYqEQdeLCTeksXhRDXkDdC
        DVbxPYe82NHMeacdb4QQoO8xAwiB6T7EmDLvkKbl8+V0QktuoOcTy+K9yCZpYl3o
        twGstYWQCoiH/IA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59846F9450;
        Thu, 24 Feb 2022 18:38:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB94EF944F;
        Thu, 24 Feb 2022 18:38:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/commit-plug-leaks + ab/diff-free-more
References: <xmqq1qztortk.fsf@gitster.g>
        <220224.86k0dkaaun.gmgdl@evledraar.gmail.com>
Date:   Thu, 24 Feb 2022 15:38:28 -0800
In-Reply-To: <220224.86k0dkaaun.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 24 Feb 2022 10:08:59 +0100")
Message-ID: <xmqqczjbj0nf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DEE64308-95CA-11EC-A28F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Feb 23 2022, Junio C Hamano wrote:
>
>> * ab/commit-plug-leaks (2022-02-16) 2 commits
>>  - commit: use strbuf_release() instead of UNLEAK()
>>  - commit: fix "author_ident" leak
>>
>>  Leakfixes in the top-level called-once function.
>>
>>  Expecting a reroll.
>>  I think UNLEAK->strbuf_release() is a regression.
>>  source: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
>
> After you noted that in [1] I followed-up in [2] giving reasons for
> wanting to keep that UNLEAK->strbuf_release() change. What do you think
> about that?

Do not count and aim to reduce the number of UNLEAK in builtin/
directory.  Re-read [1] until you get it.

Thanks.

