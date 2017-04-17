Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1BF01FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 07:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbdDQHM7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 03:12:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63348 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932719AbdDQHM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 03:12:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 853EF696AE;
        Mon, 17 Apr 2017 03:12:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BjuOXRbP8CD6WvHqlX8nkKM4BGU=; b=uhCpml
        iYL5Gwd8HbHB/HsrOGtOuGFoiuHsF7rxbNDUJxijTPTLAiri4LK4i1Xo9v0AUWUH
        eaekqSA+gQO7hx7lnPRRlxUbVx2aBD6YnOte2mVh4DvfNWZ42TJXHdj53iF2Dndx
        BE7Gjc5fsV+pbgtYfl1FD2bxsGw6A56EyeSSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vj0Y9Df4je4zN6Obi+Ud+36v7Qq7mNJL
        yMUiRxtHU85aK1ZDtdwxQVSuT92xYabnI73+as11nQXxpLJgS+PdsSd99Nq4JjzO
        nSM/ZKdg54xzmNsF7RpWvoQvOBtxQZzoLS3dxL4ZywAGw+62LiOR2xLonzGcf+lm
        U+SvfbO0EfE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E51C696AD;
        Mon, 17 Apr 2017 03:12:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA216696AC;
        Mon, 17 Apr 2017 03:12:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] rebase --signoff
References: <20170415144103.11986-1-giuseppe.bilotta@gmail.com>
Date:   Mon, 17 Apr 2017 00:12:54 -0700
In-Reply-To: <20170415144103.11986-1-giuseppe.bilotta@gmail.com> (Giuseppe
        Bilotta's message of "Sat, 15 Apr 2017 16:41:00 +0200")
Message-ID: <xmqqshl7ik21.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 479FDE96-233D-11E7-87B1-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Allow signing off a whole patchset by rebasing it with the --signoff
> option, which is simply passed through to git am.

>  Documentation/git-rebase.txt |  5 +++++
>  builtin/am.c                 | 39 +++++++++++++++++--------------------
>  git-rebase.sh                |  3 ++-
>  t/t3428-rebase-signoff.sh    | 46 ++++++++++++++++++++++++++++++++++++++++++++

Two questions.

 - Is it better to add a brand new test script than adding new tests
   to existing scripts that test "git rebase"?

 - How does this interact with "git rebase -i" and other modes of
   operation?

