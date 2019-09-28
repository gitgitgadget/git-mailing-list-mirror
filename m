Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9841F463
	for <e@80x24.org>; Sat, 28 Sep 2019 04:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfI1ErZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 00:47:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60755 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfI1ErY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 00:47:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF41735F0A;
        Sat, 28 Sep 2019 00:47:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2WB1saVO9IGE
        0IvL+apV6eZihVo=; b=auodBh1P+uMhbsel5+5Jyz4wMEXfvIixGQ57AdxC7IXB
        Xf5GT4ZcuSKOKkfjcm597VLNtMwy2MR4CESY/vdR/AJfYCpnfRJa4bqI3V15gnnR
        ZvikKp14pO5x6dV7qWT0VeaqlfEyFRjkJwxWK3cj797uK1FKaoCPvWcBqJZnaLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CSRF3h
        lZjncsB4XVSSGeI3xj3MJUjlpCKorplyebtPnQH7n/nD9Q4iwESCe+Q2n4WHolGC
        SSnfCvwLMorf6qO99fAaPwRIxWs3ai/p39tD7/ZNxuiKNxH6hxiEYkN4mzCRiZLL
        YQidCb9+ggQZebjf3I9jJZT7VODr2bQWcBoN0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7FDF35F09;
        Sat, 28 Sep 2019 00:47:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15AF235F08;
        Sat, 28 Sep 2019 00:47:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v3 2/2] t0028: add more tests
References: <pull.347.v2.git.gitgitgadget@gmail.com>
        <pull.347.v3.git.gitgitgadget@gmail.com>
        <e4410274e61f17d6f162a9218138cd2e56de7b7b.1569321628.git.gitgitgadget@gmail.com>
Date:   Sat, 28 Sep 2019 13:47:16 +0900
In-Reply-To: <e4410274e61f17d6f162a9218138cd2e56de7b7b.1569321628.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Tue, 24 Sep 2019
        03:40:30 -0700 (PDT)")
Message-ID: <xmqqv9tdjacr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D581EA4-E1AB-11E9-95E2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> After I discovered that UTF-16-LE-BOM test was bugged, I decided that

s/bugged/buggy/ perhaps?  Usually people do not place hidden
listening devices in tests ;-)

> better tests are required. Possibly the best option here is to compare
> git results against hardcoded ground truth.
> ...
> +test_commit_utf8_checkout_other "UTF-8"        "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\124\145\163\164\040\320\242\320\265\321\201\321\202"
> +test_commit_utf8_checkout_other "UTF-16LE"     "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\124\000\145\000\163\000\164\000\040\000\042\004\065\004\101\004=
\102\004"
> +test_commit_utf8_checkout_other "UTF-16BE"     "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\000\124\000\145\000\163\000\164\000\040\004\042\004\065\004\101=
\004\102"
> +test_commit_utf8_checkout_other "UTF-16LE-BOM" "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\377\376\124\000\145\000\163\000\164\000\040\000\042\004\065\004=
\101\004\102\004"
> +test_commit_utf8_checkout_other "UTF-16BE-BOM" "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\376\377\000\124\000\145\000\163\000\164\000\040\004\042\004\065=
\004\101\004\102"
> +test_commit_utf8_checkout_other "UTF-32LE"     "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\124\000\000\000\145\000\000\000\163\000\000\000\164\000\000\000=
\040\000\000\000\042\004\000\000\065\004\000\000\101\004\000\000\102\004\=
000\000"
> +test_commit_utf8_checkout_other "UTF-32BE"     "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\000\000\000\124\000\000\000\145\000\000\000\163\000\000\000\164=
\000\000\000\040\000\000\004\042\000\000\004\065\000\000\004\101\000\000\=
004\102"
