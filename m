Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88B1EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 05:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjF2F7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 01:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjF2F7O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 01:59:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B4DE5B
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 22:59:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 038C7195DCF;
        Thu, 29 Jun 2023 01:59:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=HA7L+2SERuu70R+A9n3rlQl5ONgv187fwvnreFBD81M=; b=SJAD
        2D7PqZph3lo9QQzG7YJrkb8UUd/ix4LZcUfvQXFMo2ekUGKd6qx122/2j9u6w9my
        AHTK7SG/gqNKcLPxG/7T6kUQ0+PRZ8PqCHEeFvLCkgp7tsSyF5tNLKGNkbv1ZCPH
        3HJON1ix9Peu/XKDgqTeyg7Nj84/cnaBBiCu1yo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0353195DCE;
        Thu, 29 Jun 2023 01:59:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6193A195DCD;
        Thu, 29 Jun 2023 01:59:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Majer <adamm@zombino.com>
Cc:     git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
Date:   Wed, 28 Jun 2023 22:59:11 -0700
Message-ID: <xmqqmt0iajww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1234F92C-1642-11EE-9B6C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Majer <adamm@zombino.com> writes:

> Is sha256 still considered experimental or can it be assumed to be stable?

I do not think we would officially label SHA-256 support as "stable"
until we have good interoperability with SHA-1 repositories, but the
expectation is that we will make reasonable effort to keep migration
path for the current SHA-256 repositories, even if it turns out that
its on-disk format need to be updated, to keep the end-user data safe.

So while "no-longer-experimental" patch is probably a bit premature,
the warning in flashing red letters to caution against any use other
than testing may want to be toned down.

Thanks.

