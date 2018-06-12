Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0731F403
	for <e@80x24.org>; Tue, 12 Jun 2018 18:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754260AbeFLSbh (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 14:31:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37391 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeFLSbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 14:31:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id d8-v6so25187757wro.4
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WaKHkYMZMSbqJLEz4cR2JCVIcm8YXw3E28wMkKDkCUs=;
        b=jaBJUPE3yxiNg+i6Lzo4Y+jvqRABIj0usGjBOdKm/3l5duBsWEqhBCTJoILjpdvobB
         pi1r9q1572+OzkVrcO5SQW0m+hEJ5/uFAr8Kjlz1i2bkM9eazvLcmCYbAws8ey+vTlA7
         hMyoxDIpCxMmfuoF5bDCoPNK2Bfhsh2xJ880NUhFPQDB0p/NBWn7F4oQ9gIDqzjapnfa
         aNIY21pbL3T2oRh2QJ61kJ8gzM5TQnsWD1aApldm7Mf05K1BFV6EomKNPo0tiGVjMEwe
         GxgcSspK7937p38HBErsY4Xm/PZanXrnBbC5AiTvjZ3U2vWbM6FdGdQVCDhbKDCKgFE5
         nziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WaKHkYMZMSbqJLEz4cR2JCVIcm8YXw3E28wMkKDkCUs=;
        b=AytVO4/HeJYuousanNXr1sXMKrbFULps0cuciiDbAWS9yvL0QDUNdr5mD/zynl38q1
         4naPpvzWKBgZ0YhCmmT9ITKkkCYWAQYjg8LVcCGgGPo80UglCz9Pv38YYOjBIRB410LD
         z2p65Ut6tAMJGdqHOeJ5BQ+RgeupvIocTMQl7jJ3Jwd8CKI+usGUsha0LLjDQI+z6f86
         SMB8Qd+Eojws2SU8h7e3L3pZsF8sol1fLDB3dA0+mMe+EWbobn+siVTwZ/qVEn3gqoim
         4CpdPRxJOzpkxSyXnM87KZ7HyWHHZtdNB61MWFyXW8uGR6wbEYH8l2SW/sFZ27877gld
         6RRw==
X-Gm-Message-State: APt69E1rTk3sgiPiiqHgqNvZu3boWmN0jq4hEXhv8Wl8FjVm0Whe7HtD
        UCi0c4HHJj/zKM/rcCDgowo=
X-Google-Smtp-Source: ADUXVKLrIP2L+mN3snTaljQ0/Jhv0R0vFm8plHL81G10N8P7neE7whnV8Hce9yADnuvr7XFLwQhl9w==
X-Received: by 2002:adf:9aa5:: with SMTP id a34-v6mr1462936wrc.50.1528828294255;
        Tue, 12 Jun 2018 11:31:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 137-v6sm1675935wmv.28.2018.06.12.11.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 11:31:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 04/20] abbrev tests: add tests for core.abbrev and --abbrev
References: <20180608224136.20220-1-avarab@gmail.com>
        <20180608224136.20220-5-avarab@gmail.com>
Date:   Tue, 12 Jun 2018 11:31:32 -0700
In-Reply-To: <20180608224136.20220-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 8 Jun 2018 22:41:20 +0000")
Message-ID: <xmqq4li7ambf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
> new file mode 100755
> index 0000000000..1c60f5ff93
> --- /dev/null
> +++ b/t/t0014-abbrev.sh
> @@ -0,0 +1,118 @@
> +#!/bin/sh
> +
> +test_description='test core.abbrev and related features'
> +
> +. ./test-lib.sh
> +
> +tr_d_n() {
> +	tr -d '\n'
> +}

- I personally would prefer to see the reason for having a helper
  function like this to be "make it easier to reason about", rather
  "make it shorter to type".  tr_d_n feels more about the latter; if
  we aimed for the former, this would be called strip_LF or
  something.

- In the existing stcipts, it seems that we prefer to spell tr args
  with 3-octal, e.g.  \012 for LF, \015 for CR.

- Also let's have SP on both sides of (), i.e.

	funcname () {

  for shell function definitions.

> +cut_tr_d_n_field_n() {
> +	cut -d " " -f $1 | tr_d_n
> +}

Likewise.  Name this not after how it does what it does, but after
what it does and why it does so.  In other words, if your answer to
the question: "what does the caller want?" is "it wants to pick the
nth field", then name it "pick_nth_field" or something?

> +test_expect_success 'abbrev empty value handling differs ' '
> +	test_must_fail git -c core.abbrev= log -1 --pretty=format:%h 2>stderr &&
> +	test_i18ngrep "bad numeric config value.*invalid unit" stderr &&
> +
> +	git branch -v --abbrev= | cut_tr_d_n_field_n 3 >branch &&
> +	test_byte_count = 40 branch &&

Sounds like a good thing to unify.  If anything, --options=value
should be stricter than vari.able=value but it is the other way
around.

> +	git log --abbrev= -1 --pretty=format:%h >log &&
> +	test_byte_count = 4 log &&

Makes readers wonder if 4 is about 3 hex plus terminating LF.  The
reason why this works is because --pretty=format:%h (not --format=%h
or --pretty=tformat:%h) uses delimiter semantics and we won't need
any LF to show a single record.

If we use the helper to measure the length of hexadecimal digits, it
may make sense to add a wrapper around test_byte_count that strips
LF; that way, the caller can use --format=%h instead and there will
be one less thing for the reader to worry about.

> +	git diff --raw --abbrev= HEAD~ >diff &&
> +	cut_tr_d_n_field_n 3 <diff >diff.3 &&
> +	test_byte_count = 4 diff.3 &&
> +	cut_tr_d_n_field_n 4 <diff >diff.4 &&
> +	test_byte_count = 4 diff.4 &&

These all depend on the fact that we do not have excessive number of
irrelevant objects to force us to abbreviate using more hexdigits
than the minimum 4, right?  I _think_ that is a reasonable
assumption we can depend on, even across the hash function
transition.  We may want to leave in-code comment, though.

> +	test_must_fail git diff --raw --abbrev= --no-index X Y >diff &&
> +	cut_tr_d_n_field_n 3 <diff >diff.3 &&
> +	test_byte_count = 4 diff.3 &&
