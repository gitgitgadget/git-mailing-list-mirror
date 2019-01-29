Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698751F453
	for <e@80x24.org>; Tue, 29 Jan 2019 22:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfA2WrN (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 17:47:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38619 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfA2WrN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 17:47:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so19693340wml.3
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 14:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FG6fLOIouqm13X8EiMUzNQ46TZxDLNhcDS+GeZqn3jY=;
        b=cRp9l3NEj6Y68Iu/jx+v+FmipbRbJP1LBIVmtwaRfFrEDLyZaCevaJs5XlYQNKy8o3
         boudhAPYK9WfTZ0TguGDHTrR2tDth4cxZWuavfScqyRmXjOHtkQZA64iXQpeTkta0osj
         6ZhFXE6goMUowdtBwrZm1nF59UHabQm0WHfYP1nzkxwBvEZSHzO2oKNDc22Li1qjbJS5
         3cQibJymFMIyZWb3xS9oaDiuFcJ3CJ1om8Cz3JYjxuzSZ7tEF9AyHRd6C3nKafoa/oOK
         CQxMsO6wnwVOorfU2/FaEhdtgoRai9L9LNgyZ0r9QKP8uXQ+t2/1pVHclMLk7cD2q+Pz
         0kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FG6fLOIouqm13X8EiMUzNQ46TZxDLNhcDS+GeZqn3jY=;
        b=e+u4lPi40Xl/uH+rOTKz/G7IqLoHwkEuPEThw5XyDhs0Z0yjhRvlXZQUllcrMVSIjq
         nN+N/UNKX4E16H9z7WvMbeED+YbpTTN7BsmaS4QEeonfIGh9eDz1epR3SD0SwcQe7nMe
         qXD6eUQUfe8aJZF2e8KUKg2oEhgldr9eEXq93Bd40WRf4KqJte5dioNDXTZz1DpNmHHs
         CI67LjbDTzyXC9sEAgDbzdYoVUq2zmpMqNvZJIQXTNJxSdpVJdrfaMUr4mSq/vYhXyPc
         boQRRAzo0/LZj+rF5xRZbfNsiKQhNbcWbXP0ES6IrA7zUWaHbwfGEdvu/B7H4L36hWBs
         W0CQ==
X-Gm-Message-State: AJcUukc6v14sEZAzELiZl0fyRJmmE6wHPLELNCt/qo5O1MlV3uJgwQ/9
        5DazX8O9x0IWVOMHtR5tcVQ=
X-Google-Smtp-Source: ALg8bN6/3QxDwRAhA469x2iSQUolUDiMUDah46GsPOeAMKXfYxnGsPPM/XH11Fvkm6dLcxyE/x/rRQ==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr22403432wmg.79.1548802031109;
        Tue, 29 Jan 2019 14:47:11 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f3sm220172wmd.22.2019.01.29.14.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 14:47:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 02/13] test-lib: Export PERL5LIB for testing git-svn
References: <20190129193818.8645-1-jeremyhu@apple.com>
        <20190129193818.8645-3-jeremyhu@apple.com>
Date:   Tue, 29 Jan 2019 14:47:09 -0800
In-Reply-To: <20190129193818.8645-3-jeremyhu@apple.com> (Jeremy Huddleston
        Sequoia's message of "Tue, 29 Jan 2019 11:38:08 -0800")
Message-ID: <xmqq1s4v6pzm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:

> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> ---
>  t/test-lib.sh | 3 +++
>  1 file changed, 3 insertions(+)

This obviously won't be acceptable as-is to my tree.  Shouldn't this
be something to be dealt with in config.mak.uname or something that
is meant to define platform-specific customization?

>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0f1faa24b2..4060a53f56 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1017,6 +1017,9 @@ fi
>  
>  GITPERLLIB="$GIT_BUILD_DIR"/perl/build/lib
>  export GITPERLLIB
> +PERL_VERSION=$(grep DEFAULT /usr/local/versioner/perl/versions | sed 's:^.*= *\([^ ]*\)$:\1:')
> +PERL5LIB="$GIT_BUILD_DIR"/perl:"$(xcode-select -p)"/Library/Perl/$PERL_VERSION
> +export PERL5LIB
>  test -d "$GIT_BUILD_DIR"/templates/blt || {
>  	error "You haven't built things yet, have you?"
>  }
