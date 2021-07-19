Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746AEC07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C4160E0C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348645AbhGSQUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:20:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65169 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352527AbhGSQOT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:14:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9222C147C54;
        Mon, 19 Jul 2021 12:54:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uyGv4i1aGAkEgONgq+IAY9gdDV2vqOkfJOxpSi
        ZB3vw=; b=fPP6D2/b9zPUbCDQXf80+9vonbo/E9SCyNCmmVUZBBDRnRb9eEYMxy
        DWGxNg/NxEPtXX6bW+w1iIVU14AJcxE28c+LQq+huDdoZPZfvhLc9iJFTv9CG8hP
        z6TU0mPl0zERw5JKNnlsCnrF1McH2v9B5Rt2kq95OYt9LaU6FwvbQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A370147C53;
        Mon, 19 Jul 2021 12:54:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA864147C51;
        Mon, 19 Jul 2021 12:54:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: When are you going to stop ignoring pull.mode?
References: <60f1daa896f69_330208b1@natae.notmuch>
        <c54fa084-75f4-b775-8ac2-6df3c7a36571@aixigo.com>
        <xmqqwnpooctj.fsf@gitster.g>
        <948ef19f-5588-62e9-6fc7-aa6d82f21a1b@aixigo.com>
Date:   Mon, 19 Jul 2021 09:54:53 -0700
In-Reply-To: <948ef19f-5588-62e9-6fc7-aa6d82f21a1b@aixigo.com> (Matthias
        Baumgarten's message of "Mon, 19 Jul 2021 16:14:14 +0200")
Message-ID: <xmqq4kcqnt0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0ADE8AC2-E8B2-11EB-B852-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Baumgarten <matthias.baumgarten@aixigo.com> writes:

> Initially I came from the situation where I (as maintainer of a
> repository) proposed to do a `git pull --ff-only <remote-git-url> 
> <branch-name>` for the others to integrate the newest changes safely
> (i.e. failing if they had errouneously worked on that branch, which it 
> is not intended for). I thought I could reach that safety with the
> `--ff-only` part, but it seems one of the devs had pull.rebase set for 
> him locally and thus managed to bypass my "safety". Mr. Elijah Newren
> called this a bug, see [1].

Yes, I saw it and I agree with Elijah.

Thanks.
