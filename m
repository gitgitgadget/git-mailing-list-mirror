Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 967A81F454
	for <e@80x24.org>; Wed,  3 Oct 2018 17:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJDAoc (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 20:44:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43230 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDAoc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 20:44:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id a4-v6so6145995eds.10
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SBmX9n5zKES3hJIh3PL/BAcxx+B26aEjCAS+zx0XXP8=;
        b=nfBE9xGUrKAmHz+IicuvptDNrVlt1SPtq+DP2Qdb7/q+zxtlNHqTWlqIW37hJGzKE8
         2QyR+8lJifxmVJvBresgakKB2gfKenceWafL5jYgQHk7C5QQfdJV7l6mGuKAN58Ema0t
         /n3doIogMqELPHWiMj00EUk+zBNcGMMDckDBmBHxWn+QxSmKMEuiBYf9y2YRxCWx1upZ
         VHwy220lb7DRjng9ikuECj9wTziAjzilw/YzJJhUOyYxkmfgZy2zrWs60eNrt+jHXYp5
         cONKjqGUiLvGE5fh59fZ3//a8KdwN5w628CuWRHUzlXHaccwuqnCC1HEOQtj665NSHtT
         8zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SBmX9n5zKES3hJIh3PL/BAcxx+B26aEjCAS+zx0XXP8=;
        b=UHwGjAdfGodbVjPYZvSYVrJSx++kwO1qAg/LQpCSe/rBFwbLToGqtEKzmR0Ex7/vyS
         UR0a12zs6ZRbQsup6q/G/w4jZJlIh/cQBWFKqJvRsY6Yq1X0A7tuH5lh+BLe1DfQjgxO
         n8FDo62SJ7OXiZ/L6WIpCG4sF6/Nm1ICpn03mSBCbPk8SBSs+ThGjtgH1x9dqdHM9XjA
         NhC4ZigV26fqFSV8L+jKX22NQevHTnZKmkRWUWBUozfsyGR9TTXvtKxLFbI+52t5rFNi
         Ehs6BZEPPBio4e3dC7tHyKjTjrceeGKYl3Q5sJkV/GSHhOnFk1gYBeQVK/q4KsSTXoio
         K+Pw==
X-Gm-Message-State: ABuFfohOy+xtbI9u5blRFlpi4J9nTtFYFip5Ij3ZtAR3gHuwtALHW7/h
        1+tNZ2da8bIfeQ/au0UEeHumi1hOrlcKQeNhah5dLw==
X-Google-Smtp-Source: ACcGV61B13IXjxcbtWY0RDYtveIc8B0H4sQoRLlaPxsR5v/K/Aqd4+eomNlLhwfUneRk3p+AiPHyoFGqAWVMn7VuES0=
X-Received: by 2002:a17:906:101:: with SMTP id 1-v6mr2997548eje.126.1538589304965;
 Wed, 03 Oct 2018 10:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181002191642.21504-1-jacob.e.keller@intel.com>
 <20181002195519.GB2014@sigill.intra.peff.net> <20181003101658.GM23446@localhost>
 <20181003150522.GQ23446@localhost> <CA+P7+xpB5Pqj7Kp5HiUDqtNMiX8+kGt5QfwLaZ+ROY9jj+Xnrg@mail.gmail.com>
In-Reply-To: <CA+P7+xpB5Pqj7Kp5HiUDqtNMiX8+kGt5QfwLaZ+ROY9jj+Xnrg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Oct 2018 10:54:54 -0700
Message-ID: <CAGZ79kZKb_t5ALF6KPtKt05gt1jv5gZL_rrdmeO5vNAb7ed8bQ@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: process every source file at once
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 3, 2018 at 8:52 AM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Wed, Oct 3, 2018 at 8:05 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> > In fact, it works finer than ever, because running 1.0.0 with this
> > patch on Travis CI notices a possible memmove() -> MOVE_ARRAY()
> > conversion:
> >
> >   https://travis-ci.org/szeder/git/jobs/436542684#L576
> >
> > Surprisingly, running 1.0.0 without this patch, or running 1.0.4
> > locally either with or without this patch doesn't notice that
> > memmove() call.  Presumably that's why Jonathan could kind-of "revert"
> > my conversion from f919ffebed (Use MOVE_ARRAY, 2018-01-22) in his
> > 6a1a79fd14 (object: move grafts to object parser, 2018-05-15) without
> > anyone noticing.
> >
>
> That seems very odd...

That looks like a bad rebase on my side as I was carrying that patch
for a while as the development of object store series took some time.

And I agree we should re-introduce the MOVE_ARRAY there.
