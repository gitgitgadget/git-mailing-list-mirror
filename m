Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4483F202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 07:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757351AbdJQHGY (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 03:06:24 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:49160 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757123AbdJQHGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 03:06:23 -0400
Received: by mail-io0-f196.google.com with SMTP id n137so1140258iod.6
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 00:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ghc8jGqxwiiQBFkDpxEyuLsrouOQE9VLQMedy2R/8M=;
        b=RPfNsrP8JkkApShom+2IEehw/Wp0YDmw0gO90YTtctUfcIfm5H9e9vifa5Knz7HYVf
         JsaGeRf1pHVoIXcI8y8g2RX6P42xvSB7gAdbmgxGCnbyRNOT3/vQMM2fACa9uay4r25M
         7KBWa1qwDs0BPayZ72diHk9k9mKzDQ0jLM1aM8gJXiCnuu3S/DVKyybzAVZbdhfcX2uy
         witlWz0S7/XhOM+qFrUGdyptzybOUERrBh9n/jSw6DImSVjIooBv3VG9QuoRSi+LMR15
         kTN3ODcLWvy3W+Gv/ZmwPZLmghZtqFyuC61hyoskFSRqTrH6lIyCSfQOqkGBKi4zkihh
         cSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ghc8jGqxwiiQBFkDpxEyuLsrouOQE9VLQMedy2R/8M=;
        b=cp5n4HWLWAXCNev7R0OGG5y/RMI8FuGP6xq/tQl2k6E9m7C6YjDlBslLCoBRezwc3a
         jDpL7ekhHmwmpu9cNTYYMNCRWtTgyAPl1o+WJhSIy3Q5lUXJGhIqDq+zGMgc6YaRniNq
         +7su8rN/GQ+PgRXwaqWSytn7AJmpkQqd41BYZYWEK7zpo8clTJIzvLOzep0MYEaTpewB
         nqmEg2YIdCplYcsqiUY4iCRtT016o6guuKqzLTTOacWMv5V2snF/Af6Cpj99Uf8tGPCQ
         zWNmlQC0evLaYVvKyWCwjxgOm3ChHShunpapcz1T9BrbqODPiBOA7jXUP5GC60UvY4Wc
         EHXQ==
X-Gm-Message-State: AMCzsaXhZMnD4ltDQ3RjXrxACaoVMdPV1OdcyL65aO7KLXQRE+VZcckk
        coCMdVAFnHSZGoeNnUOHP5s=
X-Google-Smtp-Source: ABhQp+RA7MHfLF1bR2C+gRs3EQcRkbW/rgmNl3LJ0Eo3Uks40LNN2GIcPtv1Df51D2Yc62Jy+evO1Q==
X-Received: by 10.107.142.131 with SMTP id q125mr15377436iod.71.1508223982474;
        Tue, 17 Oct 2017 00:06:22 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a29sm2397870itj.8.2017.10.17.00.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 00:06:21 -0700 (PDT)
Date:   Tue, 17 Oct 2017 00:06:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 0/3] Re: [PATCH] check-ref-format: require a repository for
 --branch
Message-ID: <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
References: <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
 <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
 <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
 <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
 <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com>
 <xmqq7evupemj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7evupemj.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> Subject: [PATCH] check-ref-format: --branch cannot grok @{-1} outside a repository

How about this?  It is written to be more conservative than the patch
I am replying to, but except for the commit message, it should be
pretty much equivalent.

[...]
> --- a/builtin/check-ref-format.c
> +++ b/builtin/check-ref-format.c
> @@ -38,13 +38,22 @@ static char *collapse_slashes(const char *refname)
>  
>  static int check_ref_format_branch(const char *arg)
>  {
> +	int nongit, malformed;
>  	struct strbuf sb = STRBUF_INIT;
> -	int nongit;
> +	const char *name = arg;
>  
>  	setup_git_directory_gently(&nongit);
> -	if (strbuf_check_branch_ref(&sb, arg))
> +
> +	if (!nongit)
> +		malformed = (strbuf_check_branch_ref(&sb, arg) ||
> +			     !skip_prefix(sb.buf, "refs/heads/", &name));
> +	else
> +		malformed = check_branch_ref_format(arg);

Handles the nongit case in strbuf_check_branch_ref instead of
introducing a new check_branch_ref_format helper.

[...]
> --- a/cache.h
> +++ b/cache.h
> @@ -1444,6 +1444,20 @@ extern int parse_oid_hex(const char *hex, struct object_id *oid, const char **en
>  #define INTERPRET_BRANCH_HEAD (1<<2)
>  extern int interpret_branch_name(const char *str, int len, struct strbuf *,
>  				 unsigned allowed);
> +
> +/*
> + * NEEDSWORK: declare strbuf_branchname() and strbuf_check_branch_ref()
> + * here, not in strbuf.h
> + */

As a result, it doesn't touch headers.  I agree that these functions
don't belong in strbuf.h (sorry for not updating the headers at the
same time I moved their implementations) but suspect e.g. branch.h,
revision.h, or some new header like revision-syntax.h would be a
better place.

[...]
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -568,6 +568,12 @@ static inline void strbuf_complete_line(struct strbuf *sb)
>  	strbuf_complete(sb, '\n');
>  }
>  
> +/*
> + * NEEDSWORK: the following two functions should not be in this file;
> + * these are about refnames, and should be declared next to
> + * interpret_branch_name() in cache.h
> + */

Didn't touch headers.

[...]
> --- a/t/t1402-check-ref-format.sh
> +++ b/t/t1402-check-ref-format.sh
> @@ -161,6 +161,18 @@ test_expect_success 'check-ref-format --branch from subdir' '
>  	test "$refname" = "$sha1"
>  '
>  
> +test_expect_success 'check-ref-format --branch @{-1} from non-repo' '
> +	test_must_fail nongit git check-ref-format --branch @{-1}
> +'

Swapped test_must_fail and nongit to match existing tests.

Junio C Hamano (3):
  check-ref-format --branch: do not expand @{...} outside repository
  check-ref-format --branch: strip refs/heads/ using skip_prefix
  check-ref-format doc: --branch validates and expands <branch>

 Documentation/git-check-ref-format.txt |  9 ++++++++-
 builtin/check-ref-format.c             |  6 ++++--
 sha1_name.c                            |  5 ++++-
 t/t1402-check-ref-format.sh            | 16 ++++++++++++++++
 4 files changed, 32 insertions(+), 4 deletions(-)
