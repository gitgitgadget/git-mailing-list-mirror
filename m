Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27AD201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbdEKUj7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:39:59 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33439 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756889AbdEKUj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:39:58 -0400
Received: by mail-pf0-f178.google.com with SMTP id e193so19254026pfh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=16qUw8DoVwnLaffufMB1S8G1Bcv1/PGJgNo2V7HWpqE=;
        b=jV+GerCDVXjFEHxITdh3H+4K9wrO9hdNZub6REK2zQA7dqQO5YeBskradpmPJF6FKX
         5oicBnDtk/1/Q8Zkk1PVOJYnB0LzaUf5fz45wu5tM/OnIJZuaPewlOHWq295lz5ptsQm
         drflGa1jN2BdV7sA+XiSRoUUKQoYfwCmIUpwxYqiSs0Nqetvt1TxVOr+71TSYm+k+sMV
         yzoU0eVQMhGmu5W3q7YLZdXDJDzugvIGrQO6ZkbhkCkOJgPkYzmjPTB8H2vnnzd+47xK
         RIT3LW+YZsfD/pve3L5vrAZi0VviVGmXxCKK5bVUHiMA+QuRsvpFuTQM0tnqtPAh6ZdX
         JAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=16qUw8DoVwnLaffufMB1S8G1Bcv1/PGJgNo2V7HWpqE=;
        b=i53dkLk1Kj7ootx++/ed9HAkL1PA/ut9qjZ29FCGsJa6zpWG2hoQBX790uW7M9ijpN
         rKy6bu7OEJgDvkXQXc25X8TnNISdv9frvhlcHXE3NrZMDwTRKfiEAQoB7Z5GCk097Vx3
         EK5CvzDYYGyLa3tWZny3lg/FUIgaH0L4mKNcz9ZdYioR2TxXntNq7ZeImRZz3EPuZxfm
         oq1Mb0/KYC04MEsrdIgV+pMfpUGZ1x9oOTCLd0q7lYCmsLS6OvM2w9lXcmwcEckXSpIO
         BIqsnQNCpO7pQxteHFq9j+RG0uWowgxZeC3nfmQWGJon1tppKfnCPRD0BErZWnOEIJ6K
         i2wQ==
X-Gm-Message-State: AODbwcA3a8hqxmLrXSFyOJMNT42N16XysupzXWT0YrUqcRK2IF8Xf+EX
        Xfvrqb1LOZc04BdJN6XX8g==
X-Received: by 10.99.127.70 with SMTP id p6mr410616pgn.169.1494535197562;
        Thu, 11 May 2017 13:39:57 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id a16sm2501400pgd.22.2017.05.11.13.39.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 13:39:56 -0700 (PDT)
Date:   Thu, 11 May 2017 13:39:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] send-email: support validate hook
Message-ID: <20170511203955.GL83655@google.com>
References: <20170511193753.19594-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511193753.19594-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Jonathan Tan wrote:
> Currently, send-email has support for rudimentary e-mail validation.
> Allow the user to add support for more validation by providing a
> sendemail-validate hook.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> 
> This is motivated by situations in which we discuss a work in progress
> using Gerrit (which requires Change-Id trailers in patches), and then,
> forgetting to remove the Change-Id trailers, send them to the Git
> mailing list (which does not want such trailers). I can envision such
> functionality being useful in other situations, hence this patch
> submission.
> 
> I'm not very familiar with Perl, and "There Is More Than One Way To Do
> It", so advice on Perl style is appreciated.

I can't attest to the Perl code itself (I prefer to not touch it :D) but
I've tested this and it works for my purposes!

> ---
>  Documentation/git-send-email.txt |  1 +
>  Documentation/githooks.txt       |  8 ++++++++
>  git-send-email.perl              | 18 +++++++++++++++++-
>  t/t9001-send-email.sh            | 40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 9d66166f6..bb23b02ca 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -377,6 +377,7 @@ have been specified, in which case default to 'compose'.
>  	Currently, validation means the following:
>  +
>  --
> +		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
>  		*	Warn of patches that contain lines longer than 998 characters; this
>  			is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
>  --
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 706091a56..b2514f4d4 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -447,6 +447,14 @@ rebase::
>  The commits are guaranteed to be listed in the order that they were
>  processed by rebase.
>  
> +sendemail-validate
> +~~~~~~~~~~~~~~~~~~
> +
> +This hook is invoked by 'git send-email'.  It takes a single parameter,
> +the name of the file that holds the e-mail to be sent.  Exiting with a
> +non-zero status causes 'git send-email' to abort before sending any
> +e-mails.
> +
>  
>  GIT
>  ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> index eea0a517f..7de91ca7c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -27,6 +27,7 @@ use Term::ANSIColor;
>  use File::Temp qw/ tempdir tempfile /;
>  use File::Spec::Functions qw(catfile);
>  use Error qw(:try);
> +use Cwd qw(abs_path cwd);
>  use Git;
>  use Git::I18N;
>  
> @@ -628,9 +629,24 @@ if (@rev_list_opts) {
>  @files = handle_backup_files(@files);
>  
>  if ($validate) {
> +	my @hook = ($repo->repo_path().'/hooks/sendemail-validate', '');
> +	my $use_hook = -x $hook[0];
> +	if ($use_hook) {
> +		# The hook needs a correct GIT_DIR.
> +		$ENV{"GIT_DIR"} = $repo->repo_path();
> +	}
>  	foreach my $f (@files) {
>  		unless (-p $f) {
> -			my $error = validate_patch($f);
> +			my $error;
> +			if ($use_hook) {
> +				$hook[1] = abs_path($f);
> +				my $cwd_save = cwd();
> +				chdir($repo->wc_path() or $repo->repo_path());
> +				$error = "rejected by sendemail-validate hook"
> +					unless system(@hook) == 0;
> +				chdir($cwd_save);
> +			}
> +			$error = validate_patch($f) unless $error;
>  			$error and die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
>  						  $f, $error);
>  		}
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 60a80f60b..f3f238d40 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1913,4 +1913,44 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
>  	test_cmp expected-list actual-list
>  '
>  
> +test_expect_success $PREREQ 'invoke hook' '
> +	mkdir -p .git/hooks &&
> +
> +	write_script .git/hooks/sendemail-validate <<-\EOF &&
> +		# test that we have the correct environment variable, pwd, and
> +		# argument
> +		case "$GIT_DIR" in
> +			*.git)
> +				true
> +				;;
> +			*)
> +				false
> +				;;
> +		esac &&
> +		test -e 0001-add-master.patch &&
> +		grep "add master" "$1"
> +	EOF
> +
> +	mkdir subdir &&
> +	(
> +		# Test that it works even if we are not at the root of the
> +		# working tree
> +		cd subdir &&
> +		git send-email \
> +			--from="Example <nobody@example.com>" \
> +			--to=nobody@example.com \
> +			--smtp-server="$(pwd)/../fake.sendmail" \
> +			../0001-add-master.patch &&
> +
> +		# Verify error message when a patch is rejected by the hook
> +		sed -e "s/add master/x/" ../0001-add-master.patch >../another.patch &&
> +		git send-email \
> +			--from="Example <nobody@example.com>" \
> +			--to=nobody@example.com \
> +			--smtp-server="$(pwd)/../fake.sendmail" \
> +			../another.patch 2>err
> +		test_i18ngrep "rejected by sendemail-validate hook" err
> +	)
> +'
> +
>  test_done
> -- 
> 2.13.0.rc2.291.g57267f2277-goog
> 

-- 
Brandon Williams
