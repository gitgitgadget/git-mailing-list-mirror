Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A27D207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161652AbcIZTGe (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:06:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56035 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941581AbcIZTGd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 15:06:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 239F441EC2;
        Mon, 26 Sep 2016 15:06:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I/JihapTmaDaRJxBRfrheSGmn1E=; b=TN4tlu
        wMXQLli28jxMAPKZ0a0VZu4LqF/4Oa0vMmUKLSRmIM2GCVF4oSuzgQuEXi5Su+bF
        z3ZmDrM7l2D2W6vkX7rp1GUVwqjRhP3Pd9AxKG38sX/pofChJ3pVvcID5S30tnzK
        TZ8PBDq4tV2uJ367Yg5j7h/2/Tw134fWGEBCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QUli2h4vNun4QSbX2SBzWgJaMNY1Rz/l
        ADABAwcpGpv033p8+P/JvNnSTRclCvE7QUqt7Gk3ScsirBTV73glDGNfUKV8kUIi
        +vpoVHMGPMpWfufVV85ublLApKNMjrG8FCHJK2UhVWWcTHfQwMa3BouaxzwI8sbh
        YbVmwwKrhuQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AB1C41EC0;
        Mon, 26 Sep 2016 15:06:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 957DC41EBF;
        Mon, 26 Sep 2016 15:06:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] t5100-mailinfo: replace common path prefix with variable
References: <20160919185440.18234-1-me@ikke.info>
        <20160925210808.26424-1-me@ikke.info>
Date:   Mon, 26 Sep 2016 12:06:28 -0700
In-Reply-To: <20160925210808.26424-1-me@ikke.info> (Kevin Daudt's message of
        "Sun, 25 Sep 2016 23:08:07 +0200")
Message-ID: <xmqqd1jqscp7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55E3B092-841C-11E6-B8E5-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> Many tests need to store data in a file, and repeat the same pattern to
> refer to that path:
>
>     "$TEST_DIRECTORY"/t5100/
>
> Create a variable that contains this path, and use that instead.
>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Changes since v2:
>  - changed $DATA to $data to indicate it's a script-local variable

If you are rerolling anyway, I would have liked to see the "why is
only the variable part quoted?"  issue addressed which was raised
during the previous round of the review.  I may have said it is OK
to leave it as a low-hanging fruit for others but that only meant
that it alone is not a strong enough reason to reroll this patch.

Other than that, looks good to me, though ;-)

