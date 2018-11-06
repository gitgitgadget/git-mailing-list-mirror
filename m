Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029091F453
	for <e@80x24.org>; Tue,  6 Nov 2018 17:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbeKGCye (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 21:54:34 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35151 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbeKGCye (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 21:54:34 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so12589509itj.0
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 09:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXuxMeP10TP9WXnRfgFKuITTXidQOPUPe52rcyqsPPo=;
        b=dbhCvMx4AJXwOHjKXm2+JOxrtsoNPt61/UAgprIbQ6er11kOcxsQh2BCrgj/RdBib9
         bVaYLtgEeGSC6BElR9BAViLoe/DexQ+yLXQpcEepUMqFRasVitvKmn+NXHHgDcW5VDu1
         MMBMWlYUYV6O/1Z8if21C1y6oreHQYK13mIueM0twgJNe9zlgROCNKPmILm+m+e55ptY
         cumxhe5wansS+h36BmG0amo2SrVHshFo65tbCEBjrhSAKtDzSn76VwFsQGAiw59ZDDa6
         EvncAvekMGGfGexMnp2Wc1DcUc9gm72VdnefD2rORQoaNWwTsKRgKPacYV4C1ds4tZGA
         AKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXuxMeP10TP9WXnRfgFKuITTXidQOPUPe52rcyqsPPo=;
        b=p6vfWotKPi0J2MXxSUOYSo7PhAwRQ4nzg0XtDBSDdYjzcqHY4lsVHfzvrr7ngoPiDJ
         CQCB0rvmcfxd8NgqwBrdezhV5Qk1LUgVjm6BRV5wSmJSSZ25nhjuHTqqDY7MRKSaXge7
         aOzn9rhACpeMy4g3CljBK5pHD3foi3uRZSo9UU068BvQo2KS5rH02vtyMYFE4k/Rqvl+
         jYqvy6tpa0YAw1I/S/rjiRdfYWsboDpCOPOHjSnxrY7VMoRIj3mSrwVz5nTgoy3tYE3z
         rXlYUKtzn3eKVNA5IUwRhSww3JdjnW9oU+67Q1ZGxgO9YkI9+wqY8dG+/NjTRe2cb5NS
         t4ZA==
X-Gm-Message-State: AGRZ1gK2mBHl8nggkp9SEZSsVwaQShNzSwvCDmaPgRdJBZdJCqxctbG5
        CIOa3DP6nV20/KVSJVK0QjBxlEEnyElqsSBUSzs=
X-Google-Smtp-Source: AJdET5dYHcY1qgakC4W1J3qNGIolP8ar+bCLiKNCQr9U9SnOFgdfOmPiGCxZlxvUHDNFw0XdYvnJaNKOrzl7QCLms+c=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr2696162itg.70.1541525299870;
 Tue, 06 Nov 2018 09:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20181106104811.14625-1-leif.lindholm@linaro.org>
 <CACsJy8AjY1-KT9x_CXuo+L3-g947OaC5Av0KwuJF-Xkz6VMiPQ@mail.gmail.com>
 <20181106163118.wkvcjvb7uxjvnryk@bivouac.eciton.net> <CACsJy8BGMDqiekYLdStfyxNBsW88HKv9Z_KwKjjGrEQuucnDPw@mail.gmail.com>
 <20181106172505.nw2ugm4yb3gmrnk3@bivouac.eciton.net>
In-Reply-To: <20181106172505.nw2ugm4yb3gmrnk3@bivouac.eciton.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Nov 2018 18:27:53 +0100
Message-ID: <CACsJy8C1bcsd88vHM5WFHAAHd0=+OLp32QnSfA2WB5Hfqm=OMA@mail.gmail.com>
Subject: Re: [PATCH] format-patch: respect --stat when explicitly specified
To:     Leif Lindholm <leif.lindholm@linaro.org>
Cc:     Git Mailing List <git@vger.kernel.org>, lersek@redhat.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 6:25 PM Leif Lindholm <leif.lindholm@linaro.org> wrote:
> > > Sure. Only today was the first time I had a look at the git sources,
> > > so some guidance would be most appreciated.
> >
> > No problem (and if you don't have time to do it, just say the word and
> > I will continue; this is my bug after all)
>
> Weeeell, if you're offering, I would certainly appreciate not having
> to dig deeper into this. I've got a patch review backlog the length of
> my arm in another project...

Your loss. Your name is not going to be in git.git then (j/k). Thanks
for the report. I'll double, triple check, add tests and resubmit
soon.
-- 
Duy
