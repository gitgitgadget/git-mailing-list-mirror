Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E50F20C11
	for <e@80x24.org>; Wed,  6 Dec 2017 21:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbdLFVpf (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 16:45:35 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:42225 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdLFVpe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 16:45:34 -0500
Received: by mail-qt0-f176.google.com with SMTP id g9so12694582qth.9
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 13:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4m8b503aOBsPkbG7/ftv8DDOEjJg6+sRW+LRxodF8M8=;
        b=gzBxQB+O9o9i4jp6PrRuit06s3KjW7zH6YVJ/0utnipzv2tXiyjZNXM+fzPnSxXD9H
         472Q2fx0/MfxrJCQIGOQPLGxplzL72i7mNDaxDw0rgD8ZtdM96MyHUx/Dx48HGIavRbj
         dD3Cu/28WUZ4YVkUiXXlT0xCZGJeVLNQe8Uadoj9F3l4Ok/+YIYbl1bIJIqZrv3dLYAK
         fkvu3KRxhPACF6cukqPdgJQeJ67Hixii+uHQC20vOuLZa7c4dMskyezbbaexGtnQrAKe
         qEvC6mnZIhyCVAAZC+MDUfqduAP8kSweTI7hBaC7ty7BkpDlR7ktUciq/6UBEevIANxp
         qWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4m8b503aOBsPkbG7/ftv8DDOEjJg6+sRW+LRxodF8M8=;
        b=t5iS8OcJFRvx/n6jYUHHBDiO3BqfWvGPzyf2bSV2g1SVZMBvrUoC4K3cxErNKYQ6Fe
         Qn96cCMCunN0syRf94J5Bfbvp/1kPHxBr1BNI4yBRFuZfIQc/J0M8nB+yULIS4G10wof
         g90gS+bwM0UpYbSfA7pDHBX57yLIq59zs6xEcGBNwbC9GKV+/O3OavM7+5teim+s6rpG
         OCBPxvWa0OdZe7TnwzZVMwxzsYd7PIPN4FbyW1bhpH6QCKVjx0t4uhjlARp2+Vw4p4Bu
         uEaPEekxF/mBKPjQLtO3GnfK7uSZ4aKy5ZQOV5r3JA/+be5HUIlB8flcEjydH/hMTOsf
         XAFA==
X-Gm-Message-State: AKGB3mJsaOXo26CChjoP0twQD1M66UB6SlK8/bTCo2s4IXOghSqJLNY5
        uPV3EwI9cmvPfElZjSmQ3jX0cFHlX+q9Y+8J18Y=
X-Google-Smtp-Source: AGs4zMaIjxTQDxL//FWfFbKY4da05T3xTFiVb21bwKvS0DBLpRHiDlTiRuTCs22zHXJGwxmXjI4pD5EhN7XoM/F+efM=
X-Received: by 10.237.59.22 with SMTP id p22mr6555628qte.34.1512596734018;
 Wed, 06 Dec 2017 13:45:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Wed, 6 Dec 2017 13:45:33 -0800 (PST)
In-Reply-To: <DA0A42D68346B1469147552440A64503C60832DB@ORSMSX105.amr.corp.intel.com>
References: <DA0A42D68346B1469147552440A64503C60832DB@ORSMSX105.amr.corp.intel.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Dec 2017 16:45:33 -0500
X-Google-Sender-Auth: nYuRm4Se3UxVIOOB-y9y7PAV2L4
Message-ID: <CAPig+cQXeC5Nh+=rO9U46PNgnNALd4H3on+feo_NzMg45HqUkQ@mail.gmail.com>
Subject: Re: 'git worktree add' does not fire post-checkout hook
To:     "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 4:00 PM, Gumbel, Matthew K
<matthew.k.gumbel@intel.com> wrote:
> I've noticed that when I run 'git worktree add /path/to/new/tree',
> the post-checkout hook does not fire, even though the worktree
> manpage explicitly states that "worktree add" will, "Create <path>
> and checkout <branch> into it."
>
> Is this the intended behavior? Seems like maybe a bug, but I'm not
> sure.

Seems like an oversight. Given that 'git worktree' is like a cross of
'git clone' and 'git checkout', both of which run that hook, it seems
reasonable that 'git-worktree' should do so, as well.

If you'd like to get your feet wet at contributing to the Git project,
this might be a good first dip, as it looks like an easy fix (a one-
or two-liner). The only thing which needs a bit of care is to skip the
hook when --no-checkout is specified. Other than that, 'githooks'
documentation would need an update to mention that git-worktree also
runs the hook, and t2025-worktree-add.sh would want a couple new tests
(which would probably be the most complex part of the patch).
