Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC101EB64DD
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 22:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGPWvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jul 2023 18:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPWvj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2023 18:51:39 -0400
Received: from mail.nicholasjohnson.ch (mail.nicholasjohnson.ch [93.95.231.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AB41BE
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 15:51:35 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nicholasjohnson.ch;
        s=dkim1; t=1689547892;
        bh=chsuyUYVgt0gIoJozB586qIz5APRKBeRNjs0V41PsBI=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=aBZCq+eDVBbNdYm7Od6o593cG4E737BC4d4Mjl+AnB/n0yvWzPMwmZasr6oHpWudA
         xwzNjwL9goHVtcmDoThrMVsuLc2MVobdgP/948+balWwKLylas+u6ykT3e4jcIknH4
         NPcKcbpjrWbvDdiDEqxHJFiUmH0FUE0PhAZbtIOgvFzDcl7WOJBzPaytog7XVF8KsP
         CfIXb/0GEbH9MmwjCBR+Tbm4rqo237zxPJ2nTNs/r3PU5lTLBiedh5wqHsnr7bQCtl
         lVjAY7eC4IarWPcrere9Olar141e8p7Ddh7s7XhewR6YgITUhcQSCJj5p1xt4ThNF+
         VtB1GeWJRiAtA==
Date:   Sun, 16 Jul 2023 22:52:09 +0000
Cc:     <git@vger.kernel.org>
Subject: Re: Git Privacy
From:   "nick" <nick@nicholasjohnson.ch>
To:     =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Junio C Hamano" <gitster@pobox.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <CU3SS0F0GOWY.1UEU7MOUEGUKZ@anonymous>
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
 <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
 <xmqqbkgeqw6n.fsf@gitster.g> <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
 <1d36d5ce-f452-fc31-6e30-b4ba819de7e4@web.de>
In-Reply-To: <1d36d5ce-f452-fc31-6e30-b4ba819de7e4@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe wrote:
> schrieb nick:
> > Git leaks private information about developers publicly by design
> > through its precise timestamps. You mentioned this makes it easier to
> > deny copyright claims, but one could get more or less the same benefit
> > without sacrificing privacy by rounding commit times to the nearest day=
.
> > I'm not advocating making this behavior the default, just that
> > developers be given the option to do it.
>
> I get it to some extent: timezone and timestamps are personal data,
> which may only be collected and processed for a lawful purpose according =
to
> the GDPR.

> But Git is not a legal entity, it's just a command line program that you,
> the data subject, control.

As far as I know and I'm not a lawyer either, there are no legal issues
related to this. To be clear, my argument is more a moral one, not a
legal one.

> So I see this more as a usability issue. Git allows its users to tailor
> commits to suit their needs in many ways. You can edit file contents,
> history and metadata. For timestamp and timezone this isn't as
> convenient as it could be. If git commit has a --signoff option that
> can be enabled by default then adding config options for controlling
> timestamp granularity is hard to say no to.

You're right that usability is not as good as it could be for those who
want more privacy.

Many of the i2p devs are known only under pseudonyms. They definitely
don't want their timezones leaked while developing i2p. I imagine that
they have other repos that they develop non-anonymously. They could
create a separate shell alias for Git with coarse-grained timestamps and
no timezone, but it would still require a lot of mental bookkeeping to
remember to use the alias every time. A single mistake would leak their
timezone.

Git could solve this by offering a per-repo option that controls
timestamp granularity.
