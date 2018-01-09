Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D9F1FAE2
	for <e@80x24.org>; Tue,  9 Jan 2018 22:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755451AbeAIWpS (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 17:45:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50758 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755350AbeAIWpR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 17:45:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16A13CBC04;
        Tue,  9 Jan 2018 17:45:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pt6fwZ6PcKwzItcOdB6Q9NPDgGM=; b=NKTpEu
        rm4R94buQ2db2UKu/VdoKFTAs/6U0Xo+TnYKHypizOWJX2V49ZKCbEo2d96loDz3
        t15sgAM+GlgIBGE3ew2hfqGYnGq20VpXNJWc4qxfYhH6r4M3hnr7vpsREFSRaZGR
        u52UeivWkErG5WC+SxcaD+ClJLT4nPgEzAj18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a3cCl3V+e23BFY+qQCP7sz7B6r6MrvSr
        Wa1D0p8mUPMlFtb5M2gNkOaJQ+eMsn8IP62+wxm4WiA4gY0D6wE7sLzN+ap+2dVq
        TOcagwWP+UtXaWnMJWRSxedc/Ow2jCXy7xRMQ1KKLVPFCaBy//Hqo1p1NCC3J1tT
        DIbH6cfd0ZU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F102CBC03;
        Tue,  9 Jan 2018 17:45:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 809A6CBC02;
        Tue,  9 Jan 2018 17:45:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv4 0/4] Fix --recurse-submodules for submodule worktree changes
References: <xmqqo9mahdll.fsf@gitster.mtv.corp.google.com>
        <20180105200304.34173-1-sbeller@google.com>
Date:   Tue, 09 Jan 2018 14:45:15 -0800
In-Reply-To: <20180105200304.34173-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 5 Jan 2018 12:03:00 -0800")
Message-ID: <xmqqlgh63b44.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C31860EC-F58E-11E7-9CD7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> v4:
> Stefan Beller (4):
>   t/lib-submodule-update.sh: clarify test
>   t/lib-submodule-update.sh: Fix test ignoring ignored files in
>     submodules
>   unpack-trees: oneway_merge to update submodules
>   submodule: submodule_move_head omits old argument in forced case
>
>  submodule.c               |  4 +++-
>  t/lib-submodule-update.sh | 19 +++++++++++++++++--
>  unpack-trees.c            |  3 +++
>  3 files changed, 23 insertions(+), 3 deletions(-)

Thanks.  This one looks excellent.

Let's merge it to 'next' and cook it there.
