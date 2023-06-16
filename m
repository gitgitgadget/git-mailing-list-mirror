Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DDBEB64D9
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 02:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjFPCzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 22:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbjFPCzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 22:55:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACAB358C
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 19:54:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BE46185230;
        Thu, 15 Jun 2023 22:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Y+hxdv6EJ4fpRfC9zw/WUOGJus/0eIgX/JekqD
        J50e4=; b=HmwOmAkXPB89Zj9OHK1xEUXYXIoKJtFhb9v1DUbS1oKtqYs4ifVHLT
        MdvvaypDzGatz/w+4kuzEnnYSnc9HDqtFQ0ORa0cDlUPW8T/HFnScd1p37NZDqGU
        4RoiUhBXE8RqctZkrUP2hw1c8dV5lyqOnR0VZf2YWcMz/7dx3cWE4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13C6518522F;
        Thu, 15 Jun 2023 22:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7712E18522E;
        Thu, 15 Jun 2023 22:54:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 9/9] gc: add `gc.repackFilterTo` config option
In-Reply-To: <20230614192541.1599256-10-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 14 Jun 2023 21:25:41 +0200")
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230614192541.1599256-10-christian.couder@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Thu, 15 Jun 2023 19:54:31 -0700
Message-ID: <xmqqa5x0ruag.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EB1D572-0BF1-11EE-8E6E-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> A previous commit implemented the `gc.repackFilter` config option
> to specify a filter that should be used by `git gc` when
> performing repacks.
>
> Another previous commit has implemented
> `git repack --filter-to=<dir>` to specify the location of the
> packfile containing filtered out objects when using a filter.
>
> Let's implement the `gc.repackFilterTo` config option to specify
> that location in the config when `gc.repackFilter` is used.
>
> Now when `git gc` will perform a repack with a <dir> configured
> through this option and not empty, the repack process will be
> passed a corresponding `--filter-to=<dir>` argument.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

That's an obvious follow-up on the previous step.

Thanks.
