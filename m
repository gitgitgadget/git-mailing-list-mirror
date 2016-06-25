Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C821FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 14:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbcFYOeU (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 10:34:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36348 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbcFYOeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 10:34:18 -0400
Received: by mail-io0-f195.google.com with SMTP id s63so19696706ioi.3
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 07:34:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uoAhQm+a9FZof4qECV3R9Apbu962M9s85K6cCy5ocpU=;
        b=YxJv+0UqyiA3IRWomq2gZmgQvlx64i6Fql9vnKlhvwC1BxojMvv63YnHySD5HjXokW
         9D7iI7/YQ6NhiTbS7/LbP5hqxQvK8pWYDNOVwF5g2ZyX77TIVWVXaLm5SdKc3DqBgEt4
         kAxEXrD5mYdo7RUEE6kpsJLTx2qNEz9GWT7KxVW9PyP7B563N+2tzwEP15SoL0WmTcDM
         IRHSguVqDnFP80uwbxm8LovU+JyoQzMVVQN6OG1G0ZpzfwsjIxIMeBtseo5kou9tHNGL
         4XJlqaeDx1eToIZ8tVyqZbQid0Osoi6jZrZ3+l/btk8M5PFktv6unaeyNSJ822+UwXk6
         MDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uoAhQm+a9FZof4qECV3R9Apbu962M9s85K6cCy5ocpU=;
        b=DsaOFA4NxVxGw7M69TVgEmut+yDHmavsAi7cGMs6QIdbnh/pdAHn/qsmUKYH79Wtxt
         Gf3NTmgRWhDhzG4+7H6ywmZKefzZ/725Gu5RUHebp541wmP1eGp4jsH+kAA6Hy4pUuqa
         cAtMvQCKuxOiTJ4+UkwhVRic0jHRRhHs1tclsSk/8NUIKeOk/k+2n6ynyNy7ejgQj2ce
         5PExuc0pjTeAxZy97M5Y2eqK8m5NGcWy4fLQY/Da/GSJ1e3cepePjUoB1bwq5iwMoMIo
         gyWjAya52FJhsYUDYlXmWGlTau6jHh5FKWEyIgXuf5Z8xDMZ1JjZfOXsZXnvZk/FxLeq
         ZJ1w==
X-Gm-Message-State: ALyK8tIHnW7Hh6/t0TtC+Py89OFh4roFAF485fxWUDvHaWRhh9aeziqrVf6QE5S0oy0NXaA11biPa5c/wQa2eg==
X-Received: by 10.107.22.6 with SMTP id 6mr5122093iow.128.1466865252372; Sat,
 25 Jun 2016 07:34:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 07:33:42 -0700 (PDT)
In-Reply-To: <1463694357-6503-5-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-5-git-send-email-dturner@twopensource.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 16:33:42 +0200
Message-ID: <CACsJy8CftPGmrKP8Yeok90T9=whzj69bfE3_X6wHyWOEp6vRzg@mail.gmail.com>
Subject: Re: [PATCH v12 04/20] index-helper: new daemon for caching index and
 related stuff
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
>  .gitignore                             |   1 +
>  Documentation/git-index-helper.txt     |  50 ++++++
>  Makefile                               |   5 +
>  cache.h                                |  11 ++
>  contrib/completion/git-completion.bash |   1 +
>  git-compat-util.h                      |   1 +
>  index-helper.c                         | 280 +++++++++++++++++++++++++++++++++
>  read-cache.c                           | 125 +++++++++++++--
>  t/t7900-index-helper.sh                |  23 +++
>  9 files changed, 488 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/git-index-helper.txt
>  create mode 100644 index-helper.c
>  create mode 100755 t/t7900-index-helper.sh

We still need to classify this new command in command-list.txt.
purehelpers probably the easiest choice.

> +NOTES
> +-----
> +
> +$GIT_DIR/index-helper.sock a Unix domain socket that the daemon reads
> +commands from.  The directory will also contain files named
> +"shm-index-<SHA1>".  These are used as backing stores for shared
> +memory.  Normally the daemon will clean up these files when it exits
> +or when they are no longer relevant.  But if it crashes, some objects
> +could remain there and they can be safely deleted with "rm"
> +command. The following commands are used to control the daemon:
> +
> +"refresh"::
> +       Reread the index.
> +
> +"poke":
> +       Let the daemon know the index is to be read. It keeps the
> +       daemon alive longer, unless `--exit-after=0` is used.
> +
> +All commands and replies are terminated by a NUL byte.

I think it's "all commands are replies are in pkt-line format" now.

> diff --git a/Makefile b/Makefile
> index 2742a69..c8be0e7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1433,6 +1433,10 @@ ifdef HAVE_DEV_TTY
>         BASIC_CFLAGS += -DHAVE_DEV_TTY
>  endif
>
> +ifndef NO_MMAP
> +       PROGRAM_OBJS += index-helper.o
> +endif

We need unix-socket.c too, which is only built when NO_UNIX_SOCKETS
are not defined. We don't have any platform where mmap is supported
but unix socket is not, do we?

(a couple of minutes later, reading to read-cache.c..) well
poke_daemon() calls unix_stream_connect() without any #ifdef, if
NO_UNIX_SOCKETS is set, then it would lead to undefined reference
error.

> +static void set_socket_blocking_flag(int fd, int make_nonblocking)
> +{
> +       int flags;
> +
> +       flags = fcntl(fd, F_GETFL, NULL);
> +
> +       if (flags < 0)
> +               die(_("fcntl failed"));
> +
> +       if (make_nonblocking)
> +               flags |= O_NONBLOCK;
> +       else
> +               flags &= ~O_NONBLOCK;
> +
> +       if (fcntl(fd, F_SETFL, flags) < 0)
> +               die(_("fcntl failed"));
> +}
> ...
> +               client_fd = accept(fd, NULL, NULL);
> +               if (client_fd < 0)
> +                       /*
> +                        * An error here is unlikely -- it probably
> +                        * indicates that the connecting process has
> +                        * already dropped the connection.
> +                        */
> +                       continue;
> +
> +               /*
> +                * Our connection to the client is blocking since a client
> +                * can always be killed by SIGINT or similar.
> +                */
> +               set_socket_blocking_flag(client_fd, 0);

Out of curiosity, do we really need this? I thought default behavior
was always blocking (and checked linux kernel, it seemed to agree with
me). Maybe for extra safety because other OSes may default to
something else?

> +static int poke_daemon(struct index_state *istate,
> +                      const struct stat *st, int refresh_cache)
> +{
> +       int fd;
> +       int ret = 0;
> +       const char *socket_path;
> +
> +       /* if this is from index-helper, do not poke itself (recursively) */
> +       if (istate->to_shm)
> +               return 0;
> +
> +       socket_path = git_path("index-helper.sock");
> +       if (!socket_path)
> +               return -1;

This "if" is later removed. But you can remove it now if you re-roll,
git_path() must not fail or we are screwed up long before this.
-- 
Duy
