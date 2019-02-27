Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB1320248
	for <e@80x24.org>; Wed, 27 Feb 2019 11:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfB0LNe (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 06:13:34 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52122 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfB0LNe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 06:13:34 -0500
Received: by mail-it1-f193.google.com with SMTP id e24so8659210itl.1
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zsj6pepUmPUayDDDWQUC05FoOqVCF+c4L+6MUFJ2+Bc=;
        b=tknTAE00xcckL8CcrN5gR+0lFZjxiXnEDxTDrRQMrj3LaI1n9Tbgn+jC+Kqdmm701a
         MaC+2L305QVJlz7FxQ71rTW6o3FvHJOnpFMQK8oYrrheBCIKD59LY76KuWUES6+tn+Zy
         7fRSk45VcAzY1xEvgKuS8Uq4CC4+BYy9uql7bVIAWLGTVCF8ArZfnujddGCRLTCQlMCh
         oBWlim0njrXFJL20pKIUZeTohjzlNtedaAQvStA7uDKULNcs4xLA5JXmSyJuU145Ro0E
         4uAndkVAot9b5Owzl3i8vUo7vaO9iIxSW7zgJRSr/n3HF0goU6FhOTnGERAL5aNixDgL
         tp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zsj6pepUmPUayDDDWQUC05FoOqVCF+c4L+6MUFJ2+Bc=;
        b=uVSXUKu9vsXt8SvzOtc+tCAibRTOd+Xoy17ntmiBlJTRexgyrfsktkl4yjHktGnfMX
         Or5H9qkoUrmX4T7lzcfHwuF/QPs7VAXZ7+M4gtLTKe0hJuWo993HxgmT2fbwDy1feg0Q
         96hEIvhtiHeE4YuXNBnt1eF8nAteQBlaGKp/NF9tiz3/AjPHD+yPCylr9szDbv3OI7Jr
         A1HfF0TXZUSdtUHN1CvcvnKVCjQ1A7d6hdv4fTt4Kq7SUV3yQKGsF11jEmUM53t1+EKt
         szBZEaf2041IJsk79gb4cvT/lS4XkBlDYAPs0l5wjHGBBg+plmwWemOrxdHssVqL2aE4
         9MdA==
X-Gm-Message-State: AHQUAuYX1aRWrr6FZKIcW1tioQ5/HGqjZo1Hs39uI2sJMHJNB2Bya1V6
        KzrayBs5yJI76lRvpSobyK6kg0fv3DwP57on6TUA9w==
X-Google-Smtp-Source: APXvYqwgaF0U0bdmiCWgNl1VxHCI+AJnm38DFZ5G1R56HUWHgGIjQCNJ22f5SiJ4hGPyue3b/AI8DVQ4vJfAmTzTQrk=
X-Received: by 2002:a24:7542:: with SMTP id y63mr1056700itc.70.1551266013493;
 Wed, 27 Feb 2019 03:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20190226200952.33950-1-brandon1024.br@gmail.com>
 <33efa988-ea80-d9b4-f4aa-3876331a1dfb@gmail.com> <CAETBDP7AyYKE2gQY-HbP+LBhYwvf1QXt0-JaEQwnVyr=PjrKMw@mail.gmail.com>
In-Reply-To: <CAETBDP7AyYKE2gQY-HbP+LBhYwvf1QXt0-JaEQwnVyr=PjrKMw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 27 Feb 2019 18:13:07 +0700
Message-ID: <CACsJy8BhEWRcEKRKpcBiZwewxYYoK0jipMZo9PeWAPCgDt1aNg@mail.gmail.com>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 6:43 AM Brandon Richardson
<brandon1024.br@gmail.com> wrote:
>
> Hi Andrei,
>
> > > would attempt to translate the option as a tree oid.It was also
> >
> > Missing space after period.
>
> Oops, thanks for pointing that out.
>
> >
> > > +             { OPTION_CALLBACK, 'p', NULL, &parents, "parent",
> > > +               N_("id of a parent commit object"), PARSE_OPT_NONEG,
> >
> > Comparing to other similar places, a single tab should be used to
> > align "N_" instead of two spaces.
>
> I've seen a mix of both conventions scattered around, and wasn't sure which
> to stick to. I'll switch to that.

I think we sometimes use spaces for fine alignment (search "tabs and
spaces" in CodingGuidelines). It's really up to you and Andrei which
style is preferred ;-)
-- 
Duy
