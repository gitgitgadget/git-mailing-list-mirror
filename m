Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5E81F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEGKxb (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:53:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34988 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfEGKxb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:53:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id d20so853278qto.2
        for <git@vger.kernel.org>; Tue, 07 May 2019 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Upcg/HwgdNsx3ZcFDIw0ehUfS+Fh4PimSWzSO9dGW4=;
        b=ix6L24B1t1EsfBtHHu2TPL9rQ9dhTF2FINhcAXldm6dgrmb/N3F2GAzKyoE4j1pp4c
         sF9h1z7Rf7wsfKy/le62A2ICmrp5N1a9I2DYFWc1XO+hO8PvyMi71i7KuvAgF/7aZp9p
         WDUglco9snRVRmSbsZiu9de2kFAzqkWFPWfYVuk5/320LuejuQJMmk09NQQqeXF0iovI
         GLFH6K4eMGnsoxQW5FZ0aroi2xi8O/T4tBdf3uyQjqKv0/SlMgyIFtl+YTzuof8Goi+d
         aaLW45cuFRmptUkEYUTFzfSRBirUvtO5ps49pH/ehy9M0c1au503nv6U7Ad6wLBN5svP
         gsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Upcg/HwgdNsx3ZcFDIw0ehUfS+Fh4PimSWzSO9dGW4=;
        b=E+gRLv31iH2qsN2X4ugtVRfio/f33+g9+VhkeyIG8s2awDjEcZykW6CVW92WOLkrEN
         KkpxkAflV2leNqQ7jJ4xRvIAkTc1CEQzHjHZ3YGUVs10ypr2bK8uhcPoaCoSRYUYMTAC
         ctQb4vF1zm4sDPl6RmP+Z8O//2HlvU2Iz2smO7cLZW22yi4ZGFzAmJ8lrZLtdhJbUno2
         rua3NIEB/w9l8mXbBCx8cl5eFUHrCqFPpKf1p9vHmA9cGzJyb8mk7bY1w6/9gRK/PFLC
         mZ6ectGU/4N+FqEeAyW2See5Bpsg15FGz6SemtaI+GqI8sEaTYGBAtgx5ubuI61rYmKu
         mXag==
X-Gm-Message-State: APjAAAXwDDWTfknBnpYWVBS5KkfYud2EytgmpGO5W9ZEfxZXCp1t8ZA2
        6m4j3Wl3ROjiZ/D8vefMBdyZag7pa3MAyV/YquE=
X-Google-Smtp-Source: APXvYqxI93O6+dJc0eqwhtWJcJb5hdhRi8aaTJN5gEojIHanitxi9XwXwPOus6uACwIOidqdb4ma+X3vTZo/Cofs8Q8=
X-Received: by 2002:ac8:3593:: with SMTP id k19mr9237631qtb.210.1557226410539;
 Tue, 07 May 2019 03:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3M-FZ7b3H7Z+Vr9Wbey5iYVoWiUBnDKVEenyAMrUXeNfL56w@mail.gmail.com>
 <xmqq4l6kvnuu.fsf@gitster-ct.c.googlers.com> <alpine.DEB.2.20.1905010900260.23829@perkele.intern.softwolves.pp.se>
 <xmqqtve6nbfv.fsf@gitster-ct.c.googlers.com> <alpine.DEB.2.20.1905070641380.1748@perkele.intern.softwolves.pp.se>
In-Reply-To: <alpine.DEB.2.20.1905070641380.1748@perkele.intern.softwolves.pp.se>
From:   Jeff Schwartz <jefftschwartz@gmail.com>
Date:   Tue, 7 May 2019 06:52:54 -0400
Message-ID: <CAL3M-FamUTpygCWfi_EK7k59TsaG7zo5qu-zQTeBQ3WwY1g+hA@mail.gmail.com>
Subject: Re: Request to add option to interactive rebase to preserve latest
 commit date
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, exactly. When squashing or fixup-ing commits via rebase I really
want "git log" to show the date and time of the rebase operation and
not the date and time of the commit I rebased onto, which could be
months or even years in the past. I once worked on a project where
part of the code-base hadn't been touched in over a year. After
performing a number of WIPs on it over a 4 month period I cleaned up
the final commit using interactive rebase, squashing all the WIPs into
a single commit whose message reflected the actual scope of the
changes that had been made. A naive project manager with limited
understanding of Git other than how to use 'git log' to oversee what
us developers have been up to time-wise was enraged that we had
committed changes months back and appeared to have done nothing since
then. I believe that by adding an option to
'rebase -i hash' that would apply the current date and time of the
operation would be an awesome addition to Git and its user base.

*Jeff*

On Tue, May 7, 2019 at 1:45 AM Peter Krefting <peter@softwolves.pp.se> wrote:
>
> Junio C Hamano:
>
> > as merely a different way to do the following:
> >
> >       $ git commit -m A
> >       $ edit
> >       $ edit further ;# working tree has an equivalent of C
> >       $ git commit --amend -a
>
> Indeed. My last command in the chain is usually
>
>    git commit --amend --date=now
>
> to set the commit date to now. In my use-case it is often a
> work-in-progress commit that I start out with, which I refine over a
> couple of hours/days/weeks to get working properly (depending on the
> complexity of the change), and when I am finally done, the proper
> dating of the change is "now", not "when I first started doing it".
>
> > I am still not convinced it is a good idea, but I can see how
> > another verb that behaves like existing "fixup" or "squash" but use
> > the authorship not from the updated but from the updating commit
> > might seem useful.
>
> I'd be happy with a parameter and/or configuration variable saying
> "amend and rebase uses last commit date".
>
> --
> \\// Peter - http://www.softwolves.pp.se/
