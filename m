Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CABC352BE
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 16:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D74A32075E
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 16:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BNGF4Jiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391511AbgDNQZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:25:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52212 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391503AbgDNQZb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 12:25:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D547140662;
        Tue, 14 Apr 2020 12:25:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QOcb4e5azpZ0+XAP3Tlkk3HLMpQ=; b=BNGF4J
        ivxJecfyLo87cFpY+gt+lmH1nN76nS3NjM+63KVt4m7Tny//oIq9wIQoUn14A+qs
        v7GHfgHFE0boXygV8LZQQg2bd1g7SvlUu3JQHl9HhsO7WnwgpqInADv2mBUPeGzE
        xnR+CR0NFGm4TsUFZLvcRCgdL3mjhCVE1v/k8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eo+v/luEC8l27eVdoShgcgLH4nzwhL0r
        rvnBA3iav5U219guvce3+lZi9KetnX7lbLyD/FM4BkZhOgWTyNCBNaJVvkR2H/AL
        KtM5RjPIJpB4g/MTevTUEPommlnItN4sHmqZ7qMYC2Buaj3nMUUsy0AvFlTtFpD3
        035rGEAnN8g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB8A640661;
        Tue, 14 Apr 2020 12:25:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59EF540660;
        Tue, 14 Apr 2020 12:25:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Teng Long via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v2 0/3] clone: document partial clone section
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
        <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
        <xmqqd08batub.fsf@gitster.c.googlers.com>
        <e77309ef-68a4-0ebd-0d82-051b07838fd5@gmail.com>
Date:   Tue, 14 Apr 2020 09:25:25 -0700
In-Reply-To: <e77309ef-68a4-0ebd-0d82-051b07838fd5@gmail.com> (Derrick
        Stolee's message of "Tue, 14 Apr 2020 09:43:42 -0400")
Message-ID: <xmqqimi29gqy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C504B56-7E6C-11EA-A7D3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> ... Then when I force-pushed my branch his GGG PR
> "grew" with the old commits.

Ah, so we only need to review [3/3], treating it as a single patch
series?

Thanks.
