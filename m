Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1A2C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 20:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03F624125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 20:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="snu4Lipz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAUU3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:29:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53523 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgAUU3a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 15:29:30 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB31B36D17;
        Tue, 21 Jan 2020 15:29:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oM1mp25JLaCSwctGdYO2otwTivo=; b=snu4Li
        pz75ANUzAtCz39SKrH1NUSEYAjySnGn+TMeT4tekvMZT10Mp4QWaJZOi30dWXMXP
        zNDDiPTTGKW6ULyhGmuA/rUg1eap3SNRuZojKSjxXO8A0QasEoo4q1L+AKq2h8CS
        RGh5H2yVUocWF0HaXjaqL00FydPsd3ZMC/KVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wCJdbZ6e0gGDCYIMyTapgFlxSYR3aZXZ
        x3RWYRjEt3DB0x+iFKg4cRxEPSyP4FI4tC0djbErhA4I586KUGvO2OpO+IGVhIro
        QfbjYFX2YTIDcOETBuZNldn4dncQFOd1e60Aj2JUMYSnc+NmWlqrD1OjdXxurLhL
        RNOLmJPp5TE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2A7636D16;
        Tue, 21 Jan 2020 15:29:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0CAF836D15;
        Tue, 21 Jan 2020 15:29:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 5/8] doc: stash: document more options
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <8a5f2dbe9eef0d6fe360a8ac1130b854e73245bf.1579190965.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 12:29:26 -0800
In-Reply-To: <8a5f2dbe9eef0d6fe360a8ac1130b854e73245bf.1579190965.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Thu, 16 Jan 2020
        16:09:22 +0000")
Message-ID: <xmqq7e1ka6zd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8BD1E48-3C8C-11EA-B98D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +-q::
> +--quiet::
> +	Quiet, suppress feedback messages.
> +
> +\--::
> +	Separates pathspec from options for disambiguation purposes.
> +
>  <pathspec>...::
>  	The new stash entry records the modified states only for the files
>  	that match the pathspec.  The index entries and working tree files

OK.  Describing these in the documentation is a good thing.  How
they should be added depends on in what shape the patch 4/8 should
settle, though.

Thanks.
