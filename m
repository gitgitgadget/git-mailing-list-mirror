Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8937F20951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbdCNVkO (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:40:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58917 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750835AbdCNVkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:40:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E4B57217F;
        Tue, 14 Mar 2017 17:40:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AslIunX9bVVhcq450Nhp8RqoxCU=; b=PbXO/J
        OZahLRcc9mtitqpX68Oo2PUF/+kFC6f/4Kc/XKF7WcEYGU+PwZ2NARvfha6mfjXc
        4c1GI8kZzjKN579oA2tNcgt6TcZSjMoFxBxev8EenwVOy8N850ZFul+HuNrI+8Jx
        JuY06vuEk2dUaOWgjQMNOqY4Hw0qEuDFEBbvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IG+vPUdHY+xLI8gac5lnl0DFx12Ya/y/
        9Yf68NccsXD2C/v0pUDJdavvD6hzknZ/IUP1giyixuJQsD3346ESjtcHb0BXvmXu
        36SCXxuKe+1g4A9kgLe6dcngS/ygTfaNxafRoF9VA1Fn4p0YUq1+DytQfYzSyF8P
        TUvMAB3GqFc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1545B7217E;
        Tue, 14 Mar 2017 17:40:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7723D7217A;
        Tue, 14 Mar 2017 17:40:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 00/10] decoupling a submodule's existence and its url
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
Date:   Tue, 14 Mar 2017 14:40:10 -0700
In-Reply-To: <20170313214341.172676-1-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 14:43:31 -0700")
Message-ID: <xmqqh92vh70l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD2BA3E6-08FE-11E7-B55F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> changes in v3:
>
> * Droped a patch which tried to use a more accurate URL for deinit.  It didn't
>   really fit inside the scope of this series.  It may be something we want to
>   revisit later though.
>
> * The --init-active flag now ensure that all submodules which are configured to
>   be 'active' (either via 'submodule.active' or 'submodule.<name>.active') go
>   through the initialization phase and have their relevent info copied over to
>   the config.

Aside from comments I sent already to the individual patches, I
think overall this coherently adds a nicer way to keep track of
which submodules are of interest (and which are not) than what we
traditionally had.  I'll queue it on 'pu', awaiting further
polishing (if necessary).

Thanks.
