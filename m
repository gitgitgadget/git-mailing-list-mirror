Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9E31F6C1
	for <e@80x24.org>; Thu, 25 Aug 2016 05:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757582AbcHYF4o (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 01:56:44 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34688 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757548AbcHYF4n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 01:56:43 -0400
Received: by mail-qt0-f173.google.com with SMTP id u25so18204671qtb.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 22:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FPRgPiMEnUqVZJrgDCDLjJOkOBjH/+bneE9XJuX41og=;
        b=KLUzmFzslWcWv9M0uQVSu392Ah9DQpTGR8L3qoJSVmmpaGh2jsYYVda1WBm2UBkZzK
         wVDx3XqK6wP9YyBydr6hGTsQ6WHN7TswSlrKAi5qTIaYetuM32X0ax+aUX0QpmDoO4zd
         98NPZ3xTpm60LFG0iafyMbdz+YzoKt+iNl9ophg3bcLxGxHh2VyrUL3VZTvxuqBaBxaV
         WFjiaqU7BmJpOCrHkPNX99B/oTbkHQlyviYePwCsiFp3KaR19LwVN/rHOSbt5WRslmy5
         +8xzl2e9dvZOgQWGT1G6a7TCH36zi2i8T5GaLXFicIpPZkciEObu3NYnmj/5Mw1ziT/o
         BrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FPRgPiMEnUqVZJrgDCDLjJOkOBjH/+bneE9XJuX41og=;
        b=AHkhFV3+GdPj9+32/wlpt2eyKkb1vV6qrepwbpJVQhKk0bVaJZ/Vo+ZUSj0TXjhPaY
         CTOIFKWdojt4rb69TDKbB0DFpK36k+jqDJFEli4d47uV2aqzIBsBghUgnTl4hKqEswdg
         8ARJBB2TxQMPHpaGmOsq/MGSTF0UKtnPVAmEWxi3YPxmBfG7eTl5Xj0721jLeRKfgFp5
         2o/kW7oZqXVI2Hi25kKAMXYTEsITu10Cqml3IrOqCtpu7VOVf5lyV9vFl8fIKYTNJf1S
         ybcoc5fy0YSXZFgPs4Y4zBDAyXhxJUoCHD6hqBtdmRSlevVdn0iC90tyEAZgdna7waHF
         npbA==
X-Gm-Message-State: AE9vXwPfsvgah/E7Uo3qEjYe722yufX60WZCmRF5Zhu7TC9+8R6vzzSZ4Hvdbv9Nf1dGYScUOzQQP4SNun6QGQ==
X-Received: by 10.237.38.35 with SMTP id z32mr8219540qtc.69.1472104602731;
 Wed, 24 Aug 2016 22:56:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.42.82 with HTTP; Wed, 24 Aug 2016 22:56:12 -0700 (PDT)
In-Reply-To: <20160824183358.ahxcgcrg7jo2rygp@sigill.intra.peff.net>
References: <20160822173528.755-1-oystwa@gmail.com> <20160824180730.mqlvhkthg4imd2vy@sigill.intra.peff.net>
 <CAFaJEqvm9Xj34t+F=KMtwRDEYhwHZ7=MRwsZ22-Gt_UPd4r72A@mail.gmail.com> <20160824183358.ahxcgcrg7jo2rygp@sigill.intra.peff.net>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Thu, 25 Aug 2016 11:26:12 +0530
Message-ID: <CAOLa=ZSVgm_J9n9wBp_cPWF4kWtvq_8DMLWGoYTSVetOpEJnAQ@mail.gmail.com>
Subject: Re: [PATCH v2] for-each-ref: add %(upstream:gone) to mark missing refs
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 12:03 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 24, 2016 at 08:26:26PM +0200, =C3=98ystein Walle wrote:
>
>> In the mean time, however, I have discovered that this conflicts with
>> kn/ref-filter-branch-list in pu. In that topic this specific feature is
>> implemented as well. They incorporate it into %(upstream:track) instead
>> of having a separate "sub-atom" (what's the correct nomenclature, by the
>> way?) more in line with with branch -vv and your idea.
>

I'm thinking more on the lines of `%(upstream)` being an atom and the
`:track` being
an option under that atom. I like sub-atom though ;)

> Ah, right. I was feeling like this was all vaguely familiar. I think it
> would be better to push forward kn/ref-filter-branch-list. According to
> the last "what's cooking", I think that topic is waiting on more review.
> If you're willing and able to do so, that would be a big help.
>

It's been waiting for review for a _long_ time now.

--=20
Regards,
Karthik Nayak
