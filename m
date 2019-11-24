Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1D2C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 06:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B862071A
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 06:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DNSsJHlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfKXGFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 01:05:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50098 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfKXGFV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 01:05:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A1E12AF2A;
        Sun, 24 Nov 2019 01:05:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W7Fyj5IqLARddBR25gi0knOBi3I=; b=DNSsJH
        lUDzAxgvOMO1D5ZMx8TV0rXdLFWvI1OpJBtH+ZJF3K3g6Vex7ZrrR+tlFg8R/YKr
        huE22HGquiBl5U6d6haskjJSTtpnES/fbFHZekhFlKDLfZeO7CMkJQtG4O9G8833
        XP0iygIc0v6DdlTemZV7TQG17KTL1dyrXrlIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HNkRAXlzMWHjtyE4oXJehNpdNsr3fVlp
        7Su4XJDumUt09LDPlYeiY9VGl5QmQR1yAJQJl6sjlOZuD+x09rF4YbpGG+nY1TPi
        8TYo12jRJbCxqZ+yE0yicMg0P9BFI34McRlaITnYV8O+L87dXMb5MBRvmGc8Yi8/
        dWAMwaYL5iE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 816752AF28;
        Sun, 24 Nov 2019 01:05:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E44AE2AF27;
        Sun, 24 Nov 2019 01:05:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH v2] doc: mention that 'git submodule update' fetches missing commits
References: <0102016a2274c90f-3dbf792f-5b0a-4da4-ada0-9a163a14e68d-000000@eu-west-1.amazonses.com>
        <1574560895-60251-1-git-send-email-levraiphilippeblain@gmail.com>
Date:   Sun, 24 Nov 2019 15:05:17 +0900
In-Reply-To: <1574560895-60251-1-git-send-email-levraiphilippeblain@gmail.com>
        (Philippe Blain's message of "Sat, 23 Nov 2019 21:01:35 -0500")
Message-ID: <xmqqsgmdzu5e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 644B96B2-0E80-11EA-8D84-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> 'git submodule update' will fetch new commits from the submodule remote
> if the SHA-1 recorded in the superproject is not found. This was not
> mentioned in the documentation.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Changes since v1 [4]:
> - Added my signed-off, corrected my email address
>   and shortened the title of the commit message
>   (I had actually done that when I resent my patch in [1] using submitGit, 
>   but this dit not add the "v2" prefix)
> - Added Junio's suggestion [2] (which was applied in [3] on top of the original 
>   submission [4] instead of the revised one [1]), and squashed
> - Added Helped-by trailers
> - Rebased on v2.23.0 (as was done for [3])

Thanks, will replace.  This should be ready for 'next', I would
think.
