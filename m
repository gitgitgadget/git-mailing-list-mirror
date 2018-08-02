Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4271F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbeHBQfu (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:35:50 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:53201 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387503AbeHBQfu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:35:50 -0400
Received: by mail-it0-f41.google.com with SMTP id d9-v6so3646022itf.2
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/MZxL0VpIsvtrADUc+/DDhuS0SuDhISJpYmDe5Inig=;
        b=gqUdyjGPSIuA/vG96zvvRMpEUky3Vn/Qh547Cj2uq038Sy+laDpfPDMhQelivxcVc8
         SvIRZos/U61OG7gVxXIJ4UM0GW01QLdyZWcFv49PV4e4qhsLq9+IXZtW2uJB5LPvG528
         kdX2XC8yb8+v3wlbAHLJwU4JPOMxi9eFSI/+0OfkqQtwVqoXWpMjmqjPInMBzo1B+UjH
         DbDUW8ju6fn/btQydUXc+zT2Qn12ZXtLuPnx6qVWkawd98lVv+fv+I3w7E0Lf/irW9UA
         CpVFgnORd1qilWsj4x+Cpp54hbFWzvy39K4sX0xL5MsV9IE6IKTifhNW56Y2/DCQjH8i
         0n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/MZxL0VpIsvtrADUc+/DDhuS0SuDhISJpYmDe5Inig=;
        b=gXvYSTJ9+9Fpo8v8x4C/VwmeN8nBcYUDoix/Q1cMNd7srC6ecTJxVTX4mBt7r9O7Kb
         kuwQnuiH/B7KxmR0acopw6gRFIlPbo1QESUQZGlBV6YXXXNMi6DDsJbk9ZEG6+vNENTg
         gi/vkzuOjNwytuCWRi9770SCR77C4J8bqUtMr4lGqKLAu7KeCliLlTTj+aG4N5y5XVST
         sC7n+rKIJ+g6pDCRWfOEJXd0l1kMK7pzKLVtyIDuVEGRWIm5pTttZSs+X2fPsPHLrxjN
         zqbaJlnzk6PWuQJOnouARl1dCDfXpYSRX7mD/TfQyX6LiNGGrFTPi4/YDT0zhQYZCNMO
         +NqQ==
X-Gm-Message-State: AOUpUlEDdXOxlcpfs85JTO0RgpndX+MBd2anOAuHMQF2OF3nhqKyEEaR
        rviGwlGFQKNvHcLg5fsZtnsQHZx0S6Xr2VeUepc=
X-Google-Smtp-Source: AAOMgpdjnwS3DzrtPw1RdHXYeMSSn4LQ4ujL073i42Wz6yr8lY2k4V0iG7b1tvz3bhzlCA8BEJTMu5atDYeNlwqb3bc=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr2661360itf.121.1533221060209;
 Thu, 02 Aug 2018 07:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180729092759.GA14484@sigill.intra.peff.net> <20180730152756.15012-1-pclouds@gmail.com>
 <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
 <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com> <20180731192931.GD3372@sigill.intra.peff.net>
 <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com> <20180731203746.GA9442@sigill.intra.peff.net>
 <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com> <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Aug 2018 16:43:53 +0200
Message-ID: <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 1, 2018 at 11:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Jeff King <peff@peff.net> writes:
> >
> >>> Presumably we are already in an error codepath, so if it is
> >>> absolutely necessary, then we can issue a lstat() to grab the inum
> >>> for the path we are about to create, iterate over the previously
> >>> checked out paths issuing lstat() and see which one yields the same
> >>> inum, to find the one who is the culprit.
> >>
> >> Yes, this is the cleverness I was missing in my earlier response.
> >>
> >> So it seems do-able, and I like that this incurs no cost in the
> >> non-error case.
> >
> > Not so fast, unfortunately.
> >
> > I suspect that some filesystems do not give us inum that we can use
> > for that "identity" purpose, and they tend to be the ones with the
> > case smashing characteristics where we need this code in the error
> > path the most X-<.
>
> But even if inum is unreliable, we should be able to use other
> clues, perhaps the same set of fields we use for cached stat
> matching optimization we use for "diff" plumbing commands, to
> implement the error report.  The more important part of the idea is
> that we already need to notice that we need to remove a path that is
> in the working tree while doing the checkout, so the alternative
> approach won't incur any extra cost for normal cases where the
> project being checked out does not have two files whose pathnames
> are only different in case (or checking out such an offending
> project to a case sensitive filesytem, of course).
>
> So I guess it still _is_ workable.  Any takers?

OK so we're going back to the original way of checking that we check
out the different files on the same place (because fs is icase) and
try to collect all paths for reporting, yes? I can give it another go
(but of course if anybody else steps up, I'd very gladly hand this
over)
-- 
Duy
