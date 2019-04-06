Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 483C420248
	for <e@80x24.org>; Sat,  6 Apr 2019 13:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDFNaj (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 09:30:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36729 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfDFNai (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 09:30:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id l203so7112792oia.3
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 06:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twbZ/41mDUWkJW9BJwvwMZwuP6lmkC9wdX3JNGPkyQg=;
        b=BbIPtXic7ktPXtUaDowlJIXsEjFFP3qq332b3+7KRaccq6rXnHbjlgzA+lACicyvpR
         ml/YXUv/SgP8ngG1/rHdp6R7yr5ksC8GarOVUgFnSd9KOnA4iZY+grwLdtQoKFXRRseo
         nDJtJFFLQeFo5sb7ySwnJXaxKuoDISqQOBRablAbhUbWfh97WnVycPphrSmAL888lvgM
         Z9NvODrCVZJ2B7CMHEcMZ3MRfxrySx0TIeD4YIMWquCSji5r7u184u4e5NKpbK2QmtdA
         ydHdg3V71GXnpx9S63qsl0nL//TGL1gY9KjtXEp2UAaeRGvFDoSHnv33tahSh8TWawJ9
         598g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twbZ/41mDUWkJW9BJwvwMZwuP6lmkC9wdX3JNGPkyQg=;
        b=YQvGM6a3tErsjLGrWVdIIg/1AYVbKy5yyl4mfi9Ifx2wpOmseWuDC0saZVDdmZDUq5
         hpOrem8O+p4kr6BdncZIKHSPo2IG8vmIvGugAldPSIpYo9LgONUsgRrqP2Z/M+colzlR
         9USb9FP9GWsfyRj7LGQa2nqp6nKwaLDHO4hW68l+dpz+fltJaMZHwPwh1SnQFdc1JLwE
         6j8SSrfzAy788v/ZzhCzYy9v2IKEaG3j1YlEL/7Q83GrlN2g3Whq3mSOc/3I8pA9de8H
         UXgkg/WkBCjcPJ//s/xyMHLHLhPNSywKKXRQAtLAZasIKqYj8CQu+l/hZpUIy1slfMCB
         SNXQ==
X-Gm-Message-State: APjAAAW3SsJI/QSEXN4cVQKPstDTkJeJyyVN5rFeIOBW2O65RhI9XUQI
        0z04tHiMi+YMOIlsTnnH6exEF9/Za22vdGS0gx4=
X-Google-Smtp-Source: APXvYqzfx5zVen6x+n25oCWILDFTPqb/f3CMn8X4I+zCQCiLezPSDLewqWAorOBma0Ev8EWIxM+CdnUWTcMQ90zmL00=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr4541132oif.38.1554557438022;
 Sat, 06 Apr 2019 06:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPS68VEkUbNxeKQvVDGjzVpBXKNAi3uA04pLwN9k4ZTfA@mail.gmail.com>
 <CACsJy8AnXawOgC0eWKpSF7iGXAvPdP9=SZX1HePRABVdkiKs8g@mail.gmail.com>
 <CAMknYENJogZ6vxs3zxivD3TPtDnfE9DFQDTwri+eLJmTwr4zxw@mail.gmail.com> <CACsJy8DNb+Xu_bLAGw3WHECygxMLQHkaqGhJ89SY_yGF+c20bw@mail.gmail.com>
In-Reply-To: <CACsJy8DNb+Xu_bLAGw3WHECygxMLQHkaqGhJ89SY_yGF+c20bw@mail.gmail.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Sat, 6 Apr 2019 19:00:26 +0530
Message-ID: <CAMknYEMVdH9f-sxyRkfL8OtFjC993ooAf_8z0SGA07+86NB66g@mail.gmail.com>
Subject: Re: [RFC] TODO in read-cache.c
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 6, 2019 at 5:49 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sat, Apr 6, 2019 at 7:14 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
> > > In some cases, it will be simple. For example, if you have a look at
> > > repo_read_index(), it already knows what repo it handles, so you can
> > > just extend read_index_from() to take 'struct repository *' and pass
> > > 'repo' to it.
> > >
> > > Be careful though, repository and istate does not have one-to-one
> > > relationship (I'll leave it to you to find out why). So you cannot
> > > replace
> >

at a lot of place where, read_index_from() is called, the repo struct
is not available, so i am passing `the_repository` in those calls.
this makes me wonder if this is really required, because most of the
places just don't have repo.
