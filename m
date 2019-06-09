Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220A31F462
	for <e@80x24.org>; Sun,  9 Jun 2019 10:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfFIKJU (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 06:09:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34690 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbfFIKI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 06:08:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id y198so4637070lfa.1
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itwh7UAFSIfSIW1IOHCwjaKL9cZc0DHR/VvU3mMBDVU=;
        b=flIyJjwJte4QRKt8aueF4ralhMFv1dvJa+f5utDs8lsWEeQXnCBX5wUGMNUR6+rlHu
         GeiV1dhu2UZWJHG5WeHkumFn07F39mwi3ezNh+onNtyPm+G6O9nNW3ioDUDpnkIqQWzW
         nX6Vc0yunGym/vpv6F1VOdufxncPDNLWXMDnyoFjGMRCkTuhIpPX6bHluRD1bn109Dfw
         gnSjBpmcdwaElfdpWh8Au99LG6GN4zE85WEVzjJypxTyfa9vaAJEMaRN6H+R1X0ableT
         fHW96IvuWmgMB/BerWdRfdk9+7zItBCdBrbgjmYgpjBaRH70dft5LMmkVsw9jYz08g1b
         r9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itwh7UAFSIfSIW1IOHCwjaKL9cZc0DHR/VvU3mMBDVU=;
        b=ibJQdHZcp3c06WrudWrPPPJEj4ArqZnHEQoUUZDrf+rZ7keJMV8uns95LG/QrPGnKW
         F6PSKK5IqRp2MaTnFldciuyVo0I7dqGRVn6yTC7qFq2EGD+6fAx23EZp5VpBAcZmeoFe
         +yYZomb9a2ht/vfzcL3ITmE6afLy1Jvro7/RkocwJjimpuE2UsE/PysqhZdMRqowVp2J
         jWYf1uVaqqTilSLhZApIoCZV7S5mm0vw3yCamHm+9cvTMsoPpOQhcdxpa+KzYL6Th0Kw
         MkJJWscXmupCPy8LVBuuBP8iK6LRwr5hROcwDyOp8NPepobh1rFp3HKssk3lvn8nH6aZ
         CHLQ==
X-Gm-Message-State: APjAAAVHtDbTQEHaqtp3ywQXhH3uCkY+HGMFATy4X/xIBAXeI5IH27kD
        JOSOOORl/xkbUxWU0Beo2HegvreVy5o0Ei+0+K0=
X-Google-Smtp-Source: APXvYqxrjAn9unWwPVzm93wb0Rrhcxj2fJEaxHghCObKUkiVE7JTz9PU+ybou05MTDvgh5qtEO29v1xqCDhq+mMVQbQ=
X-Received: by 2002:a19:c142:: with SMTP id r63mr34089162lff.49.1560074937562;
 Sun, 09 Jun 2019 03:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com> <20190609090235.GC28007@hank.intra.tgummerer.com>
In-Reply-To: <20190609090235.GC28007@hank.intra.tgummerer.com>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Sun, 9 Jun 2019 15:36:23 +0530
Message-ID: <CAL7ArXpMBXwOGXWmYx8Rv9bj2trJ-FS_VGgPmJbAh+evbaxNEw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/3] Teach cherry-pick/revert to skip commits
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Thomas

On Sun, Jun 9, 2019 at 2:32 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Thanks!  I found a few minor nits that I missed in my off-list review
> on the PR.  We should give others some time to comment now before you
> re-send it with the nits fixed (if you agree with them).

Yes, I'll wait for some more reviews before sending another iteration.

> One thing that would be good to add to future cover letters is a
> reminder of how this fits in to your GSoC project, where the overall
> end goal is to improve the consistency of sequencer commands, and this
> is one step along that way.

Sure, I'll keep this in mind and send some kind of summary in the next
revision.

>
> > PR: https://github.com/r1walz/git/pull/1
> > Reviewed-by: Elijah Newren <newren@gmail.com>
> > Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>
>
> Note that the 'Reviewed-by' footer is something that is "given" by the
> reviewers, and should only be added after they have explicitly given
> it for the patch/series in question.  Instead this should probably
> mention that Elijah and me reviewed this off-list in the PR you linked
> to above.

Oh! But I read here, SubmittingPatches[1] docs, that it's nice to give
credits to those who helped you. Should we fix it in some way? I don't
know. Anyway, that is beyond the scope of this patch.

>
> > --
> > 2.21.0
> >

Thanks for the review
Rohit

[1]: https://github.com/git/git/blob/v2.22.0/Documentation/SubmittingPatches#L289-L291
