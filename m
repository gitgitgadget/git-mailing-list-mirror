Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758C4207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 06:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbcJDGKI (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 02:10:08 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35696 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbcJDGKH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 02:10:07 -0400
Received: by mail-yb0-f193.google.com with SMTP id y19so2002005ybi.2
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 23:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wE3idPLoUKKUJhVXMEjp8x5QIsSEBdSaHRs6KgVu4yo=;
        b=wd01xYu1fjSmteEWMm6iUXPjgxcAjVNTJ253CccsTrAJqPCrMAxeA6uMyS0/gBFODg
         XGFNezP+6O+vHmWVZdNn8w1q/SgnlZFJdCcl9QDyj0vGbtFBZdcHTNp5K03lcaXo/zUp
         7IuLHWwn4ICH7f4nAauyxj5uBS8mkPtd+mDzIslk1ivXL00q8eculH46f8Xzli6lBA5p
         4Q8IJsw9A2ihKoLo4J3U14jqxO9g3AYWTd1qxJzdIEa5O3bvW2Zdowbo0z61/TtUoii+
         f7q8VcIN9GMuzmfpW3G7VgQgPXscH6wxlw8ssK7n4d673jv3VRW2idIF7V3dz+CTqUaH
         TZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wE3idPLoUKKUJhVXMEjp8x5QIsSEBdSaHRs6KgVu4yo=;
        b=NpYuYFKjF7bs+GHVW4THk9L2/HNz7XAqGS8UCiIWIKf0N2bsBhqS2aFolhYSP+ND45
         t0Pc2xEanu2ZYj06kdVJIgeu9T6NNksb9w2dyz37241JQAGwves8vdy5gzAThYjQTwcM
         vMjMg+GJpWaaMEcMWJgERnYqyw4W0Qpwi/aBGkhugMIAlkp91SPGrDIoTrHEJvketmST
         svhc1XTE+uxvOAz8jctY8p88c6SQhHnHfRfBJbczVuFCu/Hu6t4HyKvcVLmDfjtX6kEq
         yHfMmczakzm76S5/Z5niBJDQ5OBFmRGPa0LvlTI34vrnfqGAFc+tYwnBW3qlXt2pOjo9
         dcKQ==
X-Gm-Message-State: AA6/9RkuCAI+4FA9mQ9YDZT3dsxBPGT+4/afQYdaNUsBzDyL19tQzadsN/hNKKRgM8x8cAGDUYM4/XipThwmKA==
X-Received: by 10.37.163.104 with SMTP id d95mr1389626ybi.132.1475561407207;
 Mon, 03 Oct 2016 23:10:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 23:09:46 -0700 (PDT)
In-Reply-To: <20161003203531.bppczvzmdfumtnb2@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203531.bppczvzmdfumtnb2@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 23:09:46 -0700
Message-ID: <CA+P7+xpgNo1d_6h6XZneEei6zbV02GcC8o+e+51wpnAeenJz=g@mail.gmail.com>
Subject: Re: [PATCH 10/18] alternates: provide helper for allocating alternate
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:35 PM, Jeff King <peff@peff.net> wrote:
> Allocating a struct alternate_object_database is tricky, as
> we must over-allocate the buffer to provide scratch space,
> and then put in particular '/' and NUL markers.
>
> Let's encapsulate this in a function so that the complexity
> doesn't leak into callers (and so that we can modify it
> later).

The overall way this was broken up is definitely a lot of patches to
follow but understanding the end goal this is a huge improvement in
code maintainability here. This original allocation is indeed very
tricky.

Thanks,
Jake
