Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA33B1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 17:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbcLIR5E (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 12:57:04 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:32932 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbcLIR5D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 12:57:03 -0500
Received: by mail-qt0-f181.google.com with SMTP id p16so23001292qta.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t9GZx4x1uSJoCodDHW0Xj8zIr4cutt0iUKiECd3u1nU=;
        b=PY3t1yqenDc2YMhl5TSTxUy/jJks2BQTCD8YA1Pwba0O3mHkKaV3lRdINTZGcqy2mW
         UQPT60Id2X1TdXhO3v5pyJoxrk2z7Tzefqj8Vbc1DRtw7k+DhSsLq+uXCYC8cnGJUF1T
         7LQLl6vkNoiTpBF/IUn2pxwoQIWghBykN+ZujI/cSL1pOLHndsTKE4hbEyCxAdm3DtGC
         BzZREEd+0WFkOvhNZmihCnXTdA2qQKAVXLzUyHWOCieyLcCp+a0IzxQgrE80naZGgUs/
         4Zy0imK1tiAkOSMo9eyq4beXbiP2l8RPVV3cvAoTzPaLPQ8tQ+vxpCoTv/S3Al2Ufpn8
         xyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t9GZx4x1uSJoCodDHW0Xj8zIr4cutt0iUKiECd3u1nU=;
        b=mCddmUqzUUnH/dnc7+fZU70Nl+N3f1qqiWsN2qYxKT+XXoQcwJEu2/pOi1PvslALo9
         T1o8BeFp9QIWBu5/miJfPQ+IY7zp2mBd4dVRK8kDVFsYf1qLhB33yoy57znO3yDUEDOn
         qzFEGjCf51/P5ioCaZWKXSTLvKn54tyosWPKxX2jpcRjVWyD2sbTzmTBUljUGF2ZpK36
         vVZSRiflBRViB3UoAFncW7i/Ruzoh1f8q7fSTPym2yZG7CLAdFJ6Aa7sL0jJFB90DoVl
         eGlQVW+wfmYNTg99cHsAdYXFTRG7YCF0w/pahlAhJtQk4OUVHLZGLwmDHkrd2CHXDaYw
         QLsQ==
X-Gm-Message-State: AKaTC02DOU/oH+4fOopZPUnAGLu5fmeDC22jS/fTrQo8sSE5Y+mCxKoUEcvCshr/n2DANGlVITJ01v4UwXH54xku
X-Received: by 10.200.53.9 with SMTP id y9mr68589281qtb.176.1481306222292;
 Fri, 09 Dec 2016 09:57:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Fri, 9 Dec 2016 09:57:01 -0800 (PST)
In-Reply-To: <d10d2b12-4ef1-61e9-0b3c-89aa41c9eeff@jump-ing.de>
References: <d10d2b12-4ef1-61e9-0b3c-89aa41c9eeff@jump-ing.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Dec 2016 09:57:01 -0800
Message-ID: <CAGZ79ka4TRXW7-YY8hqvYz_NJ+dZxtwY6KDSOJ+0cZF4i-J+fA@mail.gmail.com>
Subject: Re: Resend: Gitk: memory consumption improvements
To:     Markus Hitter <mah@jump-ing.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 3:51 AM, Markus Hitter <mah@jump-ing.de> wrote:
>
> It's a month now since I sent three patches to this list for reducing memory consumption of Gitk considerably:
>
> https://public-inbox.org/git/de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de/
> https://public-inbox.org/git/e09a5309-351d-d246-d272-f527f50ad444@jump-ing.de/
> https://public-inbox.org/git/8e1c5923-d2a6-bc77-97ab-3f154b41d2ea@jump-ing.de/
> https://public-inbox.org/git/2cb7f76f-0004-a5b6-79f1-9bb4f979cf14@jump-ing.de/
>
> Everybody cheered, but apparently nobody picked these patches up and applied them to either the Git or Gitk repository. They don't appear in the regular "what's cooking" post either.

The "What's cooking" email is done by Junio (the Git maintainer)
describing the development of Git, whereas gitk is maintained by Paul
if I understand correctly.

If you look at the Git history, the changes to gitk-git/ always come in via
a merge/pull from Paul.

>
> Anything missing? I'd like to put a 'done' checkmark behind this.
>

I'd love to see those patches in use here (via a regular upstream update).

So I guess the way to go for you is to keep bugging Paul for an ack?

Thanks,
Stefan
