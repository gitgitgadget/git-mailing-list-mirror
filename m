Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7FCCD342F
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 01:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjISBQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 21:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISBQX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 21:16:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46220107
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 18:16:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63A5D1C1241;
        Mon, 18 Sep 2023 21:16:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=9Ak5hJB324nwLQJHngC79N0aUCWqTlc27j9KPk
        H82TU=; b=PwIqY7Z8xVPAGWfjUOhUHNRSQxZv6JHfsmmYu/vwrp0ATErSDnfLBN
        V40qKZc3ij97Z9ymQiqaxD3CJMNvZJ3axPmbaaSbAcelzn3O7S6ztY1YFpEng8HH
        dnnX3txM+PHMLlSfPoFGDcqPFK3CShFUJ3viXhYGvGspR+0y6LElw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C5ED1C1240;
        Mon, 18 Sep 2023 21:16:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C129D1C123F;
        Mon, 18 Sep 2023 21:16:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, "Denton Liu" <liu.denton@gmail.com>,
        "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v3 1/1] range-diff: treat notes like `log`
In-Reply-To: <c7d1e196-9521-45a7-b41c-80499f19f546@app.fastmail.com>
        (Kristoffer Haugsbakk's message of "Thu, 14 Sep 2023 22:25:37 +0200")
References: <cover.1693584310.git.code@khaugsbakk.name>
        <cover.1694383247.git.code@khaugsbakk.name>
        <a37dfb3748e23b4f5081bc9a3c80a5c546101f1d.1694383248.git.code@khaugsbakk.name>
        <xmqqzg1strgx.fsf@gitster.g>
        <dd2958c5-58bf-86dd-b666-9033259a8e1a@gmx.de>
        <c7d1e196-9521-45a7-b41c-80499f19f546@app.fastmail.com>
Date:   Mon, 18 Sep 2023 18:16:14 -0700
Message-ID: <xmqqled3hsip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 213B634C-568A-11EE-BACA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Thu, Sep 14, 2023, at 10:29, Johannes Schindelin wrote:
>>> [...]
>>
>> Right, `-G --notes` is a good argument to rethink this.
>>
>> A much more surgical way to address the issue at hand might be this
>> (Kristoffer, what do you think? It's missing documentation for the
>> newly-introduced `--show-notes-by-default` option, but you get the idea):
>
> Looks good to me. It seems like an explicit argument is the only way to
> make this work.

Will one of you tie the loose ends?

Thanks.
