Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41C52047F
	for <e@80x24.org>; Wed, 26 Jul 2017 21:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbdGZVbw (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 17:31:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53383 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751011AbdGZVbw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 17:31:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4590995D77;
        Wed, 26 Jul 2017 17:31:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wvU/OebqZ4e6YwvI/enNlJvuuqs=; b=iPaB2d
        iWrbsBvajDORdPvQTkk1DIPWjEqUVE3qG70nX7HC0xdauLg3+oCTWldt3/ra0Odj
        wMriVypXLx8BRrvrbNQIkr/sEkRqJH1b8iaftutLZ2NeNnQQG/pDJzQZflmpB82i
        kWQxHkJupx71/kqPvQDlylegwQQa0Q3neMNuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Oo0Ox+/1k22jISzWRtCd0FxPmPsRwANw
        AKapk7UlQyuPzKqgIoNcaT8cLQYICabVJ+fpHDwW23FFGTG6UclxXsMuxz4i/lrS
        xom1ImHhfzk6aJx7n+hJ1zdw9qn487xJ94upPPj8GQnshoz4HsojM7kC0ramH6pE
        rOqasj2ts7w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E1F995D76;
        Wed, 26 Jul 2017 17:31:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A134F95D75;
        Wed, 26 Jul 2017 17:31:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: Re: [PATCH 09/15] submodule: remove submodule_config callback routine
References: <20170725213928.125998-1-bmwill@google.com>
        <20170725213928.125998-10-bmwill@google.com>
Date:   Wed, 26 Jul 2017 14:31:49 -0700
In-Reply-To: <20170725213928.125998-10-bmwill@google.com> (Brandon Williams's
        message of "Tue, 25 Jul 2017 14:39:22 -0700")
Message-ID: <xmqqeft2q3zu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D602348A-7249-11E7-B3D8-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Remove the last remaining caller of 'submodule_config()' as well as the
> function itself.
>
> With 'submodule_config()' being removed the submodule-config API can be
> a little simpler as callers don't need to worry about whether or not
> they need to overlay the repository's config on top of the
> submodule-config.  This also makes it more difficult to accidentally
> add non-submodule specific configuration to the .gitmodules file.

Nice.
