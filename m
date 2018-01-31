Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754CC1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 22:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbeAaWGi (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 17:06:38 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:41014 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeAaWGh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 17:06:37 -0500
Received: by mail-vk0-f48.google.com with SMTP id g186so10035292vkd.8
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 14:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=21Au9QHk3Zr2xukrTBPM0Lph/26BiBvAAx8IP382RfY=;
        b=ZHoTm6bJSOJjdj5ukUAtLd1V/1Y30rwLRdsCf0UIVyYm8ZWKTl4Nv1w/ISZQEPLBCE
         rUT8rMKHJUGPluvLkr7Af1D/G4IIisxPpOID8s5q9aQu3vo2KZ2uhWgRyX8puDy+VRi4
         8845HLwJWamklks8x+0XApk78O0QWTP/53jeFH7MB8a/aszIL9aXPvMrfRyjJvfCjldP
         HTafmSxx/MYFg8pg39xPr+/sNCoBD33MsAthWbHNUhXyXL49YFjGI2KmZPlA+U4DTOCz
         G/Ha+5uw5XoR6+iq3oZozR7g3nsx7ooCVlsbi2QimvXtOiRXB5NkDXdB3KXHjV3/MBBR
         t9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=21Au9QHk3Zr2xukrTBPM0Lph/26BiBvAAx8IP382RfY=;
        b=EoZVSJx383MVFEcAb7uy+s9fIsdlRjhNx57SlMXtoI5kjUiTYoN2WfWwKzc2OxyqyR
         EAYQjTmYBhd9EgbUJAQHoTuns2SusXfBgWpQLuk+opP7VyHgCBiMV8dAO8MuOGyYNyCH
         0COFYBL/ffihL2H1PfsBjlm7bsMDGkSiIrslo75CpGOj6P0H/sz0HEYY0fWDsoVkQgwk
         iNGVBvYF0RWDSA8qujWmptptxq9gAnXnihL0EUNFSd+MaGDrAvORaVbxslRUIpnusUmr
         grBrfY67K7Ln+b+x0hkqs0h27DKZRe2B6FSaG4xBYMnz1JBm1icQUC2r4YgY6iEVZXh0
         L2zQ==
X-Gm-Message-State: AKwxytcOM1i5hyFd1W7xqpx2/QYtbf+4GKbqPge8Ud50lvd0ZatHN9FQ
        4KF61+HyP8ujMuzcpnLekd+Wg7UiEiSokxrKr+g9dA==
X-Google-Smtp-Source: AH8x226ww3h6FnAR0sa6ZCqw0PuRZM+nyirwB5+mhczX7EInU0AS5Nxp4Wp6lr1ZjCBdcp/B0PKb2to9b1NBUGcO8EY=
X-Received: by 10.31.229.71 with SMTP id c68mr27294830vkh.68.1517436396704;
 Wed, 31 Jan 2018 14:06:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.8.83 with HTTP; Wed, 31 Jan 2018 14:06:35 -0800 (PST)
In-Reply-To: <CAHZoaj41k0AU-S1cPH3p6gU6EzXfYiMasN7=Cv9SRd2xp=1ThA@mail.gmail.com>
References: <CAHZoaj41k0AU-S1cPH3p6gU6EzXfYiMasN7=Cv9SRd2xp=1ThA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Jan 2018 14:06:35 -0800
Message-ID: <CABPp-BErnsyzUbu5dAFCs=Z5m3Z0k8vNkMJQ9=Tc=wWqPDYNFQ@mail.gmail.com>
Subject: Re: Segmentation fault in git cherry-pick
To:     Ayke van Laethem <aykevanlaethem@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 1:43 PM, Ayke van Laethem
<aykevanlaethem@gmail.com> wrote:
> Hi all,
>
> I've found a segmentation fault in git.
>
> Here, fabsf is a branch that I'm trying to get the topmost commit from.
> After the failed cherry-pick, the change is added to the local working
> tree, but the commit isn't applied and .git/index.lock still exists.
>
> Version: 2.11.0 (Debian stretch)
>
> ~/src/micropython/ports/nrf$ valgrind git cherry-pick fabsf
> ==23286== Memcheck, a memory error detector
> ==23286== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
> ==23286== Using Valgrind-3.12.0.SVN and LibVEX; rerun with -h for copyright info
> ==23286== Command: git cherry-pick fabsf
> ==23286==
> ==23286== Invalid read of size 4
> ==23286==    at 0x21A348: add_index_entry_with_check (read-cache.c:1012)
> ==23286==    by 0x21A348: add_index_entry (read-cache.c:1061)
> ==23286==    by 0x1FAE85: merge_content (merge-recursive.c:1727)

This looks like the stack trace in
https://github.com/git-for-windows/git/issues/952, which was fixed by
Johannes Schindelin in commit
55e9f0e5c ("merge-recursive: handle NULL in add_cacheinfo()
correctly", 2016-11-26).  Could you retry with a newer version of git?

Elijah
