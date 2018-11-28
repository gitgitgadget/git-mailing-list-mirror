Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACF4A1F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 04:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeK1PLL (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 10:11:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59145 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeK1PLL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 10:11:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3119121E7B;
        Tue, 27 Nov 2018 23:10:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iL4DV1v/WTgMCpLZ0k+R4Mf3F1A=; b=DyWp+3
        YpuhL1qgw7nkBaAKSFBg14pymAcOQ+01g9+d6IGQjbCfyBiVLLKKf1RbzRCSDsDh
        +3JQ/yDfhLYD01dZiy9vv4RVe9I13wr7VGp98+qYs0/9xXHPE7xAnX4CvIvhxcNs
        2UR7iIYQUAmQ76PpgRTuchxghdVNs6Xcd6vCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=doHuwWzHpEYtEKiqo+/Pqq1j4oQEvbUx
        EZRW1Ln0SZKLVGzf6Hef23RgdCS8n2jQQP7JvjGoFzHA+vf9lxQd9D8diZu1xzwA
        kJj4sB37dVcRMUyXrmF/fzoB4eWj4M9thVxrH8ikxWQY5Kj0jSi0qtCNf8w8pVc6
        u24ID/3ds8w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABDBA121E7A;
        Tue, 27 Nov 2018 23:10:58 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A032121E79;
        Tue, 27 Nov 2018 23:10:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Steven Penny <svnpenn@gmail.com>, tboegi@web.de,
        git@vger.kernel.org
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is working (again)
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
        <20181126173252.1558-1-tboegi@web.de>
        <xmqqtvk3tj45.fsf@gitster-ct.c.googlers.com>
        <CAAXzdLX4jU7+i1W1A_Q1LpPFa1D4FYVPW5rcMnqr_tDHEJn+tw@mail.gmail.com>
        <xmqqlg5ft7pe.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811271352560.41@tvgsbejvaqbjf.bet>
Date:   Wed, 28 Nov 2018 13:10:57 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811271352560.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 27 Nov 2018 13:55:28 +0100 (STD)")
Message-ID: <xmqq1s75u9im.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BD5F886-F2C3-11E8-A0DD-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Sorry, but I fail to see the point the last example wants to make.
>
> I agree. For me, the real test is this:
>
> me@work ~
> $ cd /cygdrive
>
> me@work /cygdrive
> $ ls
> c  d
>
> So `/cygdrive` *is* a valid directory in Cygwin.

That supports the code that does not special case a path that begins
with /cygdrive/ and simply treats it as a full path and freely use
relative path, I guess.  Very good point.
