Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDC4C43332
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B0F23121
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbhAZFFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:05:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50837 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731915AbhAZCE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 21:04:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3261B93F98;
        Mon, 25 Jan 2021 20:58:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=JjTD2cfZi3MG/hJgft/hZzKFak4=; b=Yaf7+XzYrHEKD+iIsgi3
        ejGHpN++bh2zvTX7/A0FjcvErIaQhLAeO2LbNP4rwZpB6n0t1+kYhVV4Dnwm3RPx
        uxXG0fSrKYQbGNurcb+rvvwpxvbFK9yatjxVKcQfyI7ky36SVF1Mf/aSja3pxAK9
        +mIqHNiJ+zpOmJMCg4SHaDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=YW5fEL/pYt4W4U/AqbzenFzzKKOeKclVrVfjZeTdkny9qq
        raHrVyFaBneYOAZKJhYsLV/giEzxI67ogtLQ8SBjFnmeTYUJOjH0lwVnG/n1O72m
        XvXuB8Oq0O4Yvmmv7NtEfkHNc4KDWB1DOz9sQmHCIaABmj3vCbcCySv4jCCIg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29EDE93F97;
        Mon, 25 Jan 2021 20:58:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7EF393F96;
        Mon, 25 Jan 2021 20:58:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Finish converting git bisect to C part 3
References: <20210123154056.48234-1-mirucam@gmail.com>
Date:   Mon, 25 Jan 2021 17:58:37 -0800
Message-ID: <xmqq8s8gwjaq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01471E6E-5F7A-11EB-A811-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> These patches correspond to a third part of patch series 
> of Outreachy project "Finish converting `git bisect` from shell to C" 
> started by Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by me.
>
> This third part is formed by reimplementations of some `git bisect` 
> subcommands and removal of some temporary subcommands.
>
> These patch series emails were generated from:
> https://gitlab.com/mirucam/git/commits/git-bisect-work-part3_v2.

Unfortunately, with this series in the 'seen' branch, the CI jobs
seem to fail.

cf.
https://github.com/git/git/runs/1766239699?check_suite_focus=true#step:5:814
