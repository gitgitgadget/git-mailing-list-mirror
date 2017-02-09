Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8362B1FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 00:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbdBIA0l (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 19:26:41 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33536 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752468AbdBIA0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 19:26:36 -0500
Received: by mail-pg0-f67.google.com with SMTP id 194so16189992pgd.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 16:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KxsWdI2NgmPwK38rOZusNkyULTjKuq6gM5WN5S6/S54=;
        b=bGvU3e563RhN2I8zDoboG/di4jQK6IAo3lCInB+MS9Nc3gWobTR11DreDdIV5gJMLr
         fKy0s+Guvy5iFhU0tA1IAlK05Jf8AKqYPx86CeWD16c+sTuoKtlI7zEnQOEiVUON1LUr
         gaJTETZARXdEFYf85YE6vGfEjNzM/VDXQanrAQ8A2rBySlYBqa+6k3phYOmcfJ0XAfB0
         5jCrBYh78Yg04d9Ymdt5YjyVVsGIYWvG9WJ6lIEqRVs2z0obKA4h6HeEiUz7vhe3oF7L
         qMtargZG2aBB8AeShSTi29hJRnUSMx1yzwAVAOqWlTtCORBOX51klYRagnkQUiWUfDsH
         o3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KxsWdI2NgmPwK38rOZusNkyULTjKuq6gM5WN5S6/S54=;
        b=nONiRW2XJQR6aur7HoSv2jw80UhbE5gqowR/VkQZ4PMQsXnbdoQ0qW9myY4hXrYd5M
         0y0xg12S5VZn5aNAArBfPXZFCewo5uLVLxjlbCzZTff4vg/cJcoeyLRIiyeWQ7FWAYQY
         s0Mz1l3OINPurUibwRr7D1JPk9rdQPz3ioaV8ZuHBmPj8IOZdjLYvYFsH4E4Aw0JSgiX
         fXcTQOV/aE8RxPTNKrSYEOBtlLc9USo6uG4+D0/JjXMrCzECW3a/UfrKJbxwk3fsS4xW
         2kCesbF3frLj96nHzukDumyrHdzFYHR+YjaqI9Ao1ex322yi5wZGdQqx0XlxvTReOcZk
         WS7Q==
X-Gm-Message-State: AMke39n0hUl7yaZs0vUgGhqBFDHTMlH+7SlG5Poq5eFtPVSGnDHLRfcWUSW9ojepNrg7Sg==
X-Received: by 10.98.25.21 with SMTP id 21mr398300pfz.46.1486599995569;
        Wed, 08 Feb 2017 16:26:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id e7sm23383290pgp.2.2017.02.08.16.26.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 16:26:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC 00/14] Allow fetch-pack to send ref names (globs allowed)
References: <cover.1485381677.git.jonathantanmy@google.com>
        <20170207235350.10718-1-jonathantanmy@google.com>
Date:   Wed, 08 Feb 2017 16:26:33 -0800
In-Reply-To: <20170207235350.10718-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 7 Feb 2017 15:53:50 -0800")
Message-ID: <xmqq7f50tdja.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Usages of the list of remote refs or the remote-local ref
> map are updated as follows:
>  - check_not_current_branch (which checks that the current branch is not
>    affected by the fetch) is performed both on the original ref map (to
>    die before the fetch if we can, as an optimization) and on the new
>    ref map (since the new ref map is the one actually applied).

OK.

>  - Pruning is done based on the new ref map.

OK.  As that is what eventually gets "installed" on the local side,
it makes sense to become consistent with that set, not the set the
original server gave you.

>  - backfill_tags (for tag following) is performed using the original
>    list of remote refs because the new list of fetched refs is not
>    guaranteed to contain tag information. (Since backfill_tags performs
>    another fetch, it does not need to be fully consistent with the
>    just-returned packfile.)

This smells correct but I need to think about this one a bit more.

Overall I think the strategy is agreeable.
