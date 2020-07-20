Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CB9C433E1
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E1120702
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="e19WLPma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbgGTRlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:41:42 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:42758 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729907AbgGTRll (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 13:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1595266897; bh=r6Uud07B6HoWlFupORcEGAXiCBFWrtM6Ok1lnb8bD8Y=;
        h=To:Cc:Subject:From:Date:In-Reply-To;
        b=e19WLPmaLM+rZ0j93l+cl6ZQXr+WtTtOoJOpmHBAbdCFYS55KRBkIn4egG5ZCLw1V
         0ZRB2w7Yoli7eXpl2YjalypxYnQ4fxahv3clxbwIsH1foguviIwnZhc5iQTv8ICqsN
         9Aw1tUkTg5vkSsd2kb5pZzJlzV8JKd/+MqGJM3q0=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
To:     "Jeff King" <peff@peff.net>
Cc:     "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-send-email: die if sendmail.* config is set
From:   "Drew DeVault" <sir@cmpwn.com>
Date:   Mon, 20 Jul 2020 13:40:51 -0400
Message-Id: <C4BMWIIK892D.25HUQKV9F98T6@homura>
In-Reply-To: <20200720173336.GC2045458@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Jul 20, 2020 at 9:33 AM EDT, Jeff King wrote:
> This basically claims the "sendmail.*" namespace for send-email. Not
> strictly, but if we're going to warn about anything set in it, it
> effectively shuts out other uses.

The revised patch (v3 now) is less strict and offers an escape hatch via
sendmail.forbidSendmailVariables. I'd prefer that over making sendmail.*
just werk.
