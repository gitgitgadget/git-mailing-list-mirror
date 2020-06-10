Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F2BC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C06C204EC
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PNmRlmcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgFJRDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:03:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52179 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFJRDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 13:03:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88126D4724;
        Wed, 10 Jun 2020 13:03:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mLRo6YKSul5PkUQd0JoHzlA2PIE=; b=PNmRlm
        crk+xhxSFasjiT+ufnqicS0XWhZ3Ro6GofA4Unssh5+Pdtp90B1PLOZH3sufPUYV
        o9EgOVyNhpxJutwm81Ms4HePSIXnPEjmFwozZlLYggyWU6dVLWnGqJMpkzXoNuWL
        55B3yqgWKZsw68wdSuwmTcHSsTpZtUJsyK25Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fG+nb/Z2skoEUgcKt3+BfTd/AOhN6vmc
        i9szby9MJxWFYQJXgswsPEto9xanh2sK9w9cl+AxuYlSddpiRCcSKtCDzFgmUA21
        pLNh+Ej+0XF3LkF0Gvd6y1kTau/xMNMjjqVLphiPlRTfLifHW43uUYh81+N1yPYj
        sFvXnyhw/7I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 805E3D4723;
        Wed, 10 Jun 2020 13:03:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B20B8D471F;
        Wed, 10 Jun 2020 13:03:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Use sensible titles in t4014
References: <20200610165441.iktvzuwz44sbytfg@chatter.i7.local>
Date:   Wed, 10 Jun 2020 10:03:06 -0700
In-Reply-To: <20200610165441.iktvzuwz44sbytfg@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Wed, 10 Jun 2020 12:54:41 -0400")
Message-ID: <xmqqr1umg8fp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41BBE490-AB3C-11EA-9B3C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> Switch to "test" and "testbranch" in order to avoid using divisive 
> language.

If this were to call the side branch getting merged with the word
that literally means that (i.e. call it "side", not "testbranch",
and match the log message to say something like "change made on the
side branch"), then you do not even have to mention that this is
about "avoiding" divisive language but more about using the more
meaningful words that are useful in helping readers understand what
is going on.

Yes, I do not necessarily oppose to "avoid divisive language" just
for the sake of avoiding it, but I do prefer to see changes done
to use language that conveys our intention better at the same time,
since we would be finding different words and phrases anyway.

Thanks.

>
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
>  t/t4014-format-patch.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 575e079cc2..e6e7995d90 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -81,16 +81,16 @@ test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
>  '
>  
>  test_expect_success "format-patch doesn't consider merge commits" '
> -	git checkout -b slave master &&
> +	git checkout -b testbranch master &&
>  	echo "Another line" >>file &&
>  	test_tick &&
> -	git commit -am "Slave change #1" &&
> +	git commit -am "Test change #1" &&
>  	echo "Yet another line" >>file &&
>  	test_tick &&
> -	git commit -am "Slave change #2" &&
> +	git commit -am "Test change #2" &&
>  	git checkout -b merger master &&
>  	test_tick &&
> -	git merge --no-ff slave &&
> +	git merge --no-ff testbranch &&
>  	git format-patch -3 --stdout >patch &&
>  	grep "^From " patch >from &&
>  	test_line_count = 3 from
>
> base-commit: 0313f36c6ebecb3bffe6f15cf25a4883100f0214
