Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9EFC433E9
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBB761601
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbhCASuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 13:50:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52252 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbhCASq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 13:46:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F5B3114197;
        Mon,  1 Mar 2021 13:45:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uO7epyhtO5i1KOEFEU5quoCZToQ=; b=lfrgHq
        fo4vI6ckHW/e1o23yTK8rzbV54IBxY4/83nC/L20k5HNThergq6cLFEiVrKvwyJf
        wo3qkGa7VoepT3BiQstbfA/PfgrijoYoZUqc0oCxxDYceqNk1U0DI0sKY5x5DsD/
        w49Zozs3RWNhi6C1Q7GlT2AehbQL6hG/znJJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZyazrJ6u+5oooUsGtzT+h6zh+uqpTK4I
        3/Ll7r0TuEv1+mrq6w7eMsILmkeLm32B1a9vvyWcwH+89Q50IT98CASB+r2vf7bs
        TKzjeRQHf1ZHowvl3l9krYb3OmtwyTy+gGpfu/fj6k5RHlQnvW9F7Eu413nez4he
        WJqGrnxFPOQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48FE1114196;
        Mon,  1 Mar 2021 13:45:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8BADF114194;
        Mon,  1 Mar 2021 13:45:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v3 0/6][Outreachy] commit: Implementation of "amend!"
 commit
References: <20210301084512.27170-1-charvi077@gmail.com>
Date:   Mon, 01 Mar 2021 10:45:38 -0800
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Mon, 1 Mar 2021 14:15:08 +0530")
Message-ID: <xmqq8s76r9v1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52C4BB0C-7ABE-11EB-841E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> This patch series teaches `git commit --fixup` to create "amend!" commit
> as an alternative that works with `git rebase --autosquash`. It allows to
> fixup both the content and the commit message of the specified commit.
> Here we add two suboptions to the `--fixup`, first `amend` suboption that
> creates an "amend!" commit. It takes the staged changes and also allows to
> edit the commit message of the commit we are fixing.
> Example usuage:
> git commit --fixup=amend:<commit>

I only had a few minor nits and I think with them fixed the series
becomes as good as it would get in the shorter term to be ready for
'next'.  We're almost there.

Thanks.

