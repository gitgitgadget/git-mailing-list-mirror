Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2562BC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 01:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B7B20848
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 01:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="YezX2tJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgH1BMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:12:15 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:48236 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbgH1BMM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 21:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598577131; bh=b7O0+8noj5MHlaV1mQNE2lf0pURdk5XJHTxkFCqRdMg=;
        h=Subject:From:To:Cc:Date:In-Reply-To;
        b=YezX2tJet/RgrZT/3cHbiIvGB86wWRsAntoMien7SYTjgsR6wu3rqTIt7eHWr+yIf
         lM8ZodFtBKxdwpbvXSKjeOuUumjiw0DLnI+Rz0jqcL17akNASMBcyQmf74yqTRrTi4
         O94bO3QBmQTuoJPj8XXviWtWqd+MsiwgWo3uiCCU=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        <git@vger.kernel.org>
Date:   Thu, 27 Aug 2020 21:10:41 -0400
Message-Id: <C5889MKRLCLQ.38RAZT2KCK6Q9@homura>
In-Reply-To: <xmqqsgc7oa5s.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 27, 2020 at 9:02 PM EDT, Junio C Hamano wrote:
> The minority who wants to use an updated behaviour can just set the
> configuration once and the problem is behind them. The minority who
> wants to keep the current behaviour do not have to do anything. And
> there is no impact to the majority of people either way.

Eh, this would defeat the purpose. I hate the multi-cycle
compatibility-breaking dance as much as the next guy, but the whole
reason I'm here is to solve a real problem which noobs are encountering.
I on-board a lot of people with git-send-email and I've heard questions
and confusions over this prompt at least 10 times in the past few years.
Compatibility breakage is annoying but this is a real problem which real
users are having real difficulty with, and the demographic of affected
user may be particularly ill-equipped to deal with it on their own.
