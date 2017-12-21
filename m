Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00EF41F424
	for <e@80x24.org>; Thu, 21 Dec 2017 21:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbdLUVt7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 16:49:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55991 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750920AbdLUVt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 16:49:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 545DDD1654;
        Thu, 21 Dec 2017 16:49:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e0WepCpc/M/rpqXLrpIsf+/b7qQ=; b=E2A/1O
        1hiU4Y7dF3RVPifLYVVSs15/nxX8eWCSPp16KW94cLh2Zk4S0fNibz4Eh7cj32k6
        4WCUNlFeZtRJ4WE3K1osBedUpZXbVoNNunz7caTd5JBSrnGIdhGDkMOv7y9wZdMY
        4q3cCwoKX0qvGqFR851K7A14FIwLSYlkod64c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l+rqaneuHy0iclR9sSONCow7yumiOdSh
        NvzwjWyXG1IXKK5ArAQv5YmALVvILr5t+Ct2eLyA0k54N7gaM/nCW54thRnn2gNF
        s0EPU2qKMP9HRR79noBMBwhrbpAc15Xo3nt8r/GHKt1S9veV/9OASMQsrMoQIp/6
        cZlsGwzOmOM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B8DFD1653;
        Thu, 21 Dec 2017 16:49:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C025AD1652;
        Thu, 21 Dec 2017 16:49:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 4/6] fsmonitor: Add a trailing newline to test-dump-fsmonitor
References: <20171219002858.22214-1-alexmv@dropbox.com>
        <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
        <dab89f071d22a21b85dff5d31e9e9a8ceb6458e3.1513642743.git.alexmv@dropbox.com>
        <xmqqlghyv4wz.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.10.1712201744270.15915@alexmv-linux>
Date:   Thu, 21 Dec 2017 13:49:56 -0800
In-Reply-To: <alpine.DEB.2.10.1712201744270.15915@alexmv-linux> (Alex
        Vandiver's message of "Wed, 20 Dec 2017 17:55:09 -0800 (PST)")
Message-ID: <xmqqbmiru4xn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E31FE982-E698-11E7-8960-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Vandiver <alexmv@dropbox.com> writes:

> The only current uses of this tool are in tests, which only examine
> the first ("no fsmonitor" / "fsmonitor last update ...") line.  I find
> it useful as a brief summary view of the fsmonitor bits, but I suppose
> I'd also be happy with just presence/absence and a count of set/unset
> bits.
>
> Barring objections from Dscho or Ben, I'll reroll with a version that
> shows something like:
>
>     fsmonitor last update 1513821151547101894 (5 seconds ago)
>     5 files valid / 10 files invalid

As I agree that this is test/debug only, I do not care too deeply
either way, as long as it does not end with an incomplete line ;-)
