Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18C751F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 10:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403822AbfJWKFJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 06:05:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53365 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403994AbfJWKFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 06:05:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6BA63DBB2;
        Wed, 23 Oct 2019 06:05:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yzIYeyGDk6s9Dpq00/+sBEinW/o=; b=DwujBl
        8VwD40c3Fjkb1J2K4/lM2gnZm+iEIHXaPKLBsS0i/lJSA3eZDPRViBeQAEiP5t1Z
        +9Xa6KoHfdy/vs+B7N2n0nfKK6jtzTth6FY2BzjaOObHChrn/jvWJfLuNX/2aUa5
        32rIOL1hTzJwBLJR1QP+wsBKsqoSq7D6MI7SU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qalhxJDgPbTr4eXFqJ71rqaTjD/UiRr3
        bIgz4xpum2xQuQ2OmR8KVw2lVoQBik6MgA0DvDKC+ZBsGZGwAt0R+qyMI0mVMpE1
        Cvx/cSGKeolNj6jKeBh7HH6ARtd4wMICS9iM7aB8izKfzUIASGzjCLElplyRsoEn
        +GJF+Db+c+Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA8B43DBB0;
        Wed, 23 Oct 2019 06:05:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC3803DBAF;
        Wed, 23 Oct 2019 06:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/1] ci(osx): use new location of the `perforce` cask
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
        <pull.400.v3.git.1571789978.gitgitgadget@gmail.com>
        <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 19:05:04 +0900
In-Reply-To: <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 23 Oct 2019
        00:19:38 +0000")
Message-ID: <xmqqsgnjhj5b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9658F0CC-F57C-11E9-8C67-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The Azure Pipelines builds are failing for macOS due to a change in the
> location of the perforce cask. The command outputs the following error:
>
>     + brew install caskroom/cask/perforce
>     Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.
> ...
> In any case, as the error message at the top of this commit message
> shows, 'brew install caskroom/cask/perforce' has stopped working
> recently, but 'brew cask install perforce' still does, so let's use
> that.

It appears that OSX jobs at Travis are getting hit by this issue.
Here is what our failed build ends with, for example:

    +brew install caskroom/cask/perforce
    Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.

    cf. https://travis-ci.org/git/git/jobs/601697815

Today's 'pu' has this topic queued, and it seems to help even the
builds at Travis ('pu' seems to fail the test for totally different
reason, though):

    +brew link gcc@8
    Error: No such keg: /usr/local/Cellar/gcc@8

    cf. https://travis-ci.org/git/git/jobs/601697903

Thanks.
