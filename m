Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D401F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 06:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfKSGFP (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 01:05:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63338 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKSGFN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 01:05:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AAE820854;
        Tue, 19 Nov 2019 01:05:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dKb4a0eM6H4ooZI7ysVRMzv7aIE=; b=U+4a2I
        yacDWShw3V3YrtI7IiFsW9edWH9ggaXow3Py+ddZgfogy+yGbFX0DD6WNTPup3Nw
        aj1h/LqEs7zBPrE+XPI/ve1dagN8k27WHkdr31UcGvT+PxtirbePNbrkEBoCCtvV
        3RlO+tmQuxV9MgqhWWYkyblX1bABeQQjG0G9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E8ueUWaYXXugdHL1WsgCnIBHKAlSnQUw
        ZAn3JGJ8a5ftfIVVvTd1WTGA46SO0AGlWyaRu1CmWG6VUIe/icDYTQLswA1oYGsr
        km/nOKGBod4fzJ69LrkklAurnoWsZeaoJgG2g+UL5ze6H75BuukzCH6YeOsb3dvc
        dAY8+1LrRH0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 937B120852;
        Tue, 19 Nov 2019 01:05:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04E6320851;
        Tue, 19 Nov 2019 01:05:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 3/6] doc: reset: unify <pathspec> description
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
        <f961a5155a5ec1590652ce7b5a549eead71930e1.1573055478.git.gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 15:05:10 +0900
In-Reply-To: <f961a5155a5ec1590652ce7b5a549eead71930e1.1573055478.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Wed, 06 Nov 2019
        15:51:15 +0000")
Message-ID: <xmqqv9rgxuy1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C1BE9FE-0A92-11EA-A658-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -'git reset' [-q] [<tree-ish>] [--] <paths>...
> -'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
> +'git reset' [-q] [<tree-ish>] [--] <pathspec>...
> +'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]

Good.

> @@ -18,24 +18,26 @@ In the first and second form, copy entries from `<tree-ish>` to the index.
>  In the third form, set the current branch head (`HEAD`) to `<commit>`,
>  optionally modifying index and working tree to match.
>  The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
> +The <pathspec> is used to limit the paths affected by the operation
> +(see the entry for 'pathspec' in linkgit:gitglossary[7] for more details).

Good.

> -'git reset' [-q] [<tree-ish>] [--] <paths>...::
> -	This form resets the index entries for all `<paths>` to their
> +'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
> +	This form resets the index entries for all `<pathspec>` to their

This is not so good.  The original pretended as if <paths> are the
exact pathnames, so it was sort-of OK for it to say "for all paths".
Since we are highlighting the fact that these are not pathnames but
the patterns to match pathnames, however, the description needs a
slight update to match, perhaps like

	ths form resets the index entries for all paths that match
	the `<pathspec>` to their...

>  	state at `<tree-ish>`.  (It does not affect the working tree or
>  	the current branch.)

Thanks.
