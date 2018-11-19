Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5711F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 10:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeKSVGN (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 16:06:13 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45716 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeKSVGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 16:06:13 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so21637463edb.12
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 02:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=u1bGxADe0P5lH5UbqqimT5KU/sS7KRv1WpKXDmQFuac=;
        b=Osi10Cm8VkGGN5VeEgQpW6dr7SJuonRWzwUHMU5C0lRd6/9/seszdRIWaJKpqJqhYj
         Z/ieJYaZzWeCeampKvTR/5t5LW3pITfWVlcQ99k1DCwA0R0fwhaxtgeilodUMopo23U4
         e2XncCv8Fu5OOsS56dSRJVb4RyHu5sko41ytaXCf3MNCDYLflWTqWBjIv+fh+tXRzeJm
         w8ot5jKt4sMKWP4vLLH/ePtZFEdx3AlogsFOOF2byuvzuGUknsQmawiWGRhsqFz7h5d/
         WP6BnYHrWV9xrDGjjP8WjN87JCLgIVoepvyqyufRd0Cl3+aDzcYfIWdRVCK8BA1V7YMi
         fTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=u1bGxADe0P5lH5UbqqimT5KU/sS7KRv1WpKXDmQFuac=;
        b=Kmattm5j8SeUivy2SnUlCrnLntZLIlQ806p9AcvyXydFERvml7GqlE93jEuU3Yc+Su
         bU+mbKjG3/3rrn91bhieKWbQCliGkSFmDBeZ2ZAHiAg1n+UcDUNr2YwhAucXfwgOIDfs
         V4sShhahofbZHEfwYtMpZKDaEx/A3X3lOe+VFkmNMv8HiZPLHrfIrsgzMTYe242YoucD
         074i8GgGZIBOZaKqdBVTtHMcIRjdIWkVUqfRRVfsPWkQfRRzJKXSlNtaA6/F9ULQjbeq
         XtVPeb9S3F3ArK/FFU4Hc50iNeXgzHo3SqxBFMWbG9Q6qzNNqGCCpLTqoYRsfHEbghmP
         Q+PA==
X-Gm-Message-State: AGRZ1gJN4YBDFb7zh+AgA1qWtsb0f2ZukLtFRLVoyd/+pwuZLdC0/DMz
        4Ad3GpTCYCT33Tj/LTcv9OM=
X-Google-Smtp-Source: AJdET5eZ9sttEliRfLyq0+VrFuQoHktMzs8OdICxsQ46Xba/eW6gFWr8KFsHtBzRhAW7LoUt4pORAQ==
X-Received: by 2002:a17:906:d054:: with SMTP id bo20-v6mr16593064ejb.239.1542624178044;
        Mon, 19 Nov 2018 02:42:58 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id e18-v6sm6490587ejm.26.2018.11.19.02.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 02:42:57 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, max@max630.net,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
References: <20181119101535.16538-1-carenas@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181119101535.16538-1-carenas@gmail.com>
Date:   Mon, 19 Nov 2018 11:42:55 +0100
Message-ID: <87a7m51h74.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 19 2018, Carlo Marcelo Arenas Belón wrote:

> 6c213e863a ("http-backend: respect CONTENT_LENGTH for receive-pack", 2018-07-27)
> introduced all tests but without a check for CURL support from git.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  t/t5562-http-backend-content-length.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> index b24d8b05a4..7594899471 100755
> --- a/t/t5562-http-backend-content-length.sh
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -3,6 +3,12 @@
>  test_description='test git-http-backend respects CONTENT_LENGTH'
>  . ./test-lib.sh

This seems like the wrong fix for whatever bug you're encountering. I
just built with NO_CURL and:

    $ ./t5561-http-backend.sh
    1..0 # SKIP skipping test, git built without http support
    $ ./t5562-http-backend-content-length.sh
    ok 1 - setup
    ok 2 - setup, compression related
    ok 3 - fetch plain
    ok 4 - fetch plain truncated
    ok 5 - fetch plain empty
    ok 6 - fetch gzipped
    ok 7 - fetch gzipped truncated
    ok 8 - fetch gzipped empty
    ok 9 - push plain
    ok 10 - push plain truncated
    ok 11 - push plain empty
    ok 12 - push gzipped
    ok 13 - push gzipped truncated
    ok 14 - push gzipped empty
    ok 15 - CONTENT_LENGTH overflow ssite_t
    ok 16 - empty CONTENT_LENGTH
    # passed all 16 test(s)
    1..16

So all these test pass.

Of courses I still have curl on my system, but I don't see the curl(1)
utility used in the test, and my git at this point can't operate on
https?:// URLs, so what error are you getting? Can you paste the test
output with -x -v?

> +if test -n "$NO_CURL"
> +then
> +	skip_all='skipping test, git built without http support'
> +	test_done
> +fi
> +
>  test_lazy_prereq GZIP 'gzip --version'
>
>  verify_http_result() {

If we do end up needing this after all it seems better to do something
like:

    diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
    index a8729f8232..adad654277 100644
    --- a/t/lib-httpd.sh
    +++ b/t/lib-httpd.sh
    @@ -30,11 +30,7 @@
     # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
     #

    -if test -n "$NO_CURL"
    -then
    -       skip_all='skipping test, git built without http support'
    -       test_done
    -fi
    +. "$TEST_DIRECTORY"/lib-no-curl.sh

     if test -n "$NO_EXPAT" && test -n "$LIB_HTTPD_DAV"
     then
    diff --git a/t/lib-no-curl.sh b/t/lib-no-curl.sh
    new file mode 100644
    index 0000000000..014947aa2d
    --- /dev/null
    +++ b/t/lib-no-curl.sh
    @@ -0,0 +1,5 @@
    +if test -n "$NO_CURL"
    +then
    +       skip_all='skipping test, git built without http support'
    +       test_done
    +fi
    diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
    index b24d8b05a4..cffb460673 100755
    --- a/t/t5562-http-backend-content-length.sh
    +++ b/t/t5562-http-backend-content-length.sh
    @@ -2,6 +2,7 @@

     test_description='test git-http-backend respects CONTENT_LENGTH'
     . ./test-lib.sh
    +. ./lib-no-curl.sh

     test_lazy_prereq GZIP 'gzip --version'

Not really a problem with your patch, we have lots of this copy/pasting
all over the place already. I.e. stuff like:

    if test -n "$X"
    then
    	skip_all="$Y"
    	test_done
    fi

or:

    if ! test_have_prereq "$X"
    then
    	skip_all="$Y"
    	test_done
    fi

Maybe we should make more use of test_lazy_prereq and factor all that
into a new helper like:

    test_have_prereq_or_skip_all "$X" "$Y"

Which could be put at the top of these various tests...
