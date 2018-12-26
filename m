Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A20C41F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbeL1UMR (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:12:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51557 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbeL1UMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:12:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so19681946wmj.1
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=b5IrIX7CFDes64s6712DmdvOQ/e2A9eQOdfrKj3k7BU=;
        b=E+QSAHhA3iQwg7lysBBPczLd58UNg6Gyh1H4d4EBH/iILYql9tSrhrfdI81C0bqE5v
         WjToDHkMDxfG7tL2Yax3zbPZU1gatDpH55jbIYpvyHDNV/MD4y10u8q4Ze6FdZZ9oJ9n
         /Coe6U7MWssncz1a1xLiz5RgizkX5aSEC52xcTzHEoyYSEy8M02IOXCSvlmPY042lvyX
         H93dUNg93Qcokfvin1VJ0QzBczN4ygXCaf1D65Uksd3m5s3USMPNqcRkx5C9LCHl5kKb
         P7wjmUE7r8Obba0OYHHLHSBJmHTt+nVYYa+jgJt4Yb2S4LVn591hVk4wcm4bnVySAR/Y
         Va2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=b5IrIX7CFDes64s6712DmdvOQ/e2A9eQOdfrKj3k7BU=;
        b=HZMs7F4F+/jd2fER6cPWAbgSQLHS7P/xBZG3FitDsX2AzXSIk7GLX7+ZIKIJPjMQ+N
         TuRo8PdN+HoI8iMUxJyXoRLDOQ8N4FwixtlffAvJkSmX2uNU72BT9DxBdB/H/VwrN9Tm
         LbNW63wyunWQV5MAYu7pIiegNUzs9TepTFKfdtvgbLwbE4Ugh22r6LkxK6SmC/JBsPmo
         I96bQwd+t7wDcUy6SQzjq6ceYQht/mvDfDBakhm/ZOSydf4uAE9Aa103B7GeXY3d9q56
         MkyIDGAxMkAm0nLbESPPqE2oJ98MBjZ/qVeAymgwAvtbRQIdLzzhzT8iztY6h5IUtKDo
         GVfQ==
X-Gm-Message-State: AA+aEWZqQePxn5a8lgcaeUD6iiZ0JXJqZosYFORvvv/bzVbHapv4jvrL
        c4KRCPSLY7SPVvfSD/xx4oReaNqe
X-Google-Smtp-Source: ALg8bN6nljh77Mk/rxPGi1AE5U/Nb2CSCYkFMrSC2yxOoEBHII8m2e+OSs2q+tVwGiGCA2s87YCKhQ==
X-Received: by 2002:a1c:7eca:: with SMTP id z193mr26484638wmc.140.1546027935223;
        Fri, 28 Dec 2018 12:12:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e17sm49888896wri.36.2018.12.28.12.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:12:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] submodule update: add regression test with old style setups
Date:   Wed, 26 Dec 2018 10:21:25 -0800
References: <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com>
        <20181214235945.41191-1-sbeller@google.com>
        <20181214235945.41191-2-sbeller@google.com>
Message-ID: <xmqqefa1o1gi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The place to add such a regression test may look odd in t7412, but
> that is the best place as there we setup old style submodule setups
> explicitly.

Makes sense; thanks.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t7412-submodule-absorbgitdirs.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index ce74c12da2..1cfa150768 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -75,7 +75,12 @@ test_expect_success 're-setup nested submodule' '
>  	GIT_WORK_TREE=../../../nested git -C sub1/.git/modules/nested config \
>  		core.worktree "../../../nested" &&
>  	# make sure this re-setup is correct
> -	git status --ignore-submodules=none
> +	git status --ignore-submodules=none &&
> +
> +	# also make sure this old setup does not regress
> +	git submodule update --init --recursive >out 2>err &&
> +	test_must_be_empty out &&
> +	test_must_be_empty err
>  '
>  
>  test_expect_success 'absorb the git dir in a nested submodule' '
