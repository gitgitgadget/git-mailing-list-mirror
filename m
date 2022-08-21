Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A61DC25B08
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 00:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiHUAys (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 20:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiHUAyq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 20:54:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4213C1CFC8
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 17:54:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4D5F1B8B63;
        Sat, 20 Aug 2022 20:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V+qGXbq6voNjmCK0ZPaECcVljiCMNiAx2UTVJG
        /2Ges=; b=UsJU4BGYbWrrVID5FEvaf0MIFZOrm8OpjbbNEsVwPQ+V5D02AuKHVA
        jiEEkgJ4BwANQIQkfQ8mge2LHQgaVi3Zncyp1KR1C52/PFVps1d1JoZlrqHlwEu+
        1YtYPd35wBGJlInq5fqrWK7uxO3szlnND7vLC9KuWojcgzzs1qeMk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E8131B8B62;
        Sat, 20 Aug 2022 20:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3FFBB1B8B61;
        Sat, 20 Aug 2022 20:54:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tim Hockin <thockin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: rev-parse: -- is sometimes a flag and sometimes an arg?
References: <CAO_RewbD+BJd1hPKCmCNM8wYBSUmZ2TuOoy6t1up1CT-rbn4DA@mail.gmail.com>
        <xmqq8rniikrg.fsf@gitster.g>
        <CAO_RewZPXP1EUP90kU6uEQ3_CqqC7yWedjfNd7RaVASFSfrg0Q@mail.gmail.com>
        <xmqq4jy6igb2.fsf@gitster.g>
        <CAO_RewaZHL34WBaoXVyXh6ZNVuG+fi5uGUbpRMsc9N=orHzx1Q@mail.gmail.com>
Date:   Sat, 20 Aug 2022 17:54:40 -0700
In-Reply-To: <CAO_RewaZHL34WBaoXVyXh6ZNVuG+fi5uGUbpRMsc9N=orHzx1Q@mail.gmail.com>
        (Tim Hockin's message of "Sat, 20 Aug 2022 17:39:36 -0700")
Message-ID: <xmqqzgfyh0vj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6E0217C-20EB-11ED-BFA1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Hockin <thockin@google.com> writes:

> Sorry, I assumed it was clear, but that was dumb of me.
>
> I have a string - might be a tag name, might be a branch name, might
> be a SHA (complete or partial).  I want to resolve that into a
> canonical SHA.

"git rev-parse --verify string" would insist that 'string' is an
object name and show it as an object name to the standard output, or
gives an error message and exits with a non-zero status.

"git rev-parse --help" has some more elaborate examples in its
EXAMPLES section.



