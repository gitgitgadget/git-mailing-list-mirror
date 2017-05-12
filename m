Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38F82201A0
	for <e@80x24.org>; Fri, 12 May 2017 02:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755578AbdELCPO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 22:15:14 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34409 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdELCPM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 22:15:12 -0400
Received: by mail-pg0-f66.google.com with SMTP id u187so5678734pgb.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 19:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I1Nse9/a3nwrPoDKmDCfZGGFU4BbUCgjX4LwxXmYsYg=;
        b=HKLUb2DS1XOIN5CbTX9KhLBYvGA5BXNDQ5EkONsuJaYD9RsDOWr2k/W/FoWCtUkMgC
         fXnIxpTWyfrGNSMvkNFYW4c/NlIjiJ1YVkl98ubnqHCQyiVGj4wy9h1V1mbSspZY4bs2
         osW1hstmUTdjrHFdYM8Th+W1cjrYgd2EPCX9nUmzgbj5aT3pBER2iDDDclNNtkW+2mxM
         aadRY6mf21UyIAwZrLQArTV61B+SceYhkKjfo30Ge6azxq0WWl+8cBAPPQOM5JLZa9ia
         hYl7D6K2UeeGFk1fcJklTUQAwAFnidBa+hOH+kOQJJRq4SCFKYc9rJPsd8ZEMuQcemFh
         jocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I1Nse9/a3nwrPoDKmDCfZGGFU4BbUCgjX4LwxXmYsYg=;
        b=GNb+Eh5NiebaXg+4lGZvDzjlyWOO4+XJ//ZAROPIYXA5ZRdBx4xrU2dWfX5H8sj5MV
         JtiEuKU4L8jeGjYtZwA4uLMU36vRS/3NYbu4H62V7FeFlncdVDxK9kGyxmK5fjXxvnQp
         i4fZqhI/O6U8y1+RBjVr7mWg6LNHizlG3kXB84qlST0rxq+sTbrWNgmo8xKk1kVMNwSE
         Hx4X/z4vhVxl9P5aGUXmhPIT+h9vqTKiAqUyNYIb140LlEuagTS503GEA0SMDNDksq5H
         nmRViS+oATmUx+nq1bNBto/NaXvaRaDapMHrYBtxZ5gx4/gHmrfLndAMN1WwI4DGDWP5
         yJSQ==
X-Gm-Message-State: AODbwcBNRCncTGRe9nPFVpRYBn7Eyb+TIlNa3jY6qNnkRJ5RSqoEfYG1
        4JHZpHKe7LWgPVop8n0=
X-Received: by 10.98.131.142 with SMTP id h136mr1877804pfe.138.1494555311926;
        Thu, 11 May 2017 19:15:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id p76sm2204976pfa.53.2017.05.11.19.15.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 19:15:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] send-email: support validate hook
References: <20170511193753.19594-1-jonathantanmy@google.com>
Date:   Fri, 12 May 2017 11:15:10 +0900
In-Reply-To: <20170511193753.19594-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 11 May 2017 12:37:53 -0700")
Message-ID: <xmqq8tm295xt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

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

This is not about "Perl code" but I find it somewhat strange to add
this code to outside validate_patch() when we have a helper function 
specifically designed to "validate patch" and the new code is about
teaching the program an additional way to "validate patch".

Also I am not sure if setting and exporting GIT_DIR for the entire
program, only when we run this hook is a sensible thing to do.

Either the remainder of the program is safe to see the GIT_DIR
pointing at the correct location (in which case $ENV{GIT_DIR}
assignment can be done outside "if ($validate && $use_hook)" to
affect everything), or the rest of the program is not prepared to
see such a forced assignment and export (in which case we should
limit the setting of the environment to the subprocess that runs
system(@hook) without affecting anything else).  Doing something in
the middle conditionally feels like it is inviting future troubles
coming from the inconsistency (e.g. "this feature totally unrelated
to the validate hook works when validate hook is in use but
otherwise it doesn't, because $GIT_DIR is sometimes set and
sometimes not").


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

Case arms indented one level too deep.

> +		test -e 0001-add-master.patch &&

Do we only care about existence and do not mind if it is a
directory?  Otherwise using "-f" would be more sensible, perhaps?
