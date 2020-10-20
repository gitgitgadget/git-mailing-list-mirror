Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D25C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 23:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BCE22240
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 23:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="aS7phG3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410475AbgJTXEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 19:04:55 -0400
Received: from pine.sfconservancy.org ([162.242.171.33]:38816 "EHLO
        pine.sfconservancy.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410466AbgJTXEz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 19:04:55 -0400
Received: from localhost (unknown [216.161.86.19])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 9457EE281;
        Tue, 20 Oct 2020 23:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603235094;
        bh=uKNxshCGeOmp09EjN8ulJZ8pQYJdhkMow4DJ8P7XDaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aS7phG3eoTomnFVnKtVtVwqKpfSRYa+KvwRKUDj7+tM8Ks9bgSr+IpjDK6ZpVwQuh
         ikpVMGXRengLarUZL/hL+yO12Zo8ZOVU9J2VtNjkzMnl8m/BCClewReFu+/lIHmnKq
         IVKcbN+2YxSMyzECOXz1WDs2fAYBA6Esn3ct4E0mhd7gdRl3X/GLBHss3/RpU/ukfp
         5FEdUqUnLeIQpDRII4X9eTEnH6Tz0cvEpCQo4Odb8eYsBQ9uodu01ffsidIqI/0YzN
         I/rSuxgVpEfj9BORxnC5MWMnxsRc5DbZvm9F97qjI2ffsqsZDtaqnRLga1wcxffW6/
         gfrylozw8SEuQ==
Date:   Tue, 20 Oct 2020 16:02:15 -0700
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clarify meaning of --signoff & related doc
 improvements in describing Signed-off-by
Message-ID: <20201020230215.GA1404613@ebb.org>
References: <20201018233136.GA4204@nand.local>
 <20201018194912.2716372-1-gitster@pobox.com>
 <xmqqmu0it6ls.fsf@gitster.c.googlers.com>
 <cover.1603142543.git.bkuhn@sfconservancy.org>
 <37a4932d48c1d36c3c512e9f8c0bcac878de6b76.1603142543.git.bkuhn@sfconservancy.org>
 <20201019220214.GB49623@nand.local>
 <cover.1603155607.git.bkuhn@sfconservancy.org>
 <20201020023407.GB54484@nand.local>
 <20201020212820.GA1368742@ebb.org>
 <xmqq7drka6ya.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7drka6ya.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "Bradley M. Kuhn" <bkuhn@sfconservancy.org> writes:
> > I wasn't sure what I should be doing with the patch set once it was already
> > in 'seen'.

Junio C Hamano wrote:
> Being 'seen' is an indication that it has been seen and does not mean
> anything more than that.

Documentation/SubmittingPatches says:
> >>> `git pull --rebase` will automatically skip already-applied patches, and
> >>> will let you know. This works only if you rebase on top of the branch in
> >>> which your patch has been merged (i.e. it will not tell you if your patch
> >>> is merged in `seen` if you rebase on top of master).

> This is talking about a fairly mature topic that has already been in 'next'
> and was on the course to graduate to 'master'.  The topic would eventually
> be in 'master', and at that point "pull --rebase" would notice that the
> patches are no longer needed (or were merged in a different form).  But
> that does not apply to topics that are not in 'master' yet.

Junio, thanks for your detailed reply.  I have a couple ideas of some
minor changes to SubmittingPatches that would have made what you said clearer
to me when I was doing my first patch.  I'll think about it some and send
something along, but probably won't get to it until next month (but it
doesn't seem urgent).

Taylor wrote: 

>>> Since 'seen' is a convenience branch that contains the current state
>>>  of the in-flight topics, it is subject to be changed and rebuilt
>>>  multiple times (c.f., link:howto/maintain-git) so the presence of your
>>>  patches in 'seen' (but not 'next' or 'master') should not affect your
>>>  workflow.

I'll hold on to this text as a possibility, to start from when I dig
into the proposals above.  Thanks!
--
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter
