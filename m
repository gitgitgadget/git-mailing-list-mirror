Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880E41F404
	for <e@80x24.org>; Fri, 13 Apr 2018 20:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbeDMUFV (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 16:05:21 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:40360 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeDMUFU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 16:05:20 -0400
Received: by mail-yb0-f179.google.com with SMTP id c10-v6so4881709ybn.7
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pj2ynXcflfuvmmzIjFKprQcAD76daL2+rjM7y8H0qns=;
        b=q/eayM6ayqV22s8BntWrGOnuB6PfN7zbYe26r7staoaX2k3p8nQ3MT7e8v/Ii1SZ5q
         m2QLAEXa72Xmwnz+tBu00CY70BbLmSz4PQvqPPeoDL8R74H3wM2CsCt2TAsTR2C1X5jI
         dr4poITOOAb+IXqq9VHWJmWjRyJXq83OQG3XlmRRf9FvPLCAh3Go0I/AMignWneUs0O2
         iIBWQztGo2+V5EmlqXOqjr/wy5DJvLWKhuZHkc9Mr3KNQk1/4K9d6yBC4l00QcM54/G1
         j9yj+950FKCgcqSVkqBwZp1om3qs0zeV9HPYFab6B+cP6vO/tjuDkwN/LXbPKOBVClVC
         UHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pj2ynXcflfuvmmzIjFKprQcAD76daL2+rjM7y8H0qns=;
        b=X5z3dtL0GXwGxDGszH2kUWDBDhY3YhsO5m+HHquybBdchNyZcG6uZYMfZjJBR9fwU/
         uIUF3L5u59NfcMPw5oQEWbGOjTyioxi+9WVzwzCcodbTuTg0Ko9Q1dHKxFq5hgEvf/kW
         wHX4m4DS+wF91QRBGamuaEEKV4ynZF2HghQnPo9wH/BklW8/q713AvlneaekwMKpXSJq
         lsD43MwJoN5ePaLsVf7FCzgTBdNlCeEODVbgO7Vi2OuiO5d2mVkwbPebGalmUhYZHSoB
         Q0IQMe7RhNCu4WnvNjtXEicix3weBBuY8SZZxhUm2UFpcAQJjDcWEVjeDlolB2V82BVW
         sOaQ==
X-Gm-Message-State: ALQs6tD/YXe1meO2ykjfxT1EQaw/R2I5z9yOG4JysDu9+VFeQ8Le7Fp8
        NCaWkGERuy7/cJYMeFDIYWOzlbb0GAFlrXm8KpprxQ==
X-Google-Smtp-Source: AIpwx486ST/28JXDp9rk5959frhSITdKqQ+sNMQoIi+ZM0XGULZmCqmLNkahNxnHWovrCGCPt0mChwlXgkja579SoA8=
X-Received: by 2002:a25:8e09:: with SMTP id p9-v6mr6026337ybl.352.1523649918914;
 Fri, 13 Apr 2018 13:05:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Fri, 13 Apr 2018 13:05:18
 -0700 (PDT)
In-Reply-To: <20180413080733.6380-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it> <20180413080733.6380-1-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Apr 2018 13:05:18 -0700
Message-ID: <CAGZ79kagFY_AnLJ0Zjcu++e567JHYeHaW-0k8=4Q4rsyqtnU9w@mail.gmail.com>
Subject: Re: [RFC 07/10] FIXME: wrap-for-bin.sh: set 'core.submodulesFile' for
 each git invocation
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio,

On Fri, Apr 13, 2018 at 1:07 AM, Antonio Ospite <ao2@ao2.it> wrote:
> This is to test custom gitmodules file paths. The default path can be
> overridden using the 'GIT_MODULES_FILE' environmental variable.
>
> Maybe In the final patch the option should be set only when running
> tests and not unconditionally in the wrapper script, but as a proof of
> concept the wrapper script was a convenient location.
>
> Also, in the final patch a fixed custom file path could be used instead
> of the environmental variable: to exercise the code it should be enough
> to have a value different from the default one.
>
> The change to 't0001-init.sh' is needed to make the test pass, since now
> a config is set on the command line.

Missing sign off.

So you'd think we'd have to rerun the test suite with GIT_MODULES_FILE set?
That makes for an expensive test. Can we have just a few tests for a few
commands to see that the basics are working correctly?


> ---
>  Makefile        | 3 ++-
>  t/t0001-init.sh | 1 +
>  wrap-for-bin.sh | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
>  mode change 100644 => 100755 wrap-for-bin.sh
>
> diff --git a/Makefile b/Makefile
> index f18168725..38ee1f6a2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2480,7 +2480,8 @@ bin-wrappers/%: wrap-for-bin.sh
>         @mkdir -p bin-wrappers
>         $(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>              -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
> -            -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' < $< > $@ && \
> +            -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' \
> +            -e 's|git\"|git\" $$GIT_OPTIONS|' < $< > $@ && \
>         chmod +x $@
>
>  # GNU make supports exporting all variables by "export" without parameters.
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index c413bff9c..6fa3fd24e 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -93,6 +93,7 @@ test_expect_success 'No extra GIT_* on alias scripts' '
>                 sed -n \
>                         -e "/^GIT_PREFIX=/d" \
>                         -e "/^GIT_TEXTDOMAINDIR=/d" \
> +                       -e "/^GIT_CONFIG_PARAMETERS=/d" \
>                         -e "/^GIT_/s/=.*//p" |
>                 sort
>         EOF
> diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
> old mode 100644
> new mode 100755
> index 584240881..02bf41cbd
> --- a/wrap-for-bin.sh
> +++ b/wrap-for-bin.sh
> @@ -20,6 +20,8 @@ PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
>
>  export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
>
> +GIT_OPTIONS="-c core.submodulesfile=${GITMODULES_FILE:-.gitmodules}"
> +
>  if test -n "$GIT_TEST_GDB"
>  then
>         unset GIT_TEST_GDB
> --
> 2.17.0
>
