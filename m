Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08C6202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 01:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754267AbdKOBU0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 20:20:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59522 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751624AbdKOBUY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 20:20:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82390BC6BF;
        Tue, 14 Nov 2017 20:20:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jvjKOLfQUlpJUmmIWRb+adp3d3s=; b=fg7vaF
        d6SfCjIE+AJa72Hiq9+uiHiSPhpyYtXeJZNelPznkIoJ5ydfBx8mYvoSciRQY+ed
        Uxfx6pLSjjYTxGi50w/BHI8koXIzCTxNih9Bq9v5Xhpj+nxukxtK6x4U4tZIwyIT
        xKb2SV+q0CmDGgFnvREjXEcc/Q29QFoNE4Duo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TdUB3WyiO0W8eHXOOMw3a0PbqyOut0bq
        JDE5OcHExxHgIEbEcHYHovlx9XA3sYumb/vdVIZ2AI7AwIThIf0dN6kmvGGUgM/n
        FaKbPYMO/uv0f9MXD6tnyQ4wx2Aw/G3O/g0qkpggqW6bhVG+xVct1LS3QOD0icLl
        YF5sNXk094c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B6E7BC6BE;
        Tue, 14 Nov 2017 20:20:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EEBABBC6BD;
        Tue, 14 Nov 2017 20:20:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 15/30] merge-recursive: Move the get_renames() function
References: <20171110190550.27059-1-newren@gmail.com>
        <20171110190550.27059-16-newren@gmail.com>
        <xmqqh8tx5ux8.fsf@gitster.mtv.corp.google.com>
        <CABPp-BE8Jc-ZmW2bt3Fe3Azd6wEiSTUjsmhNNNdoip_LXHC_Yg@mail.gmail.com>
Date:   Wed, 15 Nov 2017 10:20:21 +0900
In-Reply-To: <CABPp-BE8Jc-ZmW2bt3Fe3Azd6wEiSTUjsmhNNNdoip_LXHC_Yg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 14 Nov 2017 09:41:32 -0800")
Message-ID: <xmqqshdg1goa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 270A4B64-C9A3-11E7-A13C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Eek!  My apologies.  I will go through and fix them up.  I see no
> reference to checkpatch.pl in git, but a google search shows there's
> one in the linux source tree.  Is that were I get it from, or is there
> a different one?



> Also, would you like me to make a separate commit that cleans up
> pre-existing issues in merge-recursive.c so that it runs clean, or
> just remove the problems I added?

That's optional.  These three patch series are already sufficiently
large, so I do not mind a clean-up after dust settles down, instead
of preliminary clean-up.

