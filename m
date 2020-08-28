Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D0EC433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 01:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5C820848
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 01:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="nkOfuY9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgH1Bx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:53:58 -0400
Received: from out0.migadu.com ([94.23.1.103]:37382 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH1Bx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 21:53:58 -0400
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1598579636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=b8qgfxXSHbUdJyNt/0cACty4EdTSKU5+9ZxOuRGiBiw=;
        b=nkOfuY9TtDXI75gzRMzvGOnFOUoQFgZuR9hRfo0iifUFD0dTkJAqWULtQzqPRgz8qk4sTz
        bI0CH+NsZ9EIJk8cnZ3Uo/Ih0kIBsxcG/K/NHPndYx9TvAX07oYKHFt2Reu15dp9yIBq9i
        5KS/b0EGYA/UtSEf4lhp+Nt25LzwZbI=
Content-Type: text/plain; charset=UTF-8
Cc:     =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Drew DeVault" <sir@cmpwn.com>
Date:   Thu, 27 Aug 2020 21:44:11 -0400
Message-Id: <C588ZA2QAFBS.23DYVMBK3E0X6@ziyou.local>
In-Reply-To: <xmqqsgc7oa5s.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 27, 2020 at 9:02 PM EDT, Junio C Hamano wrote:
> I agree that it is likely that only very small population even gets
> bittn by this "in-reply-to gets prompted" issue, because it is
> unlikely for users not to give "to:" address in one way or another
> and let the prompt logic to ask them.

The merits of this thread's proposal aside, send-email's prompting has
always seemed half-baked to me - it often doesn't even show up, and
doesn't prompt for some things that would be useful like additional CCs
(and if you're setting In-Reply-To, there are probably additional CCs).

The prompts have helped me not flub emails before, but arguably that's
not good since they're often not even shown and someone may come to rely
on their presence only to later accidentally turn them off.

Anyway, it's worth noting that, because the prompts *do* exist,
half-baked as they are, it's not really safe to assume that nobody sees
them. There might be a sizable population out there never specifying
"--to" because they know they'll be prompted for it.
