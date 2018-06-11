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
	by dcvr.yhbt.net (Postfix) with ESMTP id 10E901F403
	for <e@80x24.org>; Mon, 11 Jun 2018 17:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934095AbeFKR71 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 13:59:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36563 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933537AbeFKR7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 13:59:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so18227823wma.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Y/8goYE/St435py0Y381c14esyOl7bOGorK+/1twR8s=;
        b=ViNwh+3yu2NI01lWiFar0UMTPVRiQXioJ3UraWIM4nssNQpMSZFrYcjL1DXpTTea3j
         jOWwI5De4J81Fv77gxpHZ09tWO8BtUYniLzyXHpKspfEmHquYUoHjUzQJNs4teNS3Xqf
         YxN6iIghU36652rWk3z0JnTAtctc6uC1VaqJ18V07G9Uay7P/oicMmuKooesnwA81Upn
         oEK7CIQiUiTu/GmCg1/D7aIGoTbDs9luKOJjXDSgwN6Rypx4xnDeDBgipvdWGA94ye/T
         c3vwYugDKr5NEae5gnht/gGKXzsOU2oiZ3hM5uNE3Dc0dOf7TYUg5QxadvVZp89DEkmq
         zN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Y/8goYE/St435py0Y381c14esyOl7bOGorK+/1twR8s=;
        b=QXUEp91DLf9/FnhRQn0vJdMxa8BaAFf4Xn7FTA+Cjpni/5C6qxqn+k9P1bALcd/rwg
         GwWn7zUmu5kMEKXWZAGrr2gDrMrx0dvctdLOC2i+iCczA/CamZixK8Ys03zWfW9pq0qw
         1xFidm0OQE306ezJIyxuXn+YjwojhDkYgdMInz3RTM6/yfX4HlMwdcrqXGZawHwt2qes
         w0F1Ec7O0V37xdkTdEZ4gJRJ50v+03EmTh1c8vr4cMVAh80v6IMfldLT6rhe0oZz0bTf
         VUJm6M1j9ZKFjt/u8D5LWAmz1Q8xBpYevm//v/x8n+AlAvwCXhjBsB8FOsEP9V1A+zIV
         6p4g==
X-Gm-Message-State: APt69E1EEJbqfXM7NEQ77t2YtmXvg8TxZshITl7mEYNfL4aOfnNDQUYj
        mlBnRJWWdzXiGVRdKyPzgFE=
X-Google-Smtp-Source: ADUXVKIq1WuL9f8Vh9uwvIXbyucKhLI6s2XKdE9wSZ1cgBVoS9CRYl4OKWrLhv1nXdTEXUIuJPTf3A==
X-Received: by 2002:a50:a45d:: with SMTP id v29-v6mr146583edb.237.1528739964489;
        Mon, 11 Jun 2018 10:59:24 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id t27-v6sm1415561edb.88.2018.06.11.10.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 10:59:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Clemens Buchacher <drizzd@gmx.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] checkout files in-place
References: <20180610194444.GA1913@Sonnenschein.localdomain>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180610194444.GA1913@Sonnenschein.localdomain>
Date:   Mon, 11 Jun 2018 19:59:22 +0200
Message-ID: <87d0wxw6f9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 10 2018, Clemens Buchacher wrote:

> When replacing files with new content during checkout, we do not write
> to them in-place. Instead we unlink and re-create the files in order to
> let the system figure out ownership and permissions for the new file,
> taking umask into account.
>
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
> This change adds the core.checkout_inplace option. If enabled, checkout

The commit message should mention core.checkoutInPlace, not
core.checkout_inplace.

> will open files for writing the new content in-place. This fixes the
> issue, but with this approach the system will not update file
> permissions according to umask. Only essential updates of write and
> executable permissions are performed.
>
> The in-place checkout is therefore optional. It could be enabled by Git
> installers on Windows, where umask is irrelevant.

I think some of this...

> +core.checkoutInplace::
> +	Checkout file contents in-place. By default Git checkout removes existing
> +	work tree files before it replaces them with different contents. If this
> +	option is enabled Git will overwrite the contents of existing files
> +	in-place. This is useful on systems where open file handles to a removed
> +	file prevent creating new files at the same path. Note that Git will not
> +	update read/write permissions according to umask.
> +

...should be added to these docs. In particular let's not be coy and say
"on systems where", and instead describe that this is meant for Windows,
so users looking for that in the config man-page will see it.

We should also document the "doesn't update permissions" bit, and be
clear whether that's expected future behavior we aim to preserve, or
just a side-effect of the current implementation and may change.

>  core.abbrev::
>  	Set the length object names are abbreviated to.  If
>  	unspecified or set to "auto", an appropriate value is
> diff --git a/cache.h b/cache.h
> index 2c640d4c31..c8fccd2a80 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -808,6 +808,7 @@ extern char *git_replace_ref_base;
>  extern int fsync_object_files;
>  extern int core_preload_index;
>  extern int core_apply_sparse_checkout;
> +extern int checkout_inplace;
>  extern int precomposed_unicode;
>  extern int protect_hfs;
>  extern int protect_ntfs;
> @@ -1530,6 +1531,7 @@ struct checkout {
>  	unsigned force:1,
>  		 quiet:1,
>  		 not_new:1,
> +		 inplace:1,
>  		 refresh_cache:1;
>  };
>  #define CHECKOUT_INIT { NULL, "" }
> diff --git a/config.c b/config.c
> index cd2b404b14..4ac2407057 100644
> --- a/config.c
> +++ b/config.c
> @@ -1231,6 +1231,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
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
> index 31c00816dc..54c98870b9 100644
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
>  	mode = (mode & 0100) ? 0777 : 0666;
> -	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
> +	return open(path, flags, mode);
>  }
>
>  static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
> @@ -470,8 +475,15 @@ int checkout_entry(struct cache_entry *ce,
>  			if (!state->force)
>  				return error("%s is a directory", path.buf);
>  			remove_subtree(&path);
> -		} else if (unlink(path.buf))
> -			return error_errno("unable to unlink old '%s'", path.buf);
> +		} else if (checkout_inplace) {
> +			if (!(st.st_mode & 0200) ||
> +			    (trust_executable_bit && (st.st_mode & 0100) != (ce->ce_mode & 0100)))
> +				if (chmod(path.buf, (ce->ce_mode & 0100) ? 0777 : 0666))
> +					return error_errno("unable to change mode of '%s'", path.buf);
> +		} else {
> +			if (unlink(path.buf))
> +				return error_errno("unable to unlink old '%s'", path.buf);
> +		}
>  	} else if (state->not_new)
>  		return 0;
>
> diff --git a/environment.c b/environment.c
> index d1ac37dd18..6a8036b144 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -63,6 +63,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
>  char *notes_ref_name;
>  int grafts_replace_parents = 1;
>  int core_apply_sparse_checkout;
> +int checkout_inplace;
>  int merge_log_config = -1;
>  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  unsigned long pack_size_limit_cfg;
> diff --git a/t/t2031-checkout-inplace.sh b/t/t2031-checkout-inplace.sh
> new file mode 100755
> index 0000000000..60ea30cbf5
> --- /dev/null
> +++ b/t/t2031-checkout-inplace.sh
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +
> +test_description='checkout inplace'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +
> +	git config core.checkoutInplace true &&
> +	echo hello >world &&
> +	git add world &&
> +	git commit -m initial &&
> +	git branch other &&
> +	echo "hello again" >>world &&
> +	git add world &&
> +	git commit -m second
> +'

Would be easier to read if you used the "test_commit" helper.

> +test_expect_success 'checkout overwrites open file' '
> +
> +	git checkout -f master &&
> +	mkfifo input &&
> +	{
> +		cat >>world <input &
> +	} &&
> +	pid=$! &&
> +	test_when_finished "kill -KILL $pid; wait $pid; rm -f input" &&
> +	git checkout other &&
> +	echo hello >expect &&
> +	test_cmp expect world
> +'
> +
> +test_expect_success 'checkout overwrites read-only file' '
> +
> +	git checkout -f master &&
> +	chmod -w world &&
> +	git checkout other &&
> +	echo hello >expect &&
> +	test_cmp expect world
> +'
> +
> +test_done

There seem to be no tests here for the chmod +x case you implemented,
and it would be worthwhile to have an explicit test where we change the
umask and observe that a file's permissions will change without this
setting, but not with it.
