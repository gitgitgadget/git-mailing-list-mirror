Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04DFB1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 17:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfIBREg (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 13:04:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37642 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfIBREg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 13:04:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id t14so13508892lji.4
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6cFEh8uElRtBdk13K8BapDULZYwHbC4vgrEGbddOdw=;
        b=qKaKFg4WrP11p2NPQo+Mibhkw8gGhJLEMoG1CeFhS3mJTLCZ6HQjaR9/za9mggb7q1
         Hir9Z1zxFcRRE53rjA1OzflfjsFrNhXWZiE2axSrmPpKTVHmVrwBnilPnlM+v1re5Fre
         QRi3ZmVHlX14Kd5m3sOrlOnsfvZwJuglx8SO0NmvMbreUf1ShjI9mp9ED0fPI3RrIldA
         PY3cfrW/hOtEUg6cuKW6UOUATtUleRNITrXiiYdZeioNwIi5owTkAKLx5yZ7F26j+p/6
         AltHAl0+06bT0kDBGHw2eDuTPBFMzKxFHo1dgJerScCoFd5iQZwtHPj7o96a0yL0wyED
         oeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6cFEh8uElRtBdk13K8BapDULZYwHbC4vgrEGbddOdw=;
        b=LqMGSmOG+ybnGGy3XAUXOQVewtYHmQAvNFP76XGuUIx3tNdsxRaxWxxt9IDLrwL6pB
         sPUpltb/ynnkvUKPsp6i+PGDMKEGDwW/+Y0tPRx0lirErHrC1nh21fcg0mGzS+m612Eg
         By2sU6a82N0FiotolP36u2aBHD9Mqhu+h4YyrA7kv/nUoBAvcXNCznpPZVCQj87Wu0Z5
         O3HTc73J8CEPbojsf/GtwnebQe+MMlbeyY5laK9+GLYxqRLC9L9OYqhIHkxc39vUj9Ay
         MtkLTuaFVGaP2XhoLpwUvk5qx4OK6tIQcMMB8pj2R5bRjgtdXoPiQyVptZ8w9FQp3nAE
         l/hg==
X-Gm-Message-State: APjAAAUbFdG7bHL5k5xcp8iFt6NnZmFJI8EL7WuiEr19ZuV3e40J0pN2
        SkPCvBVixEgH/CSpumc6LCMPUcwkUGyGEGteGz8e7M8c1+xNUw==
X-Google-Smtp-Source: APXvYqxkueIWe83jl2tVxgSS/l5E2OBBoGrowJCutCTscPQZ5YGegfIBy3I2BIg5iZKY0ug69IjwXNfEs9zJhBi0SVg=
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr435148lji.26.1567443874208;
 Mon, 02 Sep 2019 10:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
In-Reply-To: <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 2 Sep 2019 19:04:21 +0200
Message-ID: <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar appears
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,


Thanks for picking this up.
I just gave your patch a go, and I think there are a couple of issues.


Applying the patch yields:

$ git apply patch1.patch
patch1.patch:18: indent with spaces.
       -yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set} \
patch1.patch:19: indent with spaces.
       -xscrollcommand {.vpane.lower.commarea.buffer.sbx set}
patch1.patch:21: indent with spaces.
       -orient vertical \
patch1.patch:24: indent with spaces.
       -orient horizontal \
patch1.patch:25: indent with spaces.
       -command [list $ui_comm xview]
warning: git-gui.sh has type 100644, expected 100755
error: patch failed: git-gui.sh:3363
error: git-gui.sh: patch does not apply


Replacing the spaces with tabs before applying, I notice the
horisontal scrollbar appears to be "outside" of the text input area.
And it doesn't follow the height of the commit message text input
area.
Here's a screenshot: https://i.imgur.com/721axUX.png


Birger

On Mon, Sep 2, 2019 at 2:06 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>
> Hi Birger,
>
> On Mon, Sep 2, 2019 at 11:13 AM Birger Skogeng Pedersen
> <birger.sp@gmail.com> wrote:
> >
> > Hi,
> >
> > I just noticed that long lines in the commit message widget does in
> > fact not show a horizontal scrollbar.
> > So if a line in the commit message is more than 75 characters, it gets
> > a bit confusing.
> > Should it not have a scrollbar?
> > Example shown here: https://i.imgur.com/I3d6nBJ.png
>
> the old reasoning was, that you should not create commit messages
> which are too wide. While I can follow this reasoning, hiding content
> is also not a good idea. Thus I tried a different aproach. Instead of
> not showing the content, I pop up a dialog, if the commit message
> contains too long lines and add you requested scrollbar.
>
> As I'm currently unable to send patches per mail, I pushed it to GitHub:
>
> https://github.com/bertwesarg/git-gui/tree/bw/commit-scrollbuffer
>
> And I will paste the scrollbuffer commit below.
>
> Best,
> Bert
>
> Author: Bert Wesarg <bert.wesarg@googlemail.com>
> Date:   Mon Sep 2 13:57:24 2019 +0200
>
>     git-gui: add horizontal scrollbar to commit buffer
>
>     Sugestted-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
>     Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> diff --git a/git-gui.sh b/git-gui.sh
> index a491085..919d1e9 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3363,14 +3363,20 @@ ttext $ui_comm -background white -foreground black \
>         -relief sunken \
>         -width $repo_config(gui.commitmsgwidth) -height 9 -wrap none \
>         -font font_diff \
> -       -yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set}
> +       -yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set} \
> +       -xscrollcommand {.vpane.lower.commarea.buffer.sbx set}
>  ${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sby \
> +       -orient vertical \
>         -command [list $ui_comm yview]
> +${NS}::scrollbar .vpane.lower.commarea.buffer.sbx \
> +       -orient horizontal \
> +       -command [list $ui_comm xview]
>
>  pack .vpane.lower.commarea.buffer.frame.sby -side right -fill y
>  pack $ui_comm -side left -fill y
> +pack .vpane.lower.commarea.buffer.sbx -side bottom -fill x
>  pack .vpane.lower.commarea.buffer.header -side top -fill x
> -pack .vpane.lower.commarea.buffer.frame -side left -fill y
> +pack .vpane.lower.commarea.buffer.frame -side top -fill x
>  pack .vpane.lower.commarea.buffer -side left -fill y
>
>  # -- Commit Message Buffer Context Menu
