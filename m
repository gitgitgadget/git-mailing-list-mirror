Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FD4C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC55660F9E
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbhJOSAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 14:00:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64766 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbhJOSAN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 14:00:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BB32FF5C3;
        Fri, 15 Oct 2021 13:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ttfD5z9V6xJ/9SpyeozDmvsL3WpAfTqwMkZyL/iRFdY=; b=vdsr
        K+d3s9tfZinfCo8ECBt951HHq2mZMnBks+E/OBAlIRlcshro0IG2Uf4OaTWfwAoC
        lppEM0M2b+plUsTZzHlSmBFZia1FUJDQI60vMDcfUPACOZju/ry8k3wxLvLODjID
        8/yBABpTMKeOrDYopzbFD0sJzNeQKI+WseYOUqY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CD3BFF5C2;
        Fri, 15 Oct 2021 13:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D91AFF5BE;
        Fri, 15 Oct 2021 13:58:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #04; Thu, 14)
References: <xmqqwnmf9lnv.fsf@gitster.g> <YWjfY3/62q6qNhFo@nand.local>
Date:   Fri, 15 Oct 2021 10:58:04 -0700
Message-ID: <xmqq8ryu6uhf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7287861E-2DE1-11EC-8538-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Oct 14, 2021 at 05:28:04PM -0700, Junio C Hamano wrote:
>> * tb/repack-write-midx (2021-10-07) 10 commits
>
> This reminded me to check on the status of
>
>     https://lore.kernel.org/git/42a8d2ef-3a67-ca2c-4334-b79975d45da7@gmail.com/
>
> which hasn't been picked up yet. Stolee took a look and didn't have any
> problems, and I think this is an important one to pick up before you cut
> -rc0, since AFAICT `git multi-pack-index {expire,repack}` are broken on
> platforms that do not allow move-into-place when the destination is
> memory mapped.

Yeah, it is still on my rader.  I think these four extra patches
build on tb/repack-write-midx, and I was waiting for the base topic
to stabilize (it had an "oops, this thing leaks" sent only a few
days before the add-on 4-patch series was sent, IIRC).

I think the base topic has been in 'next' for about a week, so it
probably is a good time to pick it up.  Thanks for pinging.


