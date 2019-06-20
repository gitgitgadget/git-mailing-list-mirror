Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 586001F462
	for <e@80x24.org>; Thu, 20 Jun 2019 14:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfFTOIN (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 10:08:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33789 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFTOIN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 10:08:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so4963664edq.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTqbRw7qgvuIIvx56zDGjCQzue6uyJnP3wK5ClSu5+Y=;
        b=V+eQO65bki6fdRObu5ukxcIaHZqlqMtLYW/TpLduaivqFzazUcuZr65N2FlKVRZ9We
         ZSQ+rt7wDs+BxU0wvZqMfvrMeRLDI0oPd4DP5mIQfrwrjLAOp0oekSwbWCey70Up4bVI
         jEtLgpIjmhx2nsuiXnaxWX39z77SOI/jl7au9+YpGdWgSlXypmZrnnoWAAXvXDVwr41f
         vGmPA3P+STKV4uCQSTo6wW9CVPUlROkNvYicM/A48bULJ05eMzoQbDlQVDy0I3V7liXb
         FvUGGuy0j5keDLDJICiwUrP8PRQQpTdaSvexxQ+PejfWz/Ea00aiB1MtgYcoSDBlq5NS
         5zAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTqbRw7qgvuIIvx56zDGjCQzue6uyJnP3wK5ClSu5+Y=;
        b=U48E/2rwKvsarVJcOnlZBHb+9HgM52y/J+xxRmVBndMbmtj3xpQhbzPzkJ+HgSi9Nu
         BvYlPu9T27ItbiUW7lzEXt6M8uTO/AlMZkJjLgUfm+FDOpXLVvltRsV52S0BQhD6UDeK
         XwIq3uC8i1hSwA+IOCLzA9g0IX5L8l6bG5ElpvxPF5fGAmOI/yOwDIO2Sez2nlBeEirM
         5uSEwPhvdlwPcKzT4Jf6LnMxHAzMiPxeVNtJcsUV58xlYkzbXGAhTpgmZUNBKCocMJwC
         +y7mz94xNCGInmhkvyQxpHbr5yYry8A8xQJs70lBsfPKO4u0hyGpVTHDLFmY67YGOcZa
         p46A==
X-Gm-Message-State: APjAAAU+HY1/iCZQAvl31bDK9CH0EY3jsP7eDrKqBIdzbOzI9X9bCli3
        j6BWd075TmlgfbNdceZNm+EKGCY51vxJZ3aeaZk=
X-Google-Smtp-Source: APXvYqz8ZgBqwzF9HVWJ9YKrtGwUHLIlYD00AeYjeHEwd/5f62+nIigQMX4TiqGPMFnYz8DvpFldW2Nd1+6x+22+Fwk=
X-Received: by 2002:a50:886a:: with SMTP id c39mr94473786edc.214.1561039691606;
 Thu, 20 Jun 2019 07:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190620083026.14524-1-chriscool@tuxfamily.org>
 <20190620083026.14524-3-chriscool@tuxfamily.org> <20190620085009.GC3952@sigill.intra.peff.net>
 <d88ac28b-638b-89c0-2bfb-634a0bb6ca4c@gmail.com>
In-Reply-To: <d88ac28b-638b-89c0-2bfb-634a0bb6ca4c@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 20 Jun 2019 16:08:00 +0200
Message-ID: <CAP8UFD1-=+32G2XYXARcXm8=hnqZwxa1Ev9nmaS=qfqKS7GSWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sha1-file: use OBJECT_INFO_NO_FETCH_IF_MISSING
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 2:39 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/20/2019 4:50 AM, Jeff King wrote:
> > On Thu, Jun 20, 2019 at 10:30:26AM +0200, Christian Couder wrote:
> >
> >> Currently the OBJECT_INFO_FOR_PREFETCH flag is used to check
> >> if we should fetch objects from promisor remotes when we
> >> haven't found them elsewhere.
> >>
> >> Now that OBJECT_INFO_NO_FETCH_IF_MISSING exists, let's use
> >> it instead to be more correct in case this new flag is ever
> >> used without OBJECT_INFO_QUICK.
> >
> > I said earlier that this one would need to be tweaked for the new
> > upstream name. But actually, I think it is not necessary after Stolee's
> > patch.
>
> Yes, I believe that 31f5256c82  does an equivalent thing to the
> combination of these patches.

Yeah, I agree. Thanks Stolee for having already fixed that, and sorry
for bothering everyone with this.

Christian.
