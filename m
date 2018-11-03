Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2F31F453
	for <e@80x24.org>; Sat,  3 Nov 2018 07:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeKCRJv (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:09:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50473 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeKCRJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:09:50 -0400
Received: by mail-it1-f194.google.com with SMTP id k206-v6so6282231ite.0
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 00:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DfjjIM2BOzSyHLJ4lljpg9jE0aCWnNopTAm9fjAtW70=;
        b=vC/H8DSMKHDkZrhtmANEs1twui5d5qTrD4ykTOjQj0Gpq6PgYQByWENb62hLhRc32G
         XWWqyVLqL7JlE0OEupdoeRRqBxuiflfWH5kKOs3PpcGnSHV7bmz2h7BoENIrTfMGD0BB
         FfPnJ1Rh7iMxU7gnmbemIu6fCiYidG3YhTd8W1IWGE0D/uGW6pyJp22iLW8RiV89t19h
         4VLkAsGcMMjEHZ7FLXBK7XAlLoooAbFque0BHgtRE0VEOKj2tCRkYb8M8WXgL9h0zyXg
         ABASd5UcFr0Q+6ANSeGobwmnB132OAPkPmJt6L4CTJV0MeycU9ZNmlCXIGRWLZl0sdba
         8qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DfjjIM2BOzSyHLJ4lljpg9jE0aCWnNopTAm9fjAtW70=;
        b=jq09nEcLQx3tbUzV5iqio5A/LnPV3TMSfExqpq82g5QsBA1Q4TKB+n2MARR3FddK6B
         f7BczuSIC8rZ3g3/cJluzoXwSr1erzB0MkppleXuvvJxKv2GIdobeDvZqfi3+e1/fTgq
         iEHGMhuXKTXD2xJF3RC9UL0IXx1fzZAG1Fbtifgsz96KwhFIZE5jH90iIgj2DeG0RSg1
         zHdevUtBZVUBngkQ0wuz9Qt7lFWt/NwAnTOwZEhw9tPgAfHNX4Ju6dHH+h/fTo7nc0Wd
         VnAEz/KB6eMMp508vbUQNjkX3ZitnhiA+BJg95nQUfmHnmgVAEebg3FY+pvbZ2L7Z0+q
         Tnmw==
X-Gm-Message-State: AGRZ1gIIAlhEgCLm12kVAxtp37ZzXvhJ4/4ELwuqo/DrEQgTwbYBueIP
        np/Iy4Z6oYWhXRwlwfANlxg=
X-Google-Smtp-Source: AJdET5cWHiaQ9BurAyijFgL6lhQXCRfRTrx1ntAfih32frYYZsgrOz+4qaa99eptkpVcqagkjMonAA==
X-Received: by 2002:a02:8986:: with SMTP id p6-v6mr13029918jaj.56.1541231962009;
        Sat, 03 Nov 2018 00:59:22 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id y190-v6sm11750153itg.19.2018.11.03.00.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 00:59:21 -0700 (PDT)
Date:   Sat, 3 Nov 2018 03:59:18 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Anmol Mago <anmolmago@gmail.com>, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Subject: Re: [PATCH v2] completion: use builtin completion for format-patch
Message-ID: <20181103075918.GA905@archbookpro.localdomain>
References: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com>
 <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
 <CACsJy8Ajc0qWw3RLak1PRPXvQzMHjaFuWJ6BPkhiVg=7fQvCnA@mail.gmail.com>
 <xmqqk1lxvaj6.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AowaAW91wGMYbC8aTOB1NoqQN-5NGx=qUCHp0i6zQRDA@mail.gmail.com>
 <xmqqzhuss6dd.fsf@gitster-ct.c.googlers.com>
 <20181103060317.GA5432@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181103060317.GA5432@duynguyen.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 03, 2018 at 07:03:18AM +0100, Duy Nguyen wrote:
> Subject: [PATCH] completion: use __gitcomp_builtin for format-patch
> 
> This helps format-patch gain completion for a couple new options,
> notably --range-diff.
> 
> Since send-email completion relies on $__git_format_patch_options
> which is now reduced, we need to do something not to regress
> send-email completion.
> 
> The workaround here is implement --git-completion-helper in
> send-email.perl just as a bridge to "format-patch --git-completion-helper".
> This is enough to use __gitcomp_builtin on send-email (to take
> advantage of caching).
> 
> In the end, send-email.perl can probably reuse the same info it passes
> to GetOptions() to generate full --git-completion-helper output so
> that we don't need to keep track of its options in git-completion.bash
> anymore. But that's something for another boring day.
> 
> Helped-by: Denton Liu <liu.denton@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 16 ++++++----------
>  git-send-email.perl                    |  8 ++++++++
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index db7fd87b6b..8409978793 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1532,13 +1532,9 @@ _git_fetch ()
>  	__git_complete_remote_or_refspec
>  }
>  
> -__git_format_patch_options="
> -	--stdout --attach --no-attach --thread --thread= --no-thread
> -	--numbered --start-number --numbered-files --keep-subject --signoff
> -	--signature --no-signature --in-reply-to= --cc= --full-index --binary
> -	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
> -	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
> -	--output-directory --reroll-count --to= --quiet --notes
> +__git_format_patch_extra_options="
> +	--full-index --not --all --no-prefix --src-prefix=
> +	--dst-prefix= --notes
>  "
>  
>  _git_format_patch ()
> @@ -1551,7 +1547,7 @@ _git_format_patch ()
>  		return
>  		;;
>  	--*)
> -		__gitcomp "$__git_format_patch_options"
> +		__gitcomp_builtin format-patch "$__git_format_patch_extra_options"
>  		return
>  		;;
>  	esac
> @@ -2081,7 +2077,7 @@ _git_send_email ()
>  		return
>  		;;
>  	--*)
> -		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
> +		__gitcomp_builtin send-email "--annotate --bcc --cc --cc-cmd --chain-reply-to
>  			--compose --confirm= --dry-run --envelope-sender
>  			--from --identity
>  			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc

Would it make sense to make send-email's completion helper print these
out directly? That way, if someone were to modify send-email in the
future, they'd only have to look through one file instead of both
send-email and the completions script.

> @@ -2090,7 +2086,7 @@ _git_send_email ()
>  			--smtp-server-port --smtp-encryption= --smtp-user
>  			--subject --suppress-cc= --suppress-from --thread --to
>  			--validate --no-validate
> -			$__git_format_patch_options"
> +			$__git_format_patch_extra_options"
>  		return
>  		;;
>  	esac
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2be5dac337..ed0714eaaa 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -119,6 +119,11 @@ sub usage {
>  	exit(1);
>  }
>  
> +sub completion_helper {
> +    print Git::command('format-patch', '--git-completion-helper');
> +    exit(0);
> +}
> +
>  # most mail servers generate the Date: header, but not all...
>  sub format_2822_time {
>  	my ($time) = @_;
> @@ -311,6 +316,7 @@ sub signal_handler {
>  # needing, first, from the command line:
>  
>  my $help;
> +my $git_completion_helper;
>  my $rc = GetOptions("h" => \$help,
>                      "dump-aliases" => \$dump_aliases);
>  usage() unless $rc;
> @@ -373,9 +379,11 @@ sub signal_handler {
>  		    "no-xmailer" => sub {$use_xmailer = 0},
>  		    "batch-size=i" => \$batch_size,
>  		    "relogin-delay=i" => \$relogin_delay,
> +		    "git-completion-helper" => \$git_completion_helper,
>  	 );
>  
>  usage() if $help;
> +completion_helper() if $git_completion_helper;
>  unless ($rc) {
>      usage();
>  }
> -- 
> 2.19.1.1005.gac84295441
> 
> -- 8< --
> --
> Duy

Aside from that one comment, it looks good to me. Thanks for helping me
clean up my earlier patch!
