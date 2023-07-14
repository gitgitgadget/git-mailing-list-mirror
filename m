Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108E0EB64DA
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 09:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjGNJWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 05:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjGNJWO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 05:22:14 -0400
Received: from mail.nicholasjohnson.ch (mail.nicholasjohnson.ch [93.95.231.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E62D53
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 02:22:11 -0700 (PDT)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nicholasjohnson.ch;
        s=dkim1; t=1689326529;
        bh=DXHibHLQkqyQH7n7dFxNLvRzZC4CGfFMmACTr3zKAlo=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=dMbIJI24mtxYga4sbGShVqVUuBIYLU6XI4bKTi2FT1XqB+FY/yu1ollH7oro8u+uO
         tQCl6v0DWGTGLAfoLs35EzR1+yHFQgwsCiub/k5VjfzaV0lCxnlT3o2Fiy6dKwgclH
         A8FzwoCdeE/0G9HgmOr8cuj98h+tSs71lkyHICfBoxvrcnLlD9p8AJAdsz+02DEeeH
         QdtCmYkrDwBwKNTZyw3flxYcfdh0zKcMRxlI9q1kEHZbKbLt89Q65G/QNUigA7ogp7
         g9MLJT05doMosAzTq83VqH5SRlNe5ZSwUfyuwQj5EhCKoX6/vvJ15lyiD9tGzPiNf5
         Km1sSoxa1IA4w==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 14 Jul 2023 09:22:44 +0000
Message-Id: <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
Cc:     <git@vger.kernel.org>
Subject: Re: Git Privacy
From:   "nick" <nick@nicholasjohnson.ch>
To:     "Junio C Hamano" <gitster@pobox.com>
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
 <xmqqlefjpwif.fsf@gitster.g>
In-Reply-To: <xmqqlefjpwif.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "nick" <nick@nicholasjohnson.ch> writes:
>
> > hooks. Perhaps a config option to automatically set the date to a time
> > before Git was invented?
>
> [...] I am not yet convinced that it is worth the engineering effort
> for this project to review, accept and maintain changes to implement
> it.

Upon further thought, given that it's already pretty easy to accomplish
timestamp obfuscation, albeit clumsy, I concede that it may not be worth
the engineering effort to implement my original suggestion. So I'll drop
it.

However, I think it is worth the effort for the time zones. Is there any
reason Git doesn't automatically convert local time to UTC in timestamps
to prevent leaking the developer's time zone?

It seems like a simple change that would be good for the developer's
privacy without harming Git in any way. It would also be easy to
implement as backwards-compatible.

I've been told this idea was already mentioned, but it has been ignored
for some time:

https://git.issues.gerritcodereview.com/issues/40000039

The sooner it's addressed, the better since it means less personal
information leakage.

> After all, if you leave series of commits that stress the fact that
> you not just fail to keep, but do deliberately avoid to keep, a
> reliable record of when you made your changes, half the value of
> keeping your work in source code management system vanishes. When
> somebody comes to your project and says certain parts of your code
> were stolen from their proprietary IP, wouldn't you rather be able
> to produce the record of who did what at which time to refute their
> claim by showing that your project members invented the code long
> before they claim they were stolen from them?

Thank you for bringing this up. This was not an angle I considered when
writing my repo git-privacy, but now I'll definitely warn about it there.

Your feedback above would not apply to the UTC time zone proposal I
linked to though. There is a good reason to implement it and, as far as
I can think of, no reason not to.
