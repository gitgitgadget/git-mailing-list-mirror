Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7601F667
	for <e@80x24.org>; Tue, 22 Aug 2017 15:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbdHVP6T (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 11:58:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61976 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751010AbdHVP6S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 11:58:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17E5BA496E;
        Tue, 22 Aug 2017 11:58:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ae7X7xkpJvpTxeMfO0+IVE6GRGI=; b=bbx5FV
        A+slekVdXpdV3ejwZIuqJjFnliIJM2HvOp4tBMCAX3exvgNwaoGx9AB+LdZALWLm
        39i98hZ2U5plwjShQzw/La7Z66kjiWcQLsU3h8DnhLjYqUOLPwTwFZ43HPzCLnQ+
        3xg5YqkMvKxWOap3z1Z0D/k0FPlJCS1HTDY1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hiJO69j/GKnR46YJ6J+ITR9k30A80I/z
        Vh+EzxtdZBrEvCuIfgd2Am788/QnGvl4Q90iejtKtgXeYs6Moq1Noz9A9kirE+Ex
        HsMfo9NtScvnjOTSfwmccXF0O+Qz/OHXg2l5eNtFbxmToVQ7wjqUWr34dzjWgHcE
        Vc19MyyqoFM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 103AAA496D;
        Tue, 22 Aug 2017 11:58:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72424A496C;
        Tue, 22 Aug 2017 11:58:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2017, #04; Fri, 18)
References: <xmqq60dkbma1.fsf@gitster.mtv.corp.google.com>
        <CACsJy8AM+dr_in_hW3y6APUo-cKsg+3sAZg9-7+02ZspSZcf=g@mail.gmail.com>
Date:   Tue, 22 Aug 2017 08:58:16 -0700
In-Reply-To: <CACsJy8AM+dr_in_hW3y6APUo-cKsg+3sAZg9-7+02ZspSZcf=g@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 22 Aug 2017 15:49:12 +0700")
Message-ID: <xmqqa82r4msn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B65EF492-8752-11E7-83D6-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Aug 19, 2017 at 4:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> [Discarded]
>>
>> * nd/prune-in-worktree (2017-04-24) 12 commits
>>  . rev-list: expose and document --single-worktree
>>  . revision.c: --reflog add HEAD reflog from all worktrees
>>  . files-backend: make reflog iterator go through per-worktree reflog
>>  . revision.c: --all adds HEAD from all worktrees
>>  . refs: remove dead for_each_*_submodule()
>>  . revision.c: use refs_for_each*() instead of for_each_*_submodule()
>>  . refs: add refs_head_ref()
>>  . refs: move submodule slash stripping code to get_submodule_ref_store
>>  . refs.c: refactor get_submodule_ref_store(), share common free block
>>  . revision.c: --indexed-objects add objects from all worktrees
>>  . revision.c: refactor add_index_objects_to_pending()
>>  . revision.h: new flag in struct rev_info wrt. worktree-related refs
>>
>>  "git gc" and friends when multiple worktrees are used off of a
>>  single repository did not consider the index and per-worktree refs
>>  of other worktrees as the root for reachability traversal, making
>>  objects that are in use only in other worktrees to be subject to
>>  garbage collection.
>
> I'm back and will try to continue this. Is it discarded because of
> lack of progress, or because the problem is already fixed some other
> way? A quick "git log --oneline" on important files has not revealed
> anything.

Welcome back. 

I ejected it out of 'pu' due to inactivity and possibly because I
saw some conflicts with topics that were making progress back then.
I do not offhand know if the old one still merges cleanly to 'pu',
but it certainly wasn't because the topic was deemed unnecessary.

Thanks.


