Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953BA1F4B7
	for <e@80x24.org>; Thu, 22 Aug 2019 22:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbfHVWef (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 18:34:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57672 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390855AbfHVWef (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 18:34:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E714167E28;
        Thu, 22 Aug 2019 18:34:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=86SUrUlgOkbxPi1Zjl4x9OhJ40g=; b=a8DJEE
        Ks9N2kOXTE0Wd+DDAzwCRvkbaGMOzXZ0KewWh/qG7aCN5SIVyrNz/GnGQ+Hpbehu
        WIkR9FfqMHln5OIep5Ol9OvDmQDJqae0CuQ5HsRxb8QAnPHCRrQVmz1LGJigjUYT
        FhtNHhPhWaeu+BuMd3Fe7StxHvGd+B4jVwk+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HAbn3rBY6b/YwGcgqQZ0tNcbqBZ/hZtw
        WB7jQgz4BWpbgOx028jNLh4+eULCl0eT+0g007FPP+o06xVKqGK+EvPibcaJeLY4
        HOIMtRzwUguD8lIYp3XZEOla1KLwRSENy/9VXGkU8iXW4BpatewRvUHIa+X0NMwW
        SMh6WjMaAMs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55C80167E27;
        Thu, 22 Aug 2019 18:34:33 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B705B167E26;
        Thu, 22 Aug 2019 18:34:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v2 0/4] git-gui: Add ability to revert selected hunks and lines
References: <20190819214110.26461-1-me@yadavpratyush.com>
        <20190822220107.4153-1-me@yadavpratyush.com>
Date:   Thu, 22 Aug 2019 15:34:31 -0700
In-Reply-To: <20190822220107.4153-1-me@yadavpratyush.com> (Pratyush Yadav's
        message of "Fri, 23 Aug 2019 03:31:03 +0530")
Message-ID: <xmqq4l28ommg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0318D036-C52D-11E9-A64B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> This series adds the ability to revert selected lines and hunks in
> git-gui. Partially based on the patch by Bert Wesarg [0].
>
> The commits can be found in the topic branch 'py/revert-hunks-lines'
> at https://github.com/prati0100/git-gui/tree/py/revert-hunks-lines
>
> Once reviewed, pull the commits from
> 415ce3f8582769d1d454b3796dc6c9c847cefa87 till
> 0a1f4ea92b97e673fda40918dae68deead43bb27, or just munge the patches and
> apply them locally, whichever you prefer.

Let's see how we can work together by you playing the role of
git-gui maintainer and the others on the list (including me) playing
the role of reviewer and contributor.  So I may keep an eye on the
discussion on this thread, I may even comment on them myself, but
you'll be the one waiting for the discussion to settle, adjusting
the patches in response to reviews, etc. and making the final
decision when/if the topic is done, at which time you'd be telling
me to pull from you.

> Pratyush Yadav (4):
>   git-gui: Move revert confirmation dialog creation to separate function
>   git-gui: Add option to disable the revert confirmation prompt
>   git-gui: Add the ability to revert selected lines
>   git-gui: Add the ability to revert selected hunk

"Move" and "Add" after "git-gui:" would better be downcased to be
more in line with the others in "git shortlog --no-merges"; I also
think "allow doing X" is shorter and better way to say "add the
ability to do X".

If I am reading the first patch correctly, we already ask for
confirmation before reverting local changes, and the steps 3 and 4
are about allowing partial reversion in addition to the wholesale
reversion, right?  An earlier objection from j6t sounded like we
require users to respond to an extra dialog after this series, but
that does not look like the case.  Instead, step 2 adds a new
feature to allow those to opt-out of the existing dialog (which may
be reused to squelch the dialog to protect features added in steps 3
and 4).  Am I reading the series correctly?

Thanks.

>
>  git-gui.sh     | 40 +++++++++++++++++++++++++++++--
>  lib/diff.tcl   | 65 ++++++++++++++++++++++++++++++++++++++++++--------
>  lib/index.tcl  | 31 ++++++++++++++++--------
>  lib/option.tcl |  1 +
>  4 files changed, 115 insertions(+), 22 deletions(-)
>
> --
> 2.21.0
