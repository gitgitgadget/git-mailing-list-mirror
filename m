Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 022781F404
	for <e@80x24.org>; Mon, 26 Mar 2018 22:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeCZWPF (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 18:15:05 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:46307 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbeCZWPE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 18:15:04 -0400
Received: by mail-yw0-f175.google.com with SMTP id v68so6622867ywg.13
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2z+W4cFde79x+/EC/iT8X0NN+4gIgcWc4lF7kfeUkU=;
        b=LGPfs4hIEhgj1tfVYq50lRTDjld2ZaozE4ToI/o/EeZGnDth5A4Lv4jjOLdh4V7PoX
         l5B+2dRiJ52Uwt7Jeoii/ibk3ra6q1J4ie7JbJGS3AVSrPqr/8U3FGxO/Cx+y67772La
         sWfUboGJhcKZimvpGX+GkBjOqz+KMuwE8uFLBtwxtpE0XRasjlpLcybc/bTVil7EVBvJ
         bMvFmzWgTSL7/CMMQb7SeOWv7+aILCQ7ybcwGxVbGYPvBr+blhGYok4pl/yw7+PVJkjo
         ROhoGCy2Q27tqNmH8u7RweUcrZYx/cO+JtKqE6M9Yo2xyc43+lyuRh054VS8vFgJNWwt
         0utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2z+W4cFde79x+/EC/iT8X0NN+4gIgcWc4lF7kfeUkU=;
        b=e6mH0bhCjdFAL1QN0jGE3OSk8DkPVygT4vfpEWdmc4NgJkIGjdTKwlhIlKfRZdlocW
         yLoK9tcqP23ghqSnwyGp/IWOl8Ww3x94/XsDHJs8JW/WEkSqh9meWiNOlkBiHqBRN1wh
         3nU5qu0ut/99zOaW5kiiQz5RbVAOTcZlbUNlsxJPMsWT6AeYTKOU7ILSk+JkjAMWCet1
         ro4Zx6CagKAUIcDnAf/amkktRhbdnHxfUa5N69NyZinL6iFWvx4ZKdqtMtNdUkktzD94
         b36ZqTKlo2+/t4QqhdVcYpLqX4Cg1XtJVK+zVDoPfBT0KuzCVIAguGpTRCzf9IyQzr3o
         ooqA==
X-Gm-Message-State: AElRT7FAWVFRD7+BhFgQlTx3niM/DC5Z/GobCu9DWfmaF6Vl+oo+fUWh
        y2eYys9y/lN8ED0RURhCG4ySBB1ibaiODqOGOlx3pg==
X-Google-Smtp-Source: AG47ELsn2fKXGz0md5fz8AjkVB0APZErBJXuHbC/7RvZIAopavWAlix3j8fcSyzGLpJRDE1Q/BNWmmdRPshxhtCg8XY=
X-Received: by 10.129.159.195 with SMTP id w186mr24436037ywg.414.1522102503273;
 Mon, 26 Mar 2018 15:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <CANT8FXR3pMgbwVWmwssDYhgv6eMFw4+Uz5xARGwFVVU1cMVmWw@mail.gmail.com>
 <20180317130128.mr2sfsrncykkubwo@tigra> <20180317161819.GB25113@sigill.intra.peff.net>
 <xmqqwoyay48n.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwoyay48n.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 22:14:52 +0000
Message-ID: <CAGZ79kZU39B42BeOxrUDxT6Nca0=Yd+O0TEgu6_HvK3O=b2KhQ@mail.gmail.com>
Subject: Re: get commit ID from a tree object ID
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, kostix@bswap.ru, clime@redhat.com,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 10:57 AM Junio C Hamano <gitster@pobox.com> wrote:

> Jeff King <peff@peff.net> writes:

> > If you want to dig further, you can use the diff machinery to show which
> > commit introduced a particular tree, like:
> >
> >   git rev-list --all |
> >   git diff-tree --stdin --pretty=raw --raw -t -r |
> >   less +/$desired_tree
> >
> > That "less" will find the mentioned tree, and then you'll have to
> > manually read the commit. It would be possible to do it mechanically
> > with a short perl script, but I'll leave that as an exercise for the
> > reader.

> Before Stefan jumps in ;-) I wonder if a recently materialized
> "find-object" option to the diff family can be used here as a
> sugar-coated way.

I am late to jump in, but testing the 'git log --find-object'
seems to have issues with trees named by sha1 here,
but the named tree via <commit>:<path> still seems to work.

It seems reasonable to be able to find trees using the find-object
flag, though.

Stefan
