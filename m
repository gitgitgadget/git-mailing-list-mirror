Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C07A202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 19:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbdCHTEo (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 14:04:44 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36232 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752998AbdCHTEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 14:04:09 -0500
Received: by mail-pf0-f179.google.com with SMTP id o126so18275158pfb.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 11:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jp7uSZjNBAv6qFI6zHq8c/9Zhty5Xvl2I8QdQtDmRcA=;
        b=SIgEENCWgHuxjaw19TwR4lS1LBTqVeVORqy2LdwqNs+blW88dnp8BWgYPTMfaq/ndz
         bIrIH38Wlv3p0wt8vW4iGVvL2awlzobz9tt8a1IEKLrEbMGJKLBv8AqHild7lEqjcjUS
         GdPRC5g2FZqW1KXtrRUB+v57yOwRV9RA76EM5JdmpdsuxSRS+NaLww0MggQiSkn+TW4v
         bUV5/Gz5xVftvzJFaLybQcmZxnsf4roh5zoHpp5412UqTeFX1m5yp6qofcnUMRynqEd7
         Amx3cuorLOhsjMAM4wNvlb9Vnt+8PQ6DT3ro1xPDvEtAgL939x+kpX7iqqVILEAkjIua
         o5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jp7uSZjNBAv6qFI6zHq8c/9Zhty5Xvl2I8QdQtDmRcA=;
        b=lB9oI3bdVnUssni1dGIBm3aDrjdMlcVVtuz/OOw+rB7TUe4hew2991oC2ON9IjMZZ9
         bCC6egH3E3xdw6qMP0+Uv7eRMh61aDstp0cYcTxjPbgya8lHjPsYGDOws6GwZE0iDEZl
         4Z/AkJUn6jV1AFyldbbKG2qtVKXgyzHuZXFjOkHoP33FHBvUjnKrETsvy6B2JqQlVn71
         obGj7KXI94FAe+HEPjKpajrxuEk/hVYxkuTbx5Y34y4UkPYIB5VKlV035NUF7O1nY2lV
         /xUGx3I6pNZtlk9N2bhYIO2VUvrDAJnU0MJvC6tvDY5INNuLydzbYeFYTHFW1/2ZEQHO
         omDQ==
X-Gm-Message-State: AMke39mpZi+MrtVLMfsXbDwe3XYujKiQKN0Bp4aJsRLU5DJlRN5MpUh+bozMzttNlRTK7wjk7iJp5exmuxtvGwOw
X-Received: by 10.98.198.78 with SMTP id m75mr9075351pfg.160.1488999847903;
 Wed, 08 Mar 2017 11:04:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 8 Mar 2017 11:04:07 -0800 (PST)
In-Reply-To: <CAHGBnuPGPcWwbrZX_92XDJu47bpH=kj2PZ7yWHK=MRfZ_RHXrQ@mail.gmail.com>
References: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
 <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net> <CAHGBnuM3iM-kHdxdox_1i56uLbv7gQ5ZUY9Xqf4BG7G_kTf+jQ@mail.gmail.com>
 <20170308140110.wgdedquqwm75zws2@sigill.intra.peff.net> <CAHGBnuPGPcWwbrZX_92XDJu47bpH=kj2PZ7yWHK=MRfZ_RHXrQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Mar 2017 11:04:07 -0800
Message-ID: <CAGZ79kbwMhL-ZnL-iYwPH=tWa8cNQbEGOYYQBw6OzFCMhOWE-w@mail.gmail.com>
Subject: Re: diff.ignoreSubmoudles config setting broken?
To:     Sebastian Schuberth <sschuberth@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 7:07 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
>
> + Jens
>

+ Jacob Keller, who touched submodule diff display code last.
(I am thinking of fd47ae6a, diff: teach diff to display submodule
difference with an inline diff, 2016-08-31), which is first release as
part of v2.11.0 (that would fit your observance)
