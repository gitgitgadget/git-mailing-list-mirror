Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE3920286
	for <e@80x24.org>; Fri,  8 Sep 2017 04:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbdIHEod (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 00:44:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60117 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750937AbdIHEoc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 00:44:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28372B0A3B;
        Fri,  8 Sep 2017 00:44:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ck5V+Nb7udnzGVfcntbM7xvHdVY=; b=TTqeXh
        2B89ZUWh/5KmeNy1myiX1oH59qiOZiKsyKqyitCScD1JfwWWp318dbMbxldXcGgv
        Us6uvSXxX/E1iGD6Oij1JKPZtwCiEpbhqwyppPHiPlwfVrl6CNmqgbNoJGHRwp5K
        3w0yflcC8dv0fh/7sFhXaRowgeJnxr+G3U03w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U+7QFW4WKcVxjy3WMZvQ4M8KGL7yRSpI
        XoOhjzQ527rR4+xt5ufiDPdnEJfsCBEUNI+h4/F0eYg6TTvDQD8lCKFhFn4Y8x4g
        qkBgAS4KK436FkMQI4PROr5XBc+iMWjiRYGHjGMPHntTZpqeviRiNqZaH0X/hFMt
        QVGc/l71Ke4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EE2FB0A3A;
        Fri,  8 Sep 2017 00:44:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D5FCB0A39;
        Fri,  8 Sep 2017 00:44:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 07/10] t1404: demonstrate two problems with reference transactions
References: <cover.1503993268.git.mhagger@alum.mit.edu>
        <caaa44126f18869158872e5473e53478db780ba9.1503993268.git.mhagger@alum.mit.edu>
Date:   Fri, 08 Sep 2017 13:44:30 +0900
In-Reply-To: <caaa44126f18869158872e5473e53478db780ba9.1503993268.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Tue, 29 Aug 2017 10:20:31 +0200")
Message-ID: <xmqqshfxztn5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67A4E1DA-9450-11E7-80F4-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +	git for-each-ref $prefix >actual &&
> +	grep "Unable to create $Q.*packed-refs.lock$Q: File exists" err &&

I added a squash for doing s/grep/test_i18n&/ here; are there other
issues in the series, or is the series more or less ready to be
polished in 'next'?

Thanks.
