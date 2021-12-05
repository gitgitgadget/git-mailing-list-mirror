Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4883C433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 18:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbhLES0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 13:26:42 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64824 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhLES0l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 13:26:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48F1417682E;
        Sun,  5 Dec 2021 13:23:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UN85Hn+o18VXVVxFRPZE2AoE+g8TGqcicUZG4x
        iW/5U=; b=hfm2ZliDOMciZHl+kFWWK9FJhCZDRR0kIsjN7BvhaiT1mR1bEdD5YI
        pfkPOFc/DW+qNaXrNmP88OxF6leyNVbxbh2s9fkb98G645kSaNTHByEIuCPxsRHQ
        pdQk7kwKuhaC7xF8g1NVk073GndLhPsGw4QNK+k7DpHu+a3a1Sve0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4265917682D;
        Sun,  5 Dec 2021 13:23:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4EC0017682C;
        Sun,  5 Dec 2021 13:23:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/2] tmp-objdir: disable ref updates when replacing the
 primary odb
References: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
        <d8ae001500c788cdabf4e6918da0a7ce89a48fc6.1638585658.git.gitgitgadget@gmail.com>
Date:   Sun, 05 Dec 2021 10:23:08 -0800
In-Reply-To: <d8ae001500c788cdabf4e6918da0a7ce89a48fc6.1638585658.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Sat, 04 Dec 2021 02:40:58
        +0000")
Message-ID: <xmqqtufmlxmb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 669BBBD8-55F8-11EC-BC01-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	/*
>  	 * This object store is ephemeral, so there is no need to fsync.
>  	 */
> -	int will_destroy;
> +	unsigned int will_destroy : 1;

<CANQDOddCC7+gGUy1VBxxwvN7ieP+N8mQhbxK2xx6ySqZc6U7-g@mail.gmail.com>
?

(https://github.com/git/git/pull/1076#discussion_r750645345)
