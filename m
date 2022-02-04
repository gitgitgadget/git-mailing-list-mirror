Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CA5C433FE
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377814AbiBDXDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:03:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52874 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbiBDXDT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:03:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6655175BDD;
        Fri,  4 Feb 2022 18:03:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jFaqT40OHbE4
        vkcRy5qzOWSCEuZob4ENjeKfMhakd0U=; b=Mp6/UvJ3sXmxsQRAdM4gpNT5/Bfv
        zDm8RjCRrqbKYz7/D1+kzsp5s9oRY4f45UXlHr0mOxoI2NpDTyWS0NTMu2v4dR9b
        2LVKUioDB8qt/MSc7g4uEin4vsy0De3+0GKP3docAFyreVmM+FRamgvEve6tupzh
        9mkxvrPbE0avpUM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFE85175BDC;
        Fri,  4 Feb 2022 18:03:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EB00B175BDB;
        Fri,  4 Feb 2022 18:03:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v10 3/9] grep tests: add missing "grep.patternType"
 config tests
References: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
        <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
        <patch-v10-3.9-3464c76cfd7-20220204T211534Z-avarab@gmail.com>
Date:   Fri, 04 Feb 2022 15:03:15 -0800
In-Reply-To: <patch-v10-3.9-3464c76cfd7-20220204T211534Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 4 Feb
 2022 22:20:45
        +0100")
Message-ID: <xmqqmtj6jkuk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A35816DE-860E-11EC-816A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	test_expect_success "grep $L with grep.extendedRegexp and grep.patter=
nType are both last-one-wins independently (BRE)" '
> +		echo "${HC}ab:a+bc" >expected &&
> +		git \
> +			-c grep.patternType=3Ddefault \
> +			-c grep.extendedRegexp=3Dtrue \
> +			-c grep.patternType=3Dbasic \
> +			grep "a+b*c" $H ab >actual &&
> +		test_cmp expected actual
> +	'
> +	test_expect_success "grep $L with grep.patternType=3Dextended and gre=
p.patternType=3Ddefault" '

Mising blank line between tests.

Other than that, this step looks good.

No need to resend; I'll fix this part up locally again.

Thanks.
