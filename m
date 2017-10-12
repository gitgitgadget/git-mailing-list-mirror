Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85761FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 04:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbdJLEr3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 00:47:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36125 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdJLEr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 00:47:28 -0400
Received: by mail-pf0-f196.google.com with SMTP id z11so4495573pfk.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 21:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bhhe2pyZqRTROjFggsBxEuTsDi3YUmo6iagJIQgcBRs=;
        b=sip8HdD0iuYqg/RBiT2YW9y6BxUO5+pZV8z5xvOw6vcTCrYlIF9AkZRy0MMZAquS8X
         Hq3K7xdbmrt/hoiVUdElrJzc8hlEkiqkGA8BcVf/D7KxWdkbWJoOEEIQijKb7NH805bO
         MlcIH0yC3sVYC0ZZ96bAhQwuoaFTYjaXnVFQCkN5TOFhyXZqMbJOCempl7RhGRFRRvMB
         kAedPrIbUQtQgYp5sGayBypTSX9MkMto8czVatk8GE9jHuVorSJeFQLtftCIAme3qn0R
         /IIhF02Xf/lHZg1JGYBHkYtFhgSQ4xqYdGxxvsEnH+dfzkADv5163UBAwXn6iZRAXcIK
         mxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bhhe2pyZqRTROjFggsBxEuTsDi3YUmo6iagJIQgcBRs=;
        b=k2HmJEz7SQ3hv/K7x3GXwljZS4CrLMkQXPJVqiwfAI/JE24iqeS8kZEK0d6tvglJ5T
         OW60iV8SRzGyM2atQWjiGPDqM5yqIhRoeMtgu8XM84BOqnoYlDxT8JYg4PgW4iQ7jtR6
         SZY3qcMtnhho8H64bAFwX+JDRzh8P8oowtLWXQKcIrqfm5KDWry5MbQtu2mNaLqYtYVE
         GG8cd7B26/YsaqupEKPMuz3EmoNWexSNpkrWuZ7d71GBtxZPN6F/2inV2xW52qA1P32h
         CiPnPPn07WKIvpu1QVMA2MFgEls3yh3kGa+Oe2b2OkhOVLi3kgxhj+ikshG0/akJrRhU
         j96g==
X-Gm-Message-State: AMCzsaUtfSSlA/COqWRlChHDsT8/e2qOLAD9ZKbGOP1RhZKvWspLrFfm
        6Y7k5+t/3AV4Lk98psnjPJU=
X-Google-Smtp-Source: AOwi7QD7R9JJ6zn5wRVCaws0nthHRhjY5imnna/KNhJvufLjqeQA7jn6q9GTkoCNWJQDWFIxxyzMFg==
X-Received: by 10.99.114.92 with SMTP id c28mr1095570pgn.342.1507783647955;
        Wed, 11 Oct 2017 21:47:27 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9e:660c:b9bb:a349])
        by smtp.gmail.com with ESMTPSA id p14sm24298796pgr.51.2017.10.11.21.47.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 21:47:26 -0700 (PDT)
Date:   Wed, 11 Oct 2017 21:47:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk
 configuration
Message-ID: <20171012044724.GD155740@aiede.mtv.corp.google.com>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
 <20171012021007.7441-2-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012021007.7441-2-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

[...]
> --- a/color.c
> +++ b/color.c
> @@ -307,8 +307,21 @@ int git_config_colorbool(const char *var, const char *value)
>  	if (value) {
>  		if (!strcasecmp(value, "never"))
>  			return 0;
> -		if (!strcasecmp(value, "always"))
> -			return var ? GIT_COLOR_AUTO : 1;
> +		if (!strcasecmp(value, "always")) {
> +			/*
> +			 * Command-line options always respect "always".
> +			 * Likewise for "-c" config on the command-line.
> +			 */
> +			if (!var ||
> +			    current_config_scope() == CONFIG_SCOPE_CMDLINE)
> +				return 1;
> +
> +			/*
> +			 * Otherwise, we're looking at on-disk config;
> +			 * downgrade to auto.
> +			 */
> +			return GIT_COLOR_AUTO;
> +		}

Yes, this looks good to me.

Should we document this special case treatment of color.* in -c
somewhere?  E.g.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/Documentation/config.txt w/Documentation/config.txt
index 13ce76d48b..d7bd6b169c 100644
--- i/Documentation/config.txt
+++ w/Documentation/config.txt
@@ -1067,11 +1067,15 @@ clean.requireForce::
 	-i or -n.   Defaults to true.
 
 color.branch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-branch[1]. May be set to `false` (or `never`) to
-	disable color entirely, `auto` (or `true` or `always`) in which
-	case colors are used only when the output is to a terminal.  If
-	unset, then the value of `color.ui` is used (`auto` by default).
+	When to use color in the output of linkgit:git-branch[1].
+	May be set to `never` (or `false`) to disable color entirely,
+	or `auto` (or `true`) in which case colors are used only when
+	the output is to a terminal.  If unset, then the value of
+	`color.ui` is used (`auto` by default).
++
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it is a historical synonym
+for `--color=always`.
 
 color.branch.<slot>::
 	Use customized color for branch coloration. `<slot>` is one of
@@ -1084,10 +1088,13 @@ color.diff::
 	Whether to use ANSI escape sequences to add color to patches.
 	If this is set to `true` or `auto`, linkgit:git-diff[1],
 	linkgit:git-log[1], and linkgit:git-show[1] will use color
-	when output is to the terminal. The value `always` is a
-	historical synonym for `auto`.  If unset, then the value of
+	when output is to the terminal. If unset, then the value of
 	`color.ui` is used (`auto` by default).
 +
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it is a historical
+synonym for `--color=always`.
++
 This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
@@ -1118,10 +1125,14 @@ color.decorate.<slot>::
 	branches, remote-tracking branches, tags, stash and HEAD, respectively.
 
 color.grep::
-	When set to `always`, always highlight matches.  When `false` (or
+	When to highlight matches using color. When `false` (or
 	`never`), never.  When set to `true` or `auto`, use color only
 	when the output is written to the terminal.  If unset, then the
 	value of `color.ui` is used (`auto` by default).
++
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it is a historical synonym
+for `--color=always`.
 
 color.grep.<slot>::
 	Use customized color for grep colorization.  `<slot>` specifies which
@@ -1153,9 +1164,11 @@ color.interactive::
 	When set to `true` or `auto`, use colors for interactive prompts
 	and displays (such as those used by "git-add --interactive" and
 	"git-clean --interactive") when the output is to the terminal.
-	When false (or `never`), never show colors. The value `always`
-	is a historical synonym for `auto`.  If unset, then the value of
-	`color.ui` is used (`auto` by default).
+	When false (or `never`), never show colors.
++
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it means to use color
+regardless of whether output is to the terminal.
 
 color.interactive.<slot>::
 	Use customized color for 'git add --interactive' and 'git clean
@@ -1168,18 +1181,24 @@ color.pager::
 	use (default is true).
 
 color.showBranch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-show-branch[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
+	When to use color in the output of linkgit:git-show-branch[1].
+	May be set to `never` (or `false`) to disable color or `auto`
+	(or `true`) to use colors only when the output is to a terminal.
+	If unset, the value of `color.ui` is used (`auto` by default).
++
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it is a historical synonym
+for `--color=always`.
 
 color.status::
-	A boolean to enable/disable color in the output of
-	linkgit:git-status[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
+	When to use color in the output of linkgit:git-status[1].
+	May be set to `never` (or `false`) to disable color or `auto`
+	(or `true`) to use colors only when the output is to the terminal.
+	If unset, then the value of `color.ui` is used (`auto` by default).
++
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it means to use color
+regardless of whether output is to the terminal.
 
 color.status.<slot>::
 	Use customized color for status colorization. `<slot>` is
@@ -1204,8 +1223,11 @@ color.ui::
 	color unless enabled explicitly with some other configuration
 	or the `--color` option. Set it to `true` or `auto` to enable
 	color when output is written to the terminal (this is also the
-	default since Git 1.8.4). The value `always` is a historical
-	synonym for `auto`.
+	default since Git 1.8.4).
++
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it means to use color
+regardless of whether output is to the terminal.
 
 column.ui::
 	Specify whether supported commands should output in columns.
