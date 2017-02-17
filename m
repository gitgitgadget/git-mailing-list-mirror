Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID,URIBL_DBL_ABUSE_BOTCC shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63CB201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964868AbdBQW4s (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:56:48 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36679 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964811AbdBQW4r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:56:47 -0500
Received: by mail-pf0-f193.google.com with SMTP id c193so196828pfb.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xaGhjtwi3NKbXv7Re54Q5paZNakplsi/CSVyn/SY9wM=;
        b=YCk/ICeQLPcWUa/oxck8SI4L2hBCilzuZnS1e9e2a0gafT5FxQA1ZgWoRMgwXgyM8v
         DtsmIVD8FHuBdYGfFEB5xaUfptVyP2CSc1WCB8OsP8CqFaDWnAAWM4G6vVUUWY8xk44O
         /1jwFo8OE1s4PxsGPGTtcRGWHzp5B5fwlk3xHCG0q6klJ8YjJOsieNWzUYvxSDsVO1av
         PtnNR8oofjtVqZDTPq/L+3Kw5hE2liivP2ZbUGuC05Kx/ALSxcBxGpBpmrVDMdwpYdiw
         Iq7MfdwpKZpbuEFRP4vOcZlZNw04+/QjDxm8lzPY7ocrtfWiQlYWvXA7UfAFjyInVZWB
         oNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xaGhjtwi3NKbXv7Re54Q5paZNakplsi/CSVyn/SY9wM=;
        b=gCdHWxGvoZ8K1YGL8HuU7fDQ2Ex3tkHmvXqoyyxsy2CvoemqOrUVJSuOUQCnsdLlYS
         WEXVSmrmWzHLKZE14drZDhR6gh8bSpvBDbnq791gKHNVrcBmLJ2yrcCi4J0tpaylnuwZ
         V28GEhzKc7ohU4nXvtrDz0zeSlE4o5Rb4T8BOMJIH940ptponcUgf0BcHE5USfs39mCa
         zC3we+vTxY6kAYO/2ZuZhzUMmswfBriZpLtJP/Lj3qZAWZg31zl9s4dkB2hezmmqtY51
         ze01z575KMlTI6yKH14aOXNPTsNWIc8cdvKoQ9l576/bbg0+bnspyHhNj7lrWWjZ6V0D
         dHnQ==
X-Gm-Message-State: AMke39nnL8bsHHes0+WkFMRb+tNG+zFjW2aah0KyRDji7ABldiWHviN2DeMQ1p/mmBwdgQ==
X-Received: by 10.99.42.78 with SMTP id q75mr12885234pgq.144.1487372206698;
        Fri, 17 Feb 2017 14:56:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id b67sm21394028pfj.81.2017.02.17.14.56.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 14:56:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Gr=C3=A9goire?= PARIS <postmaster@greg0ire.fr>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: dotfiles in git template dir are not copied
References: <ebd661c3-7d99-54d2-dda9-09c4a76cfe93@greg0ire.fr>
        <20170217204411.2yixhuazgczxmmxa@sigill.intra.peff.net>
        <2bae8d8a-f0bf-fa8b-8ce4-6880d3490b43@greg0ire.fr>
Date:   Fri, 17 Feb 2017 14:56:45 -0800
In-Reply-To: <2bae8d8a-f0bf-fa8b-8ce4-6880d3490b43@greg0ire.fr>
 (=?utf-8?Q?=22Gr=C3=A9goire?=
        PARIS"'s message of "Fri, 17 Feb 2017 22:42:43 +0100")
Message-ID: <xmqqk28opgsy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Grégoire PARIS <postmaster@greg0ire.fr> writes:

>> You could, for example, have your template directory itself be a git 
> repository.
>
> I can and I do and indeed, that might be the reason behind this.
> I made a PR to document this : https://github.com/git/git/pull/325

Let's take a look.

> From: Grégoire PARIS <postmaster@greg0ire.fr>
> Date: Fri, 17 Feb 2017 22:33:40 +0100
> Subject: [PATCH] Document dotfiles exclusion on template copy
> 
> Since there is no dotfile in the default template directory, there was
> no point in making the check for . or .. more accurate when copying. Now
> that you can customize the template directory, it would make sense, but
> it's actually a good thing to at this because you would not want to have
> your git directory copied in every git directory that is created should
> you decide to put your template directory under version control. Plus it
> might be used as a feature by people who would want to exclude some
> files.

OK.

> See https://public-inbox.org/git/20170217204411.2yixhuazgczxmmxa@sigill.intra.peff.net/T/#t

I do not think what was discussed there adds much.  Drop this line.

Instead, add your sign-off (Documentation/SubmittingPatches) here

    Signed-off-by: Grégoire PARIS <postmaster@greg0ire.fr>

> ---
>  Documentation/git-init.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 9d27197de8..e3b185cf86 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -117,7 +117,7 @@ TEMPLATE DIRECTORY
>  ------------------
>  
>  The template directory contains files and directories that will be copied to
> -the `$GIT_DIR` after it is created.
> +the `$GIT_DIR` after it is created, unless their name starts with a dot.

"... that will be copied ..., unless they are dot" is not incorrect
per-se, but perhaps rewriting the whole sentence, e.g. "Files and
directories in the template directory whose name do not start with a
dot will be copied to ...", may make it easier to read, I suspect.
