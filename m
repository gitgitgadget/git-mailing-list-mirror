Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53E51F424
	for <e@80x24.org>; Mon, 23 Apr 2018 05:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeDWFgW (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 01:36:22 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38405 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754105AbeDWFgS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 01:36:18 -0400
Received: by mail-qk0-f195.google.com with SMTP id b39so14988545qkb.5
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 22:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kBrp8Xp/rO7w8e0NQvPkHsv1TbaJy3BIpVbjfBmZwks=;
        b=ZWtuX85opvooYwF2oRQjYF+5o5OHkHTjO1dXoMbBZbRLMY2szGdiW07kzQefxG3fBW
         2URM/sUoRNRUhn2hSxuBz2rIqNAfN9Nav0BQFLX+QoD5tv2/N4FFlkc69EflJaqBfhQH
         /GmHUV6dwRtmc0g33g44hP87y1f6zVPD5x7nFTzmsw89ryBx4R48JnzBhNRD9GDzuSwZ
         rMRizJK6yyrKpjNslF7KSDD2ERJceZEta+IbU1GHfo5mm7u1BvQw6n+QuoYjHSKaMSuA
         DrE8qDmv2jMJRNea3LJQAH3w7yE+3zfF4N9uZBErOGm7gOS7T1iyua8KfqwYbvwK0RY+
         CFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kBrp8Xp/rO7w8e0NQvPkHsv1TbaJy3BIpVbjfBmZwks=;
        b=hzBWsOXshRstnqpdHNjDrIVhI+fST+Om2EhZkcoQmT8htljGDRj09F3hJ9qWbynqVE
         Y0z8dEyRXUawqZAKlaIOLN0EhUxs/EvAfBb64mZaPi6L7thZZmeHLfxs3pHOU4hETdPi
         Kb2iGpCt2AjdIaed59OKttVMe+R0uaZQn7FBbJpU9omcUQyZ7yFOkj24oTuLMyuuqs4T
         Bra+k+NGAqWTE5gSG9tcq8lMbx3VjGPyIpJeBrbUOkViprpCBjTA7bKoyRkGpjKwc8k/
         osCXcQXJygiwdDU7+OVMDD66dZKs5N4tg3A0z40zvUMvJlCYevwwEs0qoOVAKgem+7Tz
         f2Eg==
X-Gm-Message-State: ALQs6tBbXGLcBwDhTZK/MpfFpQRWiljCaM/wkrqfsR7iTIx3KAID3qr8
        8hFdibA9xXqe0uxpwZdH+kwIR6uPczzPGVZeZck=
X-Google-Smtp-Source: AB8JxZpVBUZ4gkzKc7etZ+EjpwgTVdpX3TdOZ+zYJNDADmGzWeN+MNXx3NdUMCLgzAj9HYsZgZk6b1uKwwDWtUuYMEc=
X-Received: by 10.55.79.9 with SMTP id d9mr20797616qkb.2.1524461777804; Sun,
 22 Apr 2018 22:36:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 22 Apr 2018 22:36:17 -0700 (PDT)
In-Reply-To: <20180417181300.23683-1-pclouds@gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Apr 2018 01:36:17 -0400
X-Google-Sender-Auth: Z9nnvzCRs9vzOV_qV2TDyAyU2GQ
Message-ID: <CAPig+cRkUrdtbyGEsY=DQCDoEWTrC-9n4=vKXHEap2gokB2uQg@mail.gmail.com>
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 2:13 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> The problem with completing --no- form is that the number of
> completable options now usually doubles, taking precious screen space
> and also making it hard to find the option you want.
>
> So the other half of this patch, the part in git-completion.bash, is
> to uncomplete --no- options. When you do "git checkout --<tab>",
> instead of displaying all --no- options, this patch simply displays
> one item: the --no- prefix. If you do "git checkout --no-<tab>" then
> all negative options are displayed. This helps reduce completable
> options quite efficiently.
>
> After all this "git checkout --<tab>" now looks like this
>
>     > ~/w/git $ git co --
>     --conflict=3D                   --orphan=3D
>     --detach                      --ours
>     --ignore-other-worktrees      --patch
>     --ignore-skip-worktree-bits   --progress
>     --merge                       --quiet
>     --no-                         --recurse-submodules
>     --no-detach                   --theirs
>     --no-quiet                    --track
>     --no-track

I haven't looked at the implementation, so this may be an entirely
stupid suggestion, but would it be possible to instead render the
completions as?

    % git checkout --<tab>
    --[no-]conflict=3D                   --[no-]patch
    --[no-]detach                      --[no-]progress
    --[no-]ignore-other-worktrees      --[no-]quiet
    --[no-]ignore-skip-worktree-bits   --[no-]recurse-submodules
    --[no-]merge                       --theirs
    --[no-]orphan=3D                     --[no-]track
    --ours

This would address the problem of the --no-* options taking double the
screen space.

It's also more intuitive than that lone and somewhat weird-looking
"--no-" suggestion.
