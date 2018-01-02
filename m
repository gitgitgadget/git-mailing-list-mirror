Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408011F428
	for <e@80x24.org>; Tue,  2 Jan 2018 19:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeABTkX (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 14:40:23 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46878 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeABTkV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 14:40:21 -0500
Received: by mail-wr0-f195.google.com with SMTP id g17so40276639wrd.13
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 11:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ztVkt6n1d16srFEipwNC2y3nWkw6ZfcnjaTKtfevGHE=;
        b=BDSNULWZSxbfojKe76Ht641cY1UiN3gODJu5M03aopOW9RabJ+Vjw/N2hY3lqIqI37
         8WDMaY6gDwJETutgyRMeHQSBvjEFxozJw8En7Ggy573dYBvjhwoPPuI6C1US68R11wsR
         DQGgLWCtybAOdLnhIv7a6NrXqdQ4MumLYaugXuOoQ786e6LpPS2pXdmM/koWGF176rKL
         FMBvpSfKUV+383QtNuehucrdgLuxSHD7OO+JVELDNW2bqaaeDdAQ7bPhH89dnmBRs6fl
         xqDefk/Fr3w9Cg1fZ1jHsGguK9DkfBLFm/PadIjtepBeZcIAkBBI4s2MuE3I6UPwujaK
         wRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ztVkt6n1d16srFEipwNC2y3nWkw6ZfcnjaTKtfevGHE=;
        b=s+o+xas7Wd/LlA0vRVVxCwozsmE/PjLneiaSvZ/7usEGQGHQk1I/tHwSztTA/6SL8f
         SutJJ7Kz0O1bKTqAKmvTPEFkS6lL6ppUUZjSL3TUdFO1Ge7ZSL4KkolKzfiPnJU8SCqy
         2E1h2KOFS4RqCUQ2XfhxKTfBWOZcyjJyhsfF6sOTVuINaLxCMxSTy9u91i5c7j0JNatI
         uG0XFyxnxAkQoK8UQkqRimmsz3qqr6k3ztGR0YhycgB4P7jNIlv3WRcl+anrTysORF5d
         svg0u7CI2cl+byYRPyQJ7Tqkuf4lkB2puDK/adyJAZrNyvlrqsz/eBzP1JymnubOqyh+
         c47A==
X-Gm-Message-State: AKGB3mJqaF6r4LxaadY7++wYy9HtqDwRY4E77+bwnAf931shfSM/dlR/
        JzZEb4qwTifkfEK5zxmuvF4=
X-Google-Smtp-Source: ACJfBouxsvHU4UNiLUsyQ4Im8W8/H26Y/A2Wx2oy0latALkYL6uWOFNm5zRYLw8JzrV9Z5HTCYj9iA==
X-Received: by 10.223.188.66 with SMTP id a2mr47515217wrh.249.1514922020867;
        Tue, 02 Jan 2018 11:40:20 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 201sm28773267wmm.38.2018.01.02.11.40.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 11:40:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] travis-ci: check that all build artifacts are .gitignore-d
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171231160206.19481-3-szeder.dev@gmail.com>
Date:   Tue, 2 Jan 2018 20:40:19 +0100
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D977F37C-D0E5-4EEB-98B4-693A5179F7B1@gmail.com>
References: <20171231160206.19481-1-szeder.dev@gmail.com> <20171231160206.19481-3-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 31 Dec 2017, at 17:02, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> Every once in a while our explicit .gitignore files get out of sync
> when our build process learns to create new artifacts, like test
> helper executables, but the .gitignore files are not updated
> accordingly.
>=20
> Use Travis CI to help catch such issues earlier: check that there are
> no untracked files at the end of any build jobs building Git (i.e. the
> 64 bit Clang and GCC Linux and OSX build jobs, plus the GETTEXT_POISON
> and 32 bit Linux build jobs) or its documentation, and fail the build
> job if there are any present.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> ci/lib-travisci.sh       | 10 ++++++++++
> ci/run-linux32-docker.sh |  2 ++
> ci/run-tests.sh          |  2 ++
> ci/test-documentation.sh |  6 ++++++
> 4 files changed, 20 insertions(+)
>=20
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index 1543b7959..07f27c727 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -67,6 +67,16 @@ skip_good_tree () {
> 	exit 0
> }
>=20
> +check_unignored_build_artifacts ()
> +{
> +	! git ls-files --other --exclude-standard --error-unmatch \
> +		-- ':/*' 2>/dev/null ||

What does "-- ':/*'" do? Plus, why do you redirect stderr?

--

Both patches look good to me!

Thanks,
Lars=
