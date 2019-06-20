Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59F91F461
	for <e@80x24.org>; Thu, 20 Jun 2019 20:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfFTUDG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 16:03:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56748 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfFTUDG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 16:03:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B71AB167946;
        Thu, 20 Jun 2019 16:03:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=0hXkkrUH1Jxm3hCStaelbK1Q9
        lY=; b=ImQbOSamB9Qm0LF0uNQIOtZ/F+II1PqoVi0FAopHypCxGHRKOMY2hX3nf
        jm32UHwnNavCjklkPSDq1DpWbBK7Fkxdfsc0TVx/KfJCBUwZxF4j80wCmQTQYzaH
        7WphEeeTdcDwea3oi82VFqXdXe6v1Z+Jq2lp24Fq85e9m/kJq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=kiAf0zilLVXeULg8lCE
        IEbohpIIb8QnWNhmGv72s0rbBANiwr42evABN2VYeJg8DSpIAPNoruMFyLI98MJ0
        Xj3yDJzUejy1rWrkxqXa+kQwvkOtEFt9MRD4khu82F+2cKpZErJqHeJ+uM4Ken33
        d/t34zhX/L2b8a7j0HeSecQQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0436167945;
        Thu, 20 Jun 2019 16:03:04 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11CF9167944;
        Thu, 20 Jun 2019 16:03:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Change <non-empty?> GIT_TEST_* variables to <boolean>
References: <87imt18a2r.fsf@evledraar.gmail.com>
        <20190619233046.27503-1-avarab@gmail.com>
Date:   Thu, 20 Jun 2019 13:03:03 -0700
Message-ID: <xmqqmuicm3d4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 69CC634C-9396-11E9-8362-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This changes the remaining <non-empty?> special snowflake test modes
> to <boolean> and gets rid of test_tristate() in favor of the now
> standard "boolea" test.

Is that "boolean" test?

I had a lot of trouble with the external interface to "env--helper",
but I kind of liked the changes to the tests that makes the use of
these environment variables uniform and consistent.  One fewer
things to remember.

In addition to the other review on 1/6, t0016 is taken at the tip of
'pu'; we would want to renumber to avoid test-lint complaints.
