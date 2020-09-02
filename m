Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CB2C433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 16:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A0020767
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 16:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ITw0rTMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgIBQqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:46:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51926 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgIBQqA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 12:46:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8C8E7DE18;
        Wed,  2 Sep 2020 12:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q2/DkFqLjL3UGPNfvgG4AD9trgE=; b=ITw0rT
        MIaFvQxFyk5hG/kITCiTnaKbaDl8ofrayPSnWrFdqQHnpwolRe9EPzwD6ykv2XJq
        v7UQ71TNT6ssJsxzhg7H4PxZrgNLZwCNfnlhhUcKw6tmHCO99gUfNkNS2nLb/UbS
        j6fmmoeocX08b62aIHA8aBu30bMy2dnL3Al08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ICzA7pvS0ip1olf86aJkjwxeoq42y/+J
        RI5sTiK+WJYfO/6BTQxKF4nCuL6XWPfPQ4pPbidB3f6/vQb7Y/SN666l8uWmZZQ0
        X79S5BQGfyV/dSJ226DR6pCvXVt3yhK9SzL5MwxilONI1jxTJnYomrTpryl+tru5
        7/rhwhBTNpI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0D937DE17;
        Wed,  2 Sep 2020 12:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 538227DE16;
        Wed,  2 Sep 2020 12:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2020, #01; Tue, 1)
References: <xmqqblipchk6.fsf@gitster.c.googlers.com>
        <CAPig+cTUhLoPvs+ygnc0Y4Ez3M3tfGncPzON0ejb=xEOMBixHQ@mail.gmail.com>
Date:   Wed, 02 Sep 2020 09:45:57 -0700
In-Reply-To: <CAPig+cTUhLoPvs+ygnc0Y4Ez3M3tfGncPzON0ejb=xEOMBixHQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 1 Sep 2020 17:43:54 -0400")
Message-ID: <xmqq7dtcceka.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6DEF1E4-ED3B-11EA-A3D6-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Sep 1, 2020 at 5:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * jc/run-command-use-embedded-args (2020-08-26) 1 commit
>>  Various callers of run_command API has been modernized.
>
> s/has/have/
>
>> * es/worktree-repair (2020-08-31) 5 commits
>>   (merged to 'next' on 2020-08-31 at 604825c5e4)
>>  + init: make --separate-git-dir work from within linked worktree
>>  + init: teach --separate-git-dir to repair linked worktrees
>>  + worktree: teach "repair" to fix outgoing links to worktrees
>>  + worktree: teach "repair" to fix worktree back-links to main worktree
>>  + worktree: add skeleton "repair" command
>>
>>  "git worktree repair" command to correct on-disk pointers between
>>  the repository and its secondary working trees.
>
> I wonder if this could be reworded so it's clearer that "git worktree
> repair" is a new command, and to mention fixes to "git init
> --separate-git-dir". Perhaps like this?
>
>     "git worktree" gained a "repair" subcommand to help users recover
>     from problems arising from factors outside of Git's control.
>     Also, "git init --separate-git-dir" no longer corrupts
>     administrative data related to linked worktrees.

OK that reads much better.

-from problems arising from factors outside of Git's control.
+after moving the worktrees manually without telling Git.

The latter is slightly shorter; does the "repair" help situations
other than that, or is the above cover all the "factors outside" out
control?

Thanks.
