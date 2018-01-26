Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8EB1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbeAZSTU (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:19:20 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38065 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeAZSTT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:19:19 -0500
Received: by mail-pf0-f196.google.com with SMTP id k19so783180pfj.5
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 10:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fHJdVNh59EyKWcvL4vbPE8FEMkE5FgyT6oynf5Ux5dU=;
        b=Mxq3lJdelFd64QXY+ObsqJhWJIv87mw5Bh1e1kEs2apC3ICWSUs/+Iesw3AEfX79pr
         rxOv7P31B0pZEUNuBDwIILwS/SbNKpdoin9OVnVyr3I4ySZrBNmFNIaBBBMmWjN6CWaG
         Ya8Jm2Ek0vp03SBI0jfrk2TVUqNKZPeg2EI91uwfwbAP2LvW3Evo8lDQXw5Pf8cxlBMi
         tTSoeQUOMhGTiOEH9mwibKBNB8IPyqgVXv9eqzARqcb+RDasaI3PLT+6ok8aA8E/CfJz
         NWhx1Gm9/Qndd6pEDkclsrVqXnDVuGAGQciZDe1bOa6Cjy/TWsZlbVTNHwoS3Of8OWBW
         QdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fHJdVNh59EyKWcvL4vbPE8FEMkE5FgyT6oynf5Ux5dU=;
        b=c7oHyp3DEzTZCn8xPeg1XiICIuMg17A+JS2uXn+yxSHP+p8Z0ukbdqiqdd32w4RuXG
         B0/HJfIEIEpWv9TP9yxah7pHOTV3uq6ckWFpf+wkpo0V/NYqCHirdCxtYKB6UL00Zdh7
         pmZ+IZlAPX0m/WfG3w/XrFh0Kjw2HgKqtYxDU+6cf8W8Kus02CwegOH2YvmPh/8Y6I2l
         K8JdVUsBWCW9sFhZPlcOKGUFe8z4bai56OzLfYPFUHzhAKDL3O/bmWvVv9AqBeMndKtJ
         7UdeC1kOhA9JXe+K9kfxkenFYN2N8qI5eTCHBv8lBxRL/lUhTb45CiESZpxwlhFxI+RU
         YVGw==
X-Gm-Message-State: AKwxytcART3nkDtwSzKj4y7aUzC9lYWF1mURSQ52ZNdzZFu2ETPaPzt9
        ojUtQ+uAi4nAtX4JtcH9ZOY=
X-Google-Smtp-Source: AH8x224OT3BeQQl9+DfEmyY7fGNAXBV5VFzUM/5m6T5ydAI26cwWbBeQmmyqK0oV1NsxdngrTNhD2g==
X-Received: by 2002:a17:902:7b8f:: with SMTP id w15-v6mr15292939pll.219.1516990758864;
        Fri, 26 Jan 2018 10:19:18 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id h69sm19935880pfe.20.2018.01.26.10.19.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 10:19:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/10] t: move 'test_i18ncmp' and 'test_i18ngrep' to 'test-lib-functions.sh'
References: <20180126123708.21722-1-szeder.dev@gmail.com>
        <20180126123708.21722-8-szeder.dev@gmail.com>
Date:   Fri, 26 Jan 2018 10:19:17 -0800
In-Reply-To: <20180126123708.21722-8-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 26 Jan 2018 13:37:05 +0100")
Message-ID: <xmqq607o8ouy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Both 'test_i18ncmp' and 'test_i18ngrep' helper functions are supposed
> to be called from our test scripts, so they should be in
> 'test-lib-functions.sh'.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  t/test-lib-functions.sh | 26 ++++++++++++++++++++++++++
>  t/test-lib.sh           | 26 --------------------------
>  2 files changed, 26 insertions(+), 26 deletions(-)

Hmph.  I do not care too much either way, but I had an impression
that test-lib-functions.sh is meant to be more generic (i.e. those
who want can steal it from us and use it in their project without
dragging too much of the local convention we employ in this project)
than what is in test-lib.sh, which can heavily be specific to Git,
and I also had an impression that gettext-poison build is quite a
local convention we use in this project, not applicable to other
people.

>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 1701fe2a0..92ed02937 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -705,6 +705,32 @@ test_cmp_bin() {
>  	cmp "$@"
>  }
>  
> +# Use this instead of test_cmp to compare files that contain expected and
> +# actual output from git commands that can be translated.  When running
> +# under GETTEXT_POISON this pretends that the command produced expected
> +# results.
> +test_i18ncmp () {
> +	test -n "$GETTEXT_POISON" || test_cmp "$@"
> +}
> +
> +# Use this instead of "grep expected-string actual" to see if the
> +# output from a git command that can be translated either contains an
> +# expected string, or does not contain an unwanted one.  When running
> +# under GETTEXT_POISON this pretends that the command produced expected
> +# results.
> +test_i18ngrep () {
> +	if test -n "$GETTEXT_POISON"
> +	then
> +	    : # pretend success
> +	elif test "x!" = "x$1"
> +	then
> +		shift
> +		! grep "$@"
> +	else
> +		grep "$@"
> +	fi
> +}
> +
>  # Call any command "$@" but be more verbose about its
>  # failure. This is handy for commands like "test" which do
>  # not output anything when they fail.
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9a0a21f49..852b22c80 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1062,32 +1062,6 @@ else
>  	test_set_prereq C_LOCALE_OUTPUT
>  fi
>  
> -# Use this instead of test_cmp to compare files that contain expected and
> -# actual output from git commands that can be translated.  When running
> -# under GETTEXT_POISON this pretends that the command produced expected
> -# results.
> -test_i18ncmp () {
> -	test -n "$GETTEXT_POISON" || test_cmp "$@"
> -}
> -
> -# Use this instead of "grep expected-string actual" to see if the
> -# output from a git command that can be translated either contains an
> -# expected string, or does not contain an unwanted one.  When running
> -# under GETTEXT_POISON this pretends that the command produced expected
> -# results.
> -test_i18ngrep () {
> -	if test -n "$GETTEXT_POISON"
> -	then
> -	    : # pretend success
> -	elif test "x!" = "x$1"
> -	then
> -		shift
> -		! grep "$@"
> -	else
> -		grep "$@"
> -	fi
> -}
> -
>  test_lazy_prereq PIPE '
>  	# test whether the filesystem supports FIFOs
>  	test_have_prereq !MINGW,!CYGWIN &&
