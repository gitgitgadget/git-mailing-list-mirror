Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B032A202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 19:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbdJRT5n (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 15:57:43 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:53614 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdJRT5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 15:57:42 -0400
Received: by mail-qk0-f177.google.com with SMTP id y23so7742873qkb.10
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sIrVX6uXXL6GBHhEqKS4207MiQ+uYcnmdr1vt4K6NPQ=;
        b=W8Ire0B2u4JDHvbEwPFXPx8X6kP2QKO+pJR/+XURRYTMXE6sFHswdtEdl8fzfReYQm
         lyyen3dCz4VQOMk2fz7DZnAe5Bm7oBTzyra0PIunIPSnWFJsFZ8pqIkA6KlgmqAIHA38
         czac/XvgtyePl/XY80MajEQqd7CvrcBwNvavHkAaGv2oWYhTO3PuRAFfZrRqRxyURlYa
         8Wk7Js+aSeos/C801l9SZFfVT3RZtBjofCS+P6/uX7soNRdh/WlpGwYHjGeYsa2hpbac
         nQMl68knZKn212BmnOEZGROTl+gwphdUytWKmy9Vq926CT4fQejFWApg7DC+mxXXGnP+
         bSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sIrVX6uXXL6GBHhEqKS4207MiQ+uYcnmdr1vt4K6NPQ=;
        b=DBcC2uQhx6b/1g3GXl9DDplhYFPBLuSPJjYKL17INKH07UquOsP1g+7H0hcGbCeJFQ
         vZcWFrLr5sF+4lgfibY/bRQPdX5vMw2lnfzScK4CbKEWU2KFvCaYaR2jm9B61ilw9tW6
         FdXX+c64S/vL8y3rcNvSOyz5t9NNH0TNaJlxmxQwT5W1gZVkrmBM2GFV+u2GnvXa1Oza
         D1CxcLeCFjdtFIt3HK1BMB+B/kfRJkb5k9NMfG4Zox9vLpYoYR5GZEigA9XGfmcEO7og
         bFeGpju+GEacQhHt9IrtvRyUWiqMtRS2OYrYhPiU2h3Q7GbvrkZdFWE5Yu3j0uyVAJ5p
         hLLA==
X-Gm-Message-State: AMCzsaVo2Oi7hM8UBuYPMs4fqhoPpY+iZKmp+jCl00+SHAFr/d4+mSiK
        dIY/zwzAcD2y1t6/LUSQVNwp8UNzDjxtKk8PZPprTQ==
X-Google-Smtp-Source: ABhQp+RzgAwaLY8kWu63S7dz7UL/Mc3RxQAznreuykoSHwTXjw8Hv3NeJ6WKM13s3Kd46sEtysdcqj7XSfYoPcdpGkQ=
X-Received: by 10.55.33.203 with SMTP id f72mr4209242qki.176.1508356661983;
 Wed, 18 Oct 2017 12:57:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 18 Oct 2017 12:57:41 -0700 (PDT)
In-Reply-To: <CAC2JkrLR=RUN01AeYGd1YpOPMv=kArm9LWGtMvJ7DS5sz7c3nw@mail.gmail.com>
References: <CAC2JkrLR=RUN01AeYGd1YpOPMv=kArm9LWGtMvJ7DS5sz7c3nw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Oct 2017 12:57:41 -0700
Message-ID: <CAGZ79kZD4gCBcttU8aTAyb0susP3j1BqnF_ad=EfVXbh+ymbgA@mail.gmail.com>
Subject: Re: How can I debug git source code interactively with debugger like gdb?
To:     =?UTF-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 18, 2017 at 12:42 PM, =E5=B0=8F=E5=B7=9D=E6=81=AD=E5=8F=B2 <aiu=
eogawa217@gmail.com> wrote:
> I wanna learn how daily git command works when I run specific git command=
.

1. Obtain the sources and compile Git yourself
    (git clone https://kernel.googlesource.com/pub/scm/git/git
     cd git && make && make install).
   Documentation/* and the Makefile are pretty verbose if you want
   to compile for some non-mainstream hardware or OS.
2. "gdb git" and debug away.
  Note, that some Git commands call other git commands,
  So running the command with "GIT_TRACE=3D1 git <cmd>"
  first may be helpful for diagnosis as well.
  (See the general git man page that has a couple of env vars
   that aid in debugging)

> I wanna know which function is actually called then, how variables
> changes its value, and how some object is stored into database.

For understanding Gits model, it may be easier to read a book, such
as "git from the bottom up" as that conveys the concepts better.

The source code is riddled with handling corner cases, error handling
and other implementation details that are usually not interesting but
rather tedious.

> How can I debug git source code interactively with debugger like gdb?

Also checkout ddd, a graphical frontend of gdb.

Cheers,
Stefan
