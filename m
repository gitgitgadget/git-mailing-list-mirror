Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA19C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 04:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjBIEC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 23:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjBIEBM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 23:01:12 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BCC2FCFD
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 20:01:02 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id s20-20020a17090b071400b00230ecf76407so418035pjz.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 20:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMsowJt7aYe9s1Eg87SgEQg+hfV8Sx8EPkVR9x+BC7s=;
        b=axj13Jd/LpTBwdjBzQ2kSi1M0cTXI5jevH/veXHVPWLuh3xeBOSMxWGSzHKb+bbM1P
         1ge+rUmBvDIs+9jh8zyB2kZT99zgeUHnXG2/JgnSuSENygc8PkfTrKB8IebTNTRVj6uV
         HvNT67QcSIqccYz99etY3zcXavryqCWG/UXactzLBvUbonkPIw2q4mRMus+V8D9srzNJ
         64SMAsH34k2DDoWxi8JJ2DupBkgOV2XCoHe8YrMKrK7Hd6fhiBaY1d4x4cB1QIJt891g
         OyALij8ZeMnsmZoa/0EtoZSpz+R3/y+rdnzzwBTYSCb2F2SvyRjnr6tVJsCMcoL6I4jN
         YHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TMsowJt7aYe9s1Eg87SgEQg+hfV8Sx8EPkVR9x+BC7s=;
        b=sKvzeZ4AHvARufQ38qfdHFaTnYRdjogioN0qRsFd0HZzfkPY2gkt07i0Tq4UrXqz26
         BEyv1ctUNswXUf0oKWfk4iM3scshnvjCAgQ9OT7PY52WXHVKOJdPCmEe0Ia1Bc1IsEOk
         d3C8F4RCdabAuXNnIdjRDiAd0CJd5DC5tqp5mdi7Hdv0C0JluucnIn9hdPMB51h6yFLT
         4CLOwTfIpIvXtIiXt0/8Em8G4l1ConjOGrYdsW1KeNcxhuY6p8Kjyw0mkBYjlUUbJ2OP
         +85/smG1F/FoYkFu7wuTjK3EJanKMlfOJUaCHb04l5tjSih004lDhLCNLkTtH9UjzS1g
         ugMA==
X-Gm-Message-State: AO0yUKVF69Fby+bPONTf/9uLMW2JtwrlIG/WSDZVIFdh3yaIIksyq/re
        vjVA/RK0FkrqMhzvI0Fzr0Cj0/6NiF05Ow==
X-Google-Smtp-Source: AK7set8J6jwvH3mKqkcyWBy9+gGIQ9Z/UYXGescSzIS1ifWeLvDnGUuV7stFDpJ5kC4T3YZv0h4KTW1/ORo1BA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:bd83:b0:199:472b:9299 with SMTP
 id q3-20020a170902bd8300b00199472b9299mr1299484pls.9.1675915261640; Wed, 08
 Feb 2023 20:01:01 -0800 (PST)
Date:   Thu, 09 Feb 2023 12:00:59 +0800
In-Reply-To: <patch-v5-02.10-91a44456327-20230207T154000Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
 <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com> <patch-v5-02.10-91a44456327-20230207T154000Z-avarab@gmail.com>
Message-ID: <kl6llel7trlw.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 02/10] config tests: add "NULL" tests for *_get_value_multi()
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?=" <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> +		# Value-less in the middle of a list
> +		cat >"$config" <<-\EOF &&
> +		[a]key=3Dx
> +		[a]key
> +		[a]key=3Dy
> +		EOF
> +		case "$op" in
> +		*_multi)
> +			cat >expect <<-\EOF
> +			x
> +			(NULL)
> +			y
> +			EOF
> +			;;
> +		*)
> +			cat >expect <<-\EOF
> +			y
> +			EOF
> +			;;
> +		esac &&
> +		test-tool config "$op" a.key $file >actual &&
> +		test_cmp expect actual &&

This extra test case makes me feel a bit better about making this DRY,
though the extra "case" statement detracts from the readability a bit.

Maybe if we split the _multi and non-multi cases?

	test_expect_success "multi" '
    # tmp config things

		# Value-less in the middle of a list
		cat >"$config" <<-\EOF &&
		[a]key=3Dx
		[a]key
		[a]key=3Dy
		EOF
    cat >expect <<-\EOF
    x
    (NULL)
    y
    EOF
		test-tool config "$op" a.key $file >actual &&
		test_cmp expect actual &&

		# Value-less at the end of a least (probable typo)
		cat >"$config" <<-\EOF &&
		[a]key=3Dx
		[a]key=3Dy
		[a]key
		EOF
    cat >expect <<-\EOF
    x
    y
    (NULL)
    EOF
		test-tool config "$op" a.key $file >actual &&
		test_cmp expect actual
	'

	test_expect_success "single" '
    # tmp config things

		# Value-less in the middle of a list
		cat >"$config" <<-\EOF &&
		[a]key=3Dx
		[a]key
		[a]key=3Dy
		EOF
    cat >expect <<-\EOF
    y
    EOF
		test-tool config "$op" a.key $file >actual &&
		test_cmp expect actual &&

		# Value-less at the end of a least (probable typo)
		cat >"$config" <<-\EOF &&
		[a]key=3Dx
		[a]key=3Dy
		[a]key
		EOF
    cat >expect <<-\EOF
    (NULL)
    EOF
		test-tool config "$op" a.key $file >actual &&
		test_cmp expect actual
	'

Idk. It does read a bit clearer to me, but I don't feel strongly about
it.

> +		# Value-less at the end of a least

s/least/list
