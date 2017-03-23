Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4FFD20323
	for <e@80x24.org>; Thu, 23 Mar 2017 01:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbdCWBGK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 21:06:10 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33459 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdCWBGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 21:06:09 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so24443786pgf.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 18:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xfv8EQHBZRinNrEv6zkQy3E2Muic0ELxAUmGeQ/4hpU=;
        b=mvOongzGwToXfEcMiY0gGTfQTL4firy8yDbPRjqfF9rkPAW52wO9/vzGUL6qZS6nZz
         JEYFY2AO22xv5r/MyYxdZEWjP5ZqTMlRT9va/Q29BPuYd3b19j/Zm539PW7W9kUpphL+
         sAN67efx6PHaHR2V9RH09vlDxfmgkcod65iybR4nnmMzw3GGxz28QEAAZYCbYh+FZRkV
         LGBhxySyzB+DB3CDQyzySI6e4Gq3ihOy2aQ6QgM01ZBNbwGS0trekoXCN0kT2kT5Q082
         KdJLuEpTFC1G1HGvEhpXEXyVjj9hvfKQkO1T322BtCwfxsP8SocuJ+QLkj6FSGiF+Li6
         8bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xfv8EQHBZRinNrEv6zkQy3E2Muic0ELxAUmGeQ/4hpU=;
        b=JLQ2WAtV6eIXkCGYQPG4H0F/Gn3CJIpYGriwApiu8Wynegabm3hlKITGXvNd1Ktk8/
         k7oQw0FZE8+B6Rf35LAUIyJ480zypTCafFdDT5QJ2613W4Z1iYpmWZ+qOH20+mFOPTZI
         imVLXr5G7H3Dp/fMRZfaedoQ03OD7huK13pNH1Oae84wbtABIsZPXcpT942a/LysNmKt
         jpiKkS/tr059gPF/z+vQaNgEB31/d7a5J2T7qN7xx0KWeR7dIGJzIOja3Hgsxda5hLGh
         yzTHL8azKLcpq98UcGXjIIebSOQ3a2Fnl48Yt3C6qoLTXxTVfwgD6yunW8qa3QbKhLVh
         E9Dw==
X-Gm-Message-State: AFeK/H0CDHu7pV/KEW/4jRsMPfMIdmxKKXTH2KTe0f3+AHO4Mz7UsdoovdTww2wGB8CinQ==
X-Received: by 10.99.42.78 with SMTP id q75mr47029472pgq.144.1490231167665;
        Wed, 22 Mar 2017 18:06:07 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55f5:992d:bc78:c749])
        by smtp.gmail.com with ESMTPSA id s12sm6141293pfj.9.2017.03.22.18.06.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 18:06:06 -0700 (PDT)
Date:   Wed, 22 Mar 2017 18:06:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 3/3] short status: improve reporting for submodule changes
Message-ID: <20170323010605.GJ26108@aiede.mtv.corp.google.com>
References: <20170323004329.15892-1-sbeller@google.com>
 <20170323004329.15892-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323004329.15892-4-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

>  Documentation/git-status.txt |  9 +++++++++
>  t/t3600-rm.sh                | 18 +++++++++++++-----
>  t/t7506-status-submodule.sh  | 24 ++++++++++++++++++++++++
>  wt-status.c                  | 13 +++++++++++--
>  4 files changed, 57 insertions(+), 7 deletions(-)

Very nice.

[...]
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -181,6 +181,13 @@ in which case `XY` are `!!`.

The documentation is clear.

[...]
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh

The updated behavior shown in this test makes sense.

[...]
> --- a/t/t7506-status-submodule.sh
> +++ b/t/t7506-status-submodule.sh

This test has good coverage and describes a good behavior.

[...]
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -431,10 +431,19 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
>  		}
>  		if (!d->worktree_status)
>  			d->worktree_status = p->status;
> -		d->dirty_submodule = p->two->dirty_submodule;
> -		if (S_ISGITLINK(p->two->mode))
> +		if (S_ISGITLINK(p->two->mode)) {
> +			d->dirty_submodule = p->two->dirty_submodule;
>  			d->new_submodule_commits = !!oidcmp(&p->one->oid,
>  							    &p->two->oid);
> +			if (s->status_format == STATUS_FORMAT_SHORT) {
> +				if (d->new_submodule_commits)
> +					d->worktree_status = 'M';

Can these be new DIFF_STATUS_* letters in diff.h?

I hadn't realized before that the worktree_status usually is taken
verbatim from diff_filepair.  Now I understand better what you were
talking about offline earlier today (sorry for the confusion).

We probably don't want the diff machinery to have to be aware of the
various status_format modes, so doing this here seems sensible to me.
Unfortunately it's also a reminder that "git diff --name-status" and
--diff-filter could benefit from a similar change.  (Unfortunate
because that's a harder change to make without breaking scripts.)

> +				else if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
> +					d->worktree_status = 'm';
> +				else if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> +					d->worktree_status = '?';
> +			}
> +		}

Given the above, this implementation looks good. So for what it's worth,
this patch is
Reviewed-by: Jonathan Nieder <jrineder@gmail.com>

Patch 1/3 is the one that gives me pause, since I hadn't been able to
chase down all callers.  Would it be feasible to split that into two:
one patch to switch to --porcelain=2 but not change behavior, and a
separate patch to improve what is stored in the dirty_submodule flags?

Thanks,
Jonathan
