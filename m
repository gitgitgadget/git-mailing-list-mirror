Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9399CC433FE
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7004961A03
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 18:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376494AbhITSMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 14:12:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57006 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350078AbhITSKi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 14:10:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 717B7147F82;
        Mon, 20 Sep 2021 14:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ufx9Li3ReaabHdkzFbu1L/OyhJqOFDJ6LtsQ4c
        o10sw=; b=KVLSoAURuE3G4CQQkMVxQxy+Acad9roJRMp8LCDYRGwW3GPGd7uCYx
        iGvHb36sbwsfCN2uz4ozbGMJPQzcOrR1+fKp38eEzokdhl0XNj6M9VWqPF89YlgB
        BTpD4TSMhEDiTOxacOQB7JdaSC7tCykeSoPs3pPa/ZNdg4SjWr+Bc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68DC9147F81;
        Mon, 20 Sep 2021 14:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CD4C8147F7E;
        Mon, 20 Sep 2021 14:09:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v2 1/1] submodule--helper: fix incorrect newlines in an
 error message
References: <20210805192803.679948-1-kaartic.sivaraam@gmail.com>
        <20210918193116.310575-1-kaartic.sivaraam@gmail.com>
        <20210918193116.310575-2-kaartic.sivaraam@gmail.com>
Date:   Mon, 20 Sep 2021 11:09:05 -0700
In-Reply-To: <20210918193116.310575-2-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Sun, 19 Sep 2021 01:01:16 +0530")
Message-ID: <xmqqzgs7azlq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D875C5E2-1A3D-11EC-9FAC-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> A refactoring[1] done as part of the recent conversion of
> 'git submodule add' to builtin, changed the error message
> shown when a Git directory already exists locally for a submodule
> name. Before the refactoring, the error used to appear like so:
> ...
> As one could observe the remote information is printed along with the
> first line rather than on its own line. Also, there's an additional
> newline following output.
>
> Make the error message consistent with the error message that used to be
> printed before the refactoring.

Makes sense.  Atharva, an ack?
