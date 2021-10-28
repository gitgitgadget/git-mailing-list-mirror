Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E131CC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB86B60F0F
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhJ1UgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJ1UgY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:36:24 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D27C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:33:57 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id t127so18336194ybf.13
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2EdjCsJ/fVGRsQpRFAK8jqs3MpPjmjuCHO/TxZcl68=;
        b=lztqru+2IliEx3/tas3Fe36G1F9ERxe5PlKC4+kuergT5p5RUt1lXwbnhGy1o7g4uo
         bNnHmUUpg33xpZq9F4SuuomH6nZQ2crfdh3vpQtyVBQTiTTnwVF6+ohsKgywRUVzxd9W
         qYzvq9C+SAmbM6XhPVWCV+fmM5E8DWoyMFSemI1vsnOBmBpmHzTue4Bp0lydgFQVMbWL
         mS5CzR3Olm/D8f8GxkeRjxfTe9T9wy6E7cmDonLBqlGWlYkClMP3/vDzB4PcrsphFk3B
         wGeVzKxrquOX7JpI5lMzHHvPFsw0qF5ARpAk10mA4ltGSyPw5hotPxM8fCcEcjzrSWi2
         VHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2EdjCsJ/fVGRsQpRFAK8jqs3MpPjmjuCHO/TxZcl68=;
        b=O3PnOizCg8lf/nkzJoge0GlnaewbIXYlcQQRNB8Eo797jASfw2IJZfpR0NXpL+emrU
         1nAL/6Gds4KKOcmzsNn8lL2QYVy35NpeN5vyuQRdk4yz6gncGU4Mu0usrQpeLSTB+NAg
         CDjfk4hl3IjTBzWlaisgUFBFftqGOefV7W5pVwkF89oB4I0w4x47XJrDe/IruJaEMpjx
         O/YqA0ZCYIr/hhdvxttLYK2wHc1qqedOir+StkM6iqEIGBcSK7w1ZBkp0ygmSWOBu4RU
         5xIsPJRnIvOdCZb/YkqmepTfFjW76RVz77w4PGogmg9GT4t22Zn04+OyF6qV7yfdTK2a
         jfSw==
X-Gm-Message-State: AOAM531ZlANWcl9dkUPoq7fvQflKXN9ORhxs4BpMThTUfO6gzWbyvWkx
        iimgq6OuOiLq200FMkKJtbDxHopCNFMIPYFeBMD6J2F4gq0=
X-Google-Smtp-Source: ABdhPJz8eF0CI9DSCKuCrqEsBI+nPt8doIb15FDyow0b0baWlybOmDCMcwgYjTlB/0Jl9aDRNB2ZEykJ502jilFuLiE=
X-Received: by 2002:a25:bed1:: with SMTP id k17mr6956767ybm.215.1635453236637;
 Thu, 28 Oct 2021 13:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyLXMBWyfcBVFDRbYJMk+-RjjNBQDvoDeaBtEPiXpUDDTqfOA@mail.gmail.com>
 <xmqq5ytgrkku.fsf@gitster.g>
In-Reply-To: <xmqq5ytgrkku.fsf@gitster.g>
From:   Nicholas Bransby-Williams <nbransby@gmail.com>
Date:   Thu, 28 Oct 2021 21:33:45 +0100
Message-ID: <CAGyLXMA93qQw_h97bMd14O26hSxn4xn+AzemVyrf6pn53qO3UQ@mail.gmail.com>
Subject: Re: conflict markers in markdown files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I guess using such a long marker makes it less likely but there no
reason you wouldn't have a 32 character long title in markdown

Example.... :)

An important heading in markdown
================================


On Thu, 28 Oct 2021 at 20:55, Junio C Hamano <gitster@pobox.com> wrote:
>
> Nicholas Bransby-Williams <nbransby@gmail.com> writes:
>
> > Would it make sense to add an option to merge-file so merge tools can
> > specify a custom marker that is statistically much less likely to
> > clash with the kinds of text files that are typically stored in git
> > repositories?
>
> Is the conflict-marker-size attribute sufficient?  If not, why?
>
> In our documentation, we do need to have literal runs of '<<<',
> '===', etc. to illustrate and describe the conflict markers, so we
> have these in .gitattributes at the top-level:
>
>     /Documentation/git-merge.txt conflict-marker-size=32
>     /Documentation/gitk.txt conflict-marker-size=32
>     /Documentation/user-manual.txt conflict-marker-size=32
>
> so that the auto-inserted conflict markers will be very long,
> instead of just the default (was it 7?  I do not remember offhand
> because I do not have to).  Most importantly, these "32" are written
> by folks who wrote these documentation pages and *knew* that there
> is no runs of '<', '=', '|' or '>' that are 32 letters long, so it
> is safe and can be updated to stay safe when the documentation files
> change.
