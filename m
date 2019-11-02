Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2CFD1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 05:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKBF7z (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 01:59:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61498 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKBF7z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 01:59:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEBE32FD94;
        Sat,  2 Nov 2019 01:59:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xGqeURZ2Hkw+42QkC9ZskBCS3KE=; b=m5zqpB
        DcSNsI0OJWdNYbXYBQj8C3AS+B4evIQm3Cq/yqphIJ0hCzFGZS52a66E7eICNgKJ
        7PVV2H/n4ru6Njof/Hm0hWGyJC3++SAQfhZWHzPNNXuQhndQqUqcCySlKEIGvYRG
        PY25t8qj85rXspEDqEmsjQ4jSxn6Qby2/dY4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XqFwMBkaI4uEjbNxt3rzGAdNwzrGUXp9
        HTCA8LQJZcxyJtMcRqbdNSI+mNSDM/fBgcG5aDnuv39eC/zV6y3vCzPyFUv4EsFu
        fYhWBcq5StHedi2bMbS5tY0YtuzqgbCbIr6qUjp+rLOgMJr75YTq1fTALylJccxJ
        5qSuFqkiWbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D62472FD93;
        Sat,  2 Nov 2019 01:59:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 388AC2FD92;
        Sat,  2 Nov 2019 01:59:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch: remove fetch_if_missing=0
References: <20191101203830.231676-1-jonathantanmy@google.com>
        <20191101220537.GA249573@google.com>
Date:   Sat, 02 Nov 2019 14:59:53 +0900
In-Reply-To: <20191101220537.GA249573@google.com> (Jonathan Nieder's message
        of "Fri, 1 Nov 2019 15:05:37 -0700")
Message-ID: <xmqqpnia3jja.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDAB62DA-FD35-11E9-BE57-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I would still be in favor of applying that more conservative change to
> "master", even this late in the -rc cycle.

I believe <20191023233403.145457-1-jonathantanmy@google.com> is the
latest incarnation of the "conservative" approach.  I think I can
buy that, but let me see if there are interactions with other topics
first.

