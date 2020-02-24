Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6587C11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B0920880
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o4FR5tq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBXSOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:14:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60663 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBXSOn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:14:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47A7CA5F4E;
        Mon, 24 Feb 2020 13:14:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WsIBXre0m9S//ZjmXKKJqqq3BA0=; b=o4FR5t
        q3kn+Qf2yUJDppsW7/049N8VYodG/TI4QG9F/QQzhndxcq2cbs22JRccxYFJ1rPu
        W0GJkcvr58aLfkNfDEBXUMSzV2xymAPvrx8ct28chwsMHBRPd/5/FSHxc4BYFMPH
        7u24X3hX77TMLJ+3cuchvpxYM5tYh5kju40e0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cBZDUFdV8kmckP1+878fUeFy/1iDPXJ5
        g9RFQdG9hg8080YpfnlE7wmklr6GiJZdvIKfGQxUuDff1rzHAvjyVMGqJ/fNrtnK
        +zfb/Vk4pvqPCNvWk5j+Y+4o0Uxpy+GCX6LInDMv+Liria9hoZAjJim8/us1978U
        SwCOEUXAY+k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FDE0A5F4C;
        Mon, 24 Feb 2020 13:14:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 64BE2A5F4B;
        Mon, 24 Feb 2020 13:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 13/24] builtin/init-db: allow specifying hash algorithm on command line
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-14-sandals@crustytoothpaste.net>
Date:   Mon, 24 Feb 2020 10:14:33 -0800
In-Reply-To: <20200222201749.937983-14-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 22 Feb 2020 20:17:38 +0000")
Message-ID: <xmqqh7zfrgxi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83314D16-5731-11EA-A002-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>  'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
> -	  [--separate-git-dir <git dir>]
> +	  [--separate-git-dir <git dir>] [--object-format=<format]

A missing closing ket> in <bra-ket> pair.

> +#ifndef ENABLE_SHA256
> +	if (fmt->hash_algo != GIT_HASH_SHA1)
> +		die(_("The hash algorithm %s is not supported in this build."), hash_algos[fmt->hash_algo].name);

Could you fold the overlong line here?

>  int init_db(const char *git_dir, const char *real_git_dir,
> -	    const char *template_dir, unsigned int flags)
> +	    const char *template_dir, int hash, unsigned int flags)

Perhaps rename "hash" to "hash_algo"?  I know that it is very
unlikely for a variable whose name is 'hash' to be mistaken as a raw
hash value when its type is "int" (as opposed to say char *), but
still.  I wouldn't be saying this if its type were an "enum
hash_algo" or something like that.

> +	const char *object_format = NULL;
> +	int hash_algo = GIT_HASH_UNKNOWN;

This one _is_ good.

>  	const struct option init_db_options[] = {
>  		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
>  				N_("directory from which templates will be used")),
> @@ -494,6 +526,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
>  		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
>  			   N_("separate git dir from working tree")),
> +		OPT_STRING(0, "object-format", &object_format, N_("hash"),
> +			   N_("specify the hash algorithm to use")),
>  		OPT_END()
>  	};
>  
> @@ -546,6 +580,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		free(cwd);
>  	}
>  
> +	if (object_format) {
> +		hash_algo = hash_algo_by_name(object_format);
> +		if (hash_algo == GIT_HASH_UNKNOWN)
> +			die(_("unknown hash algorithm '%s'"), object_format);
> +	}
> +
>  	if (init_shared_repository != -1)
>  		set_shared_repository(init_shared_repository);
>  
> @@ -597,5 +637,5 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  	UNLEAK(work_tree);
>  
>  	flags |= INIT_DB_EXIST_OK;
> -	return init_db(git_dir, real_git_dir, template_dir, flags);
> +	return init_db(git_dir, real_git_dir, template_dir, hash_algo, flags);
>  }
> diff --git a/cache.h b/cache.h
> index 29ee02a8d4..7a47e023ba 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -627,7 +627,8 @@ int path_inside_repo(const char *prefix, const char *path);
>  #define INIT_DB_EXIST_OK 0x0002
>  
>  int init_db(const char *git_dir, const char *real_git_dir,
> -	    const char *template_dir, unsigned int flags);
> +	    const char *template_dir, int hash_algo,

So is this one.

> +	    unsigned int flags);
>  
>  void sanitize_stdfds(void);
>  int daemonize(void);
