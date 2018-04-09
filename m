Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEBE51F424
	for <e@80x24.org>; Mon,  9 Apr 2018 09:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeDIJ2t (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 05:28:49 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:41695 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeDIJ2s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 05:28:48 -0400
Received: by mail-wr0-f169.google.com with SMTP id s12so8728253wrc.8
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=/GZDfJruOhQEAaOs55x3OlzQax5HzVqt4C4/3JdGOB0=;
        b=F33vS0uVbxnrzb+ee8qVsKVcOkYtBnLwgGPH6czxAW8BF7w731ehzMb8mS4th+hwP2
         +CvV09r4xl3nkVW94oYCYhiZSRvWDwOnzUnrm7oJQzBOGlTyXRaAAyoptd27s/Lu6lZ9
         TPPU0upLNH1aPJDnGyF331iN9xigQ5ZCCoU8wxUIQ5rTzRsTpJ+OveYhnIiPMyg9KNpA
         jQ1mSqyibTW9jLkcCqJfyxOy6IvyM6Dudja6WcLF4xnujRg5ynCOXLG8eJzd7sgS3tOl
         78eXjtHBblJPOKVcPb76y6zzY9029XCbs0YQpfn1Nlvuc2Ji4p2gOzEEzfs+SG0OlXMx
         t91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=/GZDfJruOhQEAaOs55x3OlzQax5HzVqt4C4/3JdGOB0=;
        b=rIGJjxuYXdd6h4LB/XR1tksYnvz6eSa8mgu07FqP/yfjBUmgBdOT990EW50ZwEFUNV
         1loTud73VJZxe0ON4LXlDF76dD0lgoY4++RGVlxBtRRINi7T9r8ZDZu8Ql6Yi34FavVf
         sT2PQnatFBzfcU+wxeNjd700h0f5lmau69Ocna7zmCj+iMXOii6/kevVNYtCbFaB83Ua
         ErU3z0Jlo5RyG4T/gZ+vWtwURKOmNzRnQ4HAAwGg8WBiGwAXKSEXRVD+s9p6XXhxP+tP
         zCPR1Eo9x3MSxO8Ec+Nz21R05tsmUvPw+OdJ+TzSZ7oxOnZ9k9l+vEXqVUF7EVhcEcEW
         dB8w==
X-Gm-Message-State: AElRT7Gk9v4Nz5WxLwjtOEHHyaScy4eiqPnuY/UaSP4kYK9PnyLZqRC6
        Qk1DWAPhtaVV4iCHPAm6M/s=
X-Google-Smtp-Source: AIpwx48QVKQFubfOz1+nmRJGPgckVJ070FivvaaOb6RJ3ijr1gYBUCBSwmKJbtckEcWPKthCqgO+DQ==
X-Received: by 10.223.176.253 with SMTP id j58mr25292925wra.269.1523266127660;
        Mon, 09 Apr 2018 02:28:47 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id w69sm15039601wrb.94.2018.04.09.02.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 02:28:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Vogt <mvo@ubuntu.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] Add "git show --follow-symlinks HEAD:symlink"
References: <20180409090047.lfru2ul5fbnggfg7@bod>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180409090047.lfru2ul5fbnggfg7@bod>
Date:   Mon, 09 Apr 2018 11:28:45 +0200
Message-ID: <87in90zq2a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 09 2018, Michael Vogt wrote:

> I noticed that `git show HEAD:path-to-symlink` does not work and
> returns an error like:
> "fatal: Path 'debian/changelog' exists on disk, but not in 'HEAD'."
>
> Looking at `git show` it seems there is no way right now to make
> git-show show blobs if they are symlinks [1].
>
> It would be nice to have this ability. Attached is a draft patch to
> allow to write: `git show --follow-symlinks HEAD:path-to-symlink`.
> Tests are missing in the patch, I'm happy to add those if there is a
> chance for the feature to get in.
>
> Cheers,
>  Michael
>
> [1] Using `git cat-file --follow-symlinks --batch < input` works but
>     feels a bit less elegant compared to supporting it directly in
>     git-show.
> From 616b7f21c057656960cb6b8a266095bbef734122 Mon Sep 17 00:00:00 2001
> From: Michael Vogt <mvo@ubuntu.com>
> Date: Mon, 9 Apr 2018 10:38:13 +0200
> Subject: [PATCH] support: git show --follow-symlinks HEAD:symlink
>
> Add support for the `--follow-symlinks` options to git-show. This
> allows to write:
>
>     git show --follow-symlink HEAD:path-a-symlink

The patch looks reasonable, but please submit it as described in
Documentation/SubmittingPatches, i.e. inline instead of as an
attachment, and with a signed-off-by line etc. We'd also need some tests
for this.
