Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C13C80D2C
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467FF24773
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H6VjvyRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfLMTFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:05:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61130 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfLMTFe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:05:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 783F5A848F;
        Fri, 13 Dec 2019 14:05:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MfmkicmbFXzfbQrUkN2yOMFhxiI=; b=H6Vjvy
        Rbm2htTGy41OO5ImMLgFDLYcAKrlBxwZFL3/h+vst1W7gOGCAPY/sN5ZIAfS5ocu
        MQ2puJRXGwdXEx1oDrr6J9lvNfuwoR9M3FJiPl3Q2+RGN55BGRrkrFA23yZ2ScYK
        wTc7MJYgvZ2h+/ASx+PCTW3kAqxPhxIwQ4/j8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iNZyYcF+Cmsiw7DReeejm+QvjV0ct7VM
        uDaLTaQUM1ehTX8odu73Ppz9sjhYam6UeUQh6Lb8OOFKVRVGQTjokIzrXtwU+iI+
        vusmIS/Ay97clLDhWTXc3kwjkuyr1WN2SVhi+fpnGhEY5vwo9w5TlKMiMhb3Zhro
        B6WNVncSrI4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F652A848E;
        Fri, 13 Dec 2019 14:05:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8C631A848D;
        Fri, 13 Dec 2019 14:05:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] sparse-checkout: respect core.ignoreCase in cone mode
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
        <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
        <7aeb1589-cc08-654f-1bc0-d48fec1c0729@gmail.com>
Date:   Fri, 13 Dec 2019 11:05:29 -0800
In-Reply-To: <7aeb1589-cc08-654f-1bc0-d48fec1c0729@gmail.com> (Derrick
        Stolee's message of "Thu, 12 Dec 2019 15:59:34 -0500")
Message-ID: <xmqqwob0jbba.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88A715BC-1DDB-11EA-BAC7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> If you have a plan for that branch and the merge status of those
> commits, then I'm happy to re-target my PR against 'next' or
> an equivalent branch.

This change does not make much sense without the cone-mode topic,
no?
