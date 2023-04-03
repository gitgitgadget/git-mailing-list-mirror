Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765ADC76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 17:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjDCRuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjDCRt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 13:49:59 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F273C15
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 10:49:25 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id q9-20020a170902dac900b001a18ceff5ebso17807370plx.4
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680544113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8G8CFoBZXplNcqJDBysLpuFmtbYjPWgnXiB/VQ4Ums=;
        b=RGE3U+j4+bhM0rLwz2asx5h/J/IhGceJ1Bq6lNdeF/a9G7szAOZiB+wiXe1FMu6pg1
         Jnm+RAAHNO/YgKBLQTwICVUDz+eRfOMHlFnsBaJgwVJmggxlkNQcHtHRhzcTODhfCJ8A
         NuFigNizkMI/67MxT6sfM23D2McIPQxlsOPb/fzoBfNpeCiQqytF+q4nQdb+FAbHvqNl
         dHAXyoppx9cSc/y1MPEzL/N9cr82lmDTF1iiQA3WHQ4XFHLe0jpOsIvpfYaM/2u10/8H
         PMAcdVwQ3zUrpEiYT4FHJz2QdplpHWo55VsL2RTTWNNGboIe7k7g28mnScIhdaB0KZO+
         ncpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8G8CFoBZXplNcqJDBysLpuFmtbYjPWgnXiB/VQ4Ums=;
        b=QA5u/ldVkxo58kcaiNG7V/FhmUkC8508x8KTR7lHrQwecKWqgX5fAz4QvvJhRqEIaY
         sV7bqwd/8cWd6JlvkLO+XGCFaQz4ycMzSJ/lnnwMSfMSSoiuWUgkUmORMnvpemZKkY+E
         MAABDtJnjd+fOClJSIP7eOv/eYu4mmb4eBZefb5vyjUPTU1Nz8ALaXD3SarvaNKzZn6h
         KyQOXj0KPpxOR7ryDwA1ykZj0ZhaUauCRG6AVYgh2VVSgOOX7TTfYeIyAroS+OWr8OCJ
         aCope1F7jDRfpSdI7WZHi6++1IGuQLc4baGpeliMvCwx+sMEwPmFSCrl3Q3XcmN5nBfh
         kBhA==
X-Gm-Message-State: AAQBX9dOs1/CP9LJU+ZwtmAJJPwPnKXNTUe5qKlOWuan8goWf/fmHyw2
        8wR51gT/x58K/a3h7u89Abkgas6wWEwKaA==
X-Google-Smtp-Source: AKy350ZDCtYi9yNmky3IGKeM9RhuHE6tevxa5HxUgY64yD75E4xBVnpKvMMo1za9qdDfEeZUqoERlfJNVMyjkA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90a:bc84:b0:23d:535f:59c7 with SMTP
 id x4-20020a17090abc8400b0023d535f59c7mr11206784pjr.7.1680544113636; Mon, 03
 Apr 2023 10:48:33 -0700 (PDT)
Date:   Mon, 03 Apr 2023 10:48:32 -0700
In-Reply-To: <20230403040724.642513-1-alexhenrie24@gmail.com>
Mime-Version: 1.0
References: <20230403040724.642513-1-alexhenrie24@gmail.com>
Message-ID: <kl6lpm8kzwjz.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] format-patch: correct documentation of --thread without
 an argument
From:   Glen Choo <chooglen@google.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> In Git, almost all command line flags unconditionally override the
> corresponding config option.[1] Add a test to confirm that this is the
> case for `git format-patch --thread`.

[...]

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index dfcc7da4c2..ed299e077d 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -173,8 +173,7 @@ series, where the head is chosen from the cover letter, the
>  threading makes every mail a reply to the previous one.
>  +
>  The default is `--no-thread`, unless the `format.thread` configuration
> -is set.  If `--thread` is specified without a style, it defaults to the
> -style specified by `format.thread` if any, or else `shallow`.
> +is set.  `--thread` without an argument is equivalent to `--thread=shallow`.
>  +

Perhaps more important than the test is that you're fixing blatantly
wrong documentation :)

This leads to the questions of:

a) what is the intended behavior is supposed to be: the documented one,
 or the actual one?
b) if it is supposed to be the documented one, when did it break?

AFAICT, this has _always_ been broken since it was introduced way way
back in 30984ed2e9 (format-patch: support deep threading, 2009-02-19).

		else if (!strcmp(argv[i], "--thread")
			|| !strcmp(argv[i], "--thread=shallow"))
			thread = THREAD_SHALLOW;
		else if (!strcmp(argv[i], "--thread=deep"))
			thread = THREAD_DEEP;

Given how long this has been broken for without anyone noticing, we
should probably just document whatever everyone has been using instead
of wondering what the original intended behavior is.

>  Beware that the default for 'git send-email' is to thread emails
>  itself.  If you want `git format-patch` to take care of threading, you
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 8c3d06622a..b27a72f78a 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -470,6 +470,11 @@ test_expect_success 'thread' '
>  	check_threading expect.thread --thread main
>  '
>  
> +test_expect_success '--thread overrides format.thread=deep' '
> +	test_config format.thread deep &&
> +	check_threading expect.thread --thread main
> +'
> +

The previous test is entirely in the context lines, and we can see that
"check_threading expect.thread --thread main" passes regardless of the
value of "format.thread". Nice.

Thanks!

Reviewed-By: Glen Choo <chooglen@google.com>

