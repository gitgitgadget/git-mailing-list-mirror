Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC2DC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461A060D07
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbhGNQDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:03:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54029 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhGNQDN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:03:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D88F3DD68A;
        Wed, 14 Jul 2021 12:00:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DnP9dpeElMdU5q8ycVfQyoYK5H03ZKuThPDvM3
        5J7rU=; b=Q0OKAQN59GX4tnokr9B96aNITEid3tVGEdONIKP4r8BX7jhp3uvG2k
        qeW+nwvsnQaYQOMV0tGCp0T4uojCyddo9JeOzWpHSJ4CZWAGlyU2p9MWLNHoS+2p
        ufZB0EtNyvNGFkl0DtJHCGHZHizk2DzJwQgeYX5zzsvQlFGc+rUjQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CED7FDD689;
        Wed, 14 Jul 2021 12:00:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53D3EDD688;
        Wed, 14 Jul 2021 12:00:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
        <xmqqbl7525w7.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2107141124530.76@tvgsbejvaqbjf.bet>
Date:   Wed, 14 Jul 2021 09:00:18 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2107141124530.76@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 14 Jul 2021 12:09:18 +0200 (CEST)")
Message-ID: <xmqq35sgzy0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9704E5FE-E4BC-11EB-88C5-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Which means that the likelihood of a run to fail increases with the number
> of jobs in said run (even innocuous problems such as transient failures to
> download an Ubuntu package), and it also makes it much more painful to
> re-run the entire thing because you may well end up wasting a grand total
> of ~370 minutes even if only a 30-second-job would need to be re-run.
>
> Having said that, I think you're right and the upside of keeping things
> together may outweigh that downside.

I wasn't make a request or a demand to change or not to change
anything, so in this particular exchange there was no point where I
was right (or wrong, for that matter ;-).  I was asking if there was
a solid reasoning behind the split, and if there is, I am perfectly
happy to see it done as a separate workflow with the log message
that explains why it is separate.  I am also perfectly fine with
this rolled into the primary one, with clear reasoning behind the
choice recorded in the log message.

Thanks.



