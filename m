Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C7220248
	for <e@80x24.org>; Sun,  3 Mar 2019 13:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCCNaF (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 08:30:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32903 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfCCNaF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 08:30:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id c13so2067288wmb.0
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 05:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wEos3mP1zaJXxJw0bG1WqK5mjPHvrHdVR4uwXnHoGqs=;
        b=q9LjgQilXRniH26ZKSUkYcnwOkMQIFQgbZD2QPnTP1LBDTMW1+u3A150F8nfScDyGD
         E/7uv5r457K7HgZOdTNUPpiXc/+aZ6Bg7LbREqb8gOEB4+DsyEftf3EU8BUYu4R74cP+
         xBDT1mTKwCfsVViVHORhfrUbc+pKRpNbJw9YHpIB3zTIU1G6/qShHRt14Uv0YLojxH6U
         QgexirSy+qVUEP762wMNDEMHZOUqGLFEgeDCmEl0DJwFB3mH56ZQcj9X9fjmko3aXLB1
         ElVZg0JnPcy3xwkmUpZcTXCZvZkTIHvt9pT/svbSefxTcB7A1qKl2ixWqYb2itpjO5Jb
         5Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wEos3mP1zaJXxJw0bG1WqK5mjPHvrHdVR4uwXnHoGqs=;
        b=G5ZYvhJOXnqSRNd7Gw4/PSKLW2muuY5SfZmuHmZ+FK86Lkykgc1mmfBTMIRJp/tSX8
         zgSGz17mpAXZeqhTAu50Os4EuCbjsIQ23y5Iw3NScXK3hWya8XAxaVEdQMOyF5mA/bqE
         1J9qjA6+mNbMBUHw4OUfgtzSpoJj4kZ+qz9vJok2rnezWvPjdk2QoiucZ6zVYuHSYdnZ
         4j3tJWqy5n3J1j/wuGTia1hf+POC9mDIREBVkHK07JfUT+d/coao7sT1PF03DDa7y0bo
         8U9+AjRhGcbrV4fy23lSoyjA75BKee8q/Pi+2Uc1amHdx3MSQNOIed+Fgdby9dFMbp8l
         r+Kg==
X-Gm-Message-State: AHQUAuZTS06WDUxW12G/UU94mhTgoDTlEpis07N8iaKLAJzGe/dgY/mR
        WzQ/1252QJUcc6XibBApLeQ=
X-Google-Smtp-Source: AHgI3IbHEUq63D4MscmPCF62YVj5a12gHdRB8WdDYtYO5namRvskd55qMiuOmb/VTeJysUXc6i+8Vw==
X-Received: by 2002:a1c:c187:: with SMTP id r129mr8279543wmf.107.1551619803217;
        Sun, 03 Mar 2019 05:30:03 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p6sm14663330wre.63.2019.03.03.05.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 05:30:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        t.gummerer@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH 2/3] t3600: refactor code according to contemporary guidelines
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
        <20190303122842.30380-3-rohit.ashiwal265@gmail.com>
Date:   Sun, 03 Mar 2019 22:30:02 +0900
In-Reply-To: <20190303122842.30380-3-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Sun, 3 Mar 2019 17:58:41 +0530")
Message-ID: <xmqqwolgytk5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> Subject: Re: [PATCH 2/3] t3600: refactor code according to contemporary guidelines

Please do not overuse/abuse the verb "refactor" like this.  What the
patch does is only reformat---it does not do common "refactoring"
transformations like factoring out common/duplicated code into
helper functions, etc.

If we are doing this step, let's make sure all tests use the modern
style correctly.

>  # Setup some files to be removed, some with funny characters
>  test_expect_success \
> -    'Initialize test directory' \
> -    "touch -- foo bar baz 'space embedded' -q &&
> -     git add -- foo bar baz 'space embedded' -q &&
> -     git commit -m 'add normal files'"
> +	'Initialize test directory' "
> +	touch -- foo bar baz 'space embedded' -q &&
> +	git add -- foo bar baz 'space embedded' -q &&
> +	git commit -m 'add normal files'
> +"

In the modern style, we'd write this like so:

	test_expect_success 'initialize test directory' '
		touch -- foo bar baz "space embedded" -q &&
		git add -- foo bar baz "space embedded" -q &&
		git commit -m "add normal files"
	'

In addition to indenting with HT (not SP), two more points are

 - test title comes on the first line;

 - test body is enclosed in a single quote pair, opened on the first
   line and closed on the last line.

>  
> -if test_have_prereq !FUNNYNAMES; then
> +if test_have_prereq !FUNNYNAMES
> +then

This is good.

>  	say 'Your filesystem does not allow tabs in filenames.'
>  fi
>  
>  test_expect_success FUNNYNAMES 'add files with funny names' "

This has title on the first line, and opening quote of the body as
well, which is the modern style.

>  test_expect_success \
> -    'Pre-check that foo exists and is in index before git rm foo' \
> -    '[ -f foo ] && git ls-files --error-unmatch foo'
> +	'Pre-check that foo exists and is in index before git rm foo' \
> +	'[ -f foo ] && git ls-files --error-unmatch foo'

We prefer "test ..." over "[ ... ]" (Documentation/CodingGuidelines).

Thanks.
