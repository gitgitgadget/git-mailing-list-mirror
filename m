Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B1120951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdCQRe3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:34:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52554 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751127AbdCQRe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:34:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAA7178E8B;
        Fri, 17 Mar 2017 13:28:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jzlryj/sEWlw0JqBRhN67HtFzDs=; b=N4w/WX
        xjfoOiZz4/38HimxjTf1bl6iMzSNGyvC2wo/U1n/Q22J3YQ1BZT5Z2zFalyxuIVZ
        QjzkS18VV/1CwbcbVoqwfDm8Z0PmUcJ+LWhLy+2xF4608V/Tg2zjzjQ5TI4Rl1bM
        +Tn8oQiHfAYufAZ8+Gu2EgdskEmwxCo85arkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QifC0RSQs8D27kNhGAHPCvCg+A6PGdqf
        WuzD/csh15XB8cTOHIxMvUA+jneN/K8vuSbEo2Rh7ZZBNKLIxeasAhISUiMX2nbb
        3IBtpR3bbqyUDNqbt1R6vTNARMqRKmlix+9lHaBRqB5voNeywZwrHif9D8mVxtEE
        ZZnVb0YEhj4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E27C978E8A;
        Fri, 17 Mar 2017 13:28:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57E9578E88;
        Fri, 17 Mar 2017 13:28:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] submodule sync: skip work for inactive submodules
References: <20170313214341.172676-1-bmwill@google.com>
        <20170316222952.53801-1-bmwill@google.com>
        <20170316222952.53801-4-bmwill@google.com>
        <CAGZ79kaP9ob+qvso=pV=PPaB5guaW18w297xA+bfDFASV0zibg@mail.gmail.com>
        <xmqq8to4a2xv.fsf@gitster.mtv.corp.google.com>
        <20170317065823.GA101452@google.com>
Date:   Fri, 17 Mar 2017 10:28:31 -0700
In-Reply-To: <20170317065823.GA101452@google.com> (Brandon Williams's message
        of "Thu, 16 Mar 2017 23:58:23 -0700")
Message-ID: <xmqq8to395j4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24A14146-0B37-11E7-9E7E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> ...  But this line is removed in the next patch anyways so it
> probably doesn't matter much.

Right ;-)
