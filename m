Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85FD420248
	for <e@80x24.org>; Mon, 15 Apr 2019 07:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfDOHIi (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 03:08:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38969 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDOHIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 03:08:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so18831791wmk.4
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 00:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=rm1i1+F/qnNE8IYWiRd/yQ6NYrbWE8HJFNMwKuMdbwI=;
        b=cBj+Ef8WHKWKNjRA1ifh6H5eKn6USp0TTVpWzr+6j6Fo4bKCmkdXXc92opDmmQiUWT
         mkOBvBSn47CHn+lapF+i2ZI7rQJUEyDQEhJ23DejTfGpzvWZUTsKmlkyRbFmqw7jO9VH
         +69o0y/B1JN1CWKWiphASEakOWRGpvRqb1CnJeKj+URKyaQ8tz5/SvWVargkc+mxcPwB
         dM15e831daHoFWS25clFUM01Cyl1l+wU9vsuFfZyM6FJhRSdhfRqqby52PSYVxQOwPEE
         uHw2a1NMLD94OfIWNMYnDo0THtrsKLCJfA4GP/G0FFbqV0t8ACugAMIvUxdQ/QqKmXsE
         p1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=rm1i1+F/qnNE8IYWiRd/yQ6NYrbWE8HJFNMwKuMdbwI=;
        b=EYMIxI5+gNPQtEsEOtZn+BN3odfFlgI5Fsj0GNzNdQ5gv4/FTQk0sbWUY9sir+Dt9t
         HUiAo6G9gp+h3J2OrRvvGm2Lwdv4oCykzeJB3jbVNtiWEQ4KyopHGZjI/A3Uog2gx7gD
         5VTdqGrT6LB8Pi/wS+BOFddL+vFX/ohvtfAMf/98ReED2U2z3g3zQ2V8Gatwxrt7jknA
         6W+/CC9oT9UfKyJtDyg922C8vTrc7BO3qyAXNyit+p0MOFMEmMozsrAvh+VYbTVqMiKC
         Wzw2MlLyrGo06/P9DtHRS+TkGpK0CFky289jYvwMJLhyjd58KdRCOW3J0TJ+KkyNppox
         coFQ==
X-Gm-Message-State: APjAAAXFfKoVqiPZ1poXxCJ+4jGP+t3WVwfD6vKlRRsHfirE/VTDUGLQ
        b2BN6ONFoYqQDfR4r/Hnr/oOj7meXK8=
X-Google-Smtp-Source: APXvYqzSENS0nuu1XCtjI0xomdLmWZxDp6Aqwdv7WqFiVsn8cHexlKiFkX333PnW5J5eVFaPd7cc7w==
X-Received: by 2002:a1c:a70f:: with SMTP id q15mr20371777wme.28.1555312116183;
        Mon, 15 Apr 2019 00:08:36 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y17sm59537124wrh.60.2019.04.15.00.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 00:08:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/7] remote-testgit: move it into the support directory for t5801
References: <pull.168.git.gitgitgadget@gmail.com>
        <81c08b178be6329d51586fa9d615063d3c6f9625.1555070430.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Apr 2019 16:08:34 +0900
Message-ID: <xmqqv9zfsq31.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `git-remote-testgit` script is really only used in
> `t5801-remote-helpers.sh`. It does not even contain any `@@<MAGIC>@@`
> placeholders that would need to be interpolated via `make
> git-remote-testgit`.
>
> Let's just move it to a new home, decluttering the top-level directory
> and clarifying that this is just a test helper, not an official Git
> command that we would want to ever support.

Makes sense.

> @@ -657,8 +656,6 @@ SCRIPT_PERL += git-svn.perl
>  
>  SCRIPT_PYTHON += git-p4.py
>  
> -NO_INSTALL += git-remote-testgit
> -

The line lost here was the last one that updated the value of
NO_INSTALL, so we should be able to lose all the mentions of the
make variable now.

> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index aaaa722cca..d04f8007e0 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -8,6 +8,8 @@ test_description='Test remote-helper import and export commands'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-gpg.sh
>  
> +PATH="$TEST_DIRECTORY/t5801:$PATH"
> +

I guess this makes much more sense than having it next to other test
helpers, as t5801 is the home for the remote-helper tests.

Thanks, will queue.
