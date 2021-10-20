Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3898C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B6A61361
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhJTNaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:30:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53015 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTNaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 09:30:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8F0EFFA0D;
        Wed, 20 Oct 2021 09:28:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4EfjciHk/Yb5Q6T9TRfLCjmNb6cWKKDBeZcykWL/otM=; b=Pn1S
        1BWCMWP0acSsjqNc0u3MupLATlF6jPgwlPXLSPd+ZVJjkaenMQVe0CoGcUfdYSHE
        sopYO8/0Q2nVEA3bUVuwCsd8XBDSgVjm6nNgPGDrDbgKt2Rulatd+FVFlZogprrf
        ll30/YheyBXY4P/IbqRWx+kxXl9alVB3dWU29ME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79BECFFA0C;
        Wed, 20 Oct 2021 09:28:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84748FFA0B;
        Wed, 20 Oct 2021 09:28:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/14] Sparse-checkout: modify 'git add', 'git rm',
 and 'git add' behavior
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <YW3nAKAUj/HF15OR@google.com>
        <00188c99-386f-8d4f-08f6-11a49d31184c@gmail.com>
        <YW73QD7a+NzHd8dq@google.com>
Date:   Wed, 20 Oct 2021 06:28:04 -0700
Message-ID: <xmqqa6j3su57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EBD8E5C-31A9-11EC-B415-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

>> Are you using v2.33.0? This change is not in that version.
>
> Hrm, it's an internal build that says v2.33.0 is the bsae, but the --sparse option
> is available so who knows what's actually underneath the hood.  I can try vanilla
> upstream builds if that would help narrow down the issue.

$ git version

Guessing from the e-mail address, perhaps you are using something
derived from the next branch of the day, maintained by Jonathan
Nieder's group, for internal consumption at Google.

