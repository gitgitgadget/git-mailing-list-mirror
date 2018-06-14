Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A53F1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 21:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755369AbeFNVP3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 17:15:29 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41705 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbeFNVP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 17:15:28 -0400
Received: by mail-yw0-f194.google.com with SMTP id s201-v6so2647916ywg.8
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4nvNOrkiI3UVR8zQN1JKqX4oGN+RcpiepP0Im5dL1E=;
        b=O0pXxxLG2pmt169Wh7O/0FMJARedSaoZM4dvXDw30IdnP4L+TPvpdCiQSb8FaA9+6a
         O5BnzO69EnBNJUDLDaar/jQcllMxs1jlfSGTcwIpaSS/yvWmyeY6bQgm65kumtJjZewB
         Y7+UkB8Ff3epkD2nDmM7MwV3HoO9vUFcLOn+99KlBfxOZicBFzJumvPIDJAa2tjys+q+
         cRpqKLk2925fixm9jmm4P1tezi7zihL/7kUqfKlzyQ63lQkUfAS0Y6OZfuXFzkrfGnqM
         PDBZCMzz8H6BXKaOQQm15Ob7EPweRLbbM2F0SnUgc0BUG21KVre4Cd1tQW6Huxsd4hMJ
         Wo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4nvNOrkiI3UVR8zQN1JKqX4oGN+RcpiepP0Im5dL1E=;
        b=SvSGDe14wtdI/1SyYPkp68wzs/L+EZzbmcTv4EupnESP2bLyqojaSKZyPJDqBiAzhd
         ok8aPUSjmFcoNoTaEiVVWJgVg9JXKtd+F2b0Inm9XY3vfaZ478kmTcYtj0AM6+Mqnk/7
         QqU2MnYDRVXR8qgh9+QqsGLUTdWnk0ZXKy3B2rAd0fq/N014qn12NotbN2CvCAZxH6fy
         y1FDkTheIu3lAdgQ5Y4qVMJ3EwHS0zKP92ZEoka8I3Tu7U8JFUxbQXng4GrJueW1NJ7B
         SartuToiNyDhupRHomJGVpq343Io3JGFnmBbrA/4QH4o3OGD3lSjlZanlc46h1yVRYUR
         Ntig==
X-Gm-Message-State: APt69E2fEj5QWpahi04NWPROwTVh4kPmxkobtz2suIUa+bcbcntZ40pR
        AQSY8eVvlOpcQkGeLjzLkssEnuqQHnmTJQ1bKdZBXw==
X-Google-Smtp-Source: ADUXVKLmPIJMGMyRAWqKX1lFMju18JHXZ/CyhbDHvqyNLIlVaZ9hi6MBlifzuUqnxhPS7Iy4eOsJLSZSIlq+0YTk/Kw=
X-Received: by 2002:a0d:d304:: with SMTP id v4-v6mr2375330ywd.500.1529010927080;
 Thu, 14 Jun 2018 14:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180530004810.30076-1-sbeller@google.com> <20180530004810.30076-11-sbeller@google.com>
 <CACsJy8D2JbeWvBg9F69tAJgq1874=ROFBG-QKfCHeUMZwcY-VQ@mail.gmail.com>
In-Reply-To: <CACsJy8D2JbeWvBg9F69tAJgq1874=ROFBG-QKfCHeUMZwcY-VQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 14 Jun 2018 14:15:15 -0700
Message-ID: <CAGZ79kapzeBc1KJFCS2Q4UsZDssaFpf6xamva68LAp+gQcTCCw@mail.gmail.com>
Subject: Re: [PATCH 10/35] commit: add repository argument to lookup_commit
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 9:22 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, May 30, 2018 at 2:51 AM Stefan Beller <sbeller@google.com> wrote:
> > diff --git a/shallow.c b/shallow.c
> > index 9bb07a56dca..60fe1fe1e58 100644
> > --- a/shallow.c
> > +++ b/shallow.c
> > @@ -31,7 +31,7 @@ int register_shallow(struct repository *r, const struct object_id *oid)
> >  {
> >         struct commit_graft *graft =
> >                 xmalloc(sizeof(struct commit_graft));
> > -       struct commit *commit = lookup_commit(oid);
> > +       struct commit *commit = lookup_commit(the_repository, oid);
>
> This looks wrong. register_shallow() has struct repository argument
> 'r' and it should be used here instead.

Right.

> If this is a mechanical conversion, I will also be happy that the
> switch from the_repo to r is done in a separate patch.

This part of the code is not touched later in this series,
so I'll fix it if a reroll is needed.

> FYI I noticed this because I'm in a quest to kill the_index by passing
> 'struct index_state *' throughout library code, and sometimes I pass
> 'struct repository *' instead when I see that code uses more things
> that just the index.  And I have started to replace the_repository in
> some places with a function argument.
>
> If some of my patches come first while you have not finished
> repository conversion (very likely), you and I will have to pay
> attention to this more often.
