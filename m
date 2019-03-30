Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0A420248
	for <e@80x24.org>; Sat, 30 Mar 2019 00:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfC3Aip (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 20:38:45 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35418 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfC3Aip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 20:38:45 -0400
Received: by mail-ua1-f67.google.com with SMTP id f88so1294881uaf.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 17:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMgyKleX3Vd43WWzPTzlwwzXxkxtYLpDOI3u+sgMKfs=;
        b=szofwJwOeDz4e64hb1ChvBnvP/RAXI472aT5ZwGQY2/dY3kKwTno0A9+bvZUeSSDCt
         VawM5BEunLiLM1UGLudwGITfEhA/GMrSuFhgvPo1JOwZbIpqFFl75U3eGAIU+PrPgLIX
         p0zRcM7glo7C3P4T07pY+uVuQ0Fvn61hMsSiRNtgeqXChp2kkh/3p1Fglk4BQ1gwWYwP
         2XZQODmHVg6+K08y6nn44ncIh3COzx+zqDKDTcGz8wfxXXw0roxehH9KpIHznEVH69yV
         XsCoxlvJJhAcJzgQ08dH+E4F9fn9eOCTJnycy0rdAJhzKFAbieSO7SrNBvu1Q+kkzQnf
         g9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMgyKleX3Vd43WWzPTzlwwzXxkxtYLpDOI3u+sgMKfs=;
        b=oGxSoAgf1yjbWvNCW6gBnAjF8fze7xHt+9v1ohBi/sTQaXP7jr5/cyO5W5cpoDM2Yl
         KQDSTYa+bkT/vT21E2QpMQrOP9okppi4EOXwWzrdQ/OZXpHialybJp+vC9eSLzuxEDUK
         1PGXIiRRzjMz96smcH/QUze9U+44Pfi0xi/WxZjQnI5xrHxoK9sTuGvLlXpwdi09SrWv
         1QNR81o/X71CbwgKG6l6/yh+fI5VwnEp2lM+p/AJgV4jmSUzwJTen62IoXtjX6cNPK7O
         9QX6w5hArEN++JbZsIsMH4GCHIlMS5+1C8YfYVRvpTAMVXZ1loOuyPtWmO+spOFZuVWf
         2Bzw==
X-Gm-Message-State: APjAAAUISLSVOLbSVrXUJTzeY8xueOOKBy2pY4i6J3OSbI1O7c+RfAOE
        H+I0T1yRcy+SMMi26kATAF/AY0BKAX1tl5HocePYUyR0X5Y=
X-Google-Smtp-Source: APXvYqwwsIqsMv6dg0jzZQwCWpzjCpBhxGcMuMYpwyPtodAXt4IAMYjPAMIVmMHMHiGv0U7AXB3oetOgSmU55dEQw6s=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr19635523ual.95.1553906324136;
 Fri, 29 Mar 2019 17:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BETuwt96jeBMMhzT84-=-MqEA3D7uhLb2uxW3fijx7p7Q@mail.gmail.com>
 <20190329233407.13049-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190329233407.13049-1-rohit.ashiwal265@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 29 Mar 2019 17:38:33 -0700
Message-ID: <CABPp-BEsqW61f4SWehTpFzMF97AzTUB_StOS83GAmZOC7QohSg@mail.gmail.com>
Subject: Re: [GSoC][RFC v2] Improve consistency of sequencer commands
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>, artagnon@gmail.com,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, rafa.almas@gmail.com,
        Stephan Beyer <s-beyer@gmx.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 4:35 PM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
>
> Hi Elijah
>
> On Sat, Mar 30, 2019 at 4:56 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > Overall this looks pretty good to me, just one question...
> >
>
> :)
>
> > >     5. `[Bonus]` --signoff
> >
> > --signoff is new and surprises me.  What's the plan with that one?
> >
>
> I was reading the documentation of git-rebase[1], where I found that
> `--signoff` flag is not available for interactive backend, i.e., it is not
> possible to convert a commit into `Signed-off-by` commit while interactive
> rebasing.

I'm curious if you're looking at an old version of the documentation
(...or maybe the documentation just isn't that clear?).  Interactive
rebases have supported --signoff since commit a852ec7f273c ("rebase:
extend --signoff support", 2018-03-20)
