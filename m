Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9EB20986
	for <e@80x24.org>; Mon,  3 Oct 2016 10:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbcJCKhB (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 06:37:01 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36140 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbcJCKhA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 06:37:00 -0400
Received: by mail-it0-f51.google.com with SMTP id 188so30200214iti.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HpblyuRZhBcyu5MuL/nha3UDmmClDBQPn6cUvseiNTU=;
        b=tu+HJEIyK501Ekb0PvUMakr7cvqXry11+emY41G5iaEmMrttp7JmXoTVYIfKa47RPj
         u1x046pUs3Y8p2aTGgrPeSfyAd72PsgT6sP4pvwgeV1QBamfzJOvu7blEVl0uZ0u1TBO
         dQt7Z63bQn19r+4dhxmm8CN6Gv/MIA1W86KtJ0nOBCks88fH+X0iXWip09L2hyOxqe4w
         7UyoGfIMjJZN0GFQwdNaSTKrSk7qdlLRMXVwixRunW2kxYuhS0Ok2DtgJ1vj1wOmDw/1
         DpoTOtTKiK5z+e2z8Irpp8/VwwidSDt4mIMyFqn94C/CfgBmUYbNv+6rrXalM0fXR2X/
         9Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HpblyuRZhBcyu5MuL/nha3UDmmClDBQPn6cUvseiNTU=;
        b=RXmLuqtHr8gKKhROD2lQiNanpsD/IUOGtVO/FiLqXXvcdQz6BKP3/d/NduurF26G0a
         7PjeMj3UR18mzTsgxjMs4PNEZAonSSfA/Iqi17EF20GoxoGXY9l1HF03V8VFJtVwUCZj
         MtzjZYFcM714PdQUbu1Dqfrsri8lN+3dcYuH3MNgcqKK8PXSXqRQO6bbwPxFloumQspR
         C5jcwC/qr6sWrJw+YXm3HY66Rm9I87MdpvgaylLYqx5rqomftxfUas4To3IwD/uf6p/x
         ZD7m6eGQYwkIfB4YePfyOKYZzcZWRL+jmw6PzQOrz4agvEZdVAFqPTDRbI1HGMveghfM
         t1bQ==
X-Gm-Message-State: AA6/9RlNq4pSfwbHVV2/cBkCvuZKOOx86cRsYkiA9m/ioDPDp3Ty4imym+/x/H7e8UH2BqcImb9AILDGJ8/8mg==
X-Received: by 10.36.131.10 with SMTP id d10mr5460248ite.3.1475491019211; Mon,
 03 Oct 2016 03:36:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Mon, 3 Oct 2016 03:36:28 -0700 (PDT)
In-Reply-To: <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com>
References: <20160928114348.1470-1-pclouds@gmail.com> <20160928114348.1470-2-pclouds@gmail.com>
 <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 3 Oct 2016 17:36:28 +0700
Message-ID: <CACsJy8D28iq3r3O_uzjyyJT--KQunAySRgUthF3FMrb1VM6XKw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Resurrect "diff-lib.c: adjust position of i-t-a
 entries in diff"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 2:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> After reading the three patches through, however, I do not think we
> use the command line option anywhere.  I'm inclined to say that we
> shouldn't add it at all.  Or at least do so in a separate follow-up
> patch "now we have an internal mechanism, let's expose it anyway" at
> the end.  Which means that the last sentence in my attempted rewrite
> should go.

We don't use it internally _yet_. I need to go through all the
external diff code and see --shift-ita should be there. The end goal
is still changing the default behavior and getting rid of --shift-ita,
after making sure we don't break stuff. I do use it though because
"git diff" is more often run in my workflow than "git status".

> As I already said, --shift-ita is not quite descriptive and I think
> it should be renamed to something else, but I kept that in the
> following attempt to rewrite:

It's meant to be a temporary thing (which could last a year or three,
depending on how fast I scan through the code base) so I didn't give
much thought on naming.

Umm... after a couple of minutes, I still couldn't think of any
better. The one-line summary of this change is "correct the position
of intent-to-add entries in diff", or as you put it more precisely
(with a bit paraphrasing), "make ita entries not exist in index". I
don't see any good way to shorten that to one or two words.
--ita-not-in-index good enough? Or maybe --[no-]ita-visible-in-index.
-- 
Duy
