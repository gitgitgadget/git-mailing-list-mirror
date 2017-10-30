Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB560202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 03:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbdJ3Dgy (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 23:36:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64451 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750852AbdJ3Dgx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 23:36:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C69195BE1;
        Sun, 29 Oct 2017 23:36:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XoFEmcQtRaBIk10YhJWzQGPQO8g=; b=FppHN/
        qWBl8d3Md51IhutxOAd0XggHP0JSKk9k98Fi2h/rxMh3hg4BG4LWvtfi1AkDVjkQ
        UfU4qpS5NmmevfALZXGwS73Vot8um0LhvWD+Helgnc1FUjVoh3geOvMP8EMpBsm/
        XSm3yPDfZzmdUhAsxjSAGVGuhJ1iMXYsgzN6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t40IC1HAS5LSFQrx8MW9v57FTWzOn6Wj
        GrzJVzAtbNULBtE/x7qmEHJSeqkQ2w8IlcbqzTPl5iPiq4gQtswQqpKDH0k62x0R
        I0Bior+YBhcdOig2rjwTcC+uVMPFTJLQej+Y21DdRmmt/dijUnZiDDcv8lnlTmeS
        vU9yweRG7kw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 550C195BE0;
        Sun, 29 Oct 2017 23:36:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BCEA195BDE;
        Sun, 29 Oct 2017 23:36:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: exec leaks GIT_DIR to environment
References: <20171028000152.2760-1-jacob.e.keller@intel.com>
        <alpine.DEB.2.21.1.1710281740070.6482@virtualbox>
        <4150d979-f653-e79b-563a-1dc43f12468d@talktalk.net>
        <xmqq1sll8j6f.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrXLcTQpPWgzLwt_yZo=QdfetF36jrc_TtXfqMKR2Hh3w@mail.gmail.com>
Date:   Mon, 30 Oct 2017 12:36:51 +0900
In-Reply-To: <CA+P7+xrXLcTQpPWgzLwt_yZo=QdfetF36jrc_TtXfqMKR2Hh3w@mail.gmail.com>
        (Jacob Keller's message of "Sun, 29 Oct 2017 19:53:25 -0700")
Message-ID: <xmqqo9op71d8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91F7C4CE-BD23-11E7-8F8B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I am pretty confident we can fix it....

I am sure we can eventually, but 3 hours is not enough soak time.  

I am inclined to leave the fix for 2.15.1/2.16.0 instead of delaying
the release by 10 more days.
