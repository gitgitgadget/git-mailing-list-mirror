Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D821F597
	for <e@80x24.org>; Tue, 31 Jul 2018 07:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeGaJQx (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 05:16:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39579 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGaJQx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 05:16:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so1974075wmb.4
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=SE9xFbGtvSRKQzrhs0svBmn6jQq6oqIx/cepWt6h8/0=;
        b=BfOh5vLUReEIL0wMyl+26C55uiUdW/CBjEbhyjPXv4GOIugFEqoVdJsHIDYwlMgXrv
         Tdooctzd+m/7rnxxydlwpxz9JdmCJejpDQxiSHVoB79hxhLBHTR5k788yD6vnHSy0LP8
         folbU4EmAcJYQTgRVIHMV3QceqhZ1ddVzSWShRnC3V1dxg6OySlXTSnweuva2ndmS1dM
         A6cmh3zQ9F6pMcWAJHrSGFYrDLwD79tdiunyZpKCUHQ1rlV82d93P6aDm4B5+wgjQt/m
         OZ2sGIzcu3QUheeD56+egnexCUFMndKXWutzi/J+Mgz34Z3nN1dt3iuGv56G4yJ7PAz+
         Jpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=SE9xFbGtvSRKQzrhs0svBmn6jQq6oqIx/cepWt6h8/0=;
        b=ajqHXAwBstenyZGLMCvkCelkZm/Bb/+ZfjV8ftpH0DoP2vmoqeXgFVlBYB114YOFXd
         gB2Nvn5YBX2dpcmlwzyyqbGxaJm3TM0Y3KO94ZB/ZwdQ3hmSMSFz0a+gQ/SJnZ0sSq7C
         rQkwigExHNek/05xlJSnMZQs+bgwuKLzxaLrCm/Iq/OMjKEtUV9RKjm9S8NcYPyaE79a
         nu3UVKd3MuPRaZD21LL6K/SuUwmzHnMGZOp7KRgAin4E8drLvF42ndVidKdP2+YIJk8J
         WX1M7DtkYLSKye058nPl/UNLeRMNtj8CJn0rbHxh1ks6IDGlPQ2TsrW7EdB4KCe9LA/p
         5Gyw==
X-Gm-Message-State: AOUpUlHR6cy1kAJMaBYDomxbIox63oNesXmXYfSA8sJ+Iqrj/KJoJtWc
        O5v7ukH6wZD+9n8r/Q9Pn6pfCki8VgI=
X-Google-Smtp-Source: AAOMgpcHxLk29Wtm2qvBwKn0y/m9sKTKX4glyTumSVHUiLtqcRaAUPOY+tHWrysNcGely8IZwyGjBw==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr1531868wmd.6.1533022673044;
        Tue, 31 Jul 2018 00:37:53 -0700 (PDT)
Received: from evledraar ([5.57.20.50])
        by smtp.gmail.com with ESMTPSA id m68-v6sm2548430wmb.10.2018.07.31.00.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 00:37:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/1] Highlight keywords in remote sideband output.
References: <20180730123334.65186-1-hanwen@google.com> <20180730123334.65186-2-hanwen@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180730123334.65186-2-hanwen@google.com>
Date:   Tue, 31 Jul 2018 09:37:51 +0200
Message-ID: <87tvofua7k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 30 2018, Han-Wen Nienhuys wrote:


> +	if (sideband_use_color < 0) {
> +		const char *key = "color.remote";
> +		char *value = NULL;
> +		if (!git_config_get_string(key, &value))
> +			sideband_use_color = git_config_colorbool(key, value);
> [...]
> +	struct kwtable {
> +		const char *keyword;
> +		const char *color;
> +	} keywords[] = {
> +		{"hint", GIT_COLOR_YELLOW},
> +		{"warning", GIT_COLOR_BOLD_YELLOW},
> +		{"success", GIT_COLOR_BOLD_GREEN},
> +		{"error", GIT_COLOR_BOLD_RED},


FWIW I agree with other reviewers that it would be nice if these could
be customized, but I also think it can wait for some follow-up patch.

Users who don't like these colors don't have to use them, and then
they're no worse off than now, whereas some users will appreciate these
and be better off than now.

So great if you want to improve this, but just chiming in on that point
because I think we should be respectful of the time of contributors, and
not make perfect the enemy of the good.

> +test_expect_success 'setup' '
> +	mkdir .git/hooks &&
> +        cat << EOF > .git/hooks/update &&

It's the coding style of git.git to snuggle the ">" with the
filename. I.e. "<<EOF >file", not "<< EOF > file". Same for the other
occurrences of ">" etc. below.

> +#!/bin/sh
> +echo error: error
> +echo hint: hint
> +echo success: success
> +echo warning: warning

Here I think it makes sense to more exhaustively test the sort of output
we do and don't hilight, both for regression testing and to explain this
in code. E.g. let's do all of these:

    error: text
    hint: text
    success: text
    warning: text

    PREFIXerror: text
    PREFIXhint: text
    PREFIXsuccess: text
    PREFIXwarning: text

    errorSUFFIX: text
    hintSUFFIX: text
    successSUFFIX: text
    warningSUFFIX: text

	this is an error: text
	this is a hint: text
	this is success: text
	this is a warning: text

> +test_expect_success 'push' 'git -c color.remote=always push origin HEAD:refs/heads/newbranch 2>output &&
> +  test_decode_color < output > decoded &&
> +  test_i18ngrep "<BOLD;RED>error<RESET>:" decoded &&
> +  test_i18ngrep "<YELLOW>hint<RESET>:" decoded &&
> +  test_i18ngrep "<BOLD;GREEN>success<RESET>:" decoded &&
> +  test_i18ngrep "<BOLD;YELLOW>warning<RESET>:" decoded'

I think this is a case where we want just "grep", not "test_i18ngrep",
that output you just emitted won't be translated.
