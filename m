Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14AC01F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 07:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeKKRFo (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 12:05:44 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38024 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeKKRFo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 12:05:44 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so3388314vsa.5
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 23:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aO8bpbyIukspIhigwI/EVFb8nH2onJohzKlI1Y+285Y=;
        b=FDb2jrawXXdXKEd5+KvZe1OClKwhhxKKWklpl84+07ARFnM1mCHHh/CXElTxDyuKo8
         +ObwMXBgVfKEAViJK53FfwVFHilpc7SmI/PemHq4T8F8Pd6toT12fO3+bBEfrcFWQabk
         VZlEYJpMHhYIHV8kUxFl5szRmWn6OGgGdvEXNLkzZo81Phjxwg4/mwhfP/7EyvkskUxw
         2hzJomAEKd9UiEkgL938IMhIv80SiVoqii9C15c/P25I3vPyu8H4TczfG1R/uKaPaGI/
         D0IMGMG/Ger4wE3WVXX5WSP8NDqjqAS5R2wPwhipeL4BzlIY1NquTNJGMgAtdMShqkzh
         sG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aO8bpbyIukspIhigwI/EVFb8nH2onJohzKlI1Y+285Y=;
        b=GOhgz1F2LOULHF0dJubLlTIU09qAIgwoN3GiCpQKvWHXqFXwAJwGzqVZ8YaoaPkFMQ
         ceiI19G5ESNRTCPF9AOsTukoXBk7BZoRCJBeRvQlKdQATEAmZlfuZVjLtpoXwoF8XOXh
         MO2SEpZn0EmG7U08wlX2kfCgwq/ez/wyxbqGxR5QXl1eWggVy047EAcdHR1GdQlbYYmP
         JoyZzfK8TqrxM57LAY4K4Qp2HWif3Lbfkh9WOsAX5RMFC76Vlsk+vbamfqa4bgudZ/Ox
         xiVN1soM5rIkV5vZaFkHTWobFt9I2HjXxHKIldqla4Wfwc/gNOuIpz4QQ30Z37h6Tyi8
         HiFg==
X-Gm-Message-State: AGRZ1gKDaipHEVfK3cf8swfKSGXxbsWoIpuYOF4QfZNLx/SRgggowsGi
        sa71UIDbSWMyrEdWxTrSatfiqid+hn1I+Swx3qo=
X-Google-Smtp-Source: AJdET5f+WU/ux3rJO4NNXyf9a45+dJhWrvkqlQDKGasOSEhyXf73pK8H4ngVP3FOhuMpSnGliQi4fqNzV9iG7FtrfSM=
X-Received: by 2002:a67:3c5c:: with SMTP id j89mr6403667vsa.117.1541920678051;
 Sat, 10 Nov 2018 23:17:58 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-3-newren@gmail.com>
 <20181111063601.GB30850@sigill.intra.peff.net>
In-Reply-To: <20181111063601.GB30850@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 10 Nov 2018 23:17:47 -0800
Message-ID: <CABPp-BHwg2U=b+UGK2SufB7uZPmmiPVKXoTpYt+LuHnLwmwuZQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] git-fast-export.txt: clarify misleading
 documentation about rev-list args
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:36 PM Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 10, 2018 at 10:23:04PM -0800, Elijah Newren wrote:
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/git-fast-export.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> > index ce954be532..677510b7f7 100644
> > --- a/Documentation/git-fast-export.txt
> > +++ b/Documentation/git-fast-export.txt
> > @@ -119,7 +119,8 @@ marks the same across runs.
> >       'git rev-list', that specifies the specific objects and references
> >       to export.  For example, `master~10..master` causes the
> >       current master reference to be exported along with all objects
> > -     added since its 10th ancestor commit.
> > +     added since its 10th ancestor commit and all files common to
> > +     master\~9 and master~10.
>
> Do you need to backslash the second tilde?  Maybe `master~9` and
> `master~10` instead of escaping?

Oops, yeah, that needs to be consistent.

> I'm not sure what this is trying to say. I guess that we'd always show
> all of the blobs necessary to reconstruct the first non-negative commit
> (i.e., `master~9` here)?

For someone familiar with fast-export or fast-import, sure, you'd
guess that it'd show all the blobs necessary to reconstruct the first
non-negative commit.  But it's not clear to first time users and
readers of the docs that the first non-negative commit becomes a root
commit; by comparison, filter-branch suggests using a very similar
construction and yet behaves quite differently -- it does not turn the
first non-negative commit into a root but retains the original
parent(s) of the first non-negative commit without rewriting those
earlier commits.  The text as previously written, "along with all
objects added since its 10th ancestor commit", seems to suggest
behavior similar to how filter-branch behaves (particularly the
"Acked-by example"), i.e. it implies that files not touched in the
last 10 commits are not included.  My wording in this patch was an
attempt to fix that.  Was my attempt perhaps too clumsy, or was it
just the case that you had sufficient knowledge of fast-export that
the previous text didn't mislead you?
