Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE93CEE3F39
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 00:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbjIMAec (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 20:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjIMAec (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 20:34:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D5CE4B
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 17:34:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56AD5357AB;
        Tue, 12 Sep 2023 20:34:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=4OdpRaNsYaxEBRGEYAPPl//LqHZfptVIRY07Fi
        z6d6A=; b=qSk8iJo0TY/CAnZkJZ+RBWlFCz9GKNNlfS76njj5AfkSy6v1AfaClr
        x7UTb2pPjzwbnFGeLIIVmGj080amox6bVYW02U10qbpi14TKK20W+B7xeIdMqUFS
        OifrVCdxVy0spIxZaAPRpWcful+yrjX0jdFHT0CaBe0Gw201jlMBo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F456357AA;
        Tue, 12 Sep 2023 20:34:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E6198357A9;
        Tue, 12 Sep 2023 20:34:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 2/2] completion: commit: complete trailers tokens
 more robustly
In-Reply-To: <9cb33c20294e096f5345fb1ea9d80a23e899ae6f.1694539827.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Tue, 12 Sep 2023
        17:30:27 +0000")
References: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
        <pull.1583.v2.git.1694539827.gitgitgadget@gmail.com>
        <9cb33c20294e096f5345fb1ea9d80a23e899ae6f.1694539827.git.gitgitgadget@gmail.com>
Date:   Tue, 12 Sep 2023 17:34:23 -0700
Message-ID: <xmqqsf7ikj1s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A2B7FC4-51CD-11EE-939A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> In the previous commit, we added support for completing configured
> trailer tokens in 'git commit --trailer'.
>
> Make the implementation more robust by:
>
> - using '__git' instead of plain 'git', as the rest of the completion
>   script does
> - using a stricter pattern for --get-regexp to avoid false hits
> - using 'cut' and 'rev' instead of 'awk' to account for tokens including
>   dots.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---

Thanks, both, for a quick fix.

Queued.
