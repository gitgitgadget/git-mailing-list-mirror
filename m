Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D4BC4332F
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 12:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380915AbhLCMwK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 3 Dec 2021 07:52:10 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:38676 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352128AbhLCMwK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 07:52:10 -0500
Received: by mail-pl1-f178.google.com with SMTP id o14so2033327plg.5
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 04:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SAZQkrFxNgLTLsUhMJEgIp1dzeEtdMNrcfJdQ4mOKWM=;
        b=HLfP/zkOGOWtmRVn7g1zURP/+UphDVwYfyBdj3ld642KDcU9KbBOVt4HGFZwe5JA4/
         lxyJNqYBYD7LxqciepCDUZ0iorYAINvqcjeLAh3lucRDESpYn61J1equMSRWDksSxvOF
         mVqDMYz4qBkRUHzZsNcR6sczr5zj5rtx9pPSAOcXsEUvCrbvsz6VU3sOjm1SIcBUV99t
         HzGUjS7PVcdoVOvs+9VbD8+M0I0T/tAtgDgaSW3ePQwRpe0/2oC1nau9zQNuk6Z62hMZ
         b+l1GE49CN7enNofci+RGhWFe90KRwvngUPnvL/TpLQt+aEuOELjB9jG98uC9wXKgbWn
         mqHw==
X-Gm-Message-State: AOAM533BagvQnx2k/04kMrpNNcHiGJBskqj5rQ9C9xm74QIjI0WyqS66
        Wj7q2Wbr8Io/jCtZR6MumTWsVx/YzgcommpoCLU=
X-Google-Smtp-Source: ABdhPJy3b+u4jwtED6ONzJL+E/crkBHbA7m2on0X6fPgzyG2z6LMUkpTjWgFzEvLeEZv9GBjEIfAf26KLHerezIi9zE=
X-Received: by 2002:a17:902:7d8b:b0:144:e29b:4f2b with SMTP id
 a11-20020a1709027d8b00b00144e29b4f2bmr22387207plm.57.1638535726022; Fri, 03
 Dec 2021 04:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20211203034420.47447-1-sunshine@sunshineco.com>
 <20211203034420.47447-3-sunshine@sunshineco.com> <211203.86k0gmt5fl.gmgdl@evledraar.gmail.com>
In-Reply-To: <211203.86k0gmt5fl.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Dec 2021 07:48:35 -0500
Message-ID: <CAPig+cR7f1koM7d2GoHMcDhZkQe3=XJD2RVuMajXSpcwZiyGtQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-worktree.txt: add missing `-v` to synopsis for
 `worktree list`
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 4:15 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Thu, Dec 02 2021, Eric Sunshine wrote:
> > -'git worktree list' [--porcelain]
> > +'git worktree list' [-v | --porcelain]
>
> Aside: I've been thinking of hacking something up to just change all
> these "[verse]" bits in the *.txt source to:
>
>     [verse]
>     $(git worktree -h)
>
> And then have the doc build process pick that up, run 'git $name -h', do
> some light search/replacement (e.g. "$cmd" to "'$cmd'") and build the
> docs like that.
>
> Seems far preferrable to dual-maintaining all of these forever.
>
> But in the meantime this small fix is obviously correct.

One caution that springs to mind is that there may be external tooling
which processes these documentation files directly, and such a change
might break them. (The one which popped to mind immediately was the
git-scm.{org,com} website, though I don't know what their tooling
looks like.)
