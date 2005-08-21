From: Chris Wedgwood <cw@f00f.org>
Subject: Re: Make "git-ls-files" work in subdirectories
Date: Sun, 21 Aug 2005 15:46:22 -0700
Message-ID: <20050821224622.GB26241@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0508211210500.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 22 00:47:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6yaN-0001zr-KT
	for gcvg-git@gmane.org; Mon, 22 Aug 2005 00:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVHUWqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 18:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVHUWqb
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 18:46:31 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:48268 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP
	id S1750903AbVHUWqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2005 18:46:31 -0400
Received: from pimout1-ext.prodigy.net (pimout1-int.prodigy.net [207.115.5.65])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j7LMka5x016672
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 18:46:38 -0400
X-ORBL: [63.205.185.3]
Received: from stupidest.org (adsl-63-205-185-3.dsl.snfc21.pacbell.net [63.205.185.3])
	by pimout1-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j7LMkMuS165266;
	Sun, 21 Aug 2005 18:46:23 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id B074A528F22; Sun, 21 Aug 2005 15:46:22 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508211210500.3317@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 21, 2005 at 12:55:33PM -0700, Linus Torvalds wrote:

> -		} else if (!strcmp(arg, "-t")) {
> +			continue;
> +		}
> +		if (!strcmp(arg, "-t")) {
>  			tag_cached = "H ";
>  			tag_unmerged = "M ";
>  			tag_removed = "R ";
>  			tag_other = "? ";
>  			tag_killed = "K ";
> -		} else if (!strcmp(arg, "-c") || !strcmp(arg, "--cached")) {
> +			continue;
> +		}
> +		if (!strcmp(arg, "-c") || !strcmp(arg, "--cached")) {
>  			show_cached = 1;
> -		} else if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
> +			continue;
> +		}
> +		if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
>  			show_deleted = 1;
> -		} else if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
> +			continue;
> +		}
> +		if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
>  			show_others = 1;
> -		} else if (!strcmp(arg, "-i") || !strcmp(arg, "--ignored")) {
> +			continue;
> +		}
> +		if (!strcmp(arg, "-i") || !strcmp(arg, "--ignored")) {
>  			show_ignored = 1;
> -		} else if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
> +			continue;
> +		}
> +		if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
>  			show_stage = 1;
> -		} else if (!strcmp(arg, "-k") || !strcmp(arg, "--killed")) {
> +			continue;
> +		}
> +		if (!strcmp(arg, "-k") || !strcmp(arg, "--killed")) {
>  			show_killed = 1;
> -		} else if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
> +			continue;
> +		}
> +		if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
>  			/* There's no point in showing unmerged unless
>  			 * you also show the stage information.
>  			 */
>  			show_stage = 1;
>  			show_unmerged = 1;
> -		} else if (!strcmp(arg, "-x") && i+1 < argc) {
> +			continue;
> +		}
> +		if (!strcmp(arg, "-x") && i+1 < argc) {
>  			exc_given = 1;
>  			add_exclude(argv[++i], "", 0, &exclude_list[EXC_CMDL]);
> -		} else if (!strncmp(arg, "--exclude=", 10)) {
> +			continue;
> +		}
> +		if (!strncmp(arg, "--exclude=", 10)) {
>  			exc_given = 1;
>  			add_exclude(arg+10, "", 0, &exclude_list[EXC_CMDL]);
> -		} else if (!strcmp(arg, "-X") && i+1 < argc) {
> +			continue;
> +		}
> +		if (!strcmp(arg, "-X") && i+1 < argc) {
>  			exc_given = 1;
>  			add_excludes_from_file(argv[++i]);
> -		} else if (!strncmp(arg, "--exclude-from=", 15)) {
> +			continue;
> +		}
> +		if (!strncmp(arg, "--exclude-from=", 15)) {
>  			exc_given = 1;
>  			add_excludes_from_file(arg+15);
> -		} else if (!strncmp(arg, "--exclude-per-directory=", 24)) {
> +			continue;
> +		}
> +		if (!strncmp(arg, "--exclude-per-directory=", 24)) {
>  			exc_given = 1;
>  			exclude_per_dir = arg + 24;
> -		} else
> +			continue;
> +		}
> +		if (!strcmp(arg, "--full-name")) {
> +			prefix_offset = 0;
> +			continue;
> +		}
> +		if (glob || *arg == '-')
>  			usage(ls_files_usage);
> +		glob = arg;

is there some aversion to getopt or similar get?
