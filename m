Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0240F1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeHNXFc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:05:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51873 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeHNXFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:05:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so13510537wma.1
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/JyddgfsuIiuEqIXe+h28H5QOgG7cYlCG4PpU2OThwU=;
        b=VkEUs5wFP9nlDlkRFEOS515ZfInPFHUfppqTpBb/ejHCs+B0aPiWUUuibtPcJ3evuz
         uB2iMeMq3pdyfXK5ukhawroj9i0h07hIqoeYCGI7KPZmWD8iUO8+vgjZnyfvZkvaj507
         Qd6C/znUzNUNnwlLFCPqgLnHtcEIjFbONtHmr8jWLO4Qf04OPVyQQaclIk7lCjM8P+lx
         lERuTM5o/U2x7wn6TThcJyZVllSotcdHbfr8IMOLtBHu+IYKFqBtGD82AfFsX4XbRcHu
         tpL3J2JjgYIwubjvJiQBO8jhFOT7I4kPzYSwIr0c9KlpVTmZyoABAhjdUfyiZ12GOORf
         UWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/JyddgfsuIiuEqIXe+h28H5QOgG7cYlCG4PpU2OThwU=;
        b=M4MIKfBRBYTa4mqzeH1r9nRr+5WQyXc6vL64mnW7RwVliGX6vmK59kWT2iPg+6vAAP
         +aa7bPMrKKKzUZbF+3ZNJT8Z209pNVJSQ256jckRi0wRv8Feh1We6bu29wzA06Yhv274
         d0/oShOdjDjOw14uOhxxPuLb4P1dE+2tZsfLkoQMHPiDF9/8vtFN1QFOKTWs9XHm3t2Z
         TqLX59DB0Wpenf6rzA4bqk79ClvM7FEpthPPZ/31cXhsbgpkuwxwdYGj7KT6o7o7KeZS
         dZGOsJ4Y8qAzNxobLMUnXjtYxlB0LkMu49+YEwROoHLfBjjEO+fevhJr40M3Ya4VFYAs
         BM1w==
X-Gm-Message-State: AOUpUlG7LIPqL4n1BEDZ9cVpo3C5JOQ5DVTvFNT3rKytHH5HN0qgX2va
        6rgAgDUnAC+qu8bc9DW9SPa4Mz9Z
X-Google-Smtp-Source: AA+uWPyf7+Ql6fqoXYI9Ai/u8JNGCyl4kaCENNl6g56HF8eBwqy3+gWMa4bnqbI0y9EzulrcHydAGA==
X-Received: by 2002:a1c:cf0a:: with SMTP id f10-v6mr11289438wmg.32.1534277799944;
        Tue, 14 Aug 2018 13:16:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 1-v6sm6789wmf.47.2018.08.14.13.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:16:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 3/7] t7411: be nicer to future tests and really clean things up
References: <20180814110525.17801-1-ao2@ao2.it>
        <20180814110525.17801-4-ao2@ao2.it>
Date:   Tue, 14 Aug 2018 13:16:38 -0700
In-Reply-To: <20180814110525.17801-4-ao2@ao2.it> (Antonio Ospite's message of
        "Tue, 14 Aug 2018 13:05:21 +0200")
Message-ID: <xmqq7eks1z6h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

>  test_expect_success 'error message contains blob reference' '
> +	# Remove the error introduced in the previous test.
> +	# It is not needed in the following tests.
> +	test_when_finished "git -C super reset --hard HEAD^" &&
>  	(cd super &&
>  		sha1=$(git rev-parse HEAD) &&
>  		test-tool submodule-config \

Antonio Ospite <ao2@ao2.it> writes:

> Tests 5 and 8 in t/t7411-submodule-config.sh add two commits with
> invalid lines in .gitmodules but then only the second commit is removed.
>
> This may affect future subsequent tests if they assume that the
> .gitmodules file has no errors.
>
> Remove both the commits as soon as they are not needed anymore.
>
> The error introduced in test 5 is also required by test 6, so the two
> commits from above are removed respectively in tests 6 and 8.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>  t/t7411-submodule-config.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> index 0bde5850ac..c6b6cf6fae 100755
> --- a/t/t7411-submodule-config.sh
> +++ b/t/t7411-submodule-config.sh
> @@ -98,6 +98,9 @@ test_expect_success 'error in one submodule config lets continue' '
>  '
>  
>  test_expect_success 'error message contains blob reference' '
> +	# Remove the error introduced in the previous test.
> +	# It is not needed in the following tests.
> +	test_when_finished "git -C super reset --hard HEAD^" &&

Hmm, that is ugly.  Depending on where in the subshell the previous
test failed, you'd still be taking us to an unexpected place.
Imagine if "git commit -m 'add error'" failed, for example, in the
test before this one.

I am wondering if the proper fix is to merge the previous one and
this one into a single test.  The combined test would

    - remember where the HEAD in super is and arrange to come back
      to it when test is done
    - break .gitmodules and commit it
    - run test-tool and check its output
    - also check its error output

in a single test_expect_success.

> @@ -123,6 +126,7 @@ test_expect_success 'using different treeishs works' '
>  '
>  
>  test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
> +	test_when_finished "git -C super reset --hard HEAD^" &&
>  	(cd super &&
>  		git config -f .gitmodules \
>  			submodule.submodule.fetchrecursesubmodules blabla &&
> @@ -134,8 +138,7 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
>  			HEAD b \
>  			HEAD submodule \
>  				>actual &&
> -		test_cmp expect_error actual  &&
> -		git reset --hard HEAD^
> +		test_cmp expect_error actual
>  	)
>  '

If we want to be more robust, you'd probably need to find a better
anchoring point than HEAD, which can be pointing different commit
depending on where in the subshell the process is hit with ^C,
i.e.

	ORIG=$(git -C super rev-parse HEAD) &&
	test_when_finished "git -C super reset --hard $ORIG" &&
	(
		cd super &&
		...

The patch is still an improvement compared to the current code,
where a broken test-tool that does not produce expected output in
the file 'actual' is guaranteed to leave us at a commit that we do
not expect to be at, but not entirely satisfactory.
