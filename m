Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCAAC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 17:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiHVRCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiHVRCB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 13:02:01 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87F3CBE4
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 10:01:59 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4F3161F54E;
        Mon, 22 Aug 2022 17:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1661187719;
        bh=VshFhMmKYQI7IYqjgs7DnVR68NIC0jTtFMbksM8a/d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zfI+lpbJ1waFDeV1z5LQ6BsheyNHLT0p8U43i30ZMrKCj/5UThYaaFHxxtvtH/Tpr
         sa8aEcHbv7QMQC2wMgBSFj1iqNclgeGV5xaFB1ylGEXR0YAIOuyAIGgJNz1v+5G5Bq
         xsxbXoUiUUVZ2thICEgLj3F6nqM9cr/auImsOg5s=
Date:   Mon, 22 Aug 2022 17:01:14 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        meta@public-inbox.org
Subject: Re: `git patch-id --stable' vs quoted-printable
Message-ID: <20220822170114.M247768@dcvr>
References: <20220822022503.M873583@dcvr>
 <xmqqczcsgbvn.fsf@gitster.g>
 <4e3edfa1-9c04-7a63-30ee-65fe6f2de62f@web.de>
 <xmqqmtbwdzbj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmtbwdzbj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> > Am 22.08.22 um 06:06 schrieb Junio C Hamano:
> >> René, do you remember if you used diff.suppressBlankEmpty
> >> configuration when generating the patch in question at:
> >>
> >>     https://public-inbox.org/git/6727daf1-f077-7319-187e-ab4e55de3b2d@web.de/raw
> >>
> >> by the way?
> >
> > I did not use that option.  Attached the copy from my Sent folder, which
> > has spaces at the start of the blank lines in the config.txt hunk.
> 
> Hmph, so I cannot quite explain what removed the leading spaces from
> the copy public-inbox archived.

Both the June 26 message and the latest which arrived directly
in my IMAP inbox (w/o public-inbox) are missing the space in
blank lines, matching what public-inbox.org and lore have.

I don't think postfix, SpamAssassin, or dovecot strip that..

I would expect the blank context lines in the QP version to have
"=20".  I sent this to test@public-inbox.org using
`git send-email --transfer-encoding=quoted-printable' and it
confirms the blank context lines having "=20" which are missing
in René's messages:
https://try.public-inbox.org/test/20220822165736.23246-1-e@80x24.org/raw
