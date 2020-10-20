Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA57EC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D9E2225C
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aFlN2gXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439217AbgJTW71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 18:59:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55364 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392459AbgJTW71 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 18:59:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED2F775785;
        Tue, 20 Oct 2020 18:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n9bPgTYYY24qWKWDP8qOs1c5w20=; b=aFlN2g
        XoOiT7E/9dPTqoosIzezt9Nuf9XaCrgSaCghLS6m70Kbkw6gaHhO3mfu5FotZPlG
        ekKh6dmyApkzhxJ9VK1whRFH5ZzFYbQfD6NNVHB2XVYxkDa9wQ+yfkkPuhAqY0GG
        WAIYNsTSe4GQSepp5fxpsh1uv0x1XYXiwyalg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GXLhakXgE6uiDSikwveyfJHNmDYr2ur0
        e23QEPgl77r9kpcz9e2GlK8TUXnvRJ5EvWY/4g4nTzspMaxNZJ0TK1x84Tgff7Ch
        5jhP4hGQu6qLZT82CkmjHD8DLIHNDGidtu01wIbSkUsxWHbn4pmC+SHGFybRuYwS
        CWPn3z0t6Bw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E51C575784;
        Tue, 20 Oct 2020 18:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 781DE75783;
        Tue, 20 Oct 2020 18:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2020, #03; Mon, 19)
References: <xmqqr1put77h.fsf@gitster.c.googlers.com>
        <CAPig+cS_3NBCSgOMpKHeoJAftAxvGXU1BSe-_3Jii8NrqJRphA@mail.gmail.com>
Date:   Tue, 20 Oct 2020 15:59:22 -0700
In-Reply-To: <CAPig+cS_3NBCSgOMpKHeoJAftAxvGXU1BSe-_3Jii8NrqJRphA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 19 Oct 2020 14:21:44 -0400")
Message-ID: <xmqq3628a4hh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5CE9DE0-1327-11EB-8577-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Oct 19, 2020 at 2:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * es/test-cmp-typocatcher (2020-10-16) 1 commit
>>  - Revert "test_cmp: diagnose incorrect arguments"
>
> This commit lacks the author's sign-off.
>
> Also, for what it's worth, this commit is:
>
>     Acked-by: Eric Sunshine <sunshine@sunshineco.com>

Thanks, fixed.
