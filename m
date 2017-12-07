Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6641E20954
	for <e@80x24.org>; Thu,  7 Dec 2017 15:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbdLGP0d (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 10:26:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56112 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753210AbdLGP0c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 10:26:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16956C0264;
        Thu,  7 Dec 2017 10:26:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C28H3MC2HvBT8PemzMcMFecvn7I=; b=V9qSqo
        wVYv0WN1VAM2TiLbogXA5n4JxImLhYJ1Ah6txJW55y+w5sI2TdfFFWHDeTEYcDnA
        1nBrAz3lDsF1cjyxrqNGXYCvdMkoCnxezpg7dNU0Irm7xL8vLrPVcPfa0MOJnl02
        VJhz5T3PKyzo1NPhY12wsYZTqLU0c2qTHbD+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nnek1soWJ/rtN3sW4CFIJODS/JMUnmp7
        AdJbgXdtREfid+fVIw3w35zuAHnINX0NIaDBCcyuytrMVjF8V+w+AmJ2Qg9aYSk8
        /YNHUN0ua/Nps0CcmFTPSN5+ZamdW+gbsHMHj9QF7mDQJpDAObk0ymGRqTCc/+za
        Ej4/qeq/s14=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D877C0263;
        Thu,  7 Dec 2017 10:26:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8173EC0262;
        Thu,  7 Dec 2017 10:26:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] diff: fix --relative without arguments
References: <20171207005929.24109-1-jacob.e.keller@intel.com>
Date:   Thu, 07 Dec 2017 07:26:30 -0800
In-Reply-To: <20171207005929.24109-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Wed, 6 Dec 2017 16:59:29 -0800")
Message-ID: <xmqq4lp2ftjt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 008B128A-DB63-11E7-A05C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Recently, commit f7923a5ece00 ("diff: use skip_to_optional_val()",
> 2017-12-04) changed how we parsed some diff options, preferring
> skip_to_optional_val instead of a more complex skip_prefix() setup.

I'd expect a moral equivalent of this squashed in when Christian
rerolls the skip-to-optional-val series (with helped-by: attribution
to you, probably).  It does not make much sense to leave the initial
breakage like this one in the history.

Thanks.
