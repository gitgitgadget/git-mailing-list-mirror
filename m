Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650401F453
	for <e@80x24.org>; Thu, 21 Feb 2019 13:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfBUNG5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 08:06:57 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40213 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUNG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 08:06:56 -0500
Received: by mail-io1-f68.google.com with SMTP id p17so1380597iol.7
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 05:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quoMpV3d6DjGWAFZ7AaYGfgon4xOGnK4m/zOSYRNAKc=;
        b=asFfJJKf5EnmKscHaS9DOcNht9uOtDfNUJJ+KHU4zVRkpXR4xYat/VO3sxeKNL1x0Q
         cMDwb2+rho2j6396hTx/B3GNoKLwTZXPEsd9HRZ3D5ie63SoVVINW47Ci43uVkYt7IhT
         IEIadNKoHF7F15LwoLnHPv/aJi6I2s41TSmCgdCmXeJO1slid5lJHJxr13fnrUudT6x+
         qSATBemyAgOWG78YRtueqox+FWkZKXfXZjfdjdHyMsf8nhV/FPDScVW6UPp6dLIQIkp+
         mCxgo7hquAvD1gmXZQM4Ct97QUUDXE/J9E/ODzqskvForhCY4431T6mCxJ7eiV9TZ8P3
         hnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quoMpV3d6DjGWAFZ7AaYGfgon4xOGnK4m/zOSYRNAKc=;
        b=FCsgcGZbDzgUsQ1Vu1U0QkzvNAdoq3u0ejvWXIbxPzc41yanFj3mtMfYuxckDSDA6o
         6NQ3PoxxkomRgW1X45FDuT3upvOJImsqbPGSI700yCVAb63gEFQpToGYaHB4XcGReAk+
         zYfhbaNbyG3QllES7OPSDP+M8pj/a5RjreB4OqNIprVtsqUA/FrGGkiV6YBgk04OIDLr
         uG6d40mm7YKYMJ/jLusxRXC+JWx3KY67fJ/i/8PgQCWZfokZUlDv+bv84Z0intN+gC9b
         WMLZ/q4bWwiwXVnUuVwtEY7yXGS2IKE8B08x2ob4B/JVzFtgVzk2sSTUovoVUVcxj2kf
         pkxg==
X-Gm-Message-State: AHQUAuZ6FrE+anWdBgkrKEey7lAP1W8p+MiT1oQN2XG5eqUkmuxdNsVK
        tBpkTecCgaHFB5Jsnp6CJpO6d8yDE0Lu8RwYJRZC2g==
X-Google-Smtp-Source: AHgI3IbxkqMKtXwfVMVN9B7gk+pddK/jvABnY6eWxf2SN9LxjHJF/vtQdgYQy/bi4iutRNSAbQSxF5Q2uuIcs/XjLdQ=
X-Received: by 2002:a5d:9357:: with SMTP id i23mr10700303ioo.236.1550754415327;
 Thu, 21 Feb 2019 05:06:55 -0800 (PST)
MIME-Version: 1.0
References: <CAApa7v-F7Y_WR11V-3jc-R4Y1qSv5PPof6GWvJuF_XMeTcC2zw@mail.gmail.com>
 <CACsJy8AS5eNO6gACGtRZq=qdQGkQ3jmQPVivPG+=du9u9hKYcg@mail.gmail.com> <CAApa7v_noujdWcogGNJUS7ZJRzPRxK5PPv53tST-0JoEk8+9Mw@mail.gmail.com>
In-Reply-To: <CAApa7v_noujdWcogGNJUS7ZJRzPRxK5PPv53tST-0JoEk8+9Mw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 21 Feb 2019 20:06:29 +0700
Message-ID: <CACsJy8D9h2yT18V6pH+TKOaFPNQUf=Gd6YtgVkqUW_hvS1ZFaA@mail.gmail.com>
Subject: Re: Feature Request git clone shallow-include
To:     Joe Enzminger <joe.enzminger@exactasystems.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 1:07 AM Joe Enzminger
<joe.enzminger@exactasystems.com> wrote:
>
> That is correct.  What you suggest is actually what I tried (using
> sha-1 syntax).  For my purposes, excluding the tag's parent's but
> including the tag is sufficient, but if is fairly straightforward to
> extend support to the other use cases I'm sure someone would find is
> useful.

It's not hard to do. I hope I will find some time to do it soon. My
only concern is whether reuse the current code or write new. The
former makes it easy to accidentally accept some extended sha-1 syntax
that should not run on the server side. On the other hand, the latter
will not be as thoroughly tested because it only runs by shallow code.
That's my problem though. I think I might be able to find a third
option somewhere in between.

>
> Joe
>
>
> On Tue, Feb 19, 2019 at 7:22 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Wed, Feb 20, 2019 at 7:07 AM Joe Enzminger
> > <joe.enzminger@exactasystems.com> wrote:
> > >
> > > Currently, git clone supports shallow-exclude=<tag-name>.  The client
> > > will clone up to, but not including, the commit with the tag.
> > >
> > > It would be useful to have the ability to include the commit with the
> > > tag.  The suggestion would be to add a "shallow-include" options to
> > > clone to support this behavior.
> >
> > So exclude the tag's parents and everything before, but keep the tag, correct?
> >
> > I think if we support --shallow-exclude=<tag>^ then it should work the
> > way you want (if the tag is a normal merge you may need to add
> > --shallow-exclude=<tag>^2 as well). And you can do even fancier thing
> > like --shallow-exclude=<tag>~3 (i.e. exclude the  grand grand parent
> > of the tag, but keep the tag and grand parents). We will need to
> > restrict extended SHA-1 syntax to a safe subset of course.
> >
> > > I have tried to use shallow-exclude with a follow on git fetch
> > > --deepen=1, but it always returns "fatal: error in object; unshallow
> > > <sha1>"
> > --
> > Duy



-- 
Duy
