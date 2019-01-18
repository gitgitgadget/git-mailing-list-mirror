Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152381F453
	for <e@80x24.org>; Fri, 18 Jan 2019 22:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfARWUp (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 17:20:45 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33471 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbfARWUn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 17:20:43 -0500
Received: by mail-qk1-f196.google.com with SMTP id d15so8998104qkj.0
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 14:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLOlGmFDFoHSCs0nT54HFrAWM63rA+kkg3lI08v0+N4=;
        b=eZSEZNzCBf88sxhimMkNGcuptrwhXbWuGKjq0V4381sJTEbxQ8J8UaLwL3zuqXSfrt
         MSDJLVPFT+ird0TCI67UwegfvYu1xE/MyxUjwdkF/XQw9KLr/YRvQfpiRg01Fy5xYfmd
         eK5jqIDPMcd8dv4D4tdr/ROH30bv8ULb+tqV8I0hYsb6pDmBwK8Y3Kq5/NQ6axzL+CmP
         4hpLk6e4Y053XI8iVLGuTFTUeGEDCJxyRPMieDHogtXqCq7x8kHf+vF62oOWJPrxh5wC
         yjgljbYCzjRLQBhrX66HZOI8CaUP2pNdBYRYi5MVh0cV96JGt/WtrakW9hPFSHYDoi6u
         vRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLOlGmFDFoHSCs0nT54HFrAWM63rA+kkg3lI08v0+N4=;
        b=DIn8lYn2aD0bmEYrHOptoLuuM3PQ86aTyukC6z/3jfjdiHS6D+LdS4tRHYnVi90FFp
         qCzbt3kK3DtaclYa2qrT5R27KloXFlHLWyEHhpADaUFX8kUKma7xXm3Hj3csqt+FtOyT
         IXZmsW9OeOr5msqITNPAXX/eLkeSpdHgmDn6NgOv9DfJo10C7tAo/XDCFkvbwZg/ARW2
         KCOE46JEbuBW0NkPNeEXs1nYcjL1r5cMbVkbxrYN6rbvTBtjlK818ceBny+HnCRu7NSO
         y4IIgtITUmmX2hOmHdYVFNXN986suEDH7IFWONCtfVQePNuet6XuPyY6JJ8uwruSDpkF
         CzjA==
X-Gm-Message-State: AJcUuke/3lk6GsME+qVD4FQUJDN+xvssbr+P1moZ1A2JpfBgkVJXy3uH
        P5AQIOahdwLWZctSaTWlW4mhAnJHZZnQkYN0Lxs=
X-Google-Smtp-Source: ALg8bN6DDeSIzHp3vBAH/JxClfR1kvQ9sz/blwr2bIt5K+yXTUP1OtCvD528+4UFETxDcXz9BZV/nWLnSsxJJnKKCpg=
X-Received: by 2002:a37:6e43:: with SMTP id j64mr12750257qkc.278.1547850042793;
 Fri, 18 Jan 2019 14:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20190106002619.54741-1-nbelakovski@gmail.com> <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190106002619.54741-2-nbelakovski@gmail.com> <xmqq5zv09vns.fsf@gitster-ct.c.googlers.com>
 <CAC05386ZxQsCPAV+nEXr2LJv-y48qL+YT3E+wg2T8Pf0fPRDsQ@mail.gmail.com>
In-Reply-To: <CAC05386ZxQsCPAV+nEXr2LJv-y48qL+YT3E+wg2T8Pf0fPRDsQ@mail.gmail.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Fri, 18 Jan 2019 14:20:16 -0800
Message-ID: <CAC05385tK4sk0F7tLhPnQN44eKifbb_KKkernKQMEBFHoz8hgw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ref-filter: add worktreepath atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 2:17 PM Nickolai Belakovski
<nbelakovski@gmail.com> wrote:
>
>
> I think avoiding this would be check, we can simply check ref->kind ==
> FILTER_REFS_BRANCHES ahead of calling into get_worktree_path and
> provide an empty string otherwise.
>

*would be check -> would be cheap
