Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D00671FF72
	for <e@80x24.org>; Sun, 22 Oct 2017 02:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932378AbdJVCKj (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 22:10:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50024 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932310AbdJVCKh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 22:10:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AB639C8F8;
        Sat, 21 Oct 2017 22:10:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mv1slEVku+ES87q2QEs3ZFFy4mI=; b=A+gWR0
        M3wbvsZEVTFcApERdL9SKoDCVgs341kdTuhs2RhCdidfSPq+IS/qpVu43eDWxLiR
        DbEJ18sEJPzGZMSBOAuaD5Ti2XxMVwZ4T49wqK0pasJtlpXM8TSM5vUwRf/Z1O9s
        xguXVqBjU7TipY4zKo3M/ReSUj2Ik3nVbFli0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W0O+qC6XENrT6iIucHmo+16ns4Iox36f
        VlYDj6MHgA3PstfV0jCTpwCtrgkxF0znY86cgqgQxB3ZeF3Zg1/tc2ox1sWQKgrW
        E1/4VcbspRp+0khKDs9f2CQm7gBg1j6kk2QTBYCjHR53+fimeZ8G6asGIXXDJF2n
        6ij13TC4dTk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 131819C8F7;
        Sat, 21 Oct 2017 22:10:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A9949C8F6;
        Sat, 21 Oct 2017 22:10:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v3 4/4] status: test --ignored=matching
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
        <20171019160601.9382-1-jamill@microsoft.com>
        <20171019160601.9382-5-jamill@microsoft.com>
Date:   Sun, 22 Oct 2017 11:10:29 +0900
In-Reply-To: <20171019160601.9382-5-jamill@microsoft.com> (Jameson Miller's
        message of "Thu, 19 Oct 2017 12:06:01 -0400")
Message-ID: <xmqq4lqsdjai.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DC9FF72-B6CE-11E7-92FD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jameson.miller81@gmail.com> writes:

> Add tests around status reporting ignord files that match an exclude
> pattern for both --untracked-files=normal and --untracked-files=all.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  t/t7519-ignored-mode.sh | 183 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>  create mode 100755 t/t7519-ignored-mode.sh

Ben's fsmonitor series already uses t7519, so please move this
somewhere else.  Perhaps

    git diff --name-only --diff-filter=A master pu t/

would help you see what new tests that are missing from 'master'
are added by topics in flight.
