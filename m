Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167001F404
	for <e@80x24.org>; Sun, 25 Mar 2018 18:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753830AbeCYSHy (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 14:07:54 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:56134 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeCYSHy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 14:07:54 -0400
Received: by mail-wm0-f42.google.com with SMTP id t7so11485724wmh.5
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3vadwgEjQXt7irjNhSDg7mbqLGhmV8ifInGkA3o6zH0=;
        b=IMJYGS1dhrNiCGzxrviLnkJ6OUx9jSEtDhKyvl30rPPfgxRD/KOK/Nog3YeICCpNEq
         9icYAeJymcYv14aZdb06NOwjwCL9UkNU15oyC/bB0mPG+gDsYFXbMU+lChobTAmCXT7N
         +6VZRR1e3VnGogn9/jMLWHQBgex6a0DhYzZokxzkXsj6XD7EoFx4SsdrNl/s55GRi5Gi
         AZS0Jr22X+MuIm2F9448QLoxV2uqwdy3PVeSPiqTR6U6Skx80xzEDgv3jQ3e9HakQzuT
         s6CRUIMQTRLNZ+bQlGkC9gPTmSnFH885hvYXLmhxO7IhT17LJh9YznLbOWiD+EI6CL4B
         Yjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3vadwgEjQXt7irjNhSDg7mbqLGhmV8ifInGkA3o6zH0=;
        b=ICYEZ0lBrYZiJbmrdeb3FCDblTbTijLozn3jlzpJg4TCEVSESSFKuiEst7j0Ogc4Pv
         4XiOKv1537M+xB4Up9FQWfcclFaDNX7dcs43KSOy5Td1tZ9oCbKKnig33/05b1SxpxUn
         0LsQJAXKsgjKi6SnaanqUZLwZCE9g7TCye00K4aicx/ZFmgJe/bF/yDRn8LUWNhD2ej+
         LE174aa2IdtYNWInLT0JJMg0JhbEMiTmMA5eC517u89ZytE5OrLPeMBe9OoluOwAt5LQ
         EHGBfYumhJYWosvY6Vd+B4ucATjJV/2bfoh6KXQQl5DTixT2WQwi+wcyuLYSd2cHu8C9
         zDWg==
X-Gm-Message-State: AElRT7GTAamIoKiIvUVIY8fAwGiIEh+nfE62+0LMGH1Bd7Yeh/FuqHA6
        vsebdClgpdJpJvadJ7G2dss1fFaxmW58c755MZU=
X-Google-Smtp-Source: AG47ELtecbyMZ03TGypmDP2odOzYIv7HhzKj1zY8Sv0tdqWHp9WfHUNv/AMlQvmjFRCYqfVkYjT18NJBH9/tL+ilW/s=
X-Received: by 10.80.149.68 with SMTP id v4mr37620881eda.236.1522001272660;
 Sun, 25 Mar 2018 11:07:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.203.135 with HTTP; Sun, 25 Mar 2018 11:07:32 -0700 (PDT)
In-Reply-To: <CAKk8isqvfhiMPCdNBW5WNN4BfN1sLszekQscpy5M2Okh2YmbZg@mail.gmail.com>
References: <CAKk8isqvfhiMPCdNBW5WNN4BfN1sLszekQscpy5M2Okh2YmbZg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 25 Mar 2018 11:07:32 -0700
Message-ID: <CA+P7+xqqLU-J5hv=yioMxMvp40hz_S9GfimjE7bp1Pj_TP-k3w@mail.gmail.com>
Subject: Re: Should I try to fix rebase interactive preserve-merges bug
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 10:32 AM, Wink Saville <wink@saville.com> wrote:
> There is a "TODO known breakage" in t3404-rebase-interactve.sh:
>
>    not ok 24 - exchange two commits with -p # TODO known breakage
>
> I'm contemplating trying to fix it. But with --recreate-merges coming
> maybe it's not worth the effort. Should I proceed with attempting a
> fix or is --preserve-merges going to be a synonym for
> --recreate-merges?
>
> -- Wink

AFAIK this breakage of preserve-merges is a design flaw which isn't
really fixable, which is why --recreate-merges is being added.

I believe the plan is to deprecate preserve-merges once
recreate-merges has landed.

Thanks,
Jake
