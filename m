Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED67C00140
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 23:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiG1X4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiG1X4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 19:56:24 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984254D4C9
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:56:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F100119F97C;
        Thu, 28 Jul 2022 19:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PvwOxm1ds39K
        1cn2W0lBuiQQesExYG8d6FLAwU5hbMg=; b=OEzyJyWiXizkmyXL+jBED6xk/DA2
        03bIDuWtcVU0mvza4ZDrPYBuYDqVDbvkT4ViBtt3QiozTAWaDmiwQHx9DDg8ZSdB
        3A97QJ+qiVdGmz842UJ7DZp0O+1T8jfk3mvcnFIFJcrWRqDVrtoPC7v5kH+wswdX
        5Ahs2RaPH6csWX4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E936E19F97A;
        Thu, 28 Jul 2022 19:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8852B19F979;
        Thu, 28 Jul 2022 19:56:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v5 0/6] cat-file: add --batch-command remote-object-info
 command
References: <20220502170904.2770649-1-calvinwan@google.com>
        <20220728230210.2952731-1-calvinwan@google.com>
Date:   Thu, 28 Jul 2022 16:56:16 -0700
In-Reply-To: <20220728230210.2952731-1-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 28 Jul 2022 23:02:04 +0000")
Message-ID: <xmqqo7x8aj1b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E0327C84-0ED0-11ED-80B8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Sometimes it is useful to get information about an object without havin=
g
> to download it completely. The server logic has already been implemente=
d
> as =E2=80=9Ca2ba162cda (object-info: support for retrieving object info=
,
> 2021-04-20)=E2=80=9D. This patch implements the client option for it.
>
> Add `--object-info` option to `cat-file --batch-command`. This option
> allows the client to make an object-info command request to a server
> that supports protocol v2. If the server is v2, but does not allow for
> the object-info command request, the entire object is fetched and the
> relevant object info is returned.

Thanks.  Since this has changed significantly enough to render
range-diff less useful, I think a fresh round of full review may be
needed.  I'll use a more recent tip of 'master' as the base when I
queue these patches.

