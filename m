Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1F61F454
	for <e@80x24.org>; Sat,  2 Nov 2019 03:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfKBDE5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 23:04:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62090 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfKBDE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 23:04:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B16D32D9E4;
        Fri,  1 Nov 2019 23:04:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kSROIQOGI+dNGbXwi+dDkg5S3Bg=; b=FW5v8S
        lv4yC5P3Tt9O8SveaeVrjvaoo2qPwOKokt2FEik7gOYDke2lBn3oxjaaJzeV3v23
        CHmSO/a+B2y7DATvca09KNOj5GHBetnzApW2wTQ9MiEt0couYThOxqRfXoLyu+M+
        Rkuff2+pGD5zQAQdZ0MCbFYzJDfbwZzG9s85g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RqC16p9AjPE/QOVtar/l4ZgGjjbsnRZw
        o5dk35MaNwABvlIm5efjlSh02Q51fAlfyWWSACl/qleSE8TUH2lbXtj4vUTsDYhd
        cH8LAVtbD9W7jGnSTtjVk4qGlbMdrEbXlyKWIveYpTptJkjJDOSDqIZ0RyDm5EdZ
        eNatvxt0Sjs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA4EC2D9E2;
        Fri,  1 Nov 2019 23:04:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DF272D9E0;
        Fri,  1 Nov 2019 23:04:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] update-index: optionally leave skip-worktree entries alone
References: <pull.355.git.gitgitgadget@gmail.com>
        <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>
        <86dbb11f159375da281acd6266df019106abeadb.1572261615.git.gitgitgadget@gmail.com>
        <xmqq5zk7593d.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910300930440.46@tvgsbejvaqbjf.bet>
Date:   Sat, 02 Nov 2019 12:04:52 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910300930440.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 30 Oct 2019 09:34:38 +0100 (CET)")
Message-ID: <xmqqpnib567f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B1DBA50-FD1D-11E9-86CB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>
> I changed this locally to `keep-me`. But then I saw that you merged this
> patch pair to `next` already... Do you want an add-on patch, or revert
> it out of `next`, or leave as-is?
>
> I'd like to know because I still want to merge this into Git for Windows
> v2.24.0-rc2, and I would love to deviate as little as possible from
> git.git there.

>...
> So: revert out of `next`, add-on patch, or leave as-is?

Sorry for a late response.  I was under the weather and mostly
offline for the past few days.

Whichever is easier for GGG is fine, but for the purpose of
resulting history, I think revert-replace would be the best.

Thanks.
