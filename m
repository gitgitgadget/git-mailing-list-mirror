Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509031F453
	for <e@80x24.org>; Wed, 26 Sep 2018 03:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeIZJsn (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 05:48:43 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:34560 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbeIZJsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 05:48:43 -0400
Received: by mail-pf1-f177.google.com with SMTP id k19-v6so12651230pfi.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 20:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=FXrz86iHsXb/jwE5Dd3N2up3fTpsVI6qL7gR/evVcus=;
        b=dB22ny9WP1fnG1eU8eTGsVgZYIZJkYdnur4Z/PPFDwTcJMNE477abF9WO7/Ha1AGif
         qPkV8mTQ/O9FYolVF7zL5c99vMzt4KHOxUCgUY1+fdKso9osHvS0lPbpgq80KRGTXgSG
         7+Rhjht3CHKa7GY/WMs1H0vEnwQoQ1iNJ9Rcx2m4dUGjRWRgdBRIzzRS6Fvk9NhM3RnI
         ltkmkYMhMaU5wscO6QD2HIWUOYk6W6qmOID53cDkeIv34jmNXOvTvbDLUEs3cSH+Ncoq
         8WmIekPCTD9c98wK6tBaDrkZ+JwFzx1HVkiggiB5z0qcAdTjVGrfDIUvrApqD2nxBpQ1
         oz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=FXrz86iHsXb/jwE5Dd3N2up3fTpsVI6qL7gR/evVcus=;
        b=UUb8LQy8ns0uYreXb5vPHsxWM/plNOtcDgpiHPA0toD7AEw56VuZTBU9lz7kerDefR
         NBPIZWrcI0ORfZ6lI0v76OX/6J3rra8UBPG4LcRfDxZ2veuVriB8oeyfXwVh6ak2DDGe
         aZ87kdPmvLibO+nSYr1ChSEPTdolTs9o6fwztTT8EhyTdRrM80W593Qrb7NCf4+Fx9Cn
         DFryaus2xstitnHZTGoYPtjY7s5/7H1MV2gQ7g2N8Hk1BN042YAsGeENtpGFkISehzab
         BdNtbSmivs8E0hJL70UCDrtltqalaJ2Y3y2zWNhng9hs6CqaR/yP6yBdNXpt/E1Wo/JZ
         TMkQ==
X-Gm-Message-State: ABuFfognlLIEEqLY06lywd+5K+RbAwhidQHdVGcxIOUEARxzfzzBx1tN
        n1rc4/lprUc4RGigCuZ0Lp8=
X-Google-Smtp-Source: ACcGV63sgBdGCjh6x/TYSMhbjnpZVAFJCgnkfdBLArZ6cZrvJ6ywklBmkpxf6RVdfAFf30hzXSIuUw==
X-Received: by 2002:a62:4299:: with SMTP id h25-v6mr4058475pfd.73.1537933074713;
        Tue, 25 Sep 2018 20:37:54 -0700 (PDT)
Received: from unique-pc ([27.62.128.44])
        by smtp.googlemail.com with ESMTPSA id r12-v6sm4865531pfh.79.2018.09.25.20.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 20:37:53 -0700 (PDT)
Message-ID: <37cf330b7d26241cd770de1c03961d4a88006293.camel@gmail.com>
Subject: Re: git fetch <remote> <branch> behaves weirdely when run in a
 worktree
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
In-Reply-To: <xmqqpnx1ntmm.fsf@gitster-ct.c.googlers.com>
References: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
         <CACsJy8D_37U+4sb7tb8KqGM=_3CRrTaZX1ZE9VqDVrYJT-AhnA@mail.gmail.com>
         <fa6d37b850177f7f2ba31c596d5986962eaf7382.camel@gmail.com>
         <xmqqpnx1ntmm.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 26 Sep 2018 09:07:49 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26 September 2018 03:10:17 GMT+05:30, Junio C Hamano <gitster@pobox.com> wrote:
> 
> That looks like fetching only the 'next' branch and nothing else to
> me.
> 

Interesting.


> Perhaps your script is referring to a variable whose assignment is
> misspelled and invoking
> 
> 	git fetch $origin $branch
> 
> and you are expecting the $branch variable to have string 'next' but
> due to some bugs it is empty somehow?  That explains why sometimes
> (i.e. when $branch does not get the value you expect it to have) the
> script fetches everything and some other times (i.e. when $branch
> does get the right value) the script fetches only the named branch.

Noce guees but I should have made this clear. The weirdness I described
in my initial mail happens when I run "git fetch origin next" manually
in the terminal.

The script only helped me identity that there was an issue as it was
automatically building the wrong version of Git. It was building and
installing the current 'origin/maint' when I wrote it for building
origin/next. I could easily identify the difference as 'origin/maint'
was at v2.18 while 'origin/next' was at v2.19 when I notived this
issue. Also the script doesn't depend on any variables for the branch
name. I've hardcoded the 'next' branch into it. For the sake of
reference, I've attached the script inline at the end of this mail.
Note that I've sanitized the path in which the worktree exists as
$COMMON_ROOT.

I did not notice this weirdness in another PC. But, this happens in all
the worktrees other than the main worktree in my laptop. I'm not sure
what I'm doing weirdly that might have caused this issue.

I'm not sure whether I mentioned this before I'm currently using a
manually built version of Git. It was built from origin/next pointing
at 01d371f741. But this also happens in Git v2.18.0 that comes via the
pacakge manager of my operating system (Debian testing).

--
Sivaraam

#!/bin/sh
#
# A script for the cron job that automatically fetches
# updates for the 'next' branch of Git and builds and
# installs the binary from source.
#
# The build succeeds only if the config.mak is present
# in the directory with appropriate configuration.
#
# The binary is installed into the default location if
# a prefix is not specified in the config.mak file.
# Bringing the binary into use is in the hands of the user.
# Hint: A bash alias might help.

GIT_NEXT_BUILD_AUTOMATE_DIR='$COMMON_ROOT/git-next-build-automate'
LOG_FILE="$GIT_NEXT_BUILD_AUTOMATE_DIR/GIT-NEXT-INSTALLATION-LOG.txt"
LOG_MSG_COMMON="installation of git 'next' build on $(date)"

if cd "$GIT_NEXT_BUILD_AUTOMATE_DIR"
then
	# Fetch the remote changes
	if git fetch origin next && git checkout -f FETCH_HEAD
	then
		if make install
		then
			GIT_NEXT_BUILD_STATUS=0
		else
			GIT_NEXT_BUILD_STATUS=1
		fi
	else
		GIT_NEXT_BUILD_STATUS=1
	fi
else
	GIT_NEXT_BUILD_STATUS=1
fi

if test $GIT_NEXT_BUILD_STATUS -eq 0
then
	echo "SUCCESS: $LOG_MSG_COMMON" >>"$LOG_FILE"
else
	echo "FAILURE: $LOG_MSG_COMMON" >>"$LOG_FILE"
fi

