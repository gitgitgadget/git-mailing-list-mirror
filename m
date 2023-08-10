Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3641CC001E0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 15:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjHJPto (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjHJPtm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 11:49:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E71AA
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 08:49:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C03091C65A;
        Thu, 10 Aug 2023 11:49:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3kbkpvH/zH+QkEgqiebIm/rBGnkI8A9gn1ct3h
        ZfnKo=; b=PBRoi/Ie7IGcDgJui0hdvnTcDQ+IcxJ4Dfy/sTlH0V2C82fPLKhP5q
        HX8xH1bmXGPOopI4HJpMkVg2EJLVGIzUPtTROXfXmOc/cSX+WfIPgX8JQ4poYsSm
        H23rdmnMuUkbJDBaCfUMcW13bT8rDOnz/4tnyRMmJeq+VPyT1Qgx8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8AF71C659;
        Thu, 10 Aug 2023 11:49:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 017E61C658;
        Thu, 10 Aug 2023 11:49:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] t/lib-rebase: improve documentation of
 set_fake_editor()
References: <8ce40f48-f36f-9e81-1a3f-9d8b170c4a0f@gmail.com>
        <20230809171531.2564785-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564785-2-oswald.buddenhagen@gmx.de>
        <a2830ab8-e938-56e8-4f28-074262c95ed8@gmail.com>
Date:   Thu, 10 Aug 2023 08:49:32 -0700
In-Reply-To: <a2830ab8-e938-56e8-4f28-074262c95ed8@gmail.com> (Phillip Wood's
        message of "Thu, 10 Aug 2023 15:37:21 +0100")
Message-ID: <xmqq1qgaj3sj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 807A14D4-3795-11EE-B503-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Oswald
>
> On 09/08/2023 18:15, Oswald Buddenhagen wrote:
>> Firstly, make it reflect better what actually happens. Not omitting some
>> possibilities makes it easier to fully exploit them, and not
>> contradicting the implementation makes it easier to grok and thus modify
>> the code.
>
> Thanks for expanding this first point, the new message looks fine to
> me. The code changes look good apart from one change in the that got
> missed.
>
>> -#   "<lineno>" -- add a "pick" line with the SHA1 taken from the
>> -#       specified line.
>> +#   "<cmd>" -- override the command for the next line specification. Can be
>> +#       "pick", "squash", "fixup[_-(c|C)]", "edit", "reword", "drop",
>> +#       "merge[_-{c|C}_<rev>]", or "bad" for an invalid command.
>
> This is still using "{}" in the merge documentation rather than "()"
> like the new fixup docs.
>
> Thanks

Ah, thanks for sharp eyes.  I can locally tweak these two bytes ;-)

