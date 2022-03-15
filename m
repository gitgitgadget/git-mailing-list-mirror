Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6430BC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 19:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348170AbiCOTdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiCOTdo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 15:33:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBDF5130C
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:32:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F00A19347D;
        Tue, 15 Mar 2022 15:32:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o5opFdazxPjMzQI+pJYbwXNbSleWZMz9dH7hCD
        hyn8s=; b=fA6zdt4mzrA1vSkW6ZInjUirdIV+FmVg6Vn/UWlExJZ15n/NxUXZVm
        Uz8uxbyrrA8fjTgdjMH5RgOtwnREc1cHF4NL+yZa4J2RnREQ+v8F4CUJOk1b4X3o
        pxgpQkhSGkcWteRUZDwyZpQ1yV8QLmFEXFg35YIT0jtb9a85HxiPk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 969E619347C;
        Tue, 15 Mar 2022 15:32:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E94319347A;
        Tue, 15 Mar 2022 15:32:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     gitgitgadget@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com, bagasdotme@gmail.com, git@vger.kernel.org,
        neerajsi@microsoft.com, newren@gmail.com, ps@pks.im,
        rsbecker@nexbridge.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v7] core.fsync: documentation and user-friendly
 aggregate options
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
        <20220315191245.17990-1-neerajsi@microsoft.com>
Date:   Tue, 15 Mar 2022 12:32:28 -0700
In-Reply-To: <20220315191245.17990-1-neerajsi@microsoft.com> (Neeraj Singh's
        message of "Tue, 15 Mar 2022 12:12:45 -0700")
Message-ID: <xmqqv8wfc8qb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6C1B8A6-A496-11EC-8525-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> This commit adds aggregate options for the core.fsync setting that are
> more user-friendly. These options are specified in terms of 'levels of
> safety', indicating which Git operations are considered to be sync
> points for durability.
>
> The new documentation is also included here in its entirety for ease of
> review.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
> This revision fixes a grammatical mistake in the core.fsync documentation.

Is this meant to be [PATCH v7 6/6] where 1-5/6 of v7 are supposed to
be identical to their counterparts of v6 and therefor not sent?  Not
complaining, just double-checking, as I do not want to assume and
end up missing the final updates to the other 5.

In the meantime, I'd assume that it is the case, and will fix the
author ident (you sent this from your gmail address) before
replacing the last bit.  

The only change from the previous round is "the platform default on
most platform" -> "the default on most platforms", which looks
sensible.

Thanks.

1:  39f4b94c2c ! 1:  dfeab99d23 core.fsync: documentation and user-friendly aggregate options
    @@
      ## Metadata ##
    -Author: Neeraj Singh <neerajsi@microsoft.com>
    +Author: Neeraj Singh <nksingh85@gmail.com>
     
      ## Commit message ##
         core.fsync: documentation and user-friendly aggregate options
    @@ Documentation/config/core.txt: core.whitespace::
     +is ignored.
     ++
     +The empty string resets the fsync configuration to the platform
    -+default. The platform default on most platform is equivalent to
    ++default. The default on most platforms is equivalent to
     +`core.fsync=committed,-loose-object`, which has good performance,
     +but risks losing recent work in the event of an unclean system shutdown.
     ++

Thanks.
