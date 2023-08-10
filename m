Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D548C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 22:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjHJWnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 18:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHJWnG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 18:43:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1B626A0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 15:43:05 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 563EA2C80D;
        Thu, 10 Aug 2023 18:43:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6k/vw/xAVtFN7cbtIDM9Xc7hAAQiNvSR+9jtJb
        abwBA=; b=jSE+rDRpe+tx0kD9Dc7d0v7hRlIxdYg6kzX9OouNH1sWPUKot49Wga
        YX6kFZgzbqwtjD3rSQuG8wjupSDiJJ7dAmha56uIR4ELXHWZJVeDyW35OEkNVhvC
        90nkvJnvlMyQb2i2ZBtl/XH04pM7UqD5E6OXJnaB430bDqgKbCHng=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E9DB2C80C;
        Thu, 10 Aug 2023 18:43:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EDF5B2C809;
        Thu, 10 Aug 2023 18:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Subject: Re: [RFC PATCH v2 2/7] object: move function to object.c
References: <20230810163346.274132-1-calvinwan@google.com>
        <20230810163654.275023-2-calvinwan@google.com>
        <kl6ljzu28qzt.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 10 Aug 2023 15:43:00 -0700
In-Reply-To: <kl6ljzu28qzt.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 10 Aug 2023 15:36:06 -0700")
Message-ID: <xmqq5y5mr023.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 432E108C-37CF-11EE-9573-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Minor point: I think a better home might be entry.[ch], because those
> files care about performing changes on the worktree based on the
> Git-specific file modes in the index, whereas object.[ch] seems more
> concerned about the format of objects.

Yeah, I wasn't paying much attention on that point while reading the
patch, and I do agree with you that entry.[ch] may be a better fit.

Thanks.

