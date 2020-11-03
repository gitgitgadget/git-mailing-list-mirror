Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6606DC00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDB52224E
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hGFy3skY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgKCBCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:02:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57567 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgKCBCH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 20:02:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4904A308D;
        Mon,  2 Nov 2020 20:02:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=3XGvKT79CvIYgX39x9TJzckNFvE=; b=hGFy3skYM32xeRjWc9au
        /ZMZ09XxjYvCLJaWw/E1L453oZSLuVvAhhHYw22tzO6VFAtr7Bb7VHnM5fxMDR2h
        BfeJYHC2XTzN8ax0ciVZI3yvtDho3rmAq50+Kb1EGSfEmS82C9N/Ny6G2ND6UfZy
        DJlAPKlo4dk8EmAVJh4abvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=W0uEa/70YaTqFoBFfgPyo+HgZmblyRuN3Cc1a2SJCVmhWS
        PCieqEiZpalrJo5LLwuTqjH1qDuewhz+ssldgFgjJ5YUcjEb98IaAiCAdBlOcVwQ
        1zV8kI8w8mWKvOneO5tol/wsac+D9fmiIXYMhe8wuyw2cn3dYW2Hh2biry9S8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C304A308C;
        Mon,  2 Nov 2020 20:02:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05C36A308A;
        Mon,  2 Nov 2020 20:02:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?0JvRkdGI0LAg0J7Qs9C+0L3RjNC60L7Qsg==?= 
        <lesha.ogonkov@gmail.com>, Stefan Haller <lists@haller-berlin.de>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH] Fix zsh installation instructions
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
        <xmqqr1to8dv9.fsf@gitster.c.googlers.com>
        <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
        <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
        <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de>
        <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
        <xmqqwnzbbfsi.fsf@gitster.c.googlers.com>
        <CAMP44s2DR=pV3frOePMbSyikA-KonZ5XWD7o5SqKhUbzohAFtQ@mail.gmail.com>
        <xmqqtuuc7wgu.fsf@gitster.c.googlers.com>
        <CAMP44s1+bJMrmJWeAQx18S-=spoKb0BmzWyJ4WgzuE+rNuf0cg@mail.gmail.com>
        <CAMP44s2V42MAi5R9XG94MxD9Ap1p6Y9FBAJOL60PSQSZspb3TA@mail.gmail.com>
Date:   Mon, 02 Nov 2020 17:02:04 -0800
Message-ID: <xmqq361rqmlv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3065BC10-1D70-11EB-B393-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Or put that in /tmp/zsh, and run zsh with:
>
>     ZDOTDIR=/tmp/zsh zsh -l
>
> No contamination needed.

Thanks for a few messages with tips, but the point is that it is
already much more than what a "dip my toe in the water" sightseer
wants to figure out these workarounds.


