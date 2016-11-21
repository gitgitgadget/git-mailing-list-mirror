Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A32D1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 16:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754329AbcKUQ7S (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 11:59:18 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34897 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753978AbcKUQ7P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 11:59:15 -0500
Received: by mail-yw0-f196.google.com with SMTP id b66so28184956ywh.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 08:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uJDlfHPbH7yEFjlywWfOBXtp/SYZv5Hsarz2tWe+Mdw=;
        b=DWw/Iu7VZ1rZA8bMFP+Oc4eEY5TX7dWdZVtehdZnOPbwHXwFxQOfHEWKXivYGnbceX
         rmRejGu0WmfvdOpzOtcQPB/mzTBLs10SXpL6Knyy5cZzYMgVaNzPK4wJDfleilI5nnAw
         kkP+PEt2QNFa9z7lmUuqwCK+a5TDr2I6MRlAhd9hov7HyIdKRCWjG1blHBav8HmFQUgK
         5rEQXiAaGEAdVU968ODBcHyPjgGpkaDQH5SWfj7bhj5Jri5xvld14mIVQqhy44/2FhER
         Pn/ar6NKeGCqZ0qKj5ZM7iWPsWY29Zzl7fYaG8oy6k1HBGbDfbCfHydoIOf0zvzJJ+vU
         Q0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uJDlfHPbH7yEFjlywWfOBXtp/SYZv5Hsarz2tWe+Mdw=;
        b=BQ7BMQeO1bBcC5s9lRI6oTFsdasBJz/4xmG1P0nzqbS90MPnRH8c6Y8kNIimvXkZme
         VwCGW7szhzlciEdFaBf+XMXIg9axyWYnEghK11flv9UWXYufH/Un1FpUMQAevPyxDR48
         X63fMY6GZ4FW/3uCNGxnNyfjWXtAeZ5fevL7LRVzS/XnxUhzt5rmYQ7+xlJpUwdoqV2Z
         NBz34ZadIJ6qgBMyFESDcV77i+pIT16utWV47bT4ICew+tFPqevUWunYpXNS9vz8c5TT
         Sesbe2UmUYyyM/uujw7m6gSWRRNMvKMtKz11glcWWue/ziZHgXHezYuxzlsJfCUVNfAE
         9YrA==
X-Gm-Message-State: AKaTC01pd3qK6XoIrmixqi3U6MqtyoZZWnakJL5yt8qHGIExWgqxRZG10OLqxmAbGfzXJN4RA7oRSU6Hoqow8A==
X-Received: by 10.129.102.132 with SMTP id a126mr14771099ywc.160.1479747555083;
 Mon, 21 Nov 2016 08:59:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Mon, 21 Nov 2016 08:58:54 -0800 (PST)
In-Reply-To: <cover.1479737858.git.johannes.schindelin@gmx.de>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 21 Nov 2016 08:58:54 -0800
Message-ID: <CA+P7+xqq7rNy82_RAoyiJjrC7TwboVJ8UYohARfE5fWNhELeAw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix problems with rebase -i when core.commentchar is defined
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Taufiq Hoven <taufiq.hoven@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 6:18 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The Git for Windows project recently got a bug report that detailed how
> `git rebase -i` fails when core.commentchar=auto:
>
>         https://groups.google.com/forum/#!topic/git-for-windows/eOZKjkgyX1Q
>
> This patch series fixes rebase -i's handling of core.commentchar.
>
>
> Johannes Schindelin (3):
>   rebase -i: identify problems with core.commentchar
>   stripspace: respect repository config
>   rebase -i: handle core.commentChar=auto
>
>  builtin/stripspace.c          |  4 +++-
>  git-rebase--interactive.sh    | 13 +++++++++++--
>  t/t0030-stripspace.sh         |  7 +++++++
>  t/t3404-rebase-interactive.sh | 12 ++++++++++++
>  4 files changed, 33 insertions(+), 3 deletions(-)
>
>
> base-commit: 1310affe024fba407bff55dbe65cd6d670c8a32d
> Published-As: https://github.com/dscho/git/releases/tag/rebase-i-commentchar-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git rebase-i-commentchar-v1
>
> --
> 2.10.1.583.g721a9e0
>

The series makes sense to me.

Thanks,
Jake
