Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B4E1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 04:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfKKECl (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 23:02:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51137 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfKKECl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 23:02:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAC673793A;
        Sun, 10 Nov 2019 23:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6xXKDceM1fBkWsTbd60Ob0SoY5M=; b=poxjl4
        HlRcTx80yzwJbTRSLx6UmG4Jel4iHva+GreLUKRFI16H4oa0EEl/7hmAlQjp9i9b
        MCQaHFHv7hXm0M17BKGAbJGcgxaN470u2NGM5l55/rNxuTDveyESAkzjooMDEf+K
        4HeUxZy1Edzgnyo692y/Gl/h4NOo35tz110y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vL0EW9N3Y+AO71Pix1/uNZAyr3wUQhQq
        d04NPmbvQHBF9dfar0RM5VZbwpe5B8hv8ygtqZ8fwDS3dDjYF4njrfF6HhYwiNkP
        u6LvuZ+ikrq8WnJtUlgNbSE9iUG4AIwzntsQ+47aAn4Y906smCKQOoUsCiyB8Wj0
        yUl+Ov9KOWg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D21B237939;
        Sun, 10 Nov 2019 23:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 422D737938;
        Sun, 10 Nov 2019 23:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 0/9] Improve odd encoding integration
References: <20191031092618.29073-1-congdanhqx@gmail.com>
        <cover.1573205699.git.congdanhqx@gmail.com>
Date:   Mon, 11 Nov 2019 13:02:37 +0900
In-Reply-To: <cover.1573205699.git.congdanhqx@gmail.com> (Doan Tran Cong
        Danh's message of "Fri, 8 Nov 2019 16:43:42 +0700")
Message-ID: <xmqqd0dzhxgi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19A0A2BC-0438-11EA-A9FB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doan Tran Cong Danh <congdanhqx@gmail.com> writes:

>  t/t3433-rebase-i18n.sh           |  84 +++++++++++++++++++++++++++++++
>  t/t3433/ISO8859-1.txt            | Bin 0 -> 15 bytes
>  t/t3433/eucJP.txt                | Bin 0 -> 68 bytes
>  t/t3900-i18n-commit.sh           |  37 ++++++++++++++
>  7 files changed, 195 insertions(+), 11 deletions(-)
>  create mode 100755 t/t3433-rebase-i18n.sh

Doesn't "make test" barf with test-lint failure with this series
merged to 'pu'?

In other words, isn't 3433 already taken by another series?  
