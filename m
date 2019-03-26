Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36B020248
	for <e@80x24.org>; Tue, 26 Mar 2019 10:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCZKOi (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 06:14:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39644 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCZKOi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 06:14:38 -0400
Received: by mail-io1-f67.google.com with SMTP id e13so10251228ioq.6
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5puDnHjzvo90lBtt1kJGf3Pcfwnkjgv3SdCJvXsGSA=;
        b=lI67Rwhk/9dw63fvQPWE5oNNnF3jJNepK+QzO2gnwpPGYV5Ue9xEjv8ePB/LqqubE9
         peSmEwelYaNZ+Gu8tuB8cwuzuZQ+xF5sB5HxKSi0yRs7isSE46lM1GcWBfayhwImQ1jo
         V2qkx67y5dATGL0tduzlaLsQQPeFJVtBUiuRLwDZiAVL1QWyKK11V/aBOuiUcfksPwIq
         VvGGtzwAGxtgt2QNrgrbjw2eD+IEpGr3AZKePUuU/Qw/qHbJAiY69blj6iE4gjBxqUfM
         Z9xcDX3wgoXJz/dAVHEUE537y7R8mDmROJbxCsPI6ocpvq9p2zmMvbyZsmeNWBSh53m9
         MGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5puDnHjzvo90lBtt1kJGf3Pcfwnkjgv3SdCJvXsGSA=;
        b=KFpiUkWS1wlQZ3ovX2C0mJx0c8GMyT7rFk3xPi/HLj7UmSOES41hmYIdON/WkuLWnP
         g/jfHg9iPPxp1NH/tjKHSoWyvShsf10dZUdPZePGzEbz1xW9QOV3utSMfugjke0t9Acj
         Lp+8WuC8736r8rZZf1GySgMo5C3WJCR20uhNbR/dPPZg22cRPB6WMDuvY5T6eGc2SoLe
         lPCQN31/Hy9l79nF/ZrzmSwT4FBNfOeSKU4leJ6OlS2+jnbE5Id6LADShkFO40yQlQuZ
         HO/vZ2j9m4mDT3J41WyDvtd+6zVveHYrXPfpJttW/bNCZUIG2Xgap1x2NWbiU7H9LXex
         lvaw==
X-Gm-Message-State: APjAAAW6zDHoQXBuRlN3RI2h/s6QIiI+0bRfq/pTlYKmhru7RvFfHVDA
        hJmfvqyoK8idyQ0bb+rGpHr0wJ/+2zPq6PWP8Ts=
X-Google-Smtp-Source: APXvYqyyZvtPIj4HxQumP1rM9qrIhZa2WEZ+MdXSRge5D9+hMNCXQJTWAhMG/Lz6DDrqv/c7xx0xz4u1LWRQuNSmN3s=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr17394240ioa.282.1553595277614;
 Tue, 26 Mar 2019 03:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553546216.git.jonathantanmy@google.com>
 <c4d2f409e246cce02ebfdb8c7110e3700d066ec8.1553546216.git.jonathantanmy@google.com>
 <20190326052011.GB1933@sigill.intra.peff.net>
In-Reply-To: <20190326052011.GB1933@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Mar 2019 17:14:11 +0700
Message-ID: <CACsJy8BHBR2OAHjr-LO4HEmwrmga++5RS1K76qKnh36Hsw9Chw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch-pack: respect --no-update-shallow in v2
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 12:20 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Mar 25, 2019 at 01:43:23PM -0700, Jonathan Tan wrote:
>
> > In protocol v0, when sending "shallow" lines, the server distinguishes
> > between lines caused by the remote repo being shallow and lines caused
> > by client-specified depth settings. Unless "--update-shallow" is
> > specified, there is a difference in behavior: refs that reach the former
> > "shallow" lines, but not the latter, are rejected. But in v2, the server
> > does not, and the client treats all "shallow" lines like lines caused by
> > client-specified depth settings.
> >
> > Full restoration of v0 functionality is not possible without protocol
> > change,
>
> That's rather unfortunate. Is this because the v2 ls-refs phase is
> separate, and that's when a v0 server would tell us about its shallows?
> It looks like in v2 it comes in a separate "shallow-info" section.
>
> What would the protocol change look like?  Would we just need a
> capability to instruct the server to mark the two different types of
> shallow distinctly? Or do we actually need to convey the information
> separately (e.g., in the ls-refs phase)?
>
> None of that matters for your patch here, but I'm just wondering what
> the path forward is.

If it helps (because I'm still catching up with v2 to actually help
review), this case is for cloning from a shallow repo. The commit that
outlines how .git/shallow is updated is 58babfffde (shallow.c: the 8
steps to select new commits for .git/shallow, 2013-12-05).

Since the first shallow info is about the shape of the remote repo
(where refs are the tips), ls-refs sounds like the right place to
include the information. In other words, ls-refs currently tells the
tip/top of the repo, what's missing is the piece about "the bottom"
(shallow cut points).

> > but we can implement a heuristic: if we specify any depth
> > setting, treat all "shallow" lines like lines caused by client-specified
> > depth settings (that is, unaffected by "--no-update-shallow"), but
> > otherwise, treat them like lines caused by the remote repo being shallow
> > (that is, affected by "--no-update-shallow"). This restores most of v0
> > behavior, except in the case where a client fetches from a shallow
> > repository with depth settings.
>
> That seems like the best we can do without the protocol change. And even
> if we adjust the protocol, we need some fallback behavior for existing
> v2 servers, so this is worth doing.

Are people actually doing this (i.e. cloning from or  pushing to a
shallow repo)? I added this with the intention that a big shallow repo
(e.g. one year long history) is served as the common source to reduce
server loads and everything, while the full/big repo is available but
rarely needed. I never saw anyone complain about it (so, likely not
using it).

The description of --update-shallow probably should mention this
fallback behavior? --update-shallow was not default because I feared
the local repo could be cut short by unsolicited shallow requests from
the server side, and it looks like --update-shallow is default (by
mistake) in v2? Maybe I worried for nothing. I dunno.
-- 
Duy
