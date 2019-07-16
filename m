Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EB21F461
	for <e@80x24.org>; Tue, 16 Jul 2019 16:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbfGPQN5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 12:13:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36780 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbfGPQN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 12:13:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so15170596wme.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nn+HA3i5WR3Zplqs++NVk+7Xg9KVa9AmMGZNMHpnaG0=;
        b=l64o36wgG/oBPjHdDGPYKbnwPwEW2geSgvNAs8bnT4mmhJ/+0b7w/RBaIYQsbFP9ml
         lxFynTV6u5Z/VBcOFY6/vVJTneSfotYVEa8oCGMXumtsBUfNXcyNxn9+qEM4V/pPAnPy
         yvkFFRWsVU5Rn421R0B801Nc6jIG8Qf+ubpvsoK7f+q+vbfxykdwfG/22I3LD0TIN095
         3p7qFofFJ/Pwv7NlpyHrgnLDcyaeAziJMHfmsQrhQJmMtwPbTBZPzuj+IehruGsIWrDq
         LUmJXEdczi6UgLog1B4D/TAlVt1i2PCJZiWCYr9Lq/aNbwej9QswHCDlO5A/oonqtzvE
         hYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nn+HA3i5WR3Zplqs++NVk+7Xg9KVa9AmMGZNMHpnaG0=;
        b=XLAiNyA0PkxsOhglICuSPujoUYCexsJLEtPfDdhKrtuv5Ch+8H1ZHyM3EuWwIqwTp5
         nY6yBDOh+zXP7uAXuooMafUaZnDdQWM5/UqjDmz+1pLCwVxY3v8Rq2tI+wZkRHiIpzeu
         GN77MSh4U+IpeD3e+Pc/Ny+XDRz7hWcmheKn8O3NYslr1Tvf++29RfUlGU38tYirLhzV
         NgmaJOXAor8P4DuV10j22JJIcdhuvb8PMrwEEtVNBf+vqa3l6YY46dqI9xzUUfEBUC/t
         MHmWHJR1XsuU+iPlakb6CedSHnG5xPT7sqgnpiQB7mjWOfu73ApYbzk4Fv8Lypc96dOU
         lA1Q==
X-Gm-Message-State: APjAAAVuGiw1Jzq/vyXG/zCB2nTszJGoZhTjVvq3eBTOsW5KhRGaxd9F
        6fV6Uh/48Mx6PjxChHsFE7I=
X-Google-Smtp-Source: APXvYqzfTCr4XDdXuujhbcyQN2rzuk9kaoXaOH36YmQr5I+EMv2DobbKZC5kp6J+eJ0HZFfOSedtow==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr32984414wmj.44.1563293635377;
        Tue, 16 Jul 2019 09:13:55 -0700 (PDT)
Received: from szeder.dev (x4db648c7.dyn.telefonica.de. [77.182.72.199])
        by smtp.gmail.com with ESMTPSA id x18sm19817229wmi.12.2019.07.16.09.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 09:13:54 -0700 (PDT)
Date:   Tue, 16 Jul 2019 18:13:51 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] clean: show an error message when the path is too
 long
Message-ID: <20190716161351.GH20404@szeder.dev>
References: <pull.219.git.gitgitgadget@gmail.com>
 <36677556a26cca9eafd859c88aa9b2c5a6cde309.1563285862.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36677556a26cca9eafd859c88aa9b2c5a6cde309.1563285862.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 16, 2019 at 07:04:23AM -0700, Johannes Schindelin via GitGitGadget wrote:
> +test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
> +	git config core.longpaths false &&
> +	test_when_finished git config --unset core.longpaths &&

'test_config core.longpaths false' could replace the above two lines
with a single one.

> +	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
> +	mkdir -p $a50$a50/$a50$a50/$a50$a50 &&
> +	touch $a50$a50/test.txt &&
> +	touch $a50$a50/$a50$a50/$a50$a50/test.txt &&

Is there a reason for using 'touch' to create these files here,
instead of the usual '>"$file"' shell redirections?  Something
Windows/MinGW/long path specific, perhaps?

> +	test_must_fail git clean -xdf 2>.git/err &&

I was puzzled when I saw that '2>.git/err' first, because why put that
file in the .git directory?!  but of course 'git clean' would delete
that file if it were in the worktree.  OK.

> +	grep "too long" .git/err
> +'
> +
>  test_done
> -- 
> gitgitgadget
