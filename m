Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ED3EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 23:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjFWXWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 19:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjFWXWt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 19:22:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B45E268C
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 16:22:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B254319E95;
        Fri, 23 Jun 2023 19:22:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OwRSmj4Pc2ip6SUg951B8cL27jKhuYdBc7qxVL
        oh0jo=; b=NiWo7ksVYsCXbVIYtMuZG28gmeWGR7UfncO2/a/yf9azHPRi5OJ/in
        3No4mFTSJm8N/IcfuiZvxr1tjhGXTW3XpK+UxQ9MGE2XGZI4dBWG61G3tsWwW8kQ
        nNVyLuVp63/0tm+IdUvHiyaWaS9bO47IPzjn6Vt+hKO5ujkA/rTDQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB4E719E94;
        Fri, 23 Jun 2023 19:22:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1A8E19E93;
        Fri, 23 Jun 2023 19:22:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2023, #06; Fri, 23)
References: <xmqq1qi1aix3.fsf@gitster.g>
Date:   Fri, 23 Jun 2023 16:22:42 -0700
In-Reply-To: <xmqq1qi1aix3.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        23 Jun 2023 15:54:48 -0700")
Message-ID: <xmqqo7l59325.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB102E2C-121C-11EE-B847-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * jk/redact-h2h3-headers-fix (2023-06-17) 1 commit
>   (merged to 'next' on 2023-06-20 at c1247fd527)
>  + http: handle both "h2" and "h2h3" in curl info lines
>
>  Curl library recently changed how http2 traces are shown and broke
>  the code to redact sensitive info header, which has been fixed.
>
>  Will merge to 'master'.
>  source: <20230617051559.GD562686@coredump.intra.peff.net>

Even though this hasn't spent the usual 1 calendar week days in
'next', I am inclined to fast-track merge it to 'master' (and
probably to 'maint'), as GitHub actions CI currently is broken
with any branch without this fix for macOS jobs.
