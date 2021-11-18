Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB18C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 03:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302FB61ABD
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 03:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbhKRDnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 22:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241533AbhKRDna (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 22:43:30 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F18C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 19:40:30 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p18so4016652plf.13
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 19:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvMKxuJiIjFj3V/JoGEotFvIY6XREY4h/uxMfRGy8/o=;
        b=C8P0JktS+ILO4OfRH+I7fmJn+KhB57rvj0+xpHBUZ7s1K215Q0M1APMjiegULFgqCr
         dKjRnKfIHWJS6wcW7NnNchLapslzIcLDDMspTQhjbnW70jYec4kdt+LgTnnew0i5DwZd
         8CR/qOG1N8nt13w/qPVbiHtmSfeaN7XXc5Nezv60HMgxAYkD3kinD6O7ygu2392oi3lL
         Z4PRkkTWgvB1X1TDFpeBnR3nWhFkaGjFMUgD67iQFV+20/KmWq594IiKhae4BN/a8RqC
         OacIk4h4g+m6ANH79x7UfCxmO2f5gM4i52kVfiwQLW8AMhnQTr069lvcKUsV0bBe0x/N
         wf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvMKxuJiIjFj3V/JoGEotFvIY6XREY4h/uxMfRGy8/o=;
        b=m6LqNEDOhZM0MD+CHKZ+sili1i035GS+grKH478RZV3CJgZgoFqs32CC6PadvEyEPG
         CxcsWzXuyTtOjT9pKC3t8A4TMZr+T8PP3IP0aSPaHPONClt7XNZpT1xd04aiX+PrB/1w
         xZbNqqn5lSSOZuDGIOrnjKpm8eaxYHqj+7BJwHs4OB/zHapf8MdJFHJRigVL0sqd5ufT
         uhvktgODUWn3hRaSrULh+CpcfKkf4IJOjVWf8v3EgaerF6aW7qkj9PqRyNJCIOsJpv0/
         VEQcZMk85HIJW+H+pHfCwffrdbDsXgzHeB+w1cMwuStstpEwNdk9+4XRiW83BAnEQeU1
         4MxA==
X-Gm-Message-State: AOAM533LvZAQCdnFPTBRFYNGaLZOOaAnAp5tIuoPL/++TNJinnQ63GSM
        S8bFdxZLhGoizfbK3FZY6FU=
X-Google-Smtp-Source: ABdhPJxQ6VOHx3kOfPjD8UjmaJL5PpTyUrrvosIWmzXQfPoludXJo8icOFOqkK+7PRdYVEpWJEel5A==
X-Received: by 2002:a17:90b:4ad0:: with SMTP id mh16mr6344780pjb.176.1637206830194;
        Wed, 17 Nov 2021 19:40:30 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id l1sm6707429pjh.28.2021.11.17.19.40.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Nov 2021 19:40:29 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH] midx: fix a formatting issue in "multi-pack-index.txt"
Date:   Thu, 18 Nov 2021 11:39:59 +0800
Message-Id: <20211118033959.59881-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.9.g5fbd2fc599.dirty
In-Reply-To: <YZQngLFWlns9HyoW@nand.local>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Tue, 16 Nov 2021 16:49:52 -0500, Taylor Blau wrote:

> That's it. ASCIIDoc doesn't treat an indented dash character as the
> beginning of a sub-list.

That's right.

> It will treat an indented asterisk as beginning
> a sub-list, but only if the rest of the list items begin with a "-".

There are some questions here.
I think the indent is not needed for bulleted list in ASCIIDOC. If we
want to write a nested bulleted list, we could just use asterisks
without any dashes like:

"
* Level 1 list item
** Level 2 list item
*** Level 3 list item
** Level 2 list item
* Level 1 list item
** Level 2 list item
* Level 1 list item
"

And the dashes are suggested only be used as the marker for the first
level because the dash doesn’t work well or a best practice for nested
lists, like (dash is as level 2):

"
* Level 1 list item
- Level 2 list item
* Level 1 list item
"

But, if you are writting a non-nested bulleted lists, use dashes works
too, like:

"
- Level 1 list item
- Level 1 list item
- Level 1 list item
"

> It might just be worth converting this whole thing to use what ASCIIDoc
> would probably consider to be a more standard format, i.e.:
>
>     * A list of packfile names.
>     * A sorted list of object IDs.
>     * A list of metadata for the ith object ID including:
>     ** A value j referring to the jth packfile.
>     ** An offset within the jth packfile for the object.
>     * If large offsets are required, we use another list of large
>       offsets similar to version 2 pack-indexes.

I agree with you.

The asterisks are recommanded to use I think, it displays intuitively
when writting ASCIIDOC lists (marker length = nesting level).

> Yeah, Teng's fix works just fine. So I'd be happy to see that picked up
> (with or without much additional explanation).

I found it because I'm learning about the implements about the
multi-pack-index, reverse-index and multi-pack-bitmap, very nice
feature.

Patch v2 will add more descriptions (Derrick Stolee suggested) in
commit message and will make the replacements from dashes to asterisks.

Finally, thanks Derrick Stolee and Taylor Blau for the relies.

References:
[1] https://asciidoc-py.github.io/userguide.html#_bulleted_lists
