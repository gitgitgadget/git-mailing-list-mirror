Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069B71F453
	for <e@80x24.org>; Tue, 12 Feb 2019 20:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfBLUuI (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 15:50:08 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:42531 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfBLUuI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 15:50:08 -0500
Received: by mail-ed1-f41.google.com with SMTP id r15so41919eds.9
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 12:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTfA6quBP+UGTpGytR8FsBhWpdHrrJuwpPZgJ0o7gQY=;
        b=q30BqkLNJjrwyHoApHH6UU7G8gthFlYqHikhyuiA4l5j2BbrHsqiyS8H/jVDBbmcoN
         OHyLU+3+CWP0vamQk1o5wnYmqdwjFWwOgXxdh0jLT55hyINryFvKJpuMt/0POrZospro
         OHoYzZ42kw434ha02YpjCy6AG0ngoCJUUCkCdNh38+MUO0crpDx0VRb1z7AF9FTxLYFA
         ApDSdBVmebNcZBrOQ3Rpqiyt+t5mh6KWZ+0/5zCB1tZEMM1c/jAtnLOb0kLIE8xM8rj/
         SWsyGl0CgcMJS/XSZi75DU6Yln9oIi2x2c9UpDm9I6rr6jYfMk4Jg3e82NdH0qrEqKlP
         thnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTfA6quBP+UGTpGytR8FsBhWpdHrrJuwpPZgJ0o7gQY=;
        b=sUwiV8mzEQyj4vriDW7ogYNJkJElUovpG9Lz8TVzjnnw5xu51Nv/d1nutk4grtjtJ3
         iB1tslxG6RBE/CCyRm4ebYHaj9JP0XTh2JkTTs4H0W+frhDDvvIbSFuyJaSf0F/suW4h
         1Q8p/X+P2r2FfV3mtAnfWf6mLlW9t2MOTpSGbZzyhz74deOul4+V7yUiXTHeKLvEUdi8
         zZOYRwXW+g9s8nXkaxBVR/St6+Gs9OKIglAm1y3AJTIMX8SH/hjzb3AJ9DxpuM+eIfkq
         9sAAjfgecYgES/9YorhgQY2jDnKj2+l5fetk8/s2P3Jv+AtyFccoblPSv75EMhQmBA6d
         OCRw==
X-Gm-Message-State: AHQUAua4+iqN9SswOgIvUKqmjV3qO4ps45cRUV6qF1sUpuPtnmd/AmWV
        x8Vu7vxoFvMZEYMU447rZmkdFjZuTA6cQc1IJ5oHZCe2Ov4=
X-Google-Smtp-Source: AHgI3IYINLA0avDpD8Ugttc9tAsNp+V3OqS/oUKyReZObsipwQK0A15YlWCNxBUkfdy1eleM5UHL1MwRpirQa3qLlKA=
X-Received: by 2002:a50:8f86:: with SMTP id y6mr4700374edy.131.1550004606567;
 Tue, 12 Feb 2019 12:50:06 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com> <CAP8UFD1Rv+nFqDYf33rRw-kWnfqokSG6=tG8XPFyBoVCU6Te=w@mail.gmail.com>
 <20190211221827.GG6085@hank.intra.tgummerer.com> <CAP8UFD3s3-mR528FqV3yuMEZBqT0uP+Mp5hGDcN_a1LfAsR0bg@mail.gmail.com>
 <20190212202501.GA17681@hank.intra.tgummerer.com>
In-Reply-To: <20190212202501.GA17681@hank.intra.tgummerer.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 12 Feb 2019 21:49:54 +0100
Message-ID: <CAP8UFD19Mhpm4MRjQ3xsPx-_Gc6CweTWC3aHbqyhyy0C0dvR1g@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2019 at 9:25 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 02/12, Christian Couder wrote:

> > Yeah, using more of the libgit.a API, instead of the run_command API,
> > and writing technical documentation on the stash commit format look
> > like good ideas to me. I think I will add those items to the project
> > description if you don't mind.
>
> Sure that sounds good, thanks!  I think using more of the libgit.a API
> should probably be an optional endeavor, but writing the technical
> documentation may be a good thing to include in the project.

Ok, there is now the following at the end of the idea:

"This will include writing the technical documentation of the stash
format, and optionally refactoring the `git stash` code to use more of
the libgit.a API, instead of the run_command API."
