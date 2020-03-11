Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5701FC0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC3520739
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rHQdNunb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbgCKTD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:03:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56564 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730805AbgCKTD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 15:03:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30792BCF0D;
        Wed, 11 Mar 2020 15:03:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZVI6d3ab/VD7
        lpP7cKudxC7U0gM=; b=rHQdNunblUX4EXpnZrx5pckwttZ2V4KYdcJQbr2sbpXD
        bo8Du5bwXC35FTo9SrAtNfFBpDwlKP/HZsT58PuPyBkKjHL/CxKLFPeC/tiINlE0
        k5XoUXdHgdQOraV+5BytDYqcp+zR+01W83A1ggAXPbm44ETtAZaBnrJOrTEE/Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=k6lmSf
        zwNBV9ibpDiap0FDGxRy/Qp+zALPSCbXd1v5zmOhRm8TW8JDia96T/hqT0SqGkb0
        8eYcYsAz6fIYRMK7fhrFZJ+AmTYjf19vMdPS0L5fsX49vUzEECO0K8u+DiWjcWD1
        lQ8GNO8ERui/ISyEvFZ559VnxYhDC6vcEVOzc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 288CDBCF0C;
        Wed, 11 Mar 2020 15:03:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5944FBCF09;
        Wed, 11 Mar 2020 15:03:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
Date:   Wed, 11 Mar 2020 12:03:52 -0700
In-Reply-To: <86mu8o8dsf.fsf@gmail.com> (Jakub Narebski's message of "Tue, 10
        Mar 2020 15:50:24 +0100")
Message-ID: <xmqqo8t2hfxj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D79F50E-63CB-11EA-8072-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> A few questions:
> - is it too late to propose a new project idea for GSoC 2020?
> - is it too difficult of a project for GSoC?
> ...
> ### Graph labelling for speeding up git commands
>
>  - Language: C
>  - Difficulty: hard / difficult
>  - Possible mentors: Jakub Nar=C4=99bski

I am not running the GSoC or participating in it in any way other
than just being a reviewer-maintainer of the project, but I would
appreciate a well-thought-out write-up very much.

> Git uses various clever methods for making operations on very large
> repositories faster, from bitmap indices for git-fetch[1], to generatio=
n
> numbers (also known as topological levels) in the commit-graph file for
> commit graph traversal operations like `git log --graph`[2].
>
> One possible improvement that can make Git even faster is using min-pos=
t
> intervals labelling.  The basis of this labelling is post-visit order o=
f
> a depth-first search traversal tree of a commit graph, let's call it
> 'post(v)'.
>
> If for each commit 'v' we would compute and store in the commit-graph
> file two numbers: 'post(v)' and the minimum of 'post(u)' for all commit=
s
> reachable from 'v', let's call the latter 'min_graph(v)', then the
> following condition is true:
>
>   if 'v' can reach 'u', then min_graph(v) <=3D post(u) <=3D post(v)
>
> If for each commit 'v' we would compute and store in the commit-graph
> file two numbers: 'post(v)' and the minimum of 'post(u)' for commits
> that were visited during the part of depth-first search that started
> from 'v' (which is the minimum of post-order number for subtree of a
> spanning tree that starts at 'v').  Let's call the later 'min_tree(v)'.
> Then the following condition is true:
>
>   if min_tree(v) <=3D post(u) <=3D post(v), then 'v' can reach 'u'
>
> The task would be to implement computing such labelling (or a more
> involved variant of it[3][4]), storing it in commit-graph file, and
> using it for speeding up git commands (starting from a single chosen
> command) such as:
>
>  - git merge-base --is-ancestor A B
>  - git branch --contains A
>  - git tag --contains A
>  - git branch --merged A
>  - git tag --merged A
>  - git merge-base --all A B
>  - git log --topo-sort
>
> References:
>
> 1. <http://githubengineering.com/counting-objects/>
> 2. <https://devblogs.microsoft.com/devops/supercharging-the-git-commit-=
graph-iii-generations/>
> 3. <https://arxiv.org/abs/1404.4465>
> 4. <https://github.com/steps/Ferrari>
>
> See also discussion in:
>
> <https://public-inbox.org/git/86tvl0zhos.fsf@gmail.com/t/>
