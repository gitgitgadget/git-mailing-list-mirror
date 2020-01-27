Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6973FC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B78924681
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hdx0AqkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgA0S3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:29:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55590 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgA0S3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 13:29:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BBD8A63D5;
        Mon, 27 Jan 2020 13:29:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k7OaXRL6wcnTxO0sH7elUIHSutU=; b=Hdx0Aq
        kU0djuBs72+8BewE30mLsftfMCwNdJ4S64RqdW4myl92OFvJNqDqrXxEYpjwDf5R
        mADVDsM1yl6cRjffihzT6tcBYUpjxo/gzoGYotpwn+JWZ6y4s9B1yTKhE3mOxrF6
        OaBJ1bxoJlJOxGPHDNb3o/JcqxYRAGbwIC2sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XKdrKWJO6fgC5JaWgwhQNa+Xo3SDDbjF
        BimXw4DEeO5KHateN8f6dFMrbc0kQOrAeGwF31xoB0XEXe84BXLn0VLcqe2EL1hH
        ki0MWj62p38nzpNrTcnnhggzQL3CWIpHpuc+WCXPhN8Qti4JgcWbCO+cjZ/rHLLa
        OLJ8d9iZP7Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22DD8A63D4;
        Mon, 27 Jan 2020 13:29:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 54A86A63D2;
        Mon, 27 Jan 2020 13:29:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
        <20200126200728.GA233163@generichostname>
Date:   Mon, 27 Jan 2020 10:29:14 -0800
In-Reply-To: <20200126200728.GA233163@generichostname> (Denton Liu's message
        of "Sun, 26 Jan 2020 15:07:28 -0500")
Message-ID: <xmqqr1zkbvnp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECB3AB4A-4132-11EA-9C79-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Wed, Jan 22, 2020 at 02:18:05PM -0800, Junio C Hamano wrote:
>> * ds/sparse-cone (2020-01-10) 1 commit
>>  - unpack-trees: correctly compute result count
>> ...
> This commit has incorrect authorship information for Stolee. The author
> is listed as "Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>"
> due to a bug (which has been fixed) in GGG. We should fix the authorship
> information before merging to 'next'.

Ouch, but that was a bit too late X-<.
