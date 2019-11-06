Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1311F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbfKFECH (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:02:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56806 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbfKFECG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:02:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8671A576E;
        Tue,  5 Nov 2019 23:02:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7AReaqvsyOymIzZ2X21wqm1Frm4=; b=DTVE2A
        z6h7R/5IV2gdh9p1PatbRi1rGNq21AaPWNxNAUpLytPSd7mrVJmZUM3B3VwOk7Qh
        lmVYIooj9z4PHXrExvy+wc/Wx3EPmNyLE9E7iVeSmJadVLIHZLgwHiLpEx7T/X7+
        faG9yDS+jLsOLD0mbTpBsy3X0W9nE5W+blAP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Iws7jflXHqhVWpnhFgwJWPMZ0JKsD/KS
        VY7iKG9LpN8W12LCIKruBuNWE+L1ZHe1m32RleXVMBzrEnrDgHnKpRg5NNme7aRm
        JAAjoWj40cBVtfa0YukMmBYPwo0QEShOUa1E7+ZHDGZcWQiBz0JKrPL866fEvt4A
        cpm1elUINfU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DFE69A576D;
        Tue,  5 Nov 2019 23:02:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E27FA576B;
        Tue,  5 Nov 2019 23:01:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 2/5] doc: reset: unify <pathspec> description
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <1740ac7a291cfc81418c2d437201c3373487fa26.1572895605.git.gitgitgadget@gmail.com>
Importance: high
Date:   Wed, 06 Nov 2019 13:01:56 +0900
In-Reply-To: <1740ac7a291cfc81418c2d437201c3373487fa26.1572895605.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Mon, 04 Nov 2019
        19:26:42 +0000")
Message-ID: <xmqqh83hveiz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E30AF20-004A-11EA-BE02-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  optionally modifying index and working tree to match.
>  The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
>  
> -'git reset' [-q] [<tree-ish>] [--] <paths>...::
> -	This form resets the index entries for all `<paths>` to their
> +'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
> +	This form resets the index entries for all `<pathspec>` to their
>  	state at `<tree-ish>`.  (It does not affect the working tree or
>  	the current branch.)
>  +
> -This means that `git reset <paths>` is the opposite of `git add
> -<paths>`. This command is equivalent to
> -`git restore [--source=<tree-ish>] --staged <paths>...`.
> +For more details about the <pathspec> syntax, see the 'pathspec' entry
> +in linkgit:gitglossary[7].
>  +
> -After running `git reset <paths>` to update the index entry, you can
> +This means that `git reset <pathspec>` is the opposite of `git add

It is good to show which document to read more on <pathspec>, but
inserting it just before "This means..." breaks the flow of thought.

As we introduce/explain tree-ish and commit used in the synopsis in
the ealier part of the description, it probably is a much better
place to also introduce/explain pathspec, perhaps like so:

	 In the first and second form, ...
	 In the third form,  ...
	 The <tree-ish>/<commit> defaults to HEAD in all forms.
	+The <pathspec> is used to limit the paths affected by the
	+operation in the first two forms (see the entry for
	+'pathspec' in linkgit:gitglossary[7] for more details).

> +This means that `git reset <pathspec>` is the opposite of `git add
> +<pathspec>`. This command is equivalent to
> +`git restore [--source=<tree-ish>] --staged <pathspec>...`.

Any time I see "... X. This means Y." either in the doc or in the
proposed log message, I wish the author (not you in this case,
obviously) thought twice about rewriting so that they do not say one
thing and immediately have to rephrase it, i.e. either just say Y
without saying X, or saying X more clearly without having to say Y.

In this case, however, I think X and Y are related but both relevant.
The subcommand resets the index entries for chosen paths to match
what is in the tree-ish, which is the same as restoring from a tree
to the index.

It is not quite the opposite of adding to the index from the working
tree.  In this sequence:

	$ edit newfile
	$ git add newfile

and then further

	$ edit newfile
	$ git add newfile
	$ git reset -- newfile

we are taken back to the state _before_ any of the changes made to
newfile (in fact, since HEAD does not have newfile, the resulting
index would not know about it, either).

Thanks.
