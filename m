Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8956DC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 20:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhLUUsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 15:48:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57886 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLUUsT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 15:48:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA5BFF8ED7;
        Tue, 21 Dec 2021 15:48:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5phHirwmwJxdn7UU838h7ivk0xIBUGoNq0P7zD
        1Emzo=; b=eIPdM5XsprwYjwATWcn6fhgiFHwrRgUhSquw2653Nr2tAq3hlkBCkY
        QJJ2VS4jOmTkR7D4qqqVnVYJsVNvqt4qkADhPZr+2nekcm/jn5SHzwEHPKZgBzjI
        Fgz5JjhOQ/fECUUKrIY2s6rjWp76rviB56rx/lhAuYtAuQEf2DcTQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0D1FF8ED5;
        Tue, 21 Dec 2021 15:48:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56A83F8ED4;
        Tue, 21 Dec 2021 15:48:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>
Subject: Re: t5327 log expiry
References: <CAFQ2z_MckMjRG9bOHeaKfFDkqG5L0AAz2V-uUSwMKTdh3MicGA@mail.gmail.com>
Date:   Tue, 21 Dec 2021 12:48:17 -0800
In-Reply-To: <CAFQ2z_MckMjRG9bOHeaKfFDkqG5L0AAz2V-uUSwMKTdh3MicGA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 21 Dec 2021 18:27:36 +0100")
Message-ID: <xmqqa6gtptv2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 539C13D0-629F-11EC-9885-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> Hi Taylor,
>
> Your recent work on cruft packs breaks with reftable. I suggest the
> following change
>
> - rm -fr .git/logs &&
> + git reflog expire --all --expire=all &&
>
> to make the test independent of ref storage format.

Thanks.  I should have caught it when I read the patch.
