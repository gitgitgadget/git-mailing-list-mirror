Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162B71FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 18:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbcGLSZE (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 14:25:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32960 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcGLSZD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 14:25:03 -0400
Received: by mail-it0-f66.google.com with SMTP id d65so1549872ith.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 11:25:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jevthP2dzIfEhRSlO9m87W1oAHZstQg04yY7RURt9Kw=;
        b=YeFTz0nPVQkq2DzHbEOSSOxRoZruqj279dNvW23x96E98Wc9Y95+7d5RnKmHORykps
         Pz4yNMhpViAbh8v1YmjC0G0RuKyZurUGnAfjW1FEZyMNo07auUQHzPzg7iMV27bKmI9R
         1pmBMO6MYDbhYLVsV5fpd6z8k0+en+XfIlkxI4LXUZnU2iUwsCJTrma/PmanBZQeVyG7
         Vb81GUTEZCoFnYpF50ryhetLbkC5SfBq0pjPLWWanleOY3vCay9aTsIHi7VQW6gpVqpB
         27GG6PYFx4pnTC0k+IJohTrPrtuanzTnETi8f7Mr1PAZyrU88j9d0jnleU/MxLZVIRF4
         /tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jevthP2dzIfEhRSlO9m87W1oAHZstQg04yY7RURt9Kw=;
        b=YxYC2Br9F2oDkOMIz9rdEazPr07riDw6kxaxmRwI+RKghQ1iEdqtHGmMTJsYelmYC8
         jGuV569GJxXUK+IqEgGpn8GPBVYqh6VygRa9A90EiPgmkIUiTNK4kQdQvOJuVjnsbr+j
         H+EH/6H/G0mC3LmwDKU2jhiczoBhd8z2MzUECaab5SHQHtWS73tusMXHYbPhyP3Zuz8Y
         gY7RweXMXYXDQ9NChP5mWMeFrkPVlZnyu3UsRWEAFqKM/QFab36BjqmGfNImcjqllEwe
         zX47CL4C6GEB/nhyfHMo4oU1uYdtHEBXTWbFvixF3TqVXiYMiuxunwx5Cc5KZD1AzXob
         WJ2A==
X-Gm-Message-State: ALyK8tLXQCrcyEOaE9SZa4FlLXCk5T8sqpzBTssTU1k511J6GbrjG8bElFw/3RDaP69OFhATIbAHnv/SV8NDzw==
X-Received: by 10.36.81.15 with SMTP id s15mr4688098ita.57.1468347901285; Tue,
 12 Jul 2016 11:25:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 12 Jul 2016 11:24:31 -0700 (PDT)
In-Reply-To: <1467532693-20017-1-git-send-email-novalis@novalis.org>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 20:24:31 +0200
Message-ID: <CACsJy8Br-rSTKjpt2ykn8YyFruy8CZoXWm287BtTRcAYY2DjVw@mail.gmail.com>
Subject: Re: [PATCH v14 00/21] index-helper/watchman
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>, kmaggg@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Just thinking out loud. I've been thinking about this more about this.
After the move from signal-based to unix socket for communication, we
probably are better off with a simpler design than the shm-alike one
we have now.

What if we send everything over a socket or a pipe? Sending 500MB over
a unix socket takes 253ms, that's insignificant when operations on an
index that size usually take seconds. If we send everything over
socket/pipe, we can trust data integrity and don't have to verify,
even the trailing SHA-1 in shm file.

So, what I have in mind is this, at read index time, instead of open a
socket, we run a separate program and communicate via pipes. We can
exchange capabilities if needed, then the program sends the entire
current index, the list of updated files back (and/or the list of dirs
to invalidate). The design looks very much like a smudge/clean filter.

For people who don't want extra daemon, they can write a short script
that saves indexes somewhere in tmpfs, and talk to watchman or
something else. I haven't written this script, but I don't think it
takes long to write one. Windows folks have total freedom to implement
a daemon, a service or whatever and use this program as front end. How
the service talks to this program is totally up to them. For people
who want to centralize everything, they can have just one daemon and
have the script to talk to this daemon.

I can see that getting rid of file-based stuff simplifies some
patches. We can still provide a daemon to do more advanced stuff (or
to make it work out of the box). But it's not a hard requirement and
we probably don't need to include one right now. And I think it makes
it easier to test as well because we can just go with some fake file
monitor service instead of real watchman.
--
Duy

On Sun, Jul 3, 2016 at 9:57 AM, David Turner <novalis@novalis.org> wrote:
> This addresses comments on v13:
> removed unnecessary no_mmap ifdef
> add an ifdef in unix-socket
> OS X fix for select()
> test improvement
>
> Thanks to all for suggestions.
>
> David Turner (10):
>   pkt-line: add gentle version of packet_write
>   index-helper: log warnings
>   unpack-trees: preserve index extensions
>   watchman: add a config option to enable the extension
>   index-helper: kill mode
>   index-helper: don't run if already running
>   index-helper: autorun mode
>   index-helper: optionally automatically run
>   index-helper: indexhelper.exitAfter config
>   mailmap: use main email address for dturner
>
> Nguyễn Thái Ngọc Duy (11):
>   read-cache: allow to keep mmap'd memory after reading
>   unix-socket.c: add stub implementation when unix sockets are not
>     supported
>   index-helper: new daemon for caching index and related stuff
>   index-helper: add --strict
>   daemonize(): set a flag before exiting the main process
>   index-helper: add --detach
>   read-cache: add watchman 'WAMA' extension
>   watchman: support watchman to reduce index refresh cost
>   index-helper: use watchman to avoid refreshing index with lstat()
>   update-index: enable/disable watchman support
>   trace: measure where the time is spent in the index-heavy operations
>
>  .gitignore                               |   2 +
>  .mailmap                                 |   1 +
>  Documentation/config.txt                 |  12 +
>  Documentation/git-index-helper.txt       |  86 +++++
>  Documentation/git-update-index.txt       |   6 +
>  Documentation/technical/index-format.txt |  22 ++
>  Makefile                                 |  22 ++
>  builtin/gc.c                             |   2 +-
>  builtin/update-index.c                   |  15 +
>  cache.h                                  |  25 +-
>  command-list.txt                         |   1 +
>  config.c                                 |   5 +
>  configure.ac                             |   8 +
>  contrib/completion/git-completion.bash   |   1 +
>  daemon.c                                 |   2 +-
>  diff-lib.c                               |   4 +
>  dir.c                                    |  25 +-
>  dir.h                                    |   6 +
>  environment.c                            |   2 +
>  git-compat-util.h                        |   1 +
>  index-helper.c                           | 469 +++++++++++++++++++++++++++
>  name-hash.c                              |   2 +
>  pkt-line.c                               |  18 ++
>  pkt-line.h                               |   2 +
>  preload-index.c                          |   2 +
>  read-cache.c                             | 531 ++++++++++++++++++++++++++++++-
>  refs/files-backend.c                     |   2 +
>  setup.c                                  |   4 +-
>  t/t1701-watchman-extension.sh            |  37 +++
>  t/t7063-status-untracked-cache.sh        |  22 ++
>  t/t7900-index-helper.sh                  |  79 +++++
>  t/test-lib-functions.sh                  |   4 +
>  test-dump-watchman.c                     |  16 +
>  unix-socket.h                            |  18 ++
>  unpack-trees.c                           |   1 +
>  watchman-support.c                       | 135 ++++++++
>  watchman-support.h                       |   7 +
>  37 files changed, 1578 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/git-index-helper.txt
>  create mode 100644 index-helper.c
>  create mode 100755 t/t1701-watchman-extension.sh
>  create mode 100755 t/t7900-index-helper.sh
>  create mode 100644 test-dump-watchman.c
>  create mode 100644 watchman-support.c
>  create mode 100644 watchman-support.h
>
> --
> 1.9.1
>



-- 
Duy
