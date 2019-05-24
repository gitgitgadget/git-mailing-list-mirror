Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E751F462
	for <e@80x24.org>; Fri, 24 May 2019 07:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbfEXHgE (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 03:36:04 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36623 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388911AbfEXHgE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 03:36:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id y124so6352265oiy.3
        for <git@vger.kernel.org>; Fri, 24 May 2019 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EAm536cmBgNzuQERm9w0Z4eOb4/onkapn1BQMInDP2M=;
        b=e1aQab9mqR3WCsBqPOQZLcEeoK4jg+DmtwGylFcNn5Q+E2Bek2pwnvqnCHho1IS/dT
         rPmm6zFUfECkuTzVPJ38O6AeszxCKPbMyCC4Y7hS1ULUPvHleKdJZ9/kpZr2AGmDMllw
         iIaapmsWuayRvA3Lbuxb35dW354OWcLxV4hsIc2khurRv6EZv3giNsnVRxKdEOX4DbMe
         xUd34iMEeOnxIX4KSdrS57coodNBJ3PRiE8/wMm92YW6CxTwYXLfavFiQcHEF7uI4b+Y
         C00wisyblvpG1QCZR3Ri5xRoqMvhOQjy0nF8b779y5xcvNOPOt14NYlI4aAZGlBdT92P
         HCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAm536cmBgNzuQERm9w0Z4eOb4/onkapn1BQMInDP2M=;
        b=kFvsZqNtYSxK4DoMz5PEGNDwi2ubbT9kiGSokAmBrB7CMzF3q/CpeC+uiG7173qrPe
         bc8fz4z0euwdvQuen01W4cSR8Z90gaM9u3Y+Q+dCz6pSK5j502O7g2Y2UGlveuDzFcbO
         keR9ZYCZnyPBtXPV6C+X9vPq37ahWPMGd6JEka+JBzVyISdPYQPadSqYLfSnD65vY99a
         dDOb4F2yKuhPc4yTviP2/Iv2vLPRCRVsDhEvGwk8y1It3TIRgPTMNzlx/qplxH/VAtju
         sa0bwf3BKWLKnwXMIudapxT/5grtLfC8GdwjDdODfshn6t5W/kNLxIEHFGmzGbEAJauC
         FuLA==
X-Gm-Message-State: APjAAAXxSG07L+lcsacnIhvPc1czo8ILkJlTuiREnblXjA+/QO8b+6w+
        kI8Zd4DhME8rjDlYRDP18QP4oPqspOyLijh35Wo=
X-Google-Smtp-Source: APXvYqxTcdI3/3lVrhrvj9OysUB3qAhFP3IB7nRxSpOL8pIFArL8XTAukaDxm4avqaPmgmO5jUm/bJE5bH78ZUeZHgU=
X-Received: by 2002:aca:b403:: with SMTP id d3mr5539974oif.179.1558683363281;
 Fri, 24 May 2019 00:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net>
In-Reply-To: <20190524070644.GF25694@sigill.intra.peff.net>
From:   Keegan Carruthers-Smith <keegan.csmith@gmail.com>
Date:   Fri, 24 May 2019 09:35:51 +0200
Message-ID: <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
Subject: Re: git archive generates tar with malformed pax extended attribute
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 May 2019 at 09:06, Jeff King <peff@peff.net> wrote:
>
> On Fri, May 24, 2019 at 08:45:23AM +0200, Keegan Carruthers-Smith wrote:
>
> > git archive can generate a malformed tar archive. bsdtar reports the
> > error "tar: Ignoring malformed pax extended attribute" when reading
> > the archive. Go's "tar/archive" package also reports the error
> > "archive/tar: invalid tar header". However, BusyBox's tar does not
> > report the error (unsure if it just has less error logging).
> >
> > I can reproduce this when generating the tar on linux and mac. I
> > tested this with "git version 2.21.0" and a build of next I did today:
> > "git version 2.22.0.rc1.257.g3120a18244"
> >
> > Reproduction:
> >
> >   $ git clone https://github.com/SSW-SCIENTIFIC/NNDD.git
> >   $ cd NNDD
> >   $ git archive --format tar c21b98da2ca7f007230e696b2eda5da6589fe137
> > | tar tf - > /dev/null
> >   tar: Ignoring malformed pax extended attribute
> >   tar: Error exit delayed from previous errors.
>
> I can't reproduce on Linux, using GNU tar (1.30) nor with bsdtar 3.3.3
> (from Debian's bsdtar package). What does your "tar --version" say?

bsdtar 2.8.3 - libarchive 2.8.3

> Git does write a pax header with the commit id in it as a comment.
> Presumably that's what it's complaining about (but it is not malformed
> according to any tar I've tried). If you feed git-archive a tree rather
> than a commit, that is omitted. What does:
>
>   git archive --format tar c21b98da2^{tree} | tar tf - >/dev/null
>
> say? If it doesn't complain, then we know it's indeed the pax comment
> field.

It also complains

  $ git archive --format tar c21b98da2^{tree} | tar tf - >/dev/null
  tar: Ignoring malformed pax extended attribute
  tar: Error exit delayed from previous errors.

Some more context: I work at Sourcegraph.com We mirror a lot of repos
from github.com. We usually interact with a working copy by running
git archive on it in our infrastructure. This is the first repository
that I have noticed which produces this error. An interesting thing to
note is the commit metadata contains a lot of non-ascii text which was
my guess at what my be tripping up the tar creation.

Keegan
