Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0B4C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 07:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9B66117A
	for <git@archiver.kernel.org>; Mon, 17 May 2021 07:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhEQHVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 03:21:15 -0400
Received: from coleridge.oriole.systems ([89.238.76.34]:49584 "EHLO
        coleridge.oriole.systems" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhEQHVP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 03:21:15 -0400
Date:   Mon, 17 May 2021 09:19:50 +0200
From:   Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rev-parse: fix segfault with missing --path-format
 argument
Message-ID: <20210517071950.lhj5tmvfj4vxmpkr@nabokov.fritz.box>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20210516120449.661636-1-wolf@oriole.systems>
 <xmqqsg2m6dsi.fsf@gitster.g>
 <20210516143156.mauc2ukryx5j2e2r@nabokov.fritz.box>
 <xmqqk0ny5oi1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0ny5oi1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-17 06:59, Junio C Hamano wrote:

> >> We do have untranslated die() nearby for the same option, which may
> >> want to be cleaned up either in a preliminary patch, or in this
> >> same patch as an unrelated fix "while we are at it".
> >
> > I would not mind preparing a preliminary patch that cleans up all
> > untranslated user-facing calls to die(). My editor finds 15 of those
> > in rev-parse.c, and I think they all qualify.
> >
> > If you'd rather not touch unrelated code paths I'll instead include
> > it in v2 as an unrelated fix in the same commit.
> 
> I am puzzled by the last paragraph.  Somebody who does not want to see
> "unrelated" codepaths touched would appreciate if a commit that fixes
> this segfault does not touch them at the same time.

Apologies, I was being unclear here. I was meaning to offer either
cleaning up all calls to die() in a separate patch, or fixing only the
nearby occurrence that you mentioned in the same patch. I had implicitly
assumed you had seen the other untranslated messages already but only
wanted to fix the one for the same option (ie in a nearby, "related"
path).

> In any case, I now counted existing die() messages in this file, and
> among 15 of them, only 1 is marked with _(...).  I think that it
> is the best to apply the patch as-is (without _(...)), adding one
> untranslated message to the file.

Will do.

> Then, on top of this change, the 15 untranslated messages can be
> marked with _(...) a separate commit (and it does not even have to
> be done by you).

I don't mind doing this, so I'll include it.

> That's good, too.  Simple.
> 
> Thanks.

Thanks a lot for your feedback, I'll be sending v2 along shortly.

-- 
Wolfgang
