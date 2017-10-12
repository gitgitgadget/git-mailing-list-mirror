Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C52220437
	for <e@80x24.org>; Thu, 12 Oct 2017 10:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbdJLKMw (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 06:12:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63233 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751140AbdJLKMv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 06:12:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B1E696B30;
        Thu, 12 Oct 2017 06:12:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZMn97I9spnuhpBvhVSaAsapI4x4=; b=crvfGc
        jd5UF98enA2st9k7TDbQMM2jjDCaMbn31i6JKZz7qvLWRY8hcMt3Vr4sfL9qJ71J
        yqrgVqBs1zAKCNlLEegiJQO81X9p/629OhnszMqmL4oEUJYNFU07FIPbU1fjNCLN
        uLaSocsso+ljiKfySFsDKm5o2ay1nkOmbnMI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ltufvd9ys9tpobNff63/ERd36gQh2VaH
        WPV/Q/E9F5+5TjC9xNO+ImsTCJNGhs0NYSrot0aqMhlpQ7F81I2FcZakNqUpKTyc
        1et2X2RD+HLF3iC27nzemJ4eSHwXNT5ZxZlxXjPhEzOE1d3J7qKJzpd2I79FYfBV
        vGVq8ERGfe4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6240196B2F;
        Thu, 12 Oct 2017 06:12:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91BCB96B28;
        Thu, 12 Oct 2017 06:12:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     <stefan.naewe@atlas-elektronik.com>
Cc:     <git@vger.kernel.org>
Subject: Re: Bug or feature: format-patch breaks long subject lines
References: <3405d79e-f7be-322c-615e-fd7d8987c0cf@atlas-elektronik.com>
Date:   Thu, 12 Oct 2017 19:12:49 +0900
In-Reply-To: <3405d79e-f7be-322c-615e-fd7d8987c0cf@atlas-elektronik.com>
        (stefan naewe's message of "Thu, 12 Oct 2017 08:45:19 +0000")
Message-ID: <xmqqfuaoznby.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7431556-AF35-11E7-95ED-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<stefan.naewe@atlas-elektronik.com> writes:

> Is this the expected behaviour?

Yes, it is expected.  Your are seeing the header folding in play.
"mailinfo" (hence "am") will grok it just fine, I think.
