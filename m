Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18FA1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 17:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfGCRuh (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 13:50:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56182 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfGCRug (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 13:50:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52FE07D54C;
        Wed,  3 Jul 2019 13:50:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HYZWUTCk3iQwwDeWI1H9+ti5ym4=; b=bSqExi
        W3e4GASC76/pgDQx5paK9lm5r4Ar+M0dHq1h9kTt6ppUm0AWIhj9K39FGhrO8qeE
        BrYpi90HSYbFpG8Nqgsny1W4uA4BKhnfSmoTd6q4TbPoxa6CPrr44b7PfjFhPkC6
        +MWqP8DjkgObVnaH7+f0Vo9OVWRYDuiwLdaNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NF0hno1U3LmcqgRDBCe/lR4KywsQnSZ3
        VQ+L9tBaYMP9wjnTJwJXK3ZGSS1YdcXT7HvDdBzwCXE674oFWiEEMiKUgxCoqgCa
        JCGTUSfSfWTq+OtISJFPT74UeyE2z4nvJjPPMBgPxeBQjN5UrczVxXBs9AOJE3JY
        62fTGRwXWwI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A58E7D54B;
        Wed,  3 Jul 2019 13:50:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 30E2F7D54A;
        Wed,  3 Jul 2019 13:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
Date:   Wed, 03 Jul 2019 10:50:26 -0700
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Fri, 21 Jun 2019 17:30:53 -0500")
Message-ID: <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BB1F89C-9DBB-11E9-A2EB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Here's another try at completion fixes, cleanups, and more tests. Some
> of these have already been sent.
>
> Felipe Contreras (14):
>   completion: zsh: fix __gitcomp_direct()
>   completion: zsh: fix for directories with spaces
>   completion: remove zsh hack
>   completion: zsh: improve main function selection
>   completion: prompt: fix color for Zsh
>   completion: bash: cleanup cygwin check
>   completion: zsh: update installation instructions
>   completion: bash: remove old compat wrappers
>   completion: bash: remove zsh wrapper
>   completion: zsh: trivial cleanups
>   test: completion: tests for __gitcomp regression
>   test: completion: use global config
>   completion: add default options
>   completion: add default merge strategies
>
>  contrib/completion/git-completion.bash | 202 +++++++++++++------------
>  contrib/completion/git-completion.zsh  |  53 +++----
>  contrib/completion/git-prompt.sh       |  10 +-
>  t/t9902-completion.sh                  |  37 +++--
>  4 files changed, 161 insertions(+), 141 deletions(-)

Having scanned the discussion threads so far, I think the last four
patches are going against the list consensus of (1) it is OK to rely
on --git-completion-helper; using ancient Git with new completion
script won't obviously work, but that is "if it hurts, don't". (2)
some subcommands will fail the --git-completion-helper request
(e.g. outside a repository), but as long as the output from failed
request is not cached, it is OK.

But we haven't seen any response to the earlier zsh specific
patches.  Does it mean that nobody other than Felipe cares about
having a working Git completion for zsh?  Or does it mean that all
users other than Felipe are happy with the current Git completion
for zsh and it works very well for them already?  Or somewhere in
between?

What I am trying to get at is if we would want to keep the earlier
zsh parts of the series, but with nobody seemingly interested in, it
is hard for me to justify queuing them.

Thanks.
