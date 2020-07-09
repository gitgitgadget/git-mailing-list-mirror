Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB130C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732CB205CB
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bj3TkjMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgGICnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:43:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59676 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGICnC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:43:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E22617B22D;
        Wed,  8 Jul 2020 22:42:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wo8oz5UCZZQm5PD34TcX9un6BJ4=; b=bj3Tkj
        MNs8KGZC27TyrqPD8wwxd93pZPYm6O87A4ENYx6SKkB3YnQzO3A0msvyi88g/oGi
        tJXCKnOUQkiMs605DMwtA3y1QJf2q5ddXfRXBAyfke+7S/LB3rAbmfHvdB8pGu3M
        FOT+rPpKdz2Q2Z+AFrIHijCCFRZaUcWJvWoZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UkFYX8iZr5UJNH0XBdhb3uXMxNdhEfSk
        xBj/2HAbDfTdbpQAaRR/7YQxv0g5zG21rYObXieROpfFGwZnzJqOgaT7DgnFdGGe
        sJYqr9hI2Kb63Eyn397KZpOkefQEh8DbyNBS1mUqerJ7qx+ypsACH5CoJUrdVXQ7
        r1PIZrr6vVI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D92C07B22C;
        Wed,  8 Jul 2020 22:42:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C6927B22B;
        Wed,  8 Jul 2020 22:42:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v13] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com>
        <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com>
Date:   Wed, 08 Jul 2020 19:42:58 -0700
In-Reply-To: <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com>
        (sunlin via GitGitGadget's message of "Thu, 09 Jul 2020 00:35:06
        +0000")
Message-ID: <xmqqlfjtz9vx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6C7413E-C18D-11EA-A313-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"sunlin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lin Sun <lin.sun@zoom.us>
> Subject: Re: [PATCH v13] Support auto-merge for meld to follow the vim-diff behavior

I'd retitle to match the recommended structure, e.g.

    Subject: [PATCH] mergetool: update meld backend to allow using '--auto-merge'

while queuing.

Thanks.  I might have more comments later.
