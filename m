Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7982042F
	for <e@80x24.org>; Wed, 16 Nov 2016 13:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbcKPNSH (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 08:18:07 -0500
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35286 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbcKPNSG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 08:18:06 -0500
Received: by mail-yb0-f194.google.com with SMTP id d59so4951642ybi.2
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7b5/DpaQHzBcMiHEDhsRl7/dPYRkwe9+avXwV0zZ29k=;
        b=lzYmPEh9qGv3q4+waJrAyIMc4O3pA4/h625w/EgM9bieSz7ofwh//dxSWZT0IlDPUt
         AUkFAYAfjBphV3X8VFYDw/tzF6YymkaHfcudFMXlQ/RSamTq5slhcM0KSqS41OFSpNix
         lwh2+fOSdeCM2xTMOa2FVlCbqMoNJjMWddnDOcP3SKXXikmx6CSK1OW0Gi1qircbD6Or
         Wj84x4nkmWEvjTz0Btt3J/7DRlnyMfhELDlRWSWAkksErSFyat1Hwf4ER8Jw3dknYV9L
         BWXeP68j6v5kKBjnEdcrJYwclAXA7e+K89hdSq4fdM9dzI5SjwTNsDCvPfXQPKreaDIK
         gntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7b5/DpaQHzBcMiHEDhsRl7/dPYRkwe9+avXwV0zZ29k=;
        b=ddOi0GpitFzuLUZ39nbOI6mPONU5TwE638t2LV31gdGV1phIU4enL3WVLaECD/prtV
         uiuy0x1op+ExisUgNLXrbPj+JmiI+i+06c+6aSTempXsVyhT2lqUVq45DCPPEKAEXpXP
         qQQLPmLlLz0dQwtar0n70hGxJ58rzH5QI0mAFLii6bygXvyh+y/azz3rpZ/sbQOF/QIs
         sSqUDeIYNyfrnziaUChpkxYiEE9Vf8fzdcW2wLQXLWBvFDMpu5GICuku2MtONlUZDOJk
         zD4IEFTEm3Ayjf6/6C099Uk9lHVEbX7aSXk50FiwpdfakErbqKhNiMSydQlup4KXVG/q
         V1lg==
X-Gm-Message-State: ABUngveztL+RJE4KtIv55AT5ft0EDK/WpUgk8HBDXv2nIjTgnNhhEjh48lDwNOYrn6QE3mvB+VIhdKtJ/MKMBQ==
X-Received: by 10.37.115.6 with SMTP id o6mr1444564ybc.139.1479302285626; Wed,
 16 Nov 2016 05:18:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.9 with HTTP; Wed, 16 Nov 2016 05:17:35 -0800 (PST)
In-Reply-To: <5b7d7d0b-8a6c-d516-4eb9-4e4ea13dce73@ramsayjones.plus.com>
References: <5b7d7d0b-8a6c-d516-4eb9-4e4ea13dce73@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 16 Nov 2016 20:17:35 +0700
Message-ID: <CACsJy8BD4YVjrrxz2a0gduaK6QFroHaa7t3_hQWaJ8feM4ZXqA@mail.gmail.com>
Subject: Re: [PATCH] worktree: fix a sparse 'Using plain integer as NULL
 pointer' warning
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 3:28 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Duy,
>
> If you need to re-roll your 'nd/worktree-move' branch, could you
> please squash this into the relevant patch [commit c49e92f5c
> ("worktree move: refuse to move worktrees with submodules", 12-11-2016)].

Will do, thanks (and it's also "thanks" for your other similar emails,
I just don't want to send a mail with just 'thanks' that adds nothing
else).

> Also, one of the new tests introduced by commit 31a8f3066 ("worktree move:
> new command", 12-11-2016), fails for me, thus:
>
>   $ ./t2028-worktree-move.sh -i -v
>   ...
>   --- expected  2016-11-15 20:22:50.647241458 +0000
>   +++ actual    2016-11-15 20:22:50.647241458 +0000
>   @@ -1,3 +1,3 @@
>    worktree /home/ramsay/git/t/trash directory.t2028-worktree-move
>   -worktree /home/ramsay/git/t/trash directory.t2028-worktree-move/destination
>    worktree /home/ramsay/git/t/trash directory.t2028-worktree-move/elsewhere
>   +worktree /home/ramsay/git/t/trash directory.t2028-worktree-move/destination
>   not ok 12 - move worktree
>   #
>   #             git worktree move source destination &&
>   #             test_path_is_missing source &&
>   #             git worktree list --porcelain | grep "^worktree" >actual &&
>   #             cat <<-EOF >expected &&
>   #             worktree $TRASH_DIRECTORY
>   #             worktree $TRASH_DIRECTORY/destination
>   #             worktree $TRASH_DIRECTORY/elsewhere
>   #             EOF
>   #             test_cmp expected actual &&
>   #             git -C destination log --format=%s >actual2 &&
>   #             echo init >expected2 &&
>   #             test_cmp expected2 actual2
>   #
>   $
>
> Is there an expectation that the submodules will be listed in
> any particular order by 'git worktree list --porcelain' ?

I just sent a patch [1] to fix this before reading this mail. The
order so far has been determined by readdir() which is not great.

[1] https://public-inbox.org/git/CACsJy8DOT_4N_48UaoYK61G_8JUaXbEs7N=n24CH2q1GN=++5g@mail.gmail.com/T/#mfcf797219a1a143ed2ac45198015f19e82c70db2
-- 
Duy
