Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941F9C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 05:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD022075E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 05:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="OZffOI4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHUFjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 01:39:52 -0400
Received: from out1.migadu.com ([91.121.223.63]:32384 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgHUFjv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 01:39:51 -0400
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1597988389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=tG2nrdxnaYvf04sqOeLIVbIj3fpERBB5bMF2e5vFxRs=;
        b=OZffOI4XdmKeXwWeWdk04zMXZz+7E8A6vxoybCd6NyKmb1YyNfDcdGzfDpYN8tg7qtHGeN
        9SkabfYGzPZaIu6b8MuIS+fq0/M3EX52tRI4o0ppFN7WWia9jTjsrKfJrReQqz8NSoDZ6T
        ioHPscRrFHH/52dr46kmo+rerDpyxdw=
Content-Type: text/plain; charset=UTF-8
Cc:     "Phillip Wood" <phillip.wood123@gmail.com>
Subject: Re: git add intent-to-add then git add patch no longer allows edit
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Thomas Sullivan" <tom@msbit.com.au>, <git@vger.kernel.org>
Date:   Fri, 21 Aug 2020 01:25:41 -0400
Message-Id: <C52FB27V04G0.2ML0PLGDE71MG@ziyou.local>
In-Reply-To: <CAB+jsAW_+NTJjDLG9uMrf4cc5rcwHLD5kTLk7QgvFCgryb22Gw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I fixed half of this in a topic that's on master now (it errors out
entirely if you try to stage it at all in 2.28.0), but new file diffs
still aren't splittable into hunks. Phillip Wood (on cc) is looking into
that; the tricky part is that when split into hunks only the first hunk
actually staged can be a "new file" patch.
