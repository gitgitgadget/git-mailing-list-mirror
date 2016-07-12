Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B271F744
	for <e@80x24.org>; Tue, 12 Jul 2016 02:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbcGLCKx (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 22:10:53 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36319 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbcGLCKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 22:10:52 -0400
Received: by mail-pa0-f66.google.com with SMTP id ib6so149706pad.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 19:10:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q5eTEKyZ0GffhRpsuWW/+P7ip7yDJQYEy2F5MvhlQQU=;
        b=b9kyyL2GuVhgILVK6l0QcipuyGzUD/pQ7BaTk4HEoUL5Bme7u7el4R0YY5pY54s9em
         EOAqUu8ZYNHM2Jn6RlAwJ5btHXy5rO3SkixpJep3L0EteQY5VBW3by0R5CWuK3DlL+/e
         mP7p6GwO2j1W59Wb9/gdI9H1LCaW4jezIAU9UX+Uj2Be0a+Jm+tAMvrbqDOkdF5U91kC
         m1iX1YOwvuDC4EFaf8ssSTS/ZgjAvIBF2LU1y1hMY0Xmeyvl4AE/ZXTKLc5RstN+XkLy
         6R7+4sXmAWX6ljm7xDtSa6QFUmLYS6zoBvslYhmPmjjULCs1ZAiQ94Yflu6E/LcSRJjq
         o1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q5eTEKyZ0GffhRpsuWW/+P7ip7yDJQYEy2F5MvhlQQU=;
        b=CNhUi/J1ACmsFTJ+QzJKfavz6+DleNtm4tC3Gj5eFPNgCuTOU8PmmASCE8sIYgjf8B
         5SCama4AryAHaUgesgegIlCeocEGLUhQ9bevT2VrkUQcUynFSiO0jt/GHgxrS/OF0LOt
         hPlt9fSt6HcUH2uqfA+gSjFkYXcUBSOWhtaCZruhxeEipw1tMri1lc91NuHRMPzRMJLW
         eAP0ucnbKXgmUefF2h0dkKXEX1f9Auv3Be2K2rxivCsFSdAXpVdQlrNAeQoOtzIke4gT
         hUb9Ob2pysYDGXPJ18R/zcrVL9a6PS516CBmDWb+F0aJHDkZNwBlV0z9nWyup7IJrvVc
         2X6g==
X-Gm-Message-State: ALyK8tK8eCBvVsGb8+2IOH4eCh51+OxrEgUcg1UUASsvjSlQYb3TGTa5qkNVLgus451z2Q==
X-Received: by 10.66.244.199 with SMTP id xi7mr7222615pac.127.1468289451718;
        Mon, 11 Jul 2016 19:10:51 -0700 (PDT)
Received: from gmail.com (remote-11.disneyanimation.com. [198.187.190.11])
        by smtp.gmail.com with ESMTPSA id p75sm301378pfa.71.2016.07.11.19.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2016 19:10:50 -0700 (PDT)
Date:	Mon, 11 Jul 2016 19:10:48 -0700
From:	David Aguilar <davvid@gmail.com>
To:	John Keeping <john@keeping.me.uk>
Cc:	Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>,
	git@vger.kernel.org, Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] difftool: fix argument handling in subdirs
Message-ID: <20160712021048.GA20679@gmail.com>
References: <OFEE90CED0.0832E3D4-ONC1257FE9.0053D856-C1257FE6.00660366@lancom.de>
 <155b7339538.2774.8c011de0e6d4f677db1e190e9d3169b9@rwth-aachen.de>
 <20160705195252.hzf5hvrcub3g32gg@john.keeping.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160705195252.hzf5hvrcub3g32gg@john.keeping.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[Cc'd Tim, who originally authored the dir-diff code]

On Tue, Jul 05, 2016 at 08:52:52PM +0100, John Keeping wrote:
> On Mon, Jul 04, 2016 at 08:37:39PM +0200, Bernhard Kirchen wrote:
> > Today I started using --dir-diff and noticed a problem when specifying a
> > non-full path limiter. My diff tool is setup to be meld (*1).
> > 
> > OK while working directory is repo root; also OK while working directory is
> > repo subfolder "actual":
> > git difftool --dir-diff HEAD~1 HEAD -- actual/existing/path
> > => meld opens with proper dir-diff.
> > 
> > NOT OK while working directory is repo subfolder "actual":
> > git difftool --dir-diff HEAD~1 HEAD -- existing/path
> > => nothing happens, as if using "non/such/path" as the path limiter.
> > 
> > Because "git diff HEAD~1 HEAD -- existing/path" while the working directory
> > is the repo subfolder "actual" works, I epxected the difftool to work
> > similarly. Is this a bug?
> 
> I think it is, yes.  The patch below fixes it for me and doesn't break
> any existing tests, but I still don't understand why the separate
> $diffrepo was needed originally, so I'm not certain this won't break
> some other corner case.


IIRC the original motivation for using a separate $diffrepo was
to handle GIT_DIR being set in the environment.

The lack of tests for that use case could be better, though.
Is that use case affected by this change?

Tim, do you remember why a new repo instance is used for that code path?


> -- >8 --
> When in a subdirectory of a repository, path arguments should be
> interpreted relative to the current directory not the root of the
> working tree.
> 
> The Git::repository object passed into setup_dir_diff() is configured to
> handle this correctly but we create a new Git::repository here without
> setting the WorkingSubdir argument.  By simply using the existing
> repository, path arguments are handled relative to the current
> directory.

I do like the sound of this rationale, though.

Tim, please let us know if you have a specific test case that is
not covered by this change.

BTW, `diff --raw` will still output paths that are relative to
the root but this is okay since the rest of the code expects
things to be root-relative, correct?


> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  git-difftool.perl | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/git-difftool.perl b/git-difftool.perl
> index ebd13ba..c9d3ef8 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -115,16 +115,9 @@ sub setup_dir_diff
>  {
>  	my ($repo, $workdir, $symlinks) = @_;
>  
> -	# Run the diff; exit immediately if no diff found
> -	# 'Repository' and 'WorkingCopy' must be explicitly set to insure that
> -	# if $GIT_DIR and $GIT_WORK_TREE are set in ENV, they are actually used
> -	# by Git->repository->command*.
>  	my $repo_path = $repo->repo_path();
> -	my %repo_args = (Repository => $repo_path, WorkingCopy => $workdir);
> -	my $diffrepo = Git->repository(%repo_args);
> -
>  	my @gitargs = ('diff', '--raw', '--no-abbrev', '-z', @ARGV);
> -	my $diffrtn = $diffrepo->command_oneline(@gitargs);
> +	my $diffrtn = $repo->command_oneline(@gitargs);
>  	exit(0) unless defined($diffrtn);
>  
>  	# Build index info for left and right sides of the diff
> @@ -176,12 +169,12 @@ EOF
>  
>  		if ($lmode eq $symlink_mode) {
>  			$symlink{$src_path}{left} =
> -				$diffrepo->command_oneline('show', "$lsha1");
> +				$repo->command_oneline('show', "$lsha1");
>  		}
>  
>  		if ($rmode eq $symlink_mode) {
>  			$symlink{$dst_path}{right} =
> -				$diffrepo->command_oneline('show', "$rsha1");
> +				$repo->command_oneline('show', "$rsha1");
>  		}
>  
>  		if ($lmode ne $null_mode and $status !~ /^C/) {
> -- 

Can you please also add a testcase to t/t7800-difftool.sh
demonstrating the problem fixed by this change?

Hopefully there's an existing test in there that can be adapted
to run dir-diffs in a subdirectory.

ciao,
-- 
David
