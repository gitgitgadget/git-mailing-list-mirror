Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD2DF1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 21:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934508AbeFKVjC (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 17:39:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39899 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933707AbeFKVjB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 17:39:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so19277413wmc.4
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7AAoC4XK56btScBQszDAF8chG0iTmqd5sqBFoVFKlrk=;
        b=lJdvxx9WeON1gNDBK4vm3+VMr3+uwOMhCOT3F/GEQ+eUGpfxOxq6FTfiNKkUF1HskF
         gXABTwjDD6EsQ7tlcyUNJTYVIsrdwMj1S4MKqmKtHfhU4KlKthZE54ajFd4fAGpum/LY
         ca9O24fCq27LAoG+Y5urL6Nn+MgFOJXsAnVyJg57KcjF+AT5fBCVEhPyuqZBBwdJ0IOR
         nYiZuICNpO6DSyhM2SoTUXgMUSrs+bMTn2iff8F8jeWz1oP3ZCSiXgPghoIW3vvvhyvQ
         c8h7t9R4cO/HAKK2trybEgrl04q7zvL39gigVG6qx+wilJ7YUuPVlPCQB4OE5cPDKFyR
         UdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7AAoC4XK56btScBQszDAF8chG0iTmqd5sqBFoVFKlrk=;
        b=CHYr6nSnnR/euuBkZqyh3Nq5plXK+ud3NJDxdIYp+TeXa0q+0ypQyZBWtcPzkkOO8O
         SATCHyU7IWnT06S1U3VXZgmzVLVVXtBEHoroARZexWGhQVbv6JgTIKwo8jV0Rw0DFM1v
         uTISmLj22VXiDwkTpxokFHA97VuwPLKfq6ZbU+mVBRj+sBJdB4JfWBFSfXMronwqX5/4
         EP6ee+ZMCDdJIjC4CDi58v+LgcXLGWbkPlQa3dNHq30my7wmWR6bGfkF+NXSpTv7sdOC
         KqWR5+XWNdu2EFFZaJTk7cOPbsU+JN6rb+hgNB1K2HaHTWoF2SMYrXXEmdDEmeYmH5tb
         41Dg==
X-Gm-Message-State: APt69E2v3mdNMyETyF1DDRHdR5BlDv0iVB2mNXYzQjbOJN1GtwL4w3Vt
        p4gsqK3lPMdz85kxOCZ/qss=
X-Google-Smtp-Source: ADUXVKKqs/Qlf5BawilWeIjeQ/kk+SGBGJOREjvAP+C7U+NCF2m948l1N1urfvcTQ7h1tXZtlLS2Og==
X-Received: by 2002:a50:e8c1:: with SMTP id l1-v6mr781773edn.39.1528753140523;
        Mon, 11 Jun 2018 14:39:00 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y26-v6sm10710612edr.51.2018.06.11.14.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 14:38:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Clemens Buchacher <drizzd@gmx.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH v2] checkout files in-place
References: <20180610194444.GA1913@Sonnenschein.localdomain> <20180611203958.GA1306@Sonnenschein.localdomain>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180611203958.GA1306@Sonnenschein.localdomain>
Date:   Mon, 11 Jun 2018 23:38:57 +0200
Message-ID: <87a7s1vw9a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 11 2018, Clemens Buchacher wrote:

> When replacing files with new content during checkout, we do not write
> to them in place. Instead we unlink and recreate the files in order to
> let the system figure out ownership and permissions for the new file,
> taking umask into account.

Both this summary...

> It is safe to do this on Linux file systems, even if open file handles
> still exist, because unlink only removes the directory reference to the
> file. On Windows, however, a file cannot be deleted until all handles to
> it are closed. If a file cannot be deleted, its name cannot be reused.
>
> This causes files to be deleted, but not checked out when switching
> branches. This is frequently an issue with Qt Creator, which
> continuously opens files in the work tree, as reported here:
> https://github.com/git-for-windows/git/issues/1653
>
> This change adds the core.checkoutInPlace option. If enabled, checkout
> will open files for writing the new content in place. This fixes the
> issue, but with this approach the system will not update file
> permissions according to umask. Only essential updates of write and
> executable permissions are performed.
>
> The in-place checkout is therefore optional. It could be enabled by Git
> installers on Windows, where umask is irrelevant.
>
> Signed-off-by: Clemens Buchacher <drizzd@gmx.net>
> Reviewed-by: Orgad Shaneh <orgads@gmail.com>
> Reviewed-by: "brian m. carlson" <sandals@crustytoothpaste.net>
> Reviewed-by: Duy Nguyen <pclouds@gmail.com>
> Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> Tested on Windows with Git-for-Windows and with Windows Subsystem for
> Linux.
>
>  Documentation/config.txt    | 11 ++++++
>  cache.h                     |  2 ++
>  config.c                    |  5 +++
>  entry.c                     | 18 ++++++++--
>  environment.c               |  1 +
>  t/t2031-checkout-inplace.sh | 82 +++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 116 insertions(+), 3 deletions(-)
>  create mode 100755 t/t2031-checkout-inplace.sh
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ab641bf..0860a81 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -912,6 +912,17 @@ core.sparseCheckout::
>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
>  	linkgit:git-read-tree[1] for more information.
>
> +core.checkoutInPlace::
> +	Check out file contents in place. By default Git checkout removes existing
> +	work tree files before it replaces them with different content. If this
> +	option is enabled, Git will overwrite the contents of existing files in
> +	place. This is useful on Windows, where open file handles to a removed file
> +	prevent creating new files at the same path.

...And this seems to conflict with what Junio's summarized in
xmqqvaapb3r1.fsf@gitster-ct.c.googlers.com. I.e. (if I'm reading it
correctly) it's not correct to say that we unlink the existing file,
then replace it, don't we create a new one, and then rename it in-place?

I don't know enough about this part of the code to know, but whatever it
is we should get it right here.

Also, as Junio notes that pattern will not result in a potentially
corrupt checkout where you've written 1/2 of a file, you note in
20180611174818.GA8395@Sonnenschein.localdomain that there are "no
guarantees", but I've never seen a case where being out of disk space
would cause a rename to fail, since that can happen in-place.

Whereas we definitely will end up in states where we've written 1MB of a
2MB file with this when the disk fills up, and thus when that's fixed
"git status" will show local changes, so we should note that caveat for
the user.

> +	Note that the current implementation of in-place checkout makes no effort
> +	to update read/write permissions according to umask. Permissions are
> +	however modified to enable write access and to update executable
> +	permissions.

I think we should have a paragraph break there before "Note...".

>  core.abbrev::
>  	Set the length object names are abbreviated to.  If
>  	unspecified or set to "auto", an appropriate value is
> diff --git a/cache.h b/cache.h
> index 89a107a..5b8c4d6 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -815,6 +815,7 @@ extern int fsync_object_files;
>  extern int core_preload_index;
>  extern int core_commit_graph;
>  extern int core_apply_sparse_checkout;
> +extern int checkout_inplace;
>  extern int precomposed_unicode;
>  extern int protect_hfs;
>  extern int protect_ntfs;
> @@ -1518,6 +1519,7 @@ struct checkout {
>  	unsigned force:1,
>  		 quiet:1,
>  		 not_new:1,
> +		 inplace:1,
>  		 refresh_cache:1;
>  };
>  #define CHECKOUT_INIT { NULL, "" }
> diff --git a/config.c b/config.c
> index fbbf0f8..8b35ecd 100644
> --- a/config.c
> +++ b/config.c
> @@ -1318,6 +1318,11 @@ static int git_default_core_config(const char *var, const char *value)
>  		return 0;
>  	}
>
> +	if (!strcmp(var, "core.checkoutinplace")) {
> +		checkout_inplace = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "core.precomposeunicode")) {
>  		precomposed_unicode = git_config_bool(var, value);
>  		return 0;
> diff --git a/entry.c b/entry.c
> index 2101201..a599fc1 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -78,8 +78,13 @@ static void remove_subtree(struct strbuf *path)
>
>  static int create_file(const char *path, unsigned int mode)
>  {
> +	int flags;
> +	if (checkout_inplace)
> +		flags = O_WRONLY | O_CREAT | O_TRUNC;
> +	else
> +		flags = O_WRONLY | O_CREAT | O_EXCL;

I'd find this sort of thing easier to read as:

	int flags = O_WRONLY | O_CREAT;
	if (checkout_inplace)
		flags |= O_TRUNC;
	else
		flags |= O_EXCL;

Or even:

	int flags = O_WRONLY | O_CREAT;
	flags |= checkout_inplace ? O_TRUNC : O_EXCL;

I.e. less eyeballing the two lines to see if they're the same.

>  	mode = (mode & 0100) ? 0777 : 0666;
> -	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
> +	return open(path, flags, mode);
>  }
>
>  static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
> @@ -467,8 +472,15 @@ int checkout_entry(struct cache_entry *ce,
>  			if (!state->force)
>  				return error("%s is a directory", path.buf);
>  			remove_subtree(&path);
> -		} else if (unlink(path.buf))
> -			return error_errno("unable to unlink old '%s'", path.buf);
> +		} else if (checkout_inplace) {
> +			if (!(st.st_mode & 0200) ||
> +			    (trust_executable_bit && (st.st_mode & 0100) != (ce->ce_mode & 0100)))
> +				if (chmod(path.buf, (ce->ce_mode & 0100) ? 0777 : 0666))
> +					return error_errno(_("unable to change mode of '%s'"), path.buf);
> +		} else {
> +			if (unlink(path.buf))
> +				return error_errno(_("unable to unlink old '%s'"), path.buf);
> +		}
>  	} else if (state->not_new)
>  		return 0;
>
> diff --git a/environment.c b/environment.c
> index 2a6de23..5b91f30 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -68,6 +68,7 @@ char *notes_ref_name;
>  int grafts_replace_parents = 1;
>  int core_commit_graph;
>  int core_apply_sparse_checkout;
> +int checkout_inplace;
>  int merge_log_config = -1;
>  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  unsigned long pack_size_limit_cfg;
> diff --git a/t/t2031-checkout-inplace.sh b/t/t2031-checkout-inplace.sh
> new file mode 100755
> index 0000000..d70ecc4
> --- /dev/null
> +++ b/t/t2031-checkout-inplace.sh
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +
> +test_description='in-place checkout'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +
> +	test_commit hello world &&
> +	git branch other &&
> +	test_commit hello-again world
> +'
> +
> +test_expect_success 'in-place checkout overwrites open file' '
> +
> +	git config core.checkoutInPlace true &&
> +	git checkout -f master &&
> +	exec 8<world &&
> +	git checkout other &&
> +	exec 8<&- &&
> +	echo hello >expect &&
> +	test_cmp expect world
> +'
> +
> +test_expect_success 'in-place checkout overwrites read-only file' '
> +
> +	git config core.checkoutInPlace true &&
> +	git checkout -f master &&
> +	chmod -w world &&
> +	git checkout other &&
> +	echo hello >expect &&
> +	test_cmp expect world
> +'
> +
> +test_expect_success 'in-place checkout updates executable permission' '
> +
> +	git config core.checkoutInPlace true &&
> +	git checkout -f master^0 &&
> +	test_chmod +x world &&
> +	git commit -m executable &&
> +	git checkout other &&
> +	test ! -x world

Worth testing switching branches here again & re-testing, since this
only tests +x -> -x, but not -x -> +x when we go back.

> +'
> +
> +test_expect_success POSIXPERM 'regular checkout respects umask' '
> +
> +	git config core.checkoutInPlace false &&
> +	git checkout -f master &&
> +	chmod 0660 world &&
> +	umask 0022 &&
> +	git checkout other &&
> +	actual=$(ls -l world) &&
> +	case "$actual" in
> +	-rw-r--r--*)
> +		: happy
> +		;;
> +	*)
> +		echo Oops, world is not 0644 but $actual
> +		false
> +		;;
> +	esac

Is that "ls" parsing portable? And also couldn't this be accomplished
with something like "stat --format"? I'm not sure how portable that is,
we just have one use of it in the test suite (on Cygwin only).

> +'
> +
> +test_expect_success POSIXPERM 'in-place checkout ignores umask' '
> +
> +	git config core.checkoutInPlace true &&
> +	git checkout -f master &&
> +	chmod 0660 world &&
> +	umask 0022 &&
> +	git checkout other &&
> +	actual=$(ls -l world) &&
> +	case "$actual" in
> +	-rw-rw----*)
> +		: happy
> +		;;
> +	*)
> +		echo Oops, world is not 0660 but $actual
> +		false
> +		;;
> +	esac
> +'
> +
> +test_done
