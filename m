Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C1DC32771
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 02:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiI0CQg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 26 Sep 2022 22:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiI0CQd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 22:16:33 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109E571BE3
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 19:16:31 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3511e80f908so24107607b3.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 19:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jIaGcjw7cSnJxOuiBMO/hR9pPK+ENV1017W4vOt+hUk=;
        b=kZPxQEG6FT6Jt0v0upzwWEe9CjirW8pZMPeAebKibE+8Hk/chuZvBS+M6tFgO243fR
         0WwDkTzVBaVniVh4hM+M9LLu6U1A1AOH1DzgmbmOGZQyi6EhtJJ25GHdAJlBOREq9HA1
         iKZyY8Xyfxj912dBZ4NKwWodjBMz92/pF0lDxj/vWIv+bjoXDWSdJV7wgnLvtWZMlPIV
         Xm1/CLiiLY42PkkpqMSS4cgl4zMf60onzir7GgeLzm4gffIoDXXkO4HpUFXy4hJ5IKH0
         1uX0dzHa2enZ7gQdsd80r3Auq+wmOEVLjs9yt8RYK6zfmjJotOA6glwkQrAOM40gStxE
         1cEA==
X-Gm-Message-State: ACrzQf2ph1bGNOB+XOtu0xGYv+Bpv29nBtbWETXimZFjllBDQ7o8L68D
        ugDmsLFzJ6w7Cv6JJ4yzIGWb/INWJtxHJ9J3zL+xGlrERHQFzA==
X-Google-Smtp-Source: AMsMyM6FHPdTKKtNbQfbY9XVLNDq9IYiY81HK5wsk4ms2cyrQw6ch1saDflepR7hfH+UQ4cMSoEAjUCfhxm87bq9+RI=
X-Received: by 2002:a81:a905:0:b0:33c:1ec4:e704 with SMTP id
 g5-20020a81a905000000b0033c1ec4e704mr23355063ywh.275.1664244990580; Mon, 26
 Sep 2022 19:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
 <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com> <b375b0ac798a673301a09903dcdfb22bedda7393.1664048782.git.gitgitgadget@gmail.com>
 <220926.864jwu181g.gmgdl@evledraar.gmail.com>
In-Reply-To: <220926.864jwu181g.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Sep 2022 22:16:19 -0400
Message-ID: <CAPig+cSsKu9N+vSx5gTuxksi6sDczszXntQnMinHgRZVfY9JGA@mail.gmail.com>
Subject: Re: [PATCH v12 6/6] fsmonitor: add documentation for allowRemote and
 socketDir options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 11:15 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Sep 24 2022, Eric DeCosta via GitGitGadget wrote:
> > Add documentation for 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'.
> > Call-out experimental nature of 'fsmonitor.allowRemote' and limited file
> > system support for 'fsmonitor.socketDir'.
> >
> > Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> > ---
> > -git-fsmonitor--daemon - A Built-in File System Monitor
> > +git-fsmonitor--daemon - A Built-in Filesystem Monitor
>
> We have ~400 uses of "filesystem" in-tree, but ~100 for "file system". I
> don't mind the change per-se, but this looks like an odd "while at it"
> change.
>
> >  A daemon to watch the working directory for file and directory
> > -changes using platform-specific file system notification facilities.
> > +changes using platform-specific filesystem notification facilities.
>
> More while-at-it...

These changes may have been in response to my review[1], though I did
say that such a change was outside the scope of this series. Perhaps I
need to choose my wording more carefully?

[1]: https://lore.kernel.org/git/CAPig+cQ5SMw+0Cwtw47LQM59-mQjJaOPe_LTybAC2j=3F9OywA@mail.gmail.com/
