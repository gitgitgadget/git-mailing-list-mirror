Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A343C77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244779AbjEOTxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242842AbjEOTxe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:53:34 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B60E718
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:53:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C11B41F013A;
        Mon, 15 May 2023 15:53:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HFCkx1mhrP+9pcCZ3L9SfnBq/FXDnlGDautF5j
        a1/d8=; b=V/ut2o3mACSdjb/tzyke6xEk9jXc7jrfKff0wzEWoh3QEqLK290WY3
        aien6laYK2G/GSymkpmluXtMs/vhJ3EjG7xunA++aIuDDAQ+ROf0MwBqTXPiVKPf
        uyDGKicbz0TEhaXGeUMT9ve7WR6ojd3xInzVMVIHQY2ZBjC0XNINc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B92BE1F0139;
        Mon, 15 May 2023 15:53:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EF3E51F0137;
        Mon, 15 May 2023 15:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>
Subject: Re: [PATCH v3 4/6] ls-remote doc: show peeled tags in examples
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
        <dc0c5ba17511628b384d7c2d6d5eb43342017b5d.1684152793.git.gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 12:53:28 -0700
In-Reply-To: <dc0c5ba17511628b384d7c2d6d5eb43342017b5d.1684152793.git.gitgitgadget@gmail.com>
        (Sean Allred via GitGitGadget's message of "Mon, 15 May 2023 12:13:11
        +0000")
Message-ID: <xmqqlehp8j7r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A426762-F35A-11ED-8524-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Allred via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sean Allred <allred.sean@gmail.com>
>
> Without `--refs`, this command will show peeled tags. Make this clearer
> in the examples to further mitigate the possibility of surprises in
> consuming scripts.
>
> Signed-off-by: Sean Allred <allred.sean@gmail.com>
> ---
>  Documentation/git-ls-remote.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Nice attention to the detail.  Thanks.

> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index af71cf4a92d..aabc1a7b90b 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -106,10 +106,10 @@ c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
>  
>  $ git remote add korg http://www.kernel.org/pub/scm/git/git.git
>  $ git ls-remote --tags korg v\*
> -d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
> -f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
> -c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
> -7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
> +485a869c64a68cc5795dd99689797c5900f4716d	refs/tags/v2.39.2
> +cbf04937d5b9fcf0a76c28f69e6294e9e3ecd7e6	refs/tags/v2.39.2^{}
> +d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
> +73876f4861cd3d187a4682290ab75c9dccadbc56	refs/tags/v2.40.0^{}
>  ----
>  
>  SEE ALSO
