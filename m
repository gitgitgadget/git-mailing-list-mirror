Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429511F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfKFEuM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:50:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59615 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbfKFEuM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:50:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FD95A1F13;
        Tue,  5 Nov 2019 23:50:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rePecBYR3AUQdOxDuJmrLexK/Wo=; b=hvotiP
        4GWhOjMEFzMK4yufhbvhrEMSFYuItSRYTQtX3muS2eochEV+TY+MUczmEcq+4MBh
        6dnuGiTvk9NN/WiMcWDsnxCFi1lb4YP040RYnunJUQrsqWmysX/moo9uk0HygkZX
        OV74WjQ5NwP1rTHrPDmByWJkiWh7eaZS0QJ0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gLIsNyvlcBuGFKRyRXDl6X52SnLCC4nS
        yp+jFNC31OJe8V7F+tF/o5KO/cIpITez6ZqkfoHrMUYWabDuYr98WUA+i8vl4K5k
        hJZ9zAc1S1cZFpjZBPjrm5mM4QLO+jPnOze6fg1lL5+YJP2esSFKzzNsfafIOtoi
        ul2pxrtfSXg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4932EA1F12;
        Tue,  5 Nov 2019 23:50:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1F4CCA1F0D;
        Tue,  5 Nov 2019 23:50:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 4/5] doc: commit: unify <pathspec> description
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <251d06e27f6bc93b190450ae6e1087a3126b5e52.1572895605.git.gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 13:50:04 +0900
In-Reply-To: <251d06e27f6bc93b190450ae6e1087a3126b5e52.1572895605.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Mon, 04 Nov 2019
        19:26:44 +0000")
Message-ID: <xmqq8sotvcar.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E79D316C-0050-11EA-8264-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> Synchronize it to `git add`, which has a pretty good description.
> This also better disambiguates <file>... header.

"When files are given on..." is no longer true with this change (it
wasn't true with the code before this change anyway).

	When pathspec is given on the command line, commit the
	contents of the files that match the pathspec without
	recording the changes already added to the index. ...

The second sentence also says "these files", but that can be left
as-is, since it would refer to "the files that match ..." explained
in the above sentence.

> +For more details about the <pathspec> syntax, see the 'pathspec' entry
> +in linkgit:gitglossary[7].

I am not sure if we want to repeat this all over the place.

We do not say "For details about the <commit> syntax, see the
'SPECIFYING REVISIONS' section of linkgit:git-rev-parse[1]" for
every command that takes <commit> from the command line.

Is your urge to suggest adding this sentence coming from that you
are much more familiar with <commit> than <pathspec>?  In other
words, if you were more familiar with Git, would you still be adding
this (and not corresponding one for <commit>)?

