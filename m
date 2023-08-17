Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB160C2FC04
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 00:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347339AbjHQAlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 20:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347358AbjHQAln (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 20:41:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8451B4
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 17:41:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05B9D2FCDF;
        Wed, 16 Aug 2023 20:41:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=up6erpUppMhM/UecmzQNcHJAjjVsZwZr9BaNS1
        /dTx4=; b=XCaJklDSUV1ur6qEIMgs7GFzJpg28+cGVbzh5WzgnaRvqWZCW2zWVT
        r9yqQC9zKQ6nBk/TLRzYEXvSUcDo79gtEs7od0X8BNspXokn9/R5AzjwigxEkscv
        FxfzKfQZbLHhawJDi1s1ZpZ5FwQXTzRzZBUMEHhRCzYAzXlxfAm3c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1AC62FCDE;
        Wed, 16 Aug 2023 20:41:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 171E82FCDD;
        Wed, 16 Aug 2023 20:41:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, linusa@google.com, calvinwan@google.com,
        phillip.wood123@gmail.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 2/3] unit tests: add TAP unit test framework
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
        <cover.1692229626.git.steadmon@google.com>
        <ca284c575ece0aee7149641d5fb1977ccd7e7873.1692229626.git.steadmon@google.com>
        <xmqqpm3mcyrc.fsf@gitster.g>
Date:   Wed, 16 Aug 2023 17:41:36 -0700
In-Reply-To: <xmqqpm3mcyrc.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        16 Aug 2023 17:12:55 -0700")
Message-ID: <xmqqleeacxfj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D331C202-3C96-11EE-AC3C-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>> diff --git a/Makefile b/Makefile
>> index e440728c24..4016da6e39 100644
>>
>> --- a/Makefile
>> +++ b/Makefile
>
> With that blank line, I seem to be getting
>
>     Applying: unit tests: add TAP unit test framework
>     error: patch with only garbage at line 3
>     Patch failed at 0002 unit tests: add TAP unit test framework	
>
> And with that blank line removed, I seem to then get
>
>     Applying: unit tests: add TAP unit test framework
>     error: patch failed: Makefile:682
>     error: Makefile: patch does not apply
>     error: patch failed: t/Makefile:41
>     error: t/Makefile: patch does not apply
>
> This is on top of "The fifth batch", the commit your cover letter
> refers to as the base of the series, so I am puzzled...

Well, I suspected that 2/3 comes from
https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/
which itself is whitespace damaged but has a reference to the
unit-tests branch of https://github.com/phillipwood/git repository.

But it seems to be different in subtle ways.

Please send a set of patches that can be applied cleanly (especially
when it is not an RFC series).

Thanks.
