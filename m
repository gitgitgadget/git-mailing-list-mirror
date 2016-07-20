Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76C12034E
	for <e@80x24.org>; Wed, 20 Jul 2016 22:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbcGTWZ2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 18:25:28 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35747 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091AbcGTWZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 18:25:25 -0400
Received: by mail-pa0-f67.google.com with SMTP id cf3so3997365pad.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 15:25:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aq6fN694ZsTbi/i5RCI5vSpKJVWiZqb3K57WE1d1++4=;
        b=qqkyAvhMXW40v3fOTqtpk4WCE8yxxDO8wAoHsHZfe51ozeXL84D6ZIdXUnZDC24zTQ
         noYJcsiklqw5CHcDDgHE/17oxFweVTXbLr2IfyzeyTbCMtMgYV9IRie7s9jTtp6BxHoD
         C+fx186Q4B+eTko6zGFYGr04t/IHJcPKdYlRQpD92hYR3QisLiURnTpVzHzAFZ+uXN7n
         XShlHYfEkVNn8qnmu2Q6ZjxoXb108A551GbeMyFfuRZPPpS5/a4kQQ3G4hg7moZZVQcu
         sp24FHCpaay5dOnmxjK46HhVYRHVcjmpof/EWrffjJoVMXxkvpLacheTDuzziIjY112L
         ZSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aq6fN694ZsTbi/i5RCI5vSpKJVWiZqb3K57WE1d1++4=;
        b=P33ZGa/HDDq9WNCKypZSD7GxKDVY8ENQpDU1Hr+rzPWBsqB9FXsQEIgFqVchE2h0c5
         8mXPCHMrPKwA29YV3rr8kHFoVRlauw6hxr1e/LnOMNtzsu5iWrQDIh5n3vVMnkhiFLa3
         SJt9zB8Lz4vzU7var6oGYksFH7m911OqAOCeo8TjBzhxfTgw/dciKPZlrLJxr5VjnjE7
         6aGhAqbOHZ4c/yDqr45AxYgSJ2beHKDRS6B5ClbKUoDE08J/jKeFlLdi4lWRCyFd5OC/
         Fl8CQwYfp/DqWcl65S0guT2iHxbYhgUfiOkNHOn1wqxe+qSHHr4VpQuffiDJxeAaYeru
         5Kag==
X-Gm-Message-State: ALyK8tLjmITUSni+SCTm1rMb2D1fxtrmMRSlqiCGM6Ll3XRVKCm4h2ZaUvb0NFBId0mayQ==
X-Received: by 10.66.94.71 with SMTP id da7mr77907528pab.31.1469053524435;
        Wed, 20 Jul 2016 15:25:24 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id a20sm6881338pfa.27.2016.07.20.15.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 15:25:23 -0700 (PDT)
Date:	Wed, 20 Jul 2016 15:25:20 -0700
From:	David Aguilar <davvid@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	John Keeping <john@keeping.me.uk>,
	Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] difftool: avoid $GIT_DIR and $GIT_WORK_TREE
Message-ID: <20160720222520.GA22966@gmail.com>
References: <20160719035756.24961-1-davvid@gmail.com>
 <20160719035756.24961-2-davvid@gmail.com>
 <xmqqy44xfq3n.fsf@gitster.mtv.corp.google.com>
 <xmqqvb01e3s4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvb01e3s4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 02:06:35PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > It is not wrong per-se, but as you are in a subshell, you do not
> > have to unset these, I would think.  Not worth a reroll, but unless
> > I am overlooking something (in which case please holler) I'm
> > inclined to remove these two lines myself while queuing the series.
> 
> I propose to squashing the following to 2/3 (and adjusting 3/3 as
> needed).  No need to resend if you agree it is a good idea, as it is
> part of what I've queued on 'pu'.
> 
> Thanks.


I had originally meant to squash that in but it slipped through.
It looks great.

Thank you!


>  git-difftool.perl   | 2 +-
>  t/t7800-difftool.sh | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/git-difftool.perl b/git-difftool.perl
> index bc2267f..c81cbe4 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -88,11 +88,11 @@ sub changed_files
>  	my @refreshargs = (
>  		@gitargs, 'update-index',
>  		'--really-refresh', '-q', '--unmerged');
> -	my @diffargs = (@gitargs, 'diff-files', '--name-only', '-z');
>  	try {
>  		Git::command_oneline(@refreshargs);
>  	} catch Git::Error::Command with {};
>  
> +	my @diffargs = (@gitargs, 'diff-files', '--name-only', '-z');
>  	my $line = Git::command_oneline(@diffargs);
>  	my @files;
>  	if (defined $line) {
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index afdf370..cb25480 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -421,8 +421,6 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory with GIT_DIR set' '
>  		cd sub &&
>  		git difftool --dir-diff $symlinks --extcmd ls \
>  			branch -- sub >output &&
> -		sane_unset GIT_WORK_TREE &&
> -		sane_unset GIT_DIR &&
>  		grep sub output &&
>  		! grep file output
>  	)
> -- 
> 2.9.2-581-g77f0ffb
> 

-- 
David
