Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7193C1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 19:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754063AbcH2Tt0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 15:49:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61545 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752918AbcH2TtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 15:49:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D4133AF68;
        Mon, 29 Aug 2016 15:49:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ep4MZJmiNCEnd/ZJRANKSMA/+fU=; b=aa810v
        knKZLilA5fGAtzTRUo/6Px02U7DZgdMzYhUjEYxkHofGBTcNZRWQkVmt92SpmFeS
        TITPpV8usGBc3Tw0IsLAy/HR5jTZvOBjnm5O5i4KgIJSp5Q5tfnHhLBtVp7EABgU
        MmKiN3PUiHA87c8nJJvnND2C1f9J26bvff910=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AgFm/zbrj23xTzsZ191zuCeJOQc+9DZW
        Zmr3gmUvQWplbV1VQiUHoE5/ZMJT85Xj1r+lVlgb7MQ2mS+33zE/ioyaR5aQNJEr
        jEde1IGcJ3fmKHTSFTgAHNxN0J702XzQ2ALtF0WzyL/sI9VampRgiY+HetLGhozH
        Xx/tXMtMWoQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75D253AF67;
        Mon, 29 Aug 2016 15:49:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0194C3AF66;
        Mon, 29 Aug 2016 15:49:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Kevin Daudt <me@ikke.info>, ryenus <ryenus@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Notation for current branch?
References: <CAKkAvazQxhtQauSb3MTVhzoK=xWbjMzQLBPQZUpp1n7VMUMJbQ@mail.gmail.com>
        <20160828105159.GA5477@ikke.info>
        <4114ccbc-6b23-b7fe-ce4a-fcd0c9e4038a@gmail.com>
        <CA+P7+xrGh687cYHJmYyXiWfjg_8i2-31FZOvk4bEMsO1FU22WA@mail.gmail.com>
Date:   Mon, 29 Aug 2016 12:49:22 -0700
In-Reply-To: <CA+P7+xrGh687cYHJmYyXiWfjg_8i2-31FZOvk4bEMsO1FU22WA@mail.gmail.com>
        (Jacob Keller's message of "Sun, 28 Aug 2016 23:39:02 -0700")
Message-ID: <xmqqy43f9wzh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF961D48-6E21-11E6-B90A-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> What's wrong with simply using 'HEAD' for scripting?
>
> When you want to display the current branch to the user, e.g. when
> scripting a shell prompt or similar use

Wait.  Even if a hypothetical version of Git understood @@ as "the
current branch", how would you use that notation, instead of HEAD,
to decide what to "display the current branch to the user"?

You obviously will not be doing

	echo @@

You would be doing something around "git symbolic-ref" at the very
least, and wouldn't you be feeding HEAD to that symbolic-ref anyway
while doing so?

