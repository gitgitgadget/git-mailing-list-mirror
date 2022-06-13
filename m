Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD2C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 19:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbiFMTzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348641AbiFMTzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 15:55:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34D09E9D0
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 11:26:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67668197387;
        Mon, 13 Jun 2022 14:26:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ztaY6cPYaqfPtgGBlMn9uuC+B4iTE/p001fWoB
        JiJ0E=; b=BOoT97gNsVIbTKqTRbPNHYpIMTmqXlSvAd7ibXR73YKPE6SrRF6KMy
        n2CjJRm98r7Ele2wY5VWd7TS7MEKkC6q5PyuqWgaTXr/jSRN4y88eA/wyWlSO0O4
        C5cE6OG65sS48p+tykVuOd38cmFWGyKD1YRakgxxF0qSxVbt2Z54Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5AEDC197385;
        Mon, 13 Jun 2022 14:26:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 030C7197384;
        Mon, 13 Jun 2022 14:26:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/3] diff-format.txt: fix ancient copy-paste error
References: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
        <6eaf9b3829fa8f7300bc0123c916d5ffa7c7d80b.1655123383.git.gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 11:26:46 -0700
In-Reply-To: <6eaf9b3829fa8f7300bc0123c916d5ffa7c7d80b.1655123383.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Mon, 13 Jun 2022
        12:29:41 +0000")
Message-ID: <xmqq35g8772x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62D8F324-EB46-11EC-A52B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Fix what is probably a copy-paste error dating back all the way to
> b6d8f309d9 ([PATCH] diff-raw format update take #2., 2005-05-23).

I'll retitle and rewrite the message like so:

    diff-format.txt: dst can be 0* SHA-1 when path is deleted, too
    
    "dst" can legitimately be "0\{40\}" for a creation patch, e.g. when
    the stat information is stale, but it falls into "look at work tree"
    case.  The original description in b6d8f309 ([PATCH] diff-raw format
    update take #2., 2005-05-23) forgot that deletion also makes the
    "dst" 0* SHA-1.
    
    Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks.
