Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC2F5211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 06:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeK2RSm (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 12:18:42 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64744 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeK2RSl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 12:18:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2AD353C577;
        Thu, 29 Nov 2018 01:14:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=120IBmELCGhfck3rhr+8m2HDrSE=; b=tqUvxO
        abFKzbTO0u+bNVn02dcEjh2T3Ay/65qDxic6HrPgLU/JFD9fLiPepIUTar5EnXwg
        fBz+6PXCgU8Y2qA6ZuuVmnK/f5qAEmod58ddpDEvSa9S5kOo1JdeY9tUl2YsQ86H
        RgcdPBt/En43oYKMqsv1PMUYObh+j0ZBD56Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XYXuYe85apeGXBx0zuth+dam2rCZWWMN
        q3TWOmVTzm0AxgCZPjNIW5wRC4Rpn6DQu5wcL+tZUViGP+tgptkN01N+UlIJcDmY
        MXDhU9ksfT1H7270v6QfzA0hi/FCmGL0OyRr1aEQxqKU7W4wT5LKH7bqtkIwlvXL
        CX9Q8KCaJPc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23CDF3C575;
        Thu, 29 Nov 2018 01:14:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 362183C572;
        Thu, 29 Nov 2018 01:14:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     pclouds@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        t.gummerer@gmail.com
Subject: Re: [PATCH/RFC v2 0/7] Introduce new commands switch-branch and checkout-files
References: <20181120174554.GA29910@duynguyen.home>
        <20181127165211.24763-1-pclouds@gmail.com>
        <CACsJy8D2gxPj4u0_eEg-_x-Z3S3+5FdTU6Su4VQM113nQq=PYg@mail.gmail.com>
        <CAPL8Ziuj7Ffmdvz6NZWSJ+vzAtxFQhO1cfY2wmXm16J_8sY5fw@mail.gmail.com>
        <CAPL8ZivFJXQw=yLXjOPxsjabwN5XAP_qe0LK3sODO4NkgCjZag@mail.gmail.com>
Date:   Thu, 29 Nov 2018 15:14:23 +0900
In-Reply-To: <CAPL8ZivFJXQw=yLXjOPxsjabwN5XAP_qe0LK3sODO4NkgCjZag@mail.gmail.com>
        (Stefan Xenos's message of "Wed, 28 Nov 2018 14:53:39 -0800")
Message-ID: <xmqqwoowo1fk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0532858A-F39E-11E8-8B16-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos <sxenos@google.com> writes:

> So - IMO - detaching should always be an explicit action. Some options
> that occur to me:
>
> git switch-branch --detach

That is the most obvious way to spell it, and it is why we have "git
checkout --detach".  If we were to split one half of "checkout" into
"switch-branch", I would support the idea to make switch-branch only
take a branch name and nothing else, allow it to take any commit-ish
to detach the HEAD at that commit in the history graph with the
--detach option".  I also do not think anybody minds explaining the
resulting state to be "on an unnamed branch" (or is it "the" unnamed
branch?  Given that HEAD@{} reflog is a singleton, perhaps the right
mental model is that there is only one unnamed branch per worktree).

> git detach

The detached HEAD state is not all that special to deserve a
separate command.  After all, all history growing commands like
"commit", "cherry-pick", "rebase", "merge", etc. work the same way
on the unnamed branch.

> git switch-branch HEAD

I do not think this one is acceptable.  "git checkout HEAD" does not
detach but works as if you said "git checkout master" (when on the
'master' branch).  And you do not want "git switch-branch HEAD^0" to
be that explicit way to tell Git to detach the HEAD as that will
take us back to square one ("git checkout HEAD^0" is the more
concise and time-honored way to say "git checkout --detach HEAD").
