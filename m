Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB94C07E95
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 00:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 670A2613CC
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 00:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhGCAJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 20:09:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53779 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhGCAJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 20:09:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 874A7E0819;
        Fri,  2 Jul 2021 20:06:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w3kCgxvnMkWG5YYBxIbw8IvdfPxAA5yth4SAdC
        DH51o=; b=Xc2Lxw+Eu0nSJ8/8AeSsIAnpKhSDWd5fit5cqt8C5ssAKfYp4Vb4i1
        6XvKkR0Xs7f/CJnEcWzHkweKOQv30sDUKRGVGQIUJ1d0pZpwBdwbk8JRfj7O/uCl
        9ukAUh1JjE9exn6DMPndRmDkXOJbdjtx2mfUGu6Yte2au1A3yhYAk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FE52E0818;
        Fri,  2 Jul 2021 20:06:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17CFBE0817;
        Fri,  2 Jul 2021 20:06:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrew Berry <andrew@furrypaws.ca>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: .gitignore in parents is current repo only
References: <20210702222044.72767-1-andrew@furrypaws.ca>
Date:   Fri, 02 Jul 2021 17:06:54 -0700
In-Reply-To: <20210702222044.72767-1-andrew@furrypaws.ca> (Andrew Berry's
        message of "Fri, 2 Jul 2021 18:20:44 -0400")
Message-ID: <xmqqzgv4ntup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94163CB8-DB92-11EB-97E4-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrew Berry <andrew@furrypaws.ca> writes:

> The current documentation reads as if .gitignore files will be parsed in
> every parent directory, and not until they reach a repository boundary.

Hmph.  While it is not adding an incorrect information to the
documentation per-se, I am not sure if this is necessary to begin
with.  I would have thought that "up to the toplevel of the work
tree" would be sufficiently clear where the upward traversal of the
directories ends, i.e. at the repository boundary.

>   * Patterns read from a `.gitignore` file in the same directory
> -   as the path, or in any parent directory, with patterns in the
> -   higher level files (up to the toplevel of the work tree) being overridden
> -   by those in lower level files down to the directory containing the file.
> -   These patterns match relative to the location of the
> +   as the path, or in any parent directory in the same repository, with
> +   patterns in the higher level files (up to the toplevel of the work tree)
> +   being overridden by those in lower level files down to the directory
> +   containing the file. These patterns match relative to the location of the
>     `.gitignore` file.  A project normally includes such
>     `.gitignore` files in its repository, containing patterns for
>     files generated as part of the project build.

