Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ADD31F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 04:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbdBCEsA (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 23:48:00 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33946 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbdBCEr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 23:47:59 -0500
Received: by mail-qt0-f177.google.com with SMTP id w20so16391260qtb.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 20:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JXfzoHN1PxqPnLAd2dxFtnfGCh8bKcbJIGSKqKyKQNM=;
        b=q1PYc0nYcWTo4KHuoi0wCYn6hFEwn4SEHv1b+QsC5e1hoCLE9/CY/YZU0Hs+uus7Qu
         TZuU9bi5ww8GZDvs7Jzo18XcD6Vp/8IReSlv53k0lmTqgYNRGnWDaHtY08RpuoTicBZ8
         9yEk8Bp9AacCLLZv99yQqL7TyLNA8DW3vC2uAV+c2OEALn4loAmxa5fFge5Aj7UVB3nT
         YOyV62lTbccIgAzbCLbZ2t1AzICtDg89fDc5Y4gdTyFF8kn630FStYJ2Yayf5OAH5PCF
         IF1YgDxg60AmF41BLoDJ49KnrOfplF9qJn8Y2aS7B9+oJ1QQ8SctECPg9lsa3UpD56oo
         SWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JXfzoHN1PxqPnLAd2dxFtnfGCh8bKcbJIGSKqKyKQNM=;
        b=BKL9rGjEce478+4xnbV/olscFLXcRMYdRhL2rGGWSun3LYrtpU2ZsBRWbvZ9Q5pgWE
         XleITAz0JC8esA+4+H7ojL1nCtMJwtHVtazV8vjf2GZlDsMZSkQgqNe2wNV0YSEW+ETA
         7Dhsjs65slzLCQ65ObIqfFYjUDlNHA7ebmSqzO17I1yUe97TTGWyz+0z94lak7JuXL2H
         /uCgsM54mUcso5Rqg8C9ZHfix8JArRYSHojXZN9lJurh+kRx2t91JukjtLlYpBu+AG/F
         F5s8ayd63jcrbPymjuHM6NUkB32JS7ZOFEsvH8oFbFVlJfbwEgEGvlr8wxND7i5N0W0j
         YyVg==
X-Gm-Message-State: AIkVDXJJXK46/pKwXCdgBihLi8D2CyJjrMEbR2rsZOmQwqefz3ArD/sEGvcAwuH9kCDQD2LMinrdzF7oZJ0uTQ==
X-Received: by 10.55.10.131 with SMTP id 125mr12646440qkk.257.1486097278758;
 Thu, 02 Feb 2017 20:47:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.226 with HTTP; Thu, 2 Feb 2017 20:47:58 -0800 (PST)
In-Reply-To: <CAOc6etabV=h6fEVee=N2-3ERUU7_w6eCM006mSMPqiwkRycQBw@mail.gmail.com>
References: <CAOc6etaCk=OEyarMNhorM94MBnYRscCkJBM-K08snv1ecmOaPQ@mail.gmail.com>
 <20170128035321.yrcqwkg2fiwadxj4@sigill.intra.peff.net> <xmqqd1f4uug6.fsf@gitster.mtv.corp.google.com>
 <20170130232559.krdxkt4dq4lfv4rj@sigill.intra.peff.net> <CAOc6etZZSgeBRwQA4C4Ag5A48W8tAAArdOaaKxkTOVvVGi+EpQ@mail.gmail.com>
 <CAOc6etYzAeD32oSjrvmv-PBJTdAGobsQ30iH8Q+Z9ShWOqiHfQ@mail.gmail.com> <CAOc6etabV=h6fEVee=N2-3ERUU7_w6eCM006mSMPqiwkRycQBw@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Thu, 2 Feb 2017 22:47:58 -0600
Message-ID: <CAOc6etZhQUdM9+6xty=G04t9dSXXP1BL3Ffa-a68XFbgCVOgtw@mail.gmail.com>
Subject: Re: difflame
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 10:46 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> I have been "scripting around git blame --reverse" for some days now.
> Mind taking a look? I've been working on blame-deletions for this.

blame-deletions branch, that is

Sorry for the previous top-posting.
