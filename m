Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999CBC0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 19:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjHITLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjHITLh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 15:11:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBB12123
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 12:11:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 635A022880;
        Wed,  9 Aug 2023 15:11:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=quvdrqpA9MRBMa6fhYEI0Uh16MRG4e0jaiJWrr
        2B++U=; b=KENiM/XFlxcT11nGli5Xrt5KJH4pczgQUba0bflh5PcXY0kE3+q7jU
        ZtgDPjooMF/aCgZ7jVIA7imYRJ72MJgO4KZ6atfRF4dErE6YIY3YqIRUUdsuZa8p
        YfyIwJ3WcV4Z7Mwj5mYhyPyNETrN0esHqHS7ANZHTtt2RtJmiRNTI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B8712287F;
        Wed,  9 Aug 2023 15:11:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC7932287E;
        Wed,  9 Aug 2023 15:11:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, git@vger.kernel.org
Subject: Re: git send-email -v
References: <20230809170028.GKZNPGLM93GYB+7Ej9@fat_crate.local>
        <CA+P7+xrGBNO-JNfHvbVUV9AgY_Q8PgYSr5EVycGzC5+ZB7Cv3A@mail.gmail.com>
Date:   Wed, 09 Aug 2023 12:11:31 -0700
In-Reply-To: <CA+P7+xrGBNO-JNfHvbVUV9AgY_Q8PgYSr5EVycGzC5+ZB7Cv3A@mail.gmail.com>
        (Jacob Keller's message of "Wed, 9 Aug 2023 10:42:54 -0700")
Message-ID: <xmqqv8dom3oc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D8797D0-36E8-11EE-8CC1-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> In short: this is working as intended, but it is somewhat confusing
> that it doesn't validate the argument at all. It is intentional to
> allow non-numeric strings, but maybe we ought to validate that it
> doesn't start with -- to avoid such confusion here.

I think both of your points are quite reasonable here.
