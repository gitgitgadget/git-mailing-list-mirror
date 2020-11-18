Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C47C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 21:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C9624248
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 21:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dJ7mujlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKRVxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:53:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57772 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRVxh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 16:53:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC2ACA13D2;
        Wed, 18 Nov 2020 16:53:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EJ/bkJisB1GHohn08P+RtZ8XQXM=; b=dJ7muj
        lqMBCoiTBX5Z4Ho32QgD81z3wktqX6a6pYPK9uA1CTyN1f9fxNPbtQ8GMuOKVmGK
        iOBT+WrykDTUiH+Kz4WUxpz8v/C2IE24HAdeckJAf3SLBJ5zubVCGdW65zqbwM02
        4cW9PaZLf/r3EPJp14uZH/nXXSO90w/W8XJ+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EyDu0UUX6OA0wFhpmvU8O+RBPCLkBEC8
        RhHdf8zsBcpiaWEinr4NkklDtPNLA8xNDlm5Zz/G6vX8KxEz79DzTEEbUaNnmePo
        KyDXNC7K+ctc0Dl3ENfDukZKK3nuyS1TMgSGUh7tvdkKWicJX7dxZM7iz0Z5Y7d8
        bnPKaulZCL8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4CB4A13D1;
        Wed, 18 Nov 2020 16:53:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 540FFA13D0;
        Wed, 18 Nov 2020 16:53:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] t2106 vs. the default branch name
References: <pull.792.git.1605710947.gitgitgadget@gmail.com>
        <xmqq1rgq1jgf.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011182152580.56@tvgsbejvaqbjf.bet>
Date:   Wed, 18 Nov 2020 13:53:33 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011182152580.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 18 Nov 2020 21:56:41 +0100 (CET)")
Message-ID: <xmqqsg96z602.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 814FFCEC-29E8-11EB-A03D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:


> The four test scripts for which I sent patch series in the past hours to
> remove the use of the name `master` won't be touched by v3 of this here
> patch series at all (because it won't be necessary anymore).

Ah, OK.  I somehow had an impression that the big series was more or
less done but rethinking the structure and ejecting these changes to
tests that do not care what name the "init" uses by default from the
series makes a lot of sense.

Thanks.
