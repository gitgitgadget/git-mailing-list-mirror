Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7157020A40
	for <e@80x24.org>; Mon, 27 Nov 2017 02:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbdK0CIF (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 21:08:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57476 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752258AbdK0CIE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 21:08:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 372BEAFE72;
        Sun, 26 Nov 2017 21:08:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NALmSYS5PiIy6gJ2pNSnzg7Y7vk=; b=BOVU11
        sd3R2iHgp4YRhxUXYKJvD82Esdc6yYVXjHrZmOz7UckGi/RT/bLp0liXeY3E2OJi
        8HlyMAe10hx0aTc1DD3sjG2IwQz6ob+k1Qrd1Yiw6uqsa1g6Mel85TPuhXsFFi02
        q0hiOOKTe08LQwsy9YvQTJAUsYR61BksJlxRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nExi8lKelIXN8IhJK7JL3Q4liLTVpBwr
        q3E/GJLqvTiUUOLVGlxLBUt01T+3kpSoZsAnui2ykLyz/qjBKUv48rS+vyTMUF0l
        rgBw+5Ltb90oImaGu1B0gk+ZGiTJ2pU5dhxA00je+Hk9CSqpvLSv3013s0LXLowe
        I3SFKFkzR7w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F34AAFE71;
        Sun, 26 Nov 2017 21:08:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3E9FAFE70;
        Sun, 26 Nov 2017 21:08:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc-Antoine Ruel <maruel@chromium.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: Add option --max-line-len
References: <20171123154159.17408-1-maruel@chromium.org>
        <xmqqwp2gpi1q.fsf@gitster.mtv.corp.google.com>
        <CAN+rsqmEWHhnQvktxsLJC2CkOQEmBL3b_xjRkEOHzV8W72zJew@mail.gmail.com>
        <CAN+rsqnnFXxh4=mk8L5Hzk=f=rTU101XiO-GvepSXsaVePOkZQ@mail.gmail.com>
Date:   Mon, 27 Nov 2017 11:08:02 +0900
In-Reply-To: <CAN+rsqnnFXxh4=mk8L5Hzk=f=rTU101XiO-GvepSXsaVePOkZQ@mail.gmail.com>
        (Marc-Antoine Ruel's message of "Sun, 26 Nov 2017 20:58:42 -0500")
Message-ID: <xmqqd144fp8d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD1ABD18-D317-11E7-8141-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc-Antoine Ruel <maruel@chromium.org> writes:

> [second try, now with text format]
>
> Thanks a lot for the reviews. Replying to both.
>
> If I send a follow up, I'll fix the commit description and the help
> string, remove the shorthand -M, write a more sensible test.
>
> ...
>
> Thanks for the thoughtful analysis. My main motivation was (1), thus
> filtering with a pathspec is much better than trying to work around
> the issue. The issues raised in the review are significant enough that
> committing this patch could cause significant issues; I don't know how
> to resolve handling with -v and how to handle tabs.

OK.  Thanks for thinking it through.
