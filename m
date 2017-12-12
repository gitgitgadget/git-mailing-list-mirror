Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B281F406
	for <e@80x24.org>; Tue, 12 Dec 2017 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbdLLSA2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 13:00:28 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33001 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdLLSA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 13:00:27 -0500
Received: by mail-wm0-f47.google.com with SMTP id g130so18483479wme.0
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 10:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v+d9L+JnpUrQskLBjuvRjxGRekQLphI9V6CYIBZk0WU=;
        b=iRjkWHhvGqsG8nLqd/lNeGujmuUzh3OP0ZC8DT9vdu8cd1D9ZU7EKCUbfxDibIrTC5
         LPAMRF7GPkP/i/Y0sZdjfbsGjkSN3bSnKVlujOtlGvTQpr4vROBSUqVBdyXhXqZBwKk9
         TVQz/XYDefQumT3KFeFHpBMNEPcqKNPjEVM3Duen9ZHPy2DRx6LzbgkFbRnL2cUIQI0T
         o+PdG/QSjtf8FQz0gAjWSaNMnC+XwPihEBFma0XzvWcBVkZ7qpCg73Xr5dVtdjmH6PL4
         748E6vanbXKaWUYV5saniNArEwBWbEnQ828KPf5dqXkF0ZI1DEwHGwrDktBWAAJNUAOH
         zKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v+d9L+JnpUrQskLBjuvRjxGRekQLphI9V6CYIBZk0WU=;
        b=GUsufZApPbOnNQExqRTKrWKvDXve2TaOvv1eAYvpVOSD7ujyywqkAflWdHTXJ8PDe4
         EjYcGsBff9YFRpmODR5/dHooBPo9nZVrHi/AxZ3YVpWSUN2w8diCjlTXvqnPyM/yS354
         sbZmHmyQgc4vPA/dz+5iRzIT0zOgznK/CRBwO+ItMtSbuPLEjLZEkQt7f0fNNaNPufVF
         EbXWdrbb3y8XsSxEprWSdX8tFPoBSsyHw2sDFAxy0N6toV+R9T5Y1MeL/JyyMdPEEr7U
         S2aHkUYKhw+HbviSb40vMY3UMv28boeukrQkPI0qLghAuok3qNApohvHQckwwCseFpIg
         HcGA==
X-Gm-Message-State: AKGB3mJdnUqZTm/mHqLZSPaskXW4m2UQdD0cc701nJCgO9JTPL6U/fZC
        TgAvqPhCcjmQ26v4MU5HXqR6oDvL
X-Google-Smtp-Source: ACJfBovAMZVGYE1oo3YqKHDjHg5YNvWX95fbXD0VnpXOnDJ7AO941XWt5RpHSPrf8gSCOjfmVStMow==
X-Received: by 10.28.135.204 with SMTP id j195mr2514751wmd.119.1513101626343;
        Tue, 12 Dec 2017 10:00:26 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u194sm183478wmd.6.2017.12.12.10.00.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 10:00:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/4] travis-ci: use 'set -x' in 'ci/*' scripts for extra tracing output
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171211233446.10596-2-szeder.dev@gmail.com>
Date:   Tue, 12 Dec 2017 19:00:23 +0100
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AAC2BCC-AA06-46F9-8E6E-1D99CD959FDD@gmail.com>
References: <20171101115535.15074-1-szeder.dev@gmail.com> <20171211233446.10596-1-szeder.dev@gmail.com> <20171211233446.10596-2-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12 Dec 2017, at 00:34, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> While the build logic was embedded in our '.travis.yml', Travis CI
> used to produce a nice trace log including all commands executed in
> those embedded scriptlets.  Since 657343a60 (travis-ci: move Travis CI
> code into dedicated scripts, 2017-09-10), however, we only see the
> name of the dedicated scripts, but not what those scripts are actually
> doing, resulting in a less useful trace log.  A patch later in this
> series will move setting environment variables from '.travis.yml' to
> the 'ci/*' scripts, so not even those will be included in the trace
> log.
>=20
> Use 'set -x' in 'ci/lib-travisci.sh', which is sourced in most other
> 'ci/*' scripts, so we get trace log about the commands executed in all
> of those scripts.

I kind of did that intentionally to avoid clutter in the logs.
However, I also agree with your reasoning. Therefore, the change
looks good to me!

Thanks,
Lars

>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> ci/lib-travisci.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index ac05f1f46..a0c8ae03f 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -23,7 +23,7 @@ skip_branch_tip_with_tag () {
>=20
> # Set 'exit on error' for all CI scripts to let the caller know that
> # something went wrong
> -set -e
> +set -ex
>=20
> skip_branch_tip_with_tag
>=20
> --=20
> 2.15.1.421.gc469ca1de
>=20

