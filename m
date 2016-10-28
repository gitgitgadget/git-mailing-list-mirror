Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE4D2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 21:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756341AbcJ1VnQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 17:43:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61513 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752448AbcJ1VnP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 17:43:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FFA24A55C;
        Fri, 28 Oct 2016 17:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C1OYSph+xUbh9wB5iyeT6469vys=; b=BRK0a7
        Kt1HRL/j+i/Z1PC2dIdDgBAYfbJJt/NtTihj03OmAlWMQVCFW4pP54s5xtJF0nqe
        d79W9TXy2B+MsJWKmCaiunYYQDNECdf7uJIpnfbRzX8Y4TQqz8eNN6lDrvv3u9kq
        /YZiLBX23Uf8PXv2ASBmJSvh6sk01+TR0eF2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wNzcPHyuMIzJsRtKilTzGVxhc2NDb/1Q
        gz09KneVX9N5u747rU+7RY570m3ggRmiE+1ufue3v8Oz+EDcwfl0IzFXKCych00b
        T7kebEVsT5t32HuZfsJ3+vRRcXBnLRF/xR0rsSw8UJ99gAdbxvnPonZYZQcNDGhq
        vHNWna2okhQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 886214A55B;
        Fri, 28 Oct 2016 17:43:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0874C4A559;
        Fri, 28 Oct 2016 17:43:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org
Subject: Re: [PATCHv2 00/36] Revamp the attr subsystem!
References: <20161028185502.8789-1-sbeller@google.com>
Date:   Fri, 28 Oct 2016 14:43:11 -0700
In-Reply-To: <20161028185502.8789-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 28 Oct 2016 11:54:26 -0700")
Message-ID: <xmqqr370xi8g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8762E5BC-9D57-11E6-8B5C-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> previous discussion at https://public-inbox.org/git/20161022233225.8883-1-sbeller@google.com
>
> This implements the discarded series':
> jc/attr
> jc/attr-more
> sb/pathspec-label
> sb/submodule-default-paths
>
> This includes
> * The fixes for windows
> * Junios latest suggestion to use git_attr_check_initv instead of
>   alloc/append.
>
> * I implemented the thread safe attr API in patch 27 (attr: convert to new threadsafe API)
> * patch 28 (attr: keep attr stack for each check) makes it actually possible
>   to run in a multithreaded environment.
> * I added a test for the multithreaded when it is introduced in patch 32
>   (pathspec: allow querying for attributes) as well as a test to disallow
>   multiple "attr"s in a pathspec.

I'd appreciate if you didn't unnecessarily rebase the series.  It
would make comparing the new round with the previous one a lot
easier.

Thanks.
