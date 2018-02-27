Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2BA1F576
	for <e@80x24.org>; Tue, 27 Feb 2018 09:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeB0JMR (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 04:12:17 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:39953 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeB0JMP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 04:12:15 -0500
Received: by mail-oi0-f41.google.com with SMTP id c12so12350004oic.7
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 01:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=najjWW+jSQQXNg4sdMdI825CgLWUnCGzso1STy3DaUQ=;
        b=temgD4R5XZNpWKThZPPwJ1iFJ/CoKWy1a/CsmHwKojXwKUHHQfnBl+vNwbKEArEgBL
         b3KMGrJZBaD3RYoqN1WYWzvNWWlQR+9prtiUASHS4i9uSozN98g0jsYNxSktvmKM7Y/K
         DDFIWxsnzgcThwdNeycUQZtuap9NojSyTDkfn8CRJrOcEqKvrAwQsFXtsFdBtZL6p8UL
         M8o4Un51jHhZP0dvztPuyZ+0RUC2rlMbjfdqkBQ1mMVUSOZgIcnYKtQKI6Jdxv816DgM
         NrwmPu8o2dbDJMSJLVYBDZyveXJ4o9vavYP/LUjzHhZ21YrWy9eA9aqO8kyx3ytjlz16
         FxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=najjWW+jSQQXNg4sdMdI825CgLWUnCGzso1STy3DaUQ=;
        b=cuDKb9p+L5rDU4J4PVCXqpCmkNrlelHiJHdn8Tbjd2ATPRKX4CYlG2AsoVt6aj/vyr
         e55f28PHfRBQUegMJvMSxi3yr48aLrEcWK0Xm/RMGWrErFMXHlDKs9TfsQi+4PwQhf4/
         OCX2qaDjPEuswQr7rZpE2QvZJWboaT0LIwWK0PkwBOCp6+ICjqx7AOXhyCJfNRzvAbDd
         sTS5p0GBnzLXmRGhxh+a6Bm2EIToNyE3hHst4HtRcgRE7sDesuOVDnspWevX/1H2TLzr
         3Z812svu7sY6aQqu7ZWXO8NYmTYw5ACf4akNB5/iAZ10Vyrx9l2FsJpADNHmYFdiRvVF
         jy0w==
X-Gm-Message-State: APf1xPCJUdQevyjGK48CyXzvwa7/Qx/YYH6FOlv/9aO1nucthrjKhlNV
        kxrQ2lDLCtxNPQxCsl5veu6/Ibybi1E/JOL+dug=
X-Google-Smtp-Source: AG47ELsFFZUGXjqNKt6zDmoRxkq5U6fEKmOssQisODVFHFPTRPapXhlBlCqCUIia8AXC1jiGmZjI8DJuiTb3AJxsxws=
X-Received: by 10.202.83.129 with SMTP id h123mr8827848oib.228.1519722734436;
 Tue, 27 Feb 2018 01:12:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 27 Feb 2018 01:11:44 -0800 (PST)
In-Reply-To: <CAPig+cRkEzN-dHh9R0cX5gOhsJ7X5evAMfpWuCnVp_QN3uz8ng@mail.gmail.com>
References: <20180214180814.GA139458@google.com> <20180226103030.26900-1-pclouds@gmail.com>
 <20180226103030.26900-2-pclouds@gmail.com> <CAPig+cRkEzN-dHh9R0cX5gOhsJ7X5evAMfpWuCnVp_QN3uz8ng@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Feb 2018 16:11:44 +0700
Message-ID: <CACsJy8AqXNGMdCmF5smooLyWBuiKmXG6mckquiPekWZ8GwF5Qg@mail.gmail.com>
Subject: Re: [PATCH 1/4] repository.c: move env-related setup code back to environment.c
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 1:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:

>> +       repo_set_commondir(repo, o->shared_root);
>
> The repo_set_gitdir() prototype (below) makes it seem as if the last
> argument ('o', in this case) is optional, presumably by passing in
> NULL, however, this code does not appear to be prepared to deal with
> NULL.

I know. I went this this struct because I really hate to write lots of
NULL without names

    repo_set_gitdir(gitdir, NULL, NULL, NULL, ...);

but I could not find a nicer way to make the whole struct optional,
not without repeating more code or using preprocessor. Given that this
function has 3-4 call sites max, I think it's still ok.

>
>> +       expand_base_dir(&repo->objects.objectdir, o->object_dir,
>> +                       repo->commondir, "objects");
>> +       expand_base_dir(&repo->graft_file, o->graft_file,
>> +                       repo->commondir, "info/grafts");
>> +       expand_base_dir(&repo->index_file, o->index_file,
>> +                       repo->gitdir, "index");
>>  }
-- 
Duy
