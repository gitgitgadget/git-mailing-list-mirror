Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B67BEE3F0F
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 19:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbjILTe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbjILTeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 15:34:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8611B2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 12:34:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 967CA337F7;
        Tue, 12 Sep 2023 15:34:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=bAFObheUc65b0Q+YF1L7KUyjL9VqBY1wEgcoZK
        hR7Zw=; b=cLgDBnug6xptbunXN3yRhb2CP+dmka1BKjT7tjpgeA9MzfF6WKZNOb
        gFqN7hmm/DiSZXxvtb2v94FkiOVbrNzEFCLshsIqLzF5i+l9QDqtF44elw47EHRJ
        eVDHO/lIYbt6LIQV8QlYooQJNQnTsX+atKB2wFjAW8VpS7M5o9iqQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F25B337F6;
        Tue, 12 Sep 2023 15:34:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C345337F5;
        Tue, 12 Sep 2023 15:34:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2023, #04; Tue, 12)
In-Reply-To: <12c956ea-330d-4441-937f-7885ab519e26@gmail.com> (Phillip Wood's
        message of "Tue, 12 Sep 2023 19:30:41 +0100")
References: <xmqqpm2npbwy.fsf@gitster.g>
        <12c956ea-330d-4441-937f-7885ab519e26@gmail.com>
Date:   Tue, 12 Sep 2023 12:34:16 -0700
Message-ID: <xmqqy1hbmbif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D43D824-51A3-11EE-A2A1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 12/09/2023 17:57, Junio C Hamano wrote:
>> * pw/rebase-sigint (2023-09-07) 1 commit
>>   - rebase -i: ignore signals when forking subprocesses
>>   If the commit log editor or other external programs (spawned via
>>   "exec" insn in the todo list) receive internactive signal during
>>   "git rebase -i", it caused not just the spawned program but the
>>   "Git" process that spawned them, which is often not what the end
>>   user intended.  "git" learned to ignore SIGINT and SIGQUIT while
>>   waiting for these subprocesses.
>>   Will merge to 'next'?
>>   source: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
>
> This needs a re-roll to stop it ignoring signals in the child
> c.f. <376d3ea0-a3eb-4b25-8bf2-ca40c4699e26@gmail.com>

Yeah, you're right.

Thanks.
