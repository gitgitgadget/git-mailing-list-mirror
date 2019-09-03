Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6B81F461
	for <e@80x24.org>; Tue,  3 Sep 2019 19:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfICTIR (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 15:08:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64078 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfICTIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 15:08:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BDCC7EBEA;
        Tue,  3 Sep 2019 15:08:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cC6hDLlsv80Xu4ioUxLhZEtwn80=; b=D6nLlG
        s548xJfIfwzPG/0FK9ZciGuI4mwyJ4Vug/0GTK1SxqvTcysJNXjFscLiXxvpgfWF
        1ZZr/rlq1osq0AglU8Gem2mUxxRo1+eHhzZeJOQ1H6fu3O+L4GN4LBUOJjlmkkYH
        hgrGpBgtuTkW9OpNNd1VMVeCuSLYuRWRU5O+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p8IeZcENtoq2NMcwiOaD3D7TlMYccCV/
        6HioobONg+64q9n0YYNVvYuqwXj2cgaCQQotfz+eocpM9cqrtYn3a8qxx2NjMb2i
        JWzeoh9Ov0Erzdqzfkp5QVcK3wvb6PDR2GVZVsP+6ccwmY2ZBwflkW5Y5dmEoxJr
        JV9+5QpvWp0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84F5E7EBE9;
        Tue,  3 Sep 2019 15:08:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BA3497EBE8;
        Tue,  3 Sep 2019 15:08:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Git does not recognise directory named '${sys:DATA_ROOT_DIR}'
References: <CAHMHMxW4-6AZEDaJU8KOy2kRSLXjdC_RTH528=nnhVLXh=ADUA@mail.gmail.com>
        <20190903133422.GA51158@syl.lan>
Date:   Tue, 03 Sep 2019 12:08:09 -0700
In-Reply-To: <20190903133422.GA51158@syl.lan> (Taylor Blau's message of "Tue,
        3 Sep 2019 09:34:22 -0400")
Message-ID: <xmqqa7bltcyu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C688FC6-CE7E-11E9-BFFC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> If you wish to keep this directory "empty", but stored in Git, a common
> convention is to create an empty '.gitkeep' file in the directory. This
> file is not special in any way to Git, rather it serves as _a_ file to
> keep the directory non-empty.

Hmph, I thought the common convention was to create a ".gitignore"
file in the directory with catch-all pattern, so that no matter what
cruft you had there "git add" will not add anything from it, if you
wish to keep this directory "empty".
