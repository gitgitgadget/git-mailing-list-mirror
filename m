Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07855201A0
	for <e@80x24.org>; Thu, 11 May 2017 19:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933824AbdEKTIN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 15:08:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34612 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932925AbdEKTIM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 15:08:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so4249269pfk.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 12:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ajBhY/JDoOoniqeWule77ngO7jOKe93zuFWDKy08gVk=;
        b=i6id8LJsM61wRLgFtW7TDb1Zz8g2natIZu/XlLDe903XdqdN9DoEwqg0qtZXXpuobV
         o0LJc1kFV3fOKj98jNmbrJC6bFkIQPUFzdNv4sV3bLfvPEWFwtT2slVv3PC/rNKDGqdi
         Z44ZBzSCifbT1w80HIXoHyihlEqdSt1KDhAXrciJ6zygzvNfgfO2x8Y3QZNqlgGeSxeJ
         W3QodypdVZ9TB2gTobAJKtvlbNGeCPaDZ62kq8axiGKmCB5GMPLN6awcMoRlyrQFUy+I
         HBid81GZlMykLLcoeAB3MC6HG1zPm0rvpz5ujDG99RCaWnyv/LviDmzu5HB40iPeIPrM
         srTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ajBhY/JDoOoniqeWule77ngO7jOKe93zuFWDKy08gVk=;
        b=SjQ7R7GKF3WsGtZl3giqO6t5SyTTa2HFdjeUoIS80+YHiGRGr+N7IO3Lhc3ps8Jtbj
         iUC+xl0/WN6fgC9H3+U65UikXDghRLvqh9LjazqTik3u4rWh4yfpaM5EB+YY3c1iVB22
         lt6B9LeOQqLO2CvxrogymyWaTH/57Ttd5AfLbNdgZboNgoZcSzE8UNrqcFfsWG5thVSI
         di57ew02TEea9f1FQ6VxYcZYHLNYzgxkKX0z9oNlaq8eevN+eRBweKZf5tmUX5bv2CGs
         xETrn24AazGxxGn+W5hGoEn68lr5I8JZZK0bfZlV5ytXMED9eLgeD/Uf1ePUbWPmHrkr
         lAoQ==
X-Gm-Message-State: AODbwcBB+OC0klcltYgBOcMGWenPlw2NJ3T3zWtELt1U4oX3CYQuW0gX
        1SDndUmds3QiHA==
X-Received: by 10.84.217.203 with SMTP id d11mr62946plj.141.1494529691742;
        Thu, 11 May 2017 12:08:11 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:ac23:a158:2bd3:569b])
        by smtp.gmail.com with ESMTPSA id k192sm1616294pgc.31.2017.05.11.12.08.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 12:08:11 -0700 (PDT)
Date:   Thu, 11 May 2017 12:08:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] read-tree -m: make error message for merging 0
 trees less smart aleck
Message-ID: <20170511190809.GB12516@aiede.svl.corp.google.com>
References: <20170503162931.30721-1-jn.avila@free.fr>
 <20170511120634.17683-1-jn.avila@free.fr>
 <20170511120634.17683-2-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511120634.17683-2-jn.avila@free.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jean-Noel Avila wrote:

> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Please remove my sign-off.  I didn't write or carry this patch.

If you want to acknowledge my contribution, you can use something
like Helped-by, but it's not necessary.

[...]
> +++ b/Documentation/git-read-tree.txt
> @@ -135,10 +135,10 @@ OPTIONS
>  
>  Merging
>  -------
> -If `-m` is specified, 'git read-tree' can perform 3 kinds of
> -merge, a single tree merge if only 1 tree is given, a
> -fast-forward merge with 2 trees, or a 3-way merge if 3 trees are
> -provided.
> +If `-m` is specified, at least one tree must be given on the command
> +line.

As I mentioned before, this sentence feels redundant and doesn't fix
the real problem of the `-m` reference elsewhere in this file not
pointing to this section.

[...]
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -132,7 +132,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  		OPT_BOOL(0, "empty", &read_empty,
>  			    N_("only empty the index")),
>  		OPT__VERBOSE(&opts.verbose_update, N_("be verbose")),
> -		OPT_GROUP(N_("Merging")),
> +		OPT_GROUP(N_("Merging (needs at least one tree-ish")),

This also seems a little too much of a special detail to put in the
prominent section title.  If you run "git read-tree -h", where would
you expect to find this information?

The "git read-tree -h" output turns out to not be useful for much more
than a reminder of supported options --- it doesn't give a useful
overview of the usage, since the usage string at the start is very
long.  That's unfortunate but it seems outside the scope of this
patch.  Probably the simplest thing is to drop this hunk from the
patch.


[...]
> @@ -226,9 +226,10 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  		setup_work_tree();
>  
>  	if (opts.merge) {
> -		if (stage < 2)
> -			die("just how do you expect me to merge %d trees?", stage-1);
>  		switch (stage - 1) {
> +		case 0:
> +			die(_("you must specify at least one tree to merge"));
> +			break;

This part looks good.

Thanks for your patient work.
Jonathan
