Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4422720705
	for <e@80x24.org>; Wed,  7 Sep 2016 09:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756177AbcIGJ2Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 05:28:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33340 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbcIGJ2O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 05:28:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id j136so249528wmj.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 02:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IoWWlRwpJJwm+OWBktYsv7RaZv8BtNWI25jgIA/pV5I=;
        b=YRBb4alhwvtKySLsrQQvFQDlqZqAAvGuj31dgb7WEQAD8v/x3peffpy0SaPR15h5Jc
         2ChiMPjSD69XJ83TLEnBOm4ujvCB3k9vs93FercRxTpSpZFBv9J7FI5aNBjHQ1QsyGnn
         mv3nhGzmOxHxeNMUCp/P7hQN+AkwWi+ba2FZ8gHvDJTTz2hKfoskC4F7thFCqM9F8VCc
         0vIBTKaq4mJYn9T9s4Xk7MwUskOw//L1PhxX2oGrFJcnTnhOWZ3oJiqxY8xT3HMXL0mi
         Ysnhw4g5Xg3+9oHSqt7T97q0DFvEF5k8SvfyXZubEODQcDRW6f4SThkPAD6eb9Jpi2tF
         gjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IoWWlRwpJJwm+OWBktYsv7RaZv8BtNWI25jgIA/pV5I=;
        b=Ut7jxvlDT75NY8OSQPwZ/ilRDd87B4CDtUCvKzQqt+pF4B067pvRg2bdMu3HaWNStS
         htQy5tGRqOvu44X4aZilIHNDPZxhsrp82otYow0cPK09KC9W7ghUZ1Ua9VBio8kRTRIo
         YIxpDwTDkPSRJG/2u23IJQB/0lucZkdfEgXcJiMbOZ1k3Muy9YVS6NG0Qs/Lcv0GA2uO
         5A8dzuxMWV5OFqyA9DLTeKtP85WIRhQYkzZ6EPOMqBB/IMjQSNmgHaeP0SyjAAOJXTS4
         cYgDoLwUqGThIpIbLaaZm39gBchxkcyzTvsoqomz4Wl7uDcjCSsyEWEia8qv6dohPqaj
         4k3A==
X-Gm-Message-State: AE9vXwN7zIvrkZzOWyemrBkWG0scLRZj9KSe3NrOnbmFh/5hLXpbOM4erkJRO6u7kvwDGA==
X-Received: by 10.28.16.3 with SMTP id 3mr2964443wmq.58.1473240493167;
        Wed, 07 Sep 2016 02:28:13 -0700 (PDT)
Received: from [10.156.56.142] (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id g1sm37768322wjy.5.2016.09.07.02.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 02:28:12 -0700 (PDT)
Message-ID: <1473240491.20551.1.camel@kaarsemaker.net>
Subject: Re: [PATCH v2] rebase -i: improve advice on bad instruction lines
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
Date:   Wed, 07 Sep 2016 11:28:11 +0200
In-Reply-To: <20160906185918.21286-1-ralf.thielow@gmail.com>
References: <20160906180838.865-1-ralf.thielow@gmail.com>
         <20160906185918.21286-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

There are quite a few patch series in flight these days around
interactive rebase. Have you checked for conflicts with those?

On di, 2016-09-06 at 20:59 +0200, Ralf Thielow wrote:
> If we found bad instruction lines in the instruction sheet
> of interactive rebase, we give the user advice on how to
> fix it.  However, we don't tell the user what to do afterwards.
> Give the user advice to run 'git rebase --continue' after
> the fix.
> 
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> Changes in v2:
> - adjust tests
> 
>  git-rebase--interactive.sh    | 2 +-
>  t/t3404-rebase-interactive.sh | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index b1ba21c..029594e 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1041,7 +1041,7 @@ The possible behaviours are: ignore, warn,
> error.")"
>  		# placed before the commit of the next action
>  		checkout_onto
>  
> -		warn "$(gettext "You can fix this with 'git rebase
> --edit-todo'.")"
> +		warn "$(gettext "You can fix this with 'git rebase
> --edit-todo' and then run 'git rebase --continue'.")"
>  		die "$(gettext "Or you can abort the rebase with
> 'git rebase --abort'.")"
>  	fi
>  }
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-
> interactive.sh
> index 597e94e..e38e296 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1195,7 +1195,7 @@ To avoid this message, use "drop" to explicitly
> remove a commit.
>  Use 'git config rebase.missingCommitsCheck' to change the level of
> warnings.
>  The possible behaviours are: ignore, warn, error.
>  
> -You can fix this with 'git rebase --edit-todo'.
> +You can fix this with 'git rebase --edit-todo' and then run 'git
> rebase --continue'.
>  Or you can abort the rebase with 'git rebase --abort'.
>  EOF
>  
> @@ -1219,7 +1219,7 @@ cat >expect <<EOF
>  Warning: the command isn't recognized in the following line:
>   - badcmd $(git rev-list --oneline -1 master~1)
>  
> -You can fix this with 'git rebase --edit-todo'.
> +You can fix this with 'git rebase --edit-todo' and then run 'git
> rebase --continue'.
>  Or you can abort the rebase with 'git rebase --abort'.
>  EOF
>  
> @@ -1254,7 +1254,7 @@ cat >expect <<EOF
>  Warning: the SHA-1 is missing or isn't a commit in the following
> line:
>   - edit XXXXXXX False commit
>  
> -You can fix this with 'git rebase --edit-todo'.
> +You can fix this with 'git rebase --edit-todo' and then run 'git
> rebase --continue'.
>  Or you can abort the rebase with 'git rebase --abort'.
>  EOF
>  
