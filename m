Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782301FAE2
	for <e@80x24.org>; Wed,  7 Mar 2018 10:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeCGKBf (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 05:01:35 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:44797 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeCGKBe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 05:01:34 -0500
Received: by mail-ot0-f169.google.com with SMTP id 79so1511766oth.11
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 02:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iRX7BMMb+9I26N0Z+dlh/bxiQ+WJTJ8ETKBLKui/7Es=;
        b=JxM8BTFUwit2iyyMelralrLIBKwM6GEA37hzk1IS7N2c1fjk33KJyk9zVADXfaLHnk
         Cdx4AZqKYA+jRTmifeBh5w33VM0m7cSS729qPsxq6njR771TNsJKbNqaGAJQq0VLDx4G
         0r/Q8sa9ir3IEtyMDgFD2XhgdGUoKFckYpCy6Tc1TfcdWy1+PIURca/6fB+pCuCUx8Bm
         cxVySZvSrrScjjMQ6Ml4XUHBSJHTke+FoBJPAjD6ybDG9zoDpa2PMlpNjtCaN2XeNbMN
         h2HdraW7LRTuPLyBgfaOOQ3CPlU1iZMDtQ1fYzEA6kV82TDR3RLsLHpP9SSwqIdMFZ4U
         j15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iRX7BMMb+9I26N0Z+dlh/bxiQ+WJTJ8ETKBLKui/7Es=;
        b=gPuZusDHpzuHIuE7c9YJvS/mUTzwL6CqlnmiCb6GOnWJ+krCxlVVXBZUgVPxYc/n/n
         TnrRwiaiWDubZajSA0M74/eMv36ocKcn4sfHSeCDXal9iIfTu/8V9bl4eom01fb4Hghy
         le4ALT2gAr707qS/x1d8WugQBf98ZpbcFmO9bXo2nQ24HWJY4otdxNcYGBJbVzOMv5mW
         Dh1ZHvM43Go5BlVWct0ABfjJ2ZxwjDUGkTb8P5u+aw56YYLp6ViaX2AEz49HZyko9v8H
         S5H0KeRLdBO4NJMKdCB00Sd4kVOdLj5VvSgGpVvau2GPv7r6pvw/l8S2vJl2njoSVV3g
         VUlg==
X-Gm-Message-State: AElRT7HYZrbJsFST2E7RJxAQL4htMmYyiyO8VP8YJ17Bt2PB99nxotWA
        gZr2FRXDrb8z46WcZcv02gFqIGJ8YuATgCrpjWg=
X-Google-Smtp-Source: AG47ELuLvnzpV1l1nXur9m03EbTMs1TU07Io05xyGOfrLYuDpTfo0y07Pk1t1Ujqw5sAH/w7vK7RUYOSe6vHhj+59w8=
X-Received: by 10.157.85.214 with SMTP id z22mr15947504oti.75.1520416893504;
 Wed, 07 Mar 2018 02:01:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Wed, 7 Mar 2018 02:01:02 -0800 (PST)
In-Reply-To: <CAPig+cRGMEjVbJZKXOskN6=5zchisx7UuwW9ZKGwoq5GQZQ_rw@mail.gmail.com>
References: <aa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org>
 <CAPig+cSGJhNR8dapLXN0TU8ZpTqi7m6OQf_cCGmHc9FLGcwNyg@mail.gmail.com>
 <adf7a7a0-3571-5b68-5d15-30a9067e3826@aegee.org> <CAPig+cTPFSbT7WxyoNEOSg=3Ft1pVzkgieGp44kHnZ9=NbYsqg@mail.gmail.com>
 <CACsJy8BUKCG-yiYX3ouMVa44iEo0swHpTkhW3ho_T0PCP81DSw@mail.gmail.com>
 <b34d74fa-f4c7-fb4a-49df-cd7ebd996d95@aegee.org> <CACsJy8CXEKG+WNdSPOWF7JDzPXidSRWZZ5zkdMW3N3Dg8SGW_Q@mail.gmail.com>
 <CAPig+cRGMEjVbJZKXOskN6=5zchisx7UuwW9ZKGwoq5GQZQ_rw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Mar 2018 17:01:02 +0700
Message-ID: <CACsJy8CCHzysHM4pJpY1Xz-8QLzRF5zj=+cjNifsHRCMUci8Fg@mail.gmail.com>
Subject: Re: Worktree silently deleted on git fetch/gc/log
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 5:05 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> I can't presently think of a reason why gitdir needed/used an absolute
> or normalized path. Was it because there was some need to compare such
> paths?

No, we need to re-normalize paths before comparing anyway to be safe.
I don't think I had any special reason for using absolute path either,
except that dealing with it is a bit easier than relative one.

>> If we stored relative path in ".git" file at least, the worktree would
>> immediately fail after the user moves either the linked checkout, or
>> the main one. This should send a loud and clear signal to the user
>> "something has gone horribly" and hopefully make them connect it to
>> the last rename and undo that. "git gc" would have near zero chance to
>> kick in and destroy stale worktrees.
>
> It would detect if the main or linked worktree moved up or down one or
> more directory levels or elsewhere.
>
> It would not detect if the worktree directory was merely renamed.

True. We can be a bit more aggressive and check it anyway at command
startup (once we can peek into the main .git dir, we know where this
linked worktree is supposed to be). Or perhaps we can do this in "gc
--auto" (even though gc may end up not doing any maintenance job).
This command is usually called on heavy commands, adding one more
check should not hurt.

> Still, detecting some cases of breakage early may be better than not
> detecting breakage at all.
>
> Another idea may be to store the worktree's own normalized/absolute
> path as a second line in its .git file. It could then immediately
> detect any manual movement or renaming of itself. A minor concern,
> though, is if there are any external tools reading that file directly
> since they could be confused by the second line. Of course, such tools
> hopefully would be using "git rev-parse --git-dir", so maybe it
> wouldn't be a big deal. On the other hand, older versions of Git
> itself would be confused by the second line, so perhaps the idea isn't
> viable.

Yeah I'm a bit hesitant to break that file format. Many tools ignore
our programs and peek inside anyway, I think magit is one of them.
-- 
Duy
