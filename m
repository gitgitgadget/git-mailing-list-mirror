Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01FD31F453
	for <e@80x24.org>; Thu, 31 Jan 2019 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbfAaOLi (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 09:11:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52597 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfAaOLh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 09:11:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so2654399wml.2
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 06:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hsOgcCn2MHEzGOFi+QNID5dlrQQUlsR2SAhf407tCQY=;
        b=K8j0JtuOfXBGHMeybiZCEhZ4reT+INCGzOY8ZksHc01cL0HVTkAAZG+XIQzE3C5z7z
         N3Eh2eW7YP5xXh1EPMRMbCBtEX9bZ3QCf4Jy86IuZsjs6bkjBlzpeQ6CJMvHqidWSKh3
         GHTfIWrLwvvnBNTAmnvigR5yJ3y3a6QWTVMKiwuzwbRsyo6OPgrviuM6ZfFAwhGYv+fn
         YKJuhOFaeYys0TWupeTYkmsHbOeXJOV6qurRl8y979QnaHbR/zBGL18uaf9tW2wGBs67
         esGRHMZbvwXwiFp0VtQ/wVTB3dOUKjdZgYS7lfghP8A0w0pygqCfbQZkSOK4bMIc1Mwt
         +3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hsOgcCn2MHEzGOFi+QNID5dlrQQUlsR2SAhf407tCQY=;
        b=nkbUf8Dr2Yvc3u+yOvSdViqnlio2oMBrmcakz1JUSpx8bXLPOaR4WgWnDanBvmjRmi
         UQTxjg/UAy1g2mu9elUccwckHCZOLXlMUMxfOfhaZwjHgjeY7rHPqrQ4w3aR/2lGfpQl
         rzlLuD/PNxziSFJKqZqvBDcobA1xk5qu5I0Q1E/nAzkfdQdslvWA1mEGAfo1SEVJBlz7
         btTDIvsa/P14Bs6tuxmKeM6lRktNfDP3zbSJlX7bzZ6qFvNj465flfakUTpmwwxfg4aA
         Hm3nYa3x04Xot2MsiCYJYG1/LI5DBeHJ8O5BfGiWUA0b96eZ/T/n5Q9sfIcUWmwqmyEG
         K74A==
X-Gm-Message-State: AJcUukdlMJUPq8RYwqvKaSpZGXtbfdmnpN5jvjdLMJNpxg25KZwnxoIu
        S92C1pBvOSOt024sVyrHpF0=
X-Google-Smtp-Source: ALg8bN6tbqWPTbEMAhTev4NumqZUj7/KHgs0eC6AwpxY3gQtm02m1BRk+N7QsUad9NhtYMfhgNY/MA==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr31078852wmh.87.1548943895321;
        Thu, 31 Jan 2019 06:11:35 -0800 (PST)
Received: from szeder.dev (x4db675b2.dyn.telefonica.de. [77.182.117.178])
        by smtp.gmail.com with ESMTPSA id w12sm4985054wrr.23.2019.01.31.06.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 06:11:34 -0800 (PST)
Date:   Thu, 31 Jan 2019 15:11:27 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/14] trace2: Documentation/technical/api-trace2.txt
Message-ID: <20190131141127.GA10587@szeder.dev>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
 <pull.108.v4.git.gitgitgadget@gmail.com>
 <60b56d6a8fe9c0e37563f66809cc12c98c9eb21d.1548881779.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60b56d6a8fe9c0e37563f66809cc12c98c9eb21d.1548881779.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 12:56:21PM -0800, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>

> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt

> +== Public API

> +=== Command Detail Messages
> +
> +These are concerned with describing the specific Git command
> +after the command line, config, and environment are inspected.
> +
> +`void trace2_cmd_verb(const char *command_verb)`::
> +
> +	Emits a "cmd_verb" message with the canonical name of
> +	(usually) builtin command, for example "status" or "checkout".
> +
> +`void trace2_cmd_subverb(const char *command_subverb)`::
> +
> +	Emits a "cmd_subverb" message with a qualifier name to further
> +	describe the current git command.

OK, so now we know what is meant by 'verb' and 'subverb'.

Alas, this explanation also clearly shows that the word 'verb' is a
poor fit for what it tries to convey, and 'subverb' is even worse.

Now, I have already noticed that contributors with @microsoft.com
email addresses for some reason tend to be fond of the word 'verb' ;),
and try to use it instead of perfectly adequate and well-established
Git terminology, see e.g. the early versions of the multi-pack-index
patch series:

  https://public-inbox.org/git/20181211015957.GR30222@szeder.dev/

Those commit messages and documentations were improved after all
occurrances of the word "verb" got replaced by the established Git
terms.

I'm pretty sure that this patch series would vastly benefit from
eliminating all "verb"s (and "subverb"s!) in the code, docs and commit
messages as well.

