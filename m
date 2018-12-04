Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F83F211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 20:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbeLDUJw (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 15:09:52 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:33587 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeLDUJw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 15:09:52 -0500
Received: by mail-ed1-f42.google.com with SMTP id p6so6768993eds.0
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 12:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8umTtDcmC/0ZOEdp+c55fgpbnLcxntyEFYvGyat/dE=;
        b=SwpiQPUZUWX4KFw6bZ1i06nOYYiS6TAsQNyg1i7xNlnqujS9c3cZNe+b6YDQ9KqP+R
         jzKdsdGmiRIvTy/uSZCWTGnW5j1CKJpi/oDqF5NLCSramzvMyGHUoB5bGFLZmIFBO0Cg
         bxIIaNkt5D1wj+KZ0N/ksj5hAomNbjwUVMSqWzRkEtmR7x1bxpikWFBmUYsdy7UTY3rT
         B4HhcdLkxYBNhxtW7pKV4i5QOk+r0Y9poCpV9vOnMIcypdkIqoVQ7yTT1WEIS/fBy+iF
         hQjcuwF8mGT38WDYeKGFf30J6vxeGeY2P4Ag4Bi6N7pX3Q104LzlF7v140pwO2/S2a0I
         XZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8umTtDcmC/0ZOEdp+c55fgpbnLcxntyEFYvGyat/dE=;
        b=f58CrEaP1BP2LINyZ4P8bwzUTaCPhXdB8wRZLTD+bYPDKbTKeyYzogLmaYgVp7PtV4
         5EEpBmq8eqiqSmPcJxJgryhMCJa1ODseU0ym4zw8p+QVLC9xNEBnD84anBMFQeHGPfIl
         BCGzA7wyWGi+CvOuX2Ts+G7oAjC+7kTxTR1lCaK9en7cc2yv5wDx6Sokq/J2c3LNgNj/
         UTse3CUQN/P11l4+23zwv4ngaYLCgt7uWHVCTeA22jbXn4KQGlVupaPTJP+/+0dhkWk3
         ikoayqbNRc6mMMl2ZFOorzOrdeaI9NF11e2rgyzFkrENX41FEoWD/lq+Kiu6sW39dPN1
         vrWA==
X-Gm-Message-State: AA+aEWZSsNQW6ds2/0t0j54xWYNSt7X6SZ+7HYM0+7Sa2b+lhOhii//c
        CdNNPV+vvfq149ZFcZyeCztZbgjd8/BKykzm/1IJvw==
X-Google-Smtp-Source: AFSGD/Uns81jFtohWJ7NqFWLVOnEDxZfwiklLq4QSFfUxJZRzrv9oi3o20FKJdbihFkJ2yjX7GP4eCcGNU5kZ1zADBM=
X-Received: by 2002:a17:906:3712:: with SMTP id d18-v6mr16603621ejc.126.1543954189222;
 Tue, 04 Dec 2018 12:09:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543879256.git.jonathantanmy@google.com> <707a8181a0e8cd2e21989fa6da59cee38d9fadde.1543879256.git.jonathantanmy@google.com>
In-Reply-To: <707a8181a0e8cd2e21989fa6da59cee38d9fadde.1543879256.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Dec 2018 12:09:37 -0800
Message-ID: <CAGZ79kYhemdUjxQcOZ6ryofh6XddfFZB6zG29grQwstC=VeV-g@mail.gmail.com>
Subject: Re: [WIP RFC 5/5] upload-pack: send part of packfile response as uri
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 3, 2018 at 3:38 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> This is a partial implementation of upload-pack sending part of its
> packfile response as URIs.

It does so by implementing a new flag `--exclude-configured-blobs`
in pack-objects, which would change the output of pack-objects to
output a list of URLs (of the excluded blobs) followed by the
pack to be asked for.

This design seems easy to implement as then upload-pack
can just parse the output and only needs to insert
"packfile" and "packfile-uris\n" at the appropriate places
of the stream, otherwise it just passes through the information
obtained from pack-objects.

The design as-is would make for hard documentation of
pack-objects (its output is not just a pack anymore when that
flag is given, but a highly optimized byte stream).

Initially I did not anticipate this to be one of the major design problems
as I assumed we'd want to use this pack feature over broadly (e.g.
eventually by offloading most of the objects into a base pack that
is just always included as the likelihood for any object in there is
very high on initial clone), but it makes total sense to only
output the URIs that we actually need.

An alternative that comes very close to the current situation
would be to either pass a file path or file descriptor (that upload-pack
listens to in parallel) to pack-objects as an argument of the new flag.
Then we would not need to splice the protocol sections into the single
output stream, but we could announce the sections, then flush
the URIs and then flush the pack afterwards.

I looked at this quickly, but that would need either extensions in
run-command.c for setting up the new fd for us, as there we already
have OS specific code for these setups, or we'd have to duplicate
some of the logic here, which doesn't enthuse me either.

So maybe we'd create a temp file via mkstemp and pass
the file name to pack-objects for writing the URIs and then
we'd just need to stream that file?

> +       # NEEDSWORK: "git clone" fails here because it ignores the URI provided
> +       # instead of fetching it.
> +       test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" \
> +               git -c protocol.version=2 clone \
> +               "$HTTPD_URL/smart/http_parent" http_child 2>err &&
> +       # Although "git clone" fails, we can still check that the server
> +       # provided the URI we requested and that the error message pinpoints
> +       # the object that is missing.
> +       grep "clone< uri https://example.com/a-uri" log &&
> +       test_i18ngrep "did not receive expected object $(cat h)" err

That is a nice test!
