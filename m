Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C260AC433E9
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8794020717
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbhA0D6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:58:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53735 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390064AbhA0AOl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 19:14:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8249114702;
        Tue, 26 Jan 2021 18:38:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cjAmkcGF1D2KBO87gZhGP80rAGg=; b=a1n2Fr
        Bk610BLt36FZ/zdBBl7Y5/7PebwEMpC17T6AFQBaNDhPw09SCT8YPhbP60CueWPF
        3Xnote2ComTaQljb8qDrskfc8F7Qm8labrytZXpeuMRlzxPUFAOrxFFPT8cdgdeb
        6q6Hpx0FQfmkS4i2KdaQ3p5QsuDMSxrwNFKEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=St7bqfBLgsu4aXeeKAKY+hm0Xplo13mc
        bKl/yaDkfUyQW7iOCGZiDmR46Hgr+iuBzHUdH/YItrjPxkNUrUVoVuHPlCWA8OeD
        ke6kwPbdAwW400xLhHfyu/7n46ku2/uGieO086SE6zxEOp07jXzyZQcmvIPd+xVm
        +B6UaKp+xmo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C12E9114701;
        Tue, 26 Jan 2021 18:38:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 983C81146FE;
        Tue, 26 Jan 2021 18:38:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 1/3] ls-refs: report unborn targets of symrefs
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1611686656.git.jonathantanmy@google.com>
        <32e16dfdbd3f54c0d4b39cbd555e66aa3950fffd.1611686656.git.jonathantanmy@google.com>
        <xmqq8s8f1iqe.fsf@gitster.c.googlers.com>
        <YBCjwoc5LUrk3GBA@coredump.intra.peff.net>
Date:   Tue, 26 Jan 2021 15:38:19 -0800
In-Reply-To: <YBCjwoc5LUrk3GBA@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 26 Jan 2021 18:20:34 -0500")
Message-ID: <xmqqim7jz2tw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9353A42A-602F-11EB-A857-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> See the
> discussion in the v4 thread (sorry, seems not to have hit the archive
> yet, but hopefully this link will work soon):
>
>   https://lore.kernel.org/git/YBCitNb75rpnuW2L@coredump.intra.peff.net/

I guess vger having some sort of constipation, we (not you-and-me
but list participants as a whole) would be doing this kind of
back-and-force while untable to read what others have said. 

https://lore.kernel.org/git/xmqqmtwvz4g9.fsf@gitster.c.googlers.com/

will have the following.

> It feels somewhat brittle that we have to read the same variable and
> apply the same "default to true" logic in two places and have to
> keep them in sync.  Is this because the decision to advertize or not
> has to be made way before the code that is specific to the
> implementation of ls-refs is run?
>
> If ls_refs_advertise() is always called first before ls_refs(), I
> wonder if it makes sense to reuse what we found out about the
> configured (or left unconfigured) state here and use it when
> ls_refs() gets called?  I know that the way serve.c infrastructure
> calls "do we advertise?" helper from each protocol-element handler
> is too narrow and does not allow us to pass such a necessary piece
> of information but I view it as a misdesign that can be corrected
> (and until that happens, we could use file-local static limited to
> ls-refs.c).

After giving the above a bit more thought, here are a few random
thoughts around the area.

 * As "struct protocol_capability" indicates, we have <name of
   service, the logic to advertise, the logic to serve> as a
   three-tuple for services.  The serving logic should know what
   advertising logic advertised (or more precisely, what information
   advertising logic used to make that decision) so that they can
   work consistently.

   For that, there should be a mechanism that advertising logic can
   use to leave a note to serving logic, perhaps by adding a "void
   *" to both of these functions.  The advertising function would
   allocate a piece of memory it wants to use and returns the
   pointer to it to the caller in serve.c, and that pointer is given
   to the corresponding ls_refs() when it is called by serve.c.
   Then ls_refs_advertise can say "I found this configuration
   setting and decided to advertise" to later ls_refs() and the
   latter can say "ah, as you have advertised, I have to respond to
   such a request".

 * I am not sure if "lsrefs.allowunborn = yes/no" is a good way to
   configure this feature.  Wouldn't it be more natural to make this
   three-way, i.e. "lsrefs.unborn = advertise/serve/ignore", where
   the server operator can choose among (1) advertise the presence
   of the capability and respond to requests, (2) do not advertise
   the capability but if a request comes, respond to it, and (3) do
   not advertise and do not respond.  We could throw in 'deny' that
   causes the request to result in a failure but I do not care too
   deeply about that fourth option.

   Using such a configuration mechanism, ls_refs_advertise may leave
   the value of "lsrefs.unborn" (or lack thereof) it found and used
   to base its decision to advertise, for use by ls_refs.  ls_refs
   in turn can use the value found there to decide if it ignores or
   responds to the "unborn" request.

