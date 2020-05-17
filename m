Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8300C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98159207E8
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cbHV0r6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgEQSkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 14:40:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53392 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgEQSkC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 14:40:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 376F9587EF;
        Sun, 17 May 2020 14:40:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zdFaOrDmcdEt85uhL6PBUJiHW78=; b=cbHV0r
        6AcKb7syXKR7GWz+WNOpiFStAD28+nqgUiph8KFLekixdGFEtT58Q7Ao6C0KUzyO
        CAf0y0dHnQBvbTTdXedwOagQp8z7GhgdATPjVgtBxDYrl4Cr1DYSakxTuwmV3GkQ
        qS01+Ih4lGevl2Hh/i3ixWbkQrU+o8xr2Yddo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EIfclxUNGMRuNzkoO6j702UgT4L1NKar
        pU1jwIVx8Pjze+oSiXnpeslww5blBjzSxzU38x7Go/7BbkRTa+j1FJuoI+hviLVh
        plS9IjnmfTGqOLFgTl6TJCFjUzp2a94x8sYQ9weExY5Z5KxaIVFeJIPC/Syg+MyK
        A//SbQ7bOZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13125587EC;
        Sun, 17 May 2020 14:40:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1F38587EB;
        Sun, 17 May 2020 14:39:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     Kenneth Lorber <keni@hers.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] various documentation bits
References: <1589681624-36969-1-git-send-email-keni@hers.com>
        <20200517074258.GA1381@Abhishek-Arch>
Date:   Sun, 17 May 2020 11:39:59 -0700
In-Reply-To: <20200517074258.GA1381@Abhishek-Arch> (Abhishek Kumar's message
        of "Sun, 17 May 2020 13:12:58 +0530")
Message-ID: <xmqqv9ku5rsw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D032A290-986D-11EA-8962-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Some general notes about your patch series:
>
> 1. Conventionally, we prefix the first line with "area: " where the area
> is a filename or identifier for general area of the code being modified.
> It's customary to start the remainder of the first line after "area: "
> with a lower-case letter.
>
> For example, your commit titles could have been:
> - doc: tell the glossary about core.hooksPath
> - doc: add bit on extending git to hacking Git
>
> and so on.
>
> Check out SubmittingPatches for more information.

Good suggestion.

> 2. We generally don't have a line like in our patches:
>
>> From Kenneth Lorber <keni@his.com>
>
> Between the author information and the signed-off-by, it's redundant.

Carefully inspect the e-mail header and in-body header ;-)  

The author identity must match the identity written for the
signed-off-by trailer, so the in-body header becomes needed
when the From: e-mail header does not match the true author,
like these patches.

> 3. You could probably join the patches 3 to 6 together. Or maybe
> introduce namespace-collisions.txt in third patch and add
> references in all other files in a new, fourth patch.

Perhaps, but I'd rather not to see a rule that hasn't been applied
even once in the real situation written down like a law.  I'd prefer
to see us gain experience by interacting tool authors on the list
and learn what their concerns and pain-points are.

Thansk.


