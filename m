Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD1920248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfC3LjB (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:39:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46338 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbfC3LjB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:39:01 -0400
Received: by mail-io1-f68.google.com with SMTP id b9so3887690iot.13
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSdlb0f1+4vSthkobNYPL8lmI4CKdSrZ/sa3/0u4WT0=;
        b=Zpfvyi/1OdUGFesXo51+OgVCEGGrQTXY10mv66qyFoowZGN6heMFQCuSx5aenqMv85
         XdSsJxqA73+5c43gkNx35oRaVi212uyfUqUCwpDzftc/ouFkoKq5BjY3Se/VbC5JDhPK
         ZJKb69JJ2sizTCy2rLABpxokXx12osHQCipA2YKv8eZM30SBNfIvQSxXnFeG7Rbzo1Hm
         oSyA2wUZxKKQ+xKVKpQq6zv5ehc7NFVJPGbgoLiDRQV69eDm5a5lP19WQNs+76tqhGqg
         G48kb8ER3tduWqCvTpBQcoNcF5onytqVTmzsqh0CB4h629INvvHFMJF1hCmqDUKNcaak
         wMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSdlb0f1+4vSthkobNYPL8lmI4CKdSrZ/sa3/0u4WT0=;
        b=dVU8w+J3HfSErluxYmxfbenqIXpDBeYiURqzexBXPz2YSyXnduDwsbcaKDmKVgWF4T
         n9xSJTU6KjMRtkSZyse4n6MPhl7cQfOsiYBUwka49PzOzJApjk/Evscxl8uwyeVXoSi2
         ApHuTqy7BC+lPEcLb5+CxNnxlutG4ff3Bvnl1cjSYFG/T9qrOZWJyWMWvNGliMiRNTyT
         gYdsh/IgbINd+Xhbdj5+lEt2TAcs9/FHe1fUaUeVf1Iq9PJ9A8j4uccWLZgYMobFbPCu
         QwAriqP9CX8+D9DVleQlAeO8Z9+H2tnsZthvev8vBJu3atXF0AQ1YNHNN0FUHs/V7o6s
         PR0A==
X-Gm-Message-State: APjAAAUuqmqjF4qkBVmcj0Xazsy+W198UYCVrAp7PSajWxAhjrDrLM7M
        DBsPuEpKQAM58ihQtsCwnOdUitA7AvqeG5MyMJ4xJQ==
X-Google-Smtp-Source: APXvYqx0XXPRqPjLFRedTsYPxo0231WZmzBSkkLVhCBdMNHkD+M9GKs9ybfEzSy5e+TNnpP8XIeDpWbceAgMHJy4N+0=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr12010267ioa.282.1553945940483;
 Sat, 30 Mar 2019 04:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAApa7v-F7Y_WR11V-3jc-R4Y1qSv5PPof6GWvJuF_XMeTcC2zw@mail.gmail.com>
 <CACsJy8AS5eNO6gACGtRZq=qdQGkQ3jmQPVivPG+=du9u9hKYcg@mail.gmail.com>
 <CAApa7v_noujdWcogGNJUS7ZJRzPRxK5PPv53tST-0JoEk8+9Mw@mail.gmail.com>
 <CACsJy8D9h2yT18V6pH+TKOaFPNQUf=Gd6YtgVkqUW_hvS1ZFaA@mail.gmail.com> <CAApa7v9-2BhTQgt_Vd1mLACsrR2ZhYRBRrNTx2HDrEKXuHVSXw@mail.gmail.com>
In-Reply-To: <CAApa7v9-2BhTQgt_Vd1mLACsrR2ZhYRBRrNTx2HDrEKXuHVSXw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 30 Mar 2019 18:38:34 +0700
Message-ID: <CACsJy8BQStYZrTi6Pfrq+TDy-1d74cpS=+8QTr3DDJwgb3ZB9A@mail.gmail.com>
Subject: Re: Feature Request git clone shallow-include
To:     Joe Enzminger <joe.enzminger@exactasystems.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 30, 2019 at 5:02 AM Joe Enzminger
<joe.enzminger@exactasystems.com> wrote:
>
> Duy -
>
> Any updates on this feature request?

Nope. I've been busy with other stuff. I did have a look at the
possibility of reusing code in sha1-name.c and concluded that it's not
quite safe.

> Joe
>
> On Thu, Feb 21, 2019 at 7:06 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Thu, Feb 21, 2019 at 1:07 AM Joe Enzminger
> > <joe.enzminger@exactasystems.com> wrote:
> > >
> > > That is correct.  What you suggest is actually what I tried (using
> > > sha-1 syntax).  For my purposes, excluding the tag's parent's but
> > > including the tag is sufficient, but if is fairly straightforward to
> > > extend support to the other use cases I'm sure someone would find is
> > > useful.
> >
> > It's not hard to do. I hope I will find some time to do it soon. My
> > only concern is whether reuse the current code or write new. The
> > former makes it easy to accidentally accept some extended sha-1 syntax
> > that should not run on the server side. On the other hand, the latter
> > will not be as thoroughly tested because it only runs by shallow code.
> > That's my problem though. I think I might be able to find a third
> > option somewhere in between.
> >
> > >
> > > Joe
> > >
> > >
> > > On Tue, Feb 19, 2019 at 7:22 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 20, 2019 at 7:07 AM Joe Enzminger
> > > > <joe.enzminger@exactasystems.com> wrote:
> > > > >
> > > > > Currently, git clone supports shallow-exclude=<tag-name>.  The client
> > > > > will clone up to, but not including, the commit with the tag.
> > > > >
> > > > > It would be useful to have the ability to include the commit with the
> > > > > tag.  The suggestion would be to add a "shallow-include" options to
> > > > > clone to support this behavior.
> > > >
> > > > So exclude the tag's parents and everything before, but keep the tag, correct?
> > > >
> > > > I think if we support --shallow-exclude=<tag>^ then it should work the
> > > > way you want (if the tag is a normal merge you may need to add
> > > > --shallow-exclude=<tag>^2 as well). And you can do even fancier thing
> > > > like --shallow-exclude=<tag>~3 (i.e. exclude the  grand grand parent
> > > > of the tag, but keep the tag and grand parents). We will need to
> > > > restrict extended SHA-1 syntax to a safe subset of course.
> > > >
> > > > > I have tried to use shallow-exclude with a follow on git fetch
> > > > > --deepen=1, but it always returns "fatal: error in object; unshallow
> > > > > <sha1>"
> > > > --
> > > > Duy
> >
> >
> >
> > --
> > Duy



-- 
Duy
