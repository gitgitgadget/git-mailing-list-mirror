Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B86951F954
	for <e@80x24.org>; Thu, 23 Aug 2018 14:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbeHWSUD (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 14:20:03 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39722 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbeHWSUD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 14:20:03 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so4497546iok.6
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrthayZ62qr7+yJ0IY3vf/MJtXsjGjy+BaUCVeFXDbE=;
        b=SGOgPnzRkFQZ10Ohco5IgpqtywQd6n7a7W0d9WY88Uh89cxj6YbRCdo8IgOZ4nAr2Z
         6s1QvMlIw50XeHuXjHoO35pUoHPc+g/eFG7+ehiGUSTj/d6XjjGX6EJISKpZmhkw2vkM
         749bAXayiSTRNDAH7ajo52HpIrww7yWd83dK/7XnoaQ07RaBnx2Gbcmp/h9aX/mpX++z
         ZpgyhLnrZF2w5oeYGCQ50nXe8j8Fiyg6aictkQlq1dvBnVC+bU1AnpzXRiYELr3BFN6F
         Q7yhX6Obogfj4qiuiBmEPO12CpONxcjOLUaG3USMiNKtufQzJNj93CxRQ6Co60w1Leol
         MKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrthayZ62qr7+yJ0IY3vf/MJtXsjGjy+BaUCVeFXDbE=;
        b=A6PkY0YO0txb5ONBBT+wHXWAMiNuXfpUUrk09Kbx7N6Toj4z5gGm6NNl8c5MSkE63H
         AJm2c7jyJvcB9+fB73wLKoL9tiqqjkEGVyTlk/TLWLVpw7pf1hqyLJwlQOcoWF5itDj9
         lWTAhJqKUfiiEETZoXyZHwMwCGP4b3jx4VmK+rIZF2FRrn84woj0b3VCWiYHPcW9mFo7
         xEh6xuJyxbBE5KQul9gaOl85cBDdvcwchYMIxYUWWQV+SdHYBC2/lfD/K6bIZ2IzxG7x
         Fa+0rQejI+/QmXRMwGF41QtWN06xlst0oI1AZulpptnb0gOYvNwrhSHxzKV12O2VBPwW
         +x3A==
X-Gm-Message-State: APzg51BpRNwVqjIFlTgimgP6wRy289gCuDbu4PEYkIAAkGEdYJ5Ck9CK
        PfLElCrN8Ac9LP8lw4XIFXIjm+HNFXaCwW4iMjRP0w==
X-Google-Smtp-Source: ANB0VdY7kK5P+lVDgSnuLl9n0SkX8YAoRS3wn5+x9Us7yJVRBR8pBtCsme79GamCGyJuROjxxpyB8ZQQRQGgA5X9N9s=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr14464211iok.236.1535035802413;
 Thu, 23 Aug 2018 07:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com> <20180820193007.GB31020@aiede.svl.corp.google.com>
 <CACsJy8DsEhV6p=cE6FC6Ka4=E0c-8JG0LRU_DEq-Ser5PqMcGw@mail.gmail.com>
 <20180823021156.GD92374@aiede.svl.corp.google.com> <20180823021547.GE92374@aiede.svl.corp.google.com>
In-Reply-To: <20180823021547.GE92374@aiede.svl.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 23 Aug 2018 16:49:34 +0200
Message-ID: <CACsJy8DdZLxdA4XSVVBSpeZaF+q6=81LxecYea2JtJ6-Krnk-A@mail.gmail.com>
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already staged
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 4:15 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > The remaining question becomes scripts.  A script might do
> >
> >       ... modify old-file and create new-file ...
> >       git add new-file
> >       git commit -m "some great message"
> >
> > which would trip this error.  For that matter, humans might do that,
> > too.  Could the check detect this case (where the only changes in the
> > index are additions of new files) and treat it as non-destructive?
>
> (where the only changes in the index are additions of new files *that
> match the worktree*)

I don't think my change would affect this case. If "git commit" does
not change the index by itself, there's no point in stopping it.
-- 
Duy
