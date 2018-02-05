Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFAFB1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 02:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeBECMQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 21:12:16 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33511 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeBECMO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 21:12:14 -0500
Received: by mail-pg0-f68.google.com with SMTP id u1so17184451pgr.0
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 18:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OXfLYYGrE788rQYYa5eMPF8ZWM21zprgmN0qPyInLmU=;
        b=LFRZw6AXSqq6LZ1/zPK7Rv5HQaPKTUwDm3MCxIAT4aYbH9B/ouBpsGAjOCYNxgU+2+
         Dh9ZO25o79sEbCqiLkyrzAHBSA73jco8r3hYmz2s3QzZEqSIp8AlbJdpeZkq8h8Y74qL
         ja+IhZQlOOzYDST84XEhvX3xfhKScb9nC3EdH3i4X2HGByZFzGH07dvt2xVst/znklXE
         HLn+U/8XZSskmFkidUvs1kpRDrSy5CcMRi6nZPGmB2PgKNhMWSahOS09AbInfXp957H1
         jywB5nNvv4Urllkz3PISyyS7Roq826Em9g8YgMGxS7/IbaOnQVEFIKSv568Hu3+um2PS
         RgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OXfLYYGrE788rQYYa5eMPF8ZWM21zprgmN0qPyInLmU=;
        b=qsTvaDUmw+ITqmvBHkObcwYazeQk4YQUi6JTSggmeuj3WKRwdtzagO9amFZebwLayZ
         FT6hqpp2e5AIlz8MYFCyGzAoSGEQStkcb3GB/d84bTmnF0yi77EKgwViqpkm8VPNcqmf
         Gad4dHJ/RsFg4rFgWVJBUg2e79hT+bH4kf28Ld99trGfXmp+cqg59A92NhB0XmD+RlM5
         F36DjQd9req/iLQrzxdwXP4U1mW/94DAsV/NX80ZUpfAqQ11PNEuzOwujxTPRJDVGaF0
         teHtGyOHleVj1GQd9Yc7Jxku/RxKizZ+rswUOQRDWHzF3hGizIi/ESxR7DYqHf7XmMUb
         jQJA==
X-Gm-Message-State: APf1xPCHxHSzTudTouS9REAevGaaKdLZ5Ky65i8m5x7SQLOOL94y8vFI
        jrKwB3sFcNA4K9Ni3E/4+aA=
X-Google-Smtp-Source: AH8x224TlztucwlzJx6xFvHh7O6KWPcWXFrALTAqHX17LW5tNI5mI3tkKmNQmtP+IjyX0JffN/4lxg==
X-Received: by 10.98.216.134 with SMTP id e128mr6059733pfg.36.1517796733916;
        Sun, 04 Feb 2018 18:12:13 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id u6sm7082623pgb.94.2018.02.04.18.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Feb 2018 18:12:12 -0800 (PST)
Date:   Mon, 5 Feb 2018 09:12:02 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/3] worktree: improve message when creating a new
 worktree
Message-ID: <20180205021202.GA17847@duynguyen.dek-tpc.internal>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
 <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180204221305.28300-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180204221305.28300-2-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 04, 2018 at 10:13:03PM +0000, Thomas Gummerer wrote:
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 7cef5b120b..d1549e441d 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -303,7 +303,7 @@ static int add_worktree(const char *path, const char *refname,
>  	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>  	write_file(sb.buf, "../..");
>  
> -	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
> +	fprintf(stderr, _("Preparing %s (identifier %s)"), path, name);
>  
>  	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
>  	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
> @@ -320,10 +320,19 @@ static int add_worktree(const char *path, const char *refname,
>  	if (ret)
>  		goto done;
>  
> +	fprintf(stderr, _(", setting HEAD to %s"),

As a former translator, I'm not thrilled to see a sentence broken into
two pieces like this. I'm not a Japanese translator, but I think this
sentence is translated differently when the translator sees the whole
line "Preparing ..., setting ...".

Since the code between the first fprintf and this one should not take
long to execute, perhaps we can just delete the first printf and print
a whole [*] sentence here?

I think the purpose of "Preparing..." in the first place is to show
something when git is busy checkout out the worktree. As long as we
print it before git-reset, we should be good.

> +		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
> +
> +	strbuf_reset(&sb);
> +	pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
> +	if (sb.len > 0)
> +		fprintf(stderr, " %s", sb.buf);

[*] Yes I know it's not "whole" because of this piece. But this one is
more or less a separate sentence already so it's probably ok.

Is it a bit too long to print everything in one line though?
CMIT_FMT_ONELINE could already fill 70 columns easily.

> +	fputc('\n', stderr);
> +
>  	if (opts->checkout) {
>  		cp.argv = NULL;
>  		argv_array_clear(&cp.args);
> -		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> +		argv_array_pushl(&cp.args, "reset", "--hard", "--quiet", NULL);
>  		cp.env = child_env.argv;
>  		ret = run_command(&cp);
>  		if (ret)
> -- 
> 2.16.1.101.gde0f0111ea
> 
