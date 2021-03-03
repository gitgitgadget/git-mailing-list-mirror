Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AC6C433E0
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 07:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5D164EDE
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 07:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhCCG7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:59:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61817 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355704AbhCCGzt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 01:55:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2ACB012FA99;
        Wed,  3 Mar 2021 01:55:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AyIS2HYJZ9RVHMBjQp/yRb9iK68=; b=OPLbF9
        dOHvNl95szgoTO0BJSnDLUfdzKtmrkjDJhba825kBgVrjSZqPO7lkvJgYgf5Nsoj
        z5s4g9Uuz7xXrLOEyyumw8zPCYPlt+n8ov2YG5dPXHhaYuvcrrb9XiE82tTPl3pK
        PiyI0NSo+vPgkhFqoPjobwsSfTzRBeSroAEwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HH+wJk9C1Lx21P4dXaKbTZKmMz2/V4NI
        RxTYsdpSMYzzdfnrMh7L8saBHsbbbyI9M+1pJS0S5+QAyVgazlYIuF7uyKV5k3wi
        bUF9IPF8+JJa8ZU+8HQiFGhWGFmPQQNcC+H1sZNPhj+BL6CqY5HfLH+VccBxeI4G
        Gh+XE0PCv0g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1467512FA98;
        Wed,  3 Mar 2021 01:55:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 43EBE12FA97;
        Wed,  3 Mar 2021 01:55:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jason Pyeron <jpyeron@pdinc.us>
Subject: Re: [PATCH 4/4] docs: note that archives are not stable
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
        <20210227191813.96148-5-sandals@crustytoothpaste.net>
        <87h7lwl5mv.fsf@evledraar.gmail.com>
        <YDvexO2NFM0KZ1Jo@camp.crustytoothpaste.net>
        <xmqqpn0irb9a.fsf@gitster.c.googlers.com>
        <YD7aDwX/aiRN0GZs@camp.crustytoothpaste.net>
Date:   Tue, 02 Mar 2021 22:55:02 -0800
In-Reply-To: <YD7aDwX/aiRN0GZs@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 3 Mar 2021 00:36:31 +0000")
Message-ID: <xmqqeegwloah.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61C89B2A-7BED-11EB-BF07-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think what I had intended was that Git produces deterministic output,
> but I don't actually think that's true across ports.  If someone uses a
> different version of zlib on a different OS, the output may differ.

I agree.  When I wrote my response, I had the "tar" format in mind,
which we write everything ourselves, but zip and also the compressed
output is a different story---we do rely on third-party libraries.

Thanks.
