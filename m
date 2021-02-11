Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AE5C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04ABD64DD7
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhBKIOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 03:14:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59396 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKIO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 03:14:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 994899E61D;
        Thu, 11 Feb 2021 03:13:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zfedSEXdPhtOfqJErxVO8O2v57E=; b=sU5KLl
        a7X9rqBl3z3gVSzrUB9oOhajjsEJF6KfsScdt2Bi2fF2Gd5wRjpkpFdNI+47ChtU
        VLiHbxRoWXlk1SgWuzmLD1/yYCfOu6aJVEbR/H8Ad6u2+xT7LVvjQkWdcy2Xzijf
        1qaePvnqQ1qgQYjtXQl3mStOzAonR91M+xw2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c9ObZW2/1hDo+w01NyciJzRZ88Zv4sQq
        I/MY/yiGqQg4ty5TFHYE0qtU1W0WxBsBa1fNT1+7nLSosi20aWF/j/MOrTjEJmHH
        FzlW2GwUJOslt0Nj22wffTZ8Y3WquVwWxKuXUdhUoI/xO1omYP/i6mvV1dpS/N9N
        bytPzRxbN0Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90BA09E61C;
        Thu, 11 Feb 2021 03:13:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0A0A9E61B;
        Thu, 11 Feb 2021 03:13:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 0/9] midx: implement a multi-pack reverse index
References: <cover.1612998106.git.me@ttaylorr.com>
Date:   Thu, 11 Feb 2021 00:13:43 -0800
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com> (Taylor Blau's message of
        "Wed, 10 Feb 2021 18:02:18 -0500")
Message-ID: <xmqqlfbvxbrc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F48C746-6C41-11EB-9942-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Since tb/pack-revindex-on-disk is queued to be merged to 'master', but hasn't
> yet been merged, this series is based on that branch.

This seems to have a light conflict with Derrick's chunked file
format work in midx.c where pack_info is renamed and extended so the
new pack_order variable now needs to become a member in it.

I think I resolved it OK, but without any callers that actually
utilize the new code or tests, it is almost impossible to have any
confidence in the result of the conflict resolution X-<.

Could you two please look over to see if I made any silly mistakes,
when I pushe it out later?

Thanks.


