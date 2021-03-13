Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09F3C433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 23:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5BB64D9F
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 23:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhCMXh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 18:37:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56894 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCMXhs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 18:37:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AB3197EA7;
        Sat, 13 Mar 2021 18:37:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Z4vMr4kne97RlvXvPMF7QMFIB8=; b=QilptM
        HgvtjOFP36USsQArgberdoUzGIxXUWQiMkymfXmU6mBtwC26RZzLPN4AzviQ9JeQ
        jdPE5w1eYIj7pSIdzxAJRxYXg9lZpaksuhiBsIVhGbF5snQzveedGGCV99eDcm/b
        Ao7IWDJRju9Sqy5juIsQt03bFNRH9NJsBWM3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AMIFJZ4fiTiuMiW9GfsPVJI5FTUAx5C5
        IMRrYeHsjX4qa4wK2nA4Gke5Jk/yM6LerxTmHJSXYsgYB6zhWgauN4uHvRcrWIx4
        Y3cbfAtqgIbDxJwoYm9mRkI6r6DZhNElaIO3ae0UdEfN/9xmhMl4CO0NsYbF4jLR
        v5ZTm/mV9G4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81B6697EA4;
        Sat, 13 Mar 2021 18:37:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D202697EA0;
        Sat, 13 Mar 2021 18:37:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: Re: [PATCH 2/2] doc: describe mergetool configuration in
 git-mergetool(1)
References: <20210130054655.48237-1-seth@eseth.com>
        <20210209200712.156540-1-seth@eseth.com>
        <20210209200712.156540-2-seth@eseth.com> <YEbdj27CmjNKSWf4@google.com>
        <xmqqmtvbjuvl.fsf@gitster.g> <xmqqzgzafo5o.fsf@gitster.g>
        <xmqqlfas55mk.fsf@gitster.g> <YEv5d0pGvEVpepoY@google.com>
        <xmqqh7lg54h4.fsf@gitster.g> <YEx5hM/HWby3FBJv@google.com>
        <YEx6ve6AbqacVTQH@google.com>
Date:   Sat, 13 Mar 2021 15:37:45 -0800
In-Reply-To: <YEx6ve6AbqacVTQH@google.com> (Jonathan Nieder's message of "Sat,
        13 Mar 2021 00:41:33 -0800")
Message-ID: <xmqqo8fm4oc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D03C652-8455-11EB-BB64-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Tested by running
>
> 	make -C Documentation git-mergetool.1
> 	man Documentation/git-mergetool.1
>
> and reading through the page.

Nice.  Also applying this step and running

	cd Documentation && ./doc-diff HEAD^ HEAD

would was a trivial way to see the change ;-)
