Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466641F453
	for <e@80x24.org>; Tue,  5 Feb 2019 02:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfBECBU (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 21:01:20 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36841 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfBECBU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 21:01:20 -0500
Received: by mail-yb1-f195.google.com with SMTP id 64so437336ybf.3
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 18:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XjLHcBrAu0dbmSqhPFD+vvbbcfBZxbSdYWCVxYrKV7Q=;
        b=LBIkOWmZDfAtXuOVvgWfKpH4BLXTY0De2R3BxNe6D4vrK7QEFcy6wpNM5SiVrHQGQH
         u1usB4U5NwqtnLztrwPiT08fI85KWEgWu66d1h+EYfhlpBsi/C38TceWu8+ysFwptP7g
         T2BBqdRX/nwYOUc/Dw8NXCfjgOv8O0W996i1w2+ZV0kHJoJ67ETBeKXkOVBsoKhbUC1G
         DpCDV2+VkQxNs/yIBjI7g4tIWahHfTU3upZc1aazXoSL0uaiFbZ/P+JTmTEyAkrbxM6L
         Hemn3/2KesSDLUgU6Lfe3V4M4eZXwkNBGcKzgmnwTHBUJtkxzdXnt0LL+nz5ouVc4RMP
         aOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XjLHcBrAu0dbmSqhPFD+vvbbcfBZxbSdYWCVxYrKV7Q=;
        b=F7aFDVxrPQyMR1hxI8C9nZKnHZPDf4CIQfPDCfNJ2avp6EQ4hgCUaV5dfTKDDzyPpH
         PU1UTgHMpS2NG8XRvkXN1zf1JqCcgQM74FtZW29WyU9Rto7sLNi2DHv3Rk9S6Q1DdQhG
         oTojz3fiP/rBDHVacRmGWtbVPN4LNmSh5trMmItiDFzsDxr53gUeRhzbirVKHjowyPIq
         SkX38OIRTqNLGRmcOmK79+7mXxeGWFoaWK5Dy40HkvyufIo3nNOpFf+l8KdH4SUxP2eG
         kFIhwF7fDXwBMx6pg/6DOXKi1FHfXW/pxoBVZ1SW1TMfeEyX0+tgYvtAycbKBEN7tdjp
         0LaQ==
X-Gm-Message-State: AHQUAuad5CZC/Rve8lN+W/If6PcxL2MGX/lpODLkho4hVy3aIuu3e0pj
        3vtVk6+/KKJpqQEV5hknF91WRd+EHPUl1w9o9tMS
X-Google-Smtp-Source: AHgI3IbU2o/eFTfUjPtwqX5kPvfGKTYNYEcEBtDbgCcjif7Pfor291EVayjYlg13SDcsP14SZHm4ji7Nw/ilTrHDJ5c=
X-Received: by 2002:a25:d8c2:: with SMTP id p185mr1951100ybg.79.1549332079050;
 Mon, 04 Feb 2019 18:01:19 -0800 (PST)
MIME-Version: 1.0
References: <CACwCsY5xU0pUaPZDJMqWNB0dz7DjTx3_b2Lvrft0NjA6cnPvcg@mail.gmail.com>
 <20190205015506.GB527887@genre.crustytoothpaste.net>
In-Reply-To: <20190205015506.GB527887@genre.crustytoothpaste.net>
From:   Larry Martell <larry.martell@gmail.com>
Date:   Mon, 4 Feb 2019 21:00:42 -0500
Message-ID: <CACwCsY4fwr6=2S5CHe5bH7=7Hukq9np+eT1VO+kUDyBtMLKPcA@mail.gmail.com>
Subject: Re: hook to get info on commit, and include that in a file that is
 part of the commit
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Larry Martell <larry.martell@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 4, 2019 at 8:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Mon, Feb 04, 2019 at 08:36:10PM -0500, Larry Martell wrote:
> > Is there any way using a git hook to get info on the commit (id,
> > message), put that in a file, and include that file in the commit?
> >
> > If I try that in a pre-commit hook I do not get the info on the
> > current commit. I tried it in pre-receive but it does not seem to get
> > executed at all.
>
> You cannot include a file in the commit with that commit's ID.
>
> The object ID of a commit is based on the data it contains, which is in
> turn based on the data in its top-level tree, which is in turn based on
> the data in all of its trees and blobs. If you add or change a file in a
> commit (or the message of that commit), you necessarily result in that
> commit having a different object ID. This is by design and is valuable
> for checking the integrity of the history.
>
> Furthermore, the hooks for a commit are designed for checking and
> notification, not for editing the commit, with the exception of the
> commit message hooks, which are designed only for editing the commit
> message, not the contents.
>
> The pre-receive hook runs on the server side, so if you aren't running
> it there, then it won't get called at all.

Thanks for the reply. Any suggestions on how to achieve what I want to do?

The use case is that we want to have a file that is part of the
install that has certain info (commit id, date of commit, commit
message, etc.). and we'd like that to be generated automatically.
