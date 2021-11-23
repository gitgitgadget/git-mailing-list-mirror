Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC96C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 21:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhKWWAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 17:00:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50563 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbhKWWAq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 17:00:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98081F2BC0;
        Tue, 23 Nov 2021 16:57:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+wAE77gd2TsIivfKv7K2oBGPXPiKV0lDp00E/i
        iPFC8=; b=L9V7ftQC0TfFZDnVNmQXd5rdUwZJ7H892ImikChTVa9P8uIBLWpbUO
        Ho/HARdupFsgyRjszn/nGvTpp4efudcqOgovaYhhZLN+YaCsjOoN+vNv5ZhliPJ/
        6yLvLSIeVz/gZRyiFM4lwK9eciJ/WeR4c4nPNqqr9hfjIzUN4HDCs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FD4AF2BBF;
        Tue, 23 Nov 2021 16:57:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07E8BF2BBE;
        Tue, 23 Nov 2021 16:57:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
        <20211123003958.3978-1-chooglen@google.com>
        <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
        <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
        <kl6lzgputxxw.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 23 Nov 2021 13:57:34 -0800
In-Reply-To: <kl6lzgputxxw.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 23 Nov 2021 12:32:43 -0800")
Message-ID: <xmqqv90i7cxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E369F16-4CA8-11EC-BC97-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> This doesn't sound like a typical definition of 'emptiness' to me, but I
> can accept it if others also find it compelling. IOW if your definition
> of 'emptiness' is compelling enough, then I'll be convinced that there
> is no mixing of concerns and there would be no objection.

FWIW, I do not find it compelling.  I can grant that it might be
convenient, but I do not think it is a good idea to explain the
reason why the directory is protected is because it is "not empty".

