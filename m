Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0366FCD4857
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 18:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjIYS6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 14:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjIYS6I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 14:58:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B046295
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 11:58:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 425F121FCB;
        Mon, 25 Sep 2023 14:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=MP2qk6i3WxYfG+5iNGDpbUERrJIWcmo6L58PEl
        wZSkQ=; b=kqinERC7ADEickb2ls54N6utJj6lo6M0YYZUPldgHkZ8pG3cWZcnAC
        eEGPjK8Gh95PvaHg9C79W3yv9Kvu4iHJnO5KWwWlvi51fuplLN1mtyVpsO0VQGCW
        DlcjEAWGjD+c45hdRneCDh5hVNqWe5JWVHTbaKQjTEfIZBLwycLVg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39DDF21FCA;
        Mon, 25 Sep 2023 14:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E09C321FC8;
        Mon, 25 Sep 2023 14:57:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     phillip.wood123@gmail.com
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        linusa@google.com, calvinwan@google.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 2/3] unit tests: add TAP unit test framework
In-Reply-To: <0b6de919-8dbf-454f-807b-5abb64388cb7@gmail.com> (phillip's
        message of "Sun, 24 Sep 2023 14:57:53 +0100")
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
        <cover.1692297001.git.steadmon@google.com>
        <3cc98d4045eeda6e8cc24914802edc16d367fba0.1692297001.git.steadmon@google.com>
        <xmqq350hw6n7.fsf@gitster.g> <xmqqa5te0y9r.fsf@gitster.g>
        <0b6de919-8dbf-454f-807b-5abb64388cb7@gmail.com>
Date:   Mon, 25 Sep 2023 11:57:57 -0700
Message-ID: <xmqqbkdqt70q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71BBB984-5BD5-11EE-998F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

phillip.wood123@gmail.com writes:

> When I was writing this I was torn between whether to follow our usual
> convention of returning zero for success and minus one for failure or
> to return one for success and zero for failure. In the end I decided
> to go with the former but I tend to agree with you that the latter
> would be easier to understand.

An understandable contention.

>>>> @@ -0,0 +1,2 @@
>>>> +/t-basic
>>>> +/t-strbuf
>>>
>>> Also, can we come up with some naming convention so that we do not
>>> have to keep adding to this file every time we add a new test
>>> script?
>
> Perhaps we should put the unit test binaries in a separate directory
> so we can just add that directory to .gitignore.

Yeah, if we can do that, that would help organizing these tests.

Thanks for working on this.

