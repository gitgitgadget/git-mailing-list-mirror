Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7C1EE021C
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 03:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjINDQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 23:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjINDQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 23:16:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA131BE2
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 20:16:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75E401EE50;
        Wed, 13 Sep 2023 23:16:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=LDyb2U7VRLlSo8UMcjzVgnPyJfhkXyeH/Zp+FJ
        2UIDE=; b=kQeuuM6p3xoGxdXxz5eT2DDE4UnIzjfyuJRYdODcN89bwJf2lxkpl7
        W6dcv6P0GDf7L0cjE+vXKxhOw134mVUiARlst/9j5KITRF3NHbqVqlv+YoSelezg
        Ih+RvOBis4c0Jyu3w3/H8qX3LmjtmnyMZnkpIG7bbDtpRGAerrT+k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F0841EE4F;
        Wed, 13 Sep 2023 23:16:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05B9D1EE4E;
        Wed, 13 Sep 2023 23:16:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/6] trailer: rename *_DEFAULT enums to *_UNSPECIFIED
In-Reply-To: <owlyzg1pjx2f.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Wed, 13 Sep 2023 19:41:28 -0700")
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <52958c3557c34992df59e9c10f098f457526702c.1694240177.git.gitgitgadget@gmail.com>
        <xmqqr0n4v8ul.fsf@gitster.g> <owlyzg1pjx2f.fsf@fine.c.googlers.com>
Date:   Wed, 13 Sep 2023 20:16:21 -0700
Message-ID: <xmqq1qf1la0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15032320-52AD-11EE-89B8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>> It gets tempting to initialize a variable to the default and arrange
>> the rest of the system so that the variable set to the default
>> triggers the default activity.  Such an obvious solution however
>> cannot be used when (1) being left unspecified to use the default
>> value and (2) explicitly set by the user to a value that happens to
>> be the same as the default have to behave differently.  I am not
>> sure if that applies to the trailers system, though.
>>
>> Thanks.
>
> I get the feeling that you wrote the "Such an obvious ... differently"
> sentence after writing the last sentence in that paragraph, because when
> you say
>
>     I am not
>     sure if that applies to the trailers system, though.
>
> I read the "that" (emphasis added) in there as referring to the solution
> described in the first sentence, and not the conditions (1) and (2) you
> enumerated. IOW, you are OK with this patch.

"that" refers to "the reason not to use such an obvious solution".
I do not know if trailer subsystem wants to treat "left unspecified"
and "set to the value that happens to be the same as the default" in
a different way.  If it does want to do so, then I do not see a
strong reason not to use the "obvious solution".

Thanks.
