Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495E22047F
	for <e@80x24.org>; Tue, 19 Sep 2017 17:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbdISRp7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 13:45:59 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:45687 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdISRp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 13:45:58 -0400
Received: by mail-pg0-f48.google.com with SMTP id 188so212344pgb.2
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Vt6eTFlvSkdhl/jAg2Kb8UM5SYfTcrmb/EStcVgFY0=;
        b=PqSTR07lj0EUKjP7Y/Nd+jiLZyYmmjZUUO+kXEPbosMEXdGO5FhZKknkZpiTAynlhS
         4J8yLJfM28rKmVQOBe/jKiIhPW0qYinEZnPb5XzLaVuKLsFIxBd88I06KHUpqZ+fqD/+
         cN8z6PMG5dPrnwB70zq93Sg+7AE3vBNiVxHJOv+DvRtOgWac5bFes3VaGG4v1AAFwZDQ
         imZUUhBqE2CfoaZJFtCMtXiWvIc95ht+oRboWoi3KF/eERTV2Kh1KaZI3S+iODdwafae
         PHcgB1D1mUow0Qwc90LCFzqHPeEgFGEfNyt089nhEsiI6t6JC9Fcv8AtBA532oiObURx
         0KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Vt6eTFlvSkdhl/jAg2Kb8UM5SYfTcrmb/EStcVgFY0=;
        b=N90qDoubAJrvJ7McdUHZ4ACP0MwP8mm9bUY3JoPnmKzcKiZ7Z7nx1lv3gKsrz5QtH7
         bfty/pNchIj37qtSJ1VkAZ6R/IY3hiZCc5jybP2Z87nloSTSVH4BVFYVW0T3oPuAjIPZ
         krNQnIrP+s0qb6m7UWRG/leFKrPJnG9Ogrnax9TzkakfyhZrisIxTJat4VyDzloqXkU3
         4xKmVkzXQzCetFp3b5zNpkZuI9C6IsIIUv1W6YL4IfFx6PbxCd2bo1GxvsYHscTpPDIV
         fgB48xPS6pWO/8yD9PVtLdKj4swhS80yRrJtpqYPRXOaBSG9W1FVYC7NiFVnAt2lxIYg
         gjBw==
X-Gm-Message-State: AHPjjUiPJx7Iz+WQvatU+nqkLxJ5r/ei97h+hAgBMtJH8+q9C9NaQqtn
        ulNG4Gp5ilsabKbXqJdH8tYjOw==
X-Google-Smtp-Source: AOwi7QBcmUWAiNgbgEE8995VrZACI6CwjSaqUdocwNuuH7g7gzYz07yBN5qypcFjR1Mk+SPHAtqa1A==
X-Received: by 10.98.133.17 with SMTP id u17mr1995264pfd.235.1505843157821;
        Tue, 19 Sep 2017 10:45:57 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:c4b9:4349:9a84:b260])
        by smtp.gmail.com with ESMTPSA id q23sm4268501pfk.182.2017.09.19.10.45.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 10:45:57 -0700 (PDT)
Date:   Tue, 19 Sep 2017 10:45:53 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 09/40] Add initial external odb support
Message-ID: <20170919104553.494d7d3b@twelve2.svl.corp.google.com>
In-Reply-To: <20170916080731.13925-10-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
        <20170916080731.13925-10-chriscool@tuxfamily.org>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wonder if it's better to get a change like this (PATCH v6 09/40 and
any of the previous patches that this depends on) in and then build on
it rather than to review the whole patch set at a time.  This would
reduce ripple effects (of needing to change later patches in a patch set
multiple times unnecessarily) and help collaboration (in that multiple
people can write patches, since the foundation would already be laid).

The same concerns about fsck apply, but that shouldn't be a problem,
since this patch provides the same internal API as mine ("get" function
taking in a single hash, and "have" function taking in a single hash) so
it shouldn't be too difficult to adapt my fsck and gc patches [1]. (I
can do that if necessary.)

[1] https://public-inbox.org/git/20170915134343.3814dc38@twelve2.svl.corp.google.com/

One possible issue (with committing something early) is that later work
(for example, a fast long-running process protocol) will make the
earlier work (for example, here, a simple single-shot protocol)
obsolete, while saddling us with the necessity of maintaining the
earlier one. To that end, if we want to start with the support for a
hook, a better approach might be to only code the fast long-running
process protocol, and put a wrapper script in contrib/ that can wrap a
single-shot process in a long-running process.

And another possible issue is that we design ourselves into a corner.
Thinking about the use cases that I know about (the Android use case and
the Microsoft GVFS use case), I don't think we are doing that - for
Android, this means that large blob metadata needs to be part of the
design (and this patch series does provide for that), and for Microsoft
GVFS, "get" is relatively cheap, so a configuration option to not invoke
"have" first when loading a missing object might be sufficient.

As for the design itself (including fetch and clone), it differs from my
patches (linked above as [1]) in that mine is self-contained (requiring
only an updated Git server and Git client) whereas this, as far as I can
tell, requires an external process and some measure of coordination
between the administrator of the server and the client user (for
example, the client must have the same ODB mechanism as the server, if
not, the server might omit certain blobs that the client does not know
how to fetch).

And I think that my design can be extended to support a use case in
which, for example, blobs corresponding to a certain type of filename
(defined by a glob like in gitattributes) can be excluded during
fetch/clone, much like --blob-max-bytes, and they can be fetched either
through the built-in mechanism or through a custom hook.

For those reasons, I still lean towards my design, but if we do want to
go with this design, here are my comments about this patch...

First of all:
 - You'll probably need to add a repository extension.
 - I get compile errors when I "git am" these onto master. I think
   '#include "config.h"' is needed in some places.

On Sat, 16 Sep 2017 10:07:00 +0200
Christian Couder <christian.couder@gmail.com> wrote:

> The external-odb.{c,h} files contains the functions that are
> called by the rest of Git from "sha1_file.c".
> 
> The odb-helper.{c,h} files contains the functions to
> actually implement communication with the external scripts or
> processes that will manage external git objects.
> 
> For now only script mode is supported, and only the 'have' and
> 'get_git_obj' instructions are supported.

This "have", as I see from this commit, is more like a "list" command in
that it lists all hashes that it knows about, and does not check if a
given hash exists.

> +static struct odb_helper *helpers;
> +static struct odb_helper **helpers_tail = &helpers;

This could be done with the helpers in list.h instead.

> +int external_odb_get_object(const unsigned char *sha1)
> +{
> +	struct odb_helper *o;
> +	const char *path;
> +
> +	if (!external_odb_has_object(sha1))
> +		return -1;
> +
> +	path = sha1_file_name_alt(external_odb_root(), sha1);

If the purpose of making these functions global in the previous patch is
just for temporary names, I don't think it's necessary for them to be
global. Just concatenate the hex SHA1 to external_odb_root()?

>  /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
> @@ -667,7 +684,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
>  		if (check_and_freshen_file(path, freshen))
>  			return 1;
>  	}
> -	return 0;
> +	return external_odb_has_object(sha1);
>  }
>  
>  static int check_and_freshen(const unsigned char *sha1, int freshen)
> @@ -824,6 +841,9 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
>  			return 0;
>  	}
>  
> +	if (!external_odb_get_object(sha1) && !lstat(*path, st))
> +		return 0;
> +
>  	return -1;
>  }
>  
> @@ -859,7 +879,14 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
>  	if (fd >= 0)
>  		return fd;
>  
> -	return open_sha1_file_alt(sha1, path);
> +	fd = open_sha1_file_alt(sha1, path);
> +	if (fd >= 0)
> +		return fd;
> +
> +	if (!external_odb_get_object(sha1))
> +		fd = open_sha1_file_alt(sha1, path);
> +
> +	return fd;
>  }

Any reason why you prefer to update the loose object functions than to
update the generic one (sha1_object_info_extended)? My concern with just
updating the loose object functions was that a caller might have
obtained the path by iterating through the loose object dirs, and in
that case we shouldn't query the external ODB for anything.

> +ALT_SOURCE="$PWD/alt-repo/.git"
> +export ALT_SOURCE
> +write_script odb-helper <<\EOF
> +GIT_DIR=$ALT_SOURCE; export GIT_DIR
> +case "$1" in
> +have)
> +	git cat-file --batch-check --batch-all-objects |
> +	awk '{print $1 " " $3 " " $2}'
> +	;;
> +get_git_obj)
> +	cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
> +	;;
> +esac
> +EOF
> +HELPER="\"$PWD\"/odb-helper"

Thanks for the clear test. It is very obvious that "have" returns a list
of objects, and "get_git_obj" returns the compressed loose object with
the Git loose object header included.

> +
> +test_expect_success 'setup alternate repo' '
> +	git init alt-repo &&
> +	(cd alt-repo &&
> +	 test_commit one &&

Probably better written as "test_commit -C alt-repo one".

> +	 test_commit two
> +	) &&
> +	alt_head=`cd alt-repo && git rev-parse HEAD`

I think the style is to use $() and "git -C alt-repo rev-parse HEAD".
