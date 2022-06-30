Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763A8C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiF3VfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiF3VfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:35:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B148052395
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:35:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E498135BCB;
        Thu, 30 Jun 2022 17:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cuznq7gos4ohSmVovO05KpLZg0d3oMGjZrEcdD
        ENDa8=; b=EA1Jsoiwz91906VpgN+9QhS86bdVh5UM53s9OUjIIrj4nCwFaP5YUI
        XLSRUKR09ejArhQhSBZjtnccvTqdMZI+Xgyt+Nm70t8uxG2muW+uVdaf/6wVA8YY
        jeYlSgtpbCSHwjme1brjT6QHCciWM9O8EE+xuk4hkUIjzTQVBj8b8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86A2C135BCA;
        Thu, 30 Jun 2022 17:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4BBC135BC9;
        Thu, 30 Jun 2022 17:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git <git@vger.kernel.org>
Subject: Re: Non-interactively rewording commit messages
References: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
        <CAP8UFD1Ar13wqQP0ecb37saShSVj5Gxcjdpz=pckXZ7X9TRfSQ@mail.gmail.com>
Date:   Thu, 30 Jun 2022 14:35:18 -0700
In-Reply-To: <CAP8UFD1Ar13wqQP0ecb37saShSVj5Gxcjdpz=pckXZ7X9TRfSQ@mail.gmail.com>
        (Christian Couder's message of "Thu, 30 Jun 2022 19:34:54 +0200")
Message-ID: <xmqqh741decp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A4E114A-F8BC-11EC-AEA1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> For example, I have a set of commits:
>>
>> abcabc: This commit does foo
>> bcdbcd: This commit does bar
>> cdecde: This commit does baz
>>
>> They were all sent to the mailing list and a maintainer sent a "Reviewed-by"
>> to the second commit. In a usual interactive rebase session this would be:
> ...
>
> Have you tried `git interpret-trailers`?

Do you mean a

	git fast-export |
	git interpret-trailers |
	git fast-import

pipeline?
