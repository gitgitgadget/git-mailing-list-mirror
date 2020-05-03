Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8ACC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 16:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BAAF2068E
	for <git@archiver.kernel.org>; Sun,  3 May 2020 16:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RzJ2EX/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgECQ6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 12:58:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53790 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgECQ6O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 12:58:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5305E40606;
        Sun,  3 May 2020 12:58:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rk/8q+G2sn/vRU5b5sCXMQLJDlM=; b=RzJ2EX
        /ZntcBirqhe3cq/R5Wc3MQ3NuNTgk8G5dMtAbfh45Y9f0JhZOrB34rX1pT/MOBeR
        A0jZWnM7DW/N15xJO00gJSC9c24jamWuS5Jy2s9KbnQZKp8KyjzeXNvl0AxZvXbE
        ba0oh4097Zy2igOBfZ17Tj2IJP8IzrL7xfRYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eQWPGCpHFBnvNiiIOYOyocLY+h0PZZJT
        zKjF3Xy0foufkoKAE45H/9OCtbub4UOpfJhsSNy2Q5UUiolUYDQ4j6uw2zt6ocWd
        8RWWMz2aXT9tixpksdbr985HnwTa0keZdIhLviU2J7y2Pnl3QWM8ExsHk6/DZ07J
        v9/o49PkMBc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C50140605;
        Sun,  3 May 2020 12:58:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC3AC40604;
        Sun,  3 May 2020 12:58:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (April 30, 2020)
References: <fda6d0db-f79e-f44e-7c2b-b60ed1794cd0@gmail.com>
        <CAFQ2z_PP9Ld+GDctV-v2CDKFamF6zKdJZ_-jhahj_fcm3wy4Hw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2005012316350.18039@tvgsbejvaqbjf.bet>
        <20200503095500.GF170902@coredump.intra.peff.net>
Date:   Sun, 03 May 2020 09:58:11 -0700
In-Reply-To: <20200503095500.GF170902@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 3 May 2020 05:55:00 -0400")
Message-ID: <xmqq1ro1j6qk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45AC5D28-8D5F-11EA-BCA1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree, and I think it's not just a question of review, but of
> maintenance going forward.
> ...
> ... I'd
> be even more afraid to see similar issues in something as critical as
> ref storage.

Thanks for saying these.  I have nothing to add.
