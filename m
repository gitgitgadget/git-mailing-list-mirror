Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928C71FAE3
	for <e@80x24.org>; Tue, 13 Mar 2018 19:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeCMT5K (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 15:57:10 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32831 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeCMT5I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 15:57:08 -0400
Received: by mail-pg0-f44.google.com with SMTP id g12so348847pgs.0
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 12:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=J52mGvrYWJIDbKt3ajRE3ssOgGEv4aUaeqcOJTimdmk=;
        b=o1cSjGJXiP8ncNOe2nBjHuZdrKEOvJL1XNhoNfMHqEixBq8Gp5nW9P+MJgXS46iqY0
         eT6kezzA0vO9JW4T88ARtc9RYqAr4d1uWj/4Grd2W9MRC3zF6QRbljkHQzYZ4QBFUG17
         BrqV14K7y0LOHzZ9oa53bk+nnIyRt+aeV5KcLP2rhwTwJGvCxh2TwAbQmeR5EHvSd/Rk
         HleL7GzE3JUaV5BBM2kEevxrezni5YsPi/ZLAsoYia1ocUrQc8Dz1HrLPncVV+1Hn330
         YrWyiaeZ6SU28p0Bj2ile/VTyxVmuOf5OLn9KRJDF8SggFt/XG9OrrgxzkkcllgcHca8
         HpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J52mGvrYWJIDbKt3ajRE3ssOgGEv4aUaeqcOJTimdmk=;
        b=friuc8Yfqr7KMJ358g4hFquXBaGs9SVzJnIFkmDuTGYTKMedKn0wnHpxFE3G89OMv9
         Eqto9aRGkffbmKdk2hE3ZeerB6ywMw4ZxlGQlqXrhN44RaL2rZu3Cd8cD4LODopY3teg
         PHx/60RT7Q2NqQwT4/2TIGjCM2Ohp8S+uaEkpBsjjyeMU5psNYGQKHjx12L3bCMtCchL
         sZvX/ojBFungdrm65T5V3pQgjyoBN9Pdq1E8yQiAHf+iZbU6qGWrQjO2fwIJe3QuZMdD
         7PF7hGOwLDlAozJ/M02y4rgeHn7g2CaxF2ltiiyNmkCB+mFQQwUF7R/R8BZOpV1J7EX1
         yzQQ==
X-Gm-Message-State: AElRT7GDtj06cVw7PI+tUwpu1F1kyOVILxGMKVQgz59bNxpwyYaR0b2C
        3EVxazoTEDRKF3CJMaLoX1k=
X-Google-Smtp-Source: AG47ELsXLONVvM948bC3XheMZ3rEM+qxEYnfHaJeJFIP2iSqNrFvK3CswbLpwiHw4r0RRB5I9bsnKg==
X-Received: by 10.98.157.199 with SMTP id a68mr1727771pfk.59.1520971027711;
        Tue, 13 Mar 2018 12:57:07 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c185sm1662340pfb.72.2018.03.13.12.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 12:57:07 -0700 (PDT)
Date:   Tue, 13 Mar 2018 12:56:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] shortlog: do not accept revisions when run outside
 repo
Message-ID: <20180313195640.GA147135@aiede.svl.corp.google.com>
References: <cover.1520680894.git.martin.agren@gmail.com>
 <78669e644b64fc10c34adb59717d2039f81cb092.1520680894.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78669e644b64fc10c34adb59717d2039f81cb092.1520680894.git.martin.agren@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Martin Ågren wrote:

> If we are outside a repo and have any arguments left after
> option-parsing, `setup_revisions()` will try to do its job and
> something like this will happen:
>
>  $ git shortlog v2.16.0..
>  BUG: environment.c:183: git environment hasn't been setup
>  Aborted (core dumped)

Yikes.  Thanks for fixing it.

[...]
>                                                       (So yes, after
> this patch, we will still silently ignore stdin for confused usage such
> as `git log v2.15.0.. | git shortlog v2.16.0..`. But at least that does
> not crash.)

I don't follow here.  Are you saying this command should notice that
there is input in stdin?  How would it notice?

[...]
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -127,6 +127,11 @@ test_expect_success !MINGW 'shortlog can read --format=raw output' '
>  	test_cmp expect out
>  '
>  
> +test_expect_success 'shortlog from non-git directory refuses revisions' '
> +	test_must_fail env GIT_DIR=non-existing git shortlog HEAD 2>out &&
> +	test_i18ngrep "no revisions can be given" out
> +'

\o/

[...]
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -293,6 +293,12 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
>  parse_done:
>  	argc = parse_options_end(&ctx);
>  
> +	if (nongit && argc != 1) {

Just curious: would argc ever be 0 here?  'argc <= 1' might be clearer.

> +		error(_("no revisions can be given when running "
> +			"from outside a repository"));
> +		usage_with_options(shortlog_usage, options);
> +	}
> +

The error message is

	error: no revisions can be given when running from outside a repository
	usage: ...

Do we need to dump usage here?  I wonder if a simple die() call would
be easier for the user to act on.

Not about this patch: I was a little surprised to see 'error:' instead
of 'usage:' or 'fatal:'.  It turns out git is pretty inconsistent
about that: e.g. there is

	error(_("no remote specified"));
	usage_with_options(builtin_remote_setbranches_usage, options);

Some other callers just use usage_with_options without describing the
error.  check-attr has a private error_with_usage() helper to implement
the error() followed by usage_with_options() idiom.  Most callers just
use die(), like

	die(_("'%s' cannot be used with %s"), "--merge", "--patch");

Documentation/technical/api-error-handling.txt says

 - `usage` is for errors in command line usage.  After printing its
   message, it exits with status 129.  (See also `usage_with_options`
   in the link:api-parse-options.html[parse-options API].)

which is not prescriptive enough to help.

Separate from that, I wonder if the error message can be made a little
shorter and clearer.  E.g.

	fatal: shortlog <revs> can only be used inside a git repository

Thanks and hope that helps,
Jonathan
