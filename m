Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D563EC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3BD61166
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhEFIjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 04:39:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53016 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhEFIjm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 04:39:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4705C06EF;
        Thu,  6 May 2021 04:38:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HWIqhRYSAMzhzl0hae/R52vuVNYFH+aZJinOLP
        NdszE=; b=KQnj1qZFqd0Hf7HSTYxLoayM98K2KWgQcEbffJlPRZ+oy7EKxS1VD0
        5BRNeTABhWEVwXol1YkVWB7HIzWCYnf5tH50phaPpY3PWH8J8t1WklTYvM6yRN9i
        QsKZ/sBJrk6in4OfiZwzdfYPQhm7KmBKskAxWVYp0XgpW0qRB6iaY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCE67C06ED;
        Thu,  6 May 2021 04:38:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45377C06EC;
        Thu,  6 May 2021 04:38:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri <yuri@rawbw.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
        <fff9baee-ac4e-66ea-1dfb-791a8b044527@kdbg.org>
        <e75f000b-e376-45d5-ee5a-2a555076a3d9@rawbw.com>
        <35877543-93b8-00f8-692e-09a06d4679aa@kdbg.org>
        <d4ae27b9-3911-506c-a23c-3ed91bb250d1@rawbw.com>
Date:   Thu, 06 May 2021 17:38:43 +0900
In-Reply-To: <d4ae27b9-3911-506c-a23c-3ed91bb250d1@rawbw.com>
        (yuri@rawbw.com's message of "Wed, 5 May 2021 23:58:16 -0700")
Message-ID: <xmqqbl9oz27g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77A246EA-AE46-11EB-8714-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri <yuri@rawbw.com> writes:

> On 5/5/21 11:43 PM, Johannes Sixt wrote:
>> I know. But, as I said, when you turn away from your current work, which
>> is precious, then you should make a commit, in particular, when you can
>> forsee that you might not be able to come back soon.
>
>
> How can I commit unfinished work? Commits are public, this would break
> things.

Unlike centralized SCM like SVN and CVS, commits in Git are private
until you make them public by pushing, and you do not allow other
people to fetch/pull from the repository you actively work in.  If
your commits become public immediately after you make them, perhaps
there is a room in your workflow for vast improvement.

