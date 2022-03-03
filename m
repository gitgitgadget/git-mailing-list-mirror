Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AC7C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 19:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiCCTsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 14:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbiCCTsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 14:48:17 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7FD6251
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 11:47:30 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CE3412658C;
        Thu,  3 Mar 2022 14:47:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9XLLq6EJaxJT+4UI0uvg9vr6hlR7BhuEr3RaJi
        x7jWQ=; b=eBDHJV3PQBoLjzCdVt2QqH7wzRRMnAC54muL8uKMqVQbc7LkIUV4iB
        dhw7TRP3eIwtAqANTxaK8vAR1aCdzdn/6X0gwvFiepesaEzVZZ4oRSdIeyhRHPI/
        Ed5/vPBa+ou431bvn66f4T6QuLdgpHsKC7khpxfsZbsvp4P+Yoq90=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 340FE12658B;
        Thu,  3 Mar 2022 14:47:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8ED4312658A;
        Thu,  3 Mar 2022 14:47:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add builtin driver for kotlin language
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
        <20220302142608.2754709-1-jaydeepjd.8914@gmail.com>
        <20220302142608.2754709-2-jaydeepjd.8914@gmail.com>
        <fe93dfb2-7c0d-11cb-09a0-9ccc7fcc2507@kdbg.org>
        <76d46b15-f6c0-b8da-87e8-a992047b9a6a@gmail.com>
Date:   Thu, 03 Mar 2022 11:47:25 -0800
In-Reply-To: <76d46b15-f6c0-b8da-87e8-a992047b9a6a@gmail.com> (Jaydeep Das's
        message of "Thu, 3 Mar 2022 17:11:37 +0530")
Message-ID: <xmqqwnhaakdu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0BB1A92-9B2A-11EC-927F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jaydeep Das <jaydeepjd.8914@gmail.com> writes:

> How about modifying the number match regex to:
>
> `[0-9._]+([Ee][-+]?[0-9]+)?[fFlLuU]*[^a-zA-Z]` ?
>
> The `[^a-zA-Z]` in the end would make sure to not match
> the `.F` in `X.Find`.

Do we want to match "foo.F<EOL>"?  If requiring at least one
non-alpha after [fFlLuU]* is OK, then please ignore this message ;-)

Thanks.

