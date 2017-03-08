Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F4520135
	for <e@80x24.org>; Wed,  8 Mar 2017 22:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754534AbdCHW21 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 17:28:27 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34276 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754523AbdCHW2X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 17:28:23 -0500
Received: by mail-lf0-f49.google.com with SMTP id k202so20762441lfe.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 14:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+QoWRX7bC3RgFAM5yx64WsSgv6hx8W7jLt17/mFEKNE=;
        b=mPNWWerOwrtUgcUfl8nF79ya6M7EflH6HRouUqjo1mf0ZzvNpHVyta8wlgEpf9Ewtj
         iFWO3Uu83RS32tLIVCxd/K4EcmFkpT4yXn96n3umEBSsJbuo6umbtakUfNkjUsrzy/WW
         Tf0rUNNbsZwoGaohvLF93gTCTBm7FNflKvV6iuODOhXIhuvPx8oL2TmJonsQev0fOSwV
         7JnfRWiWEJ0qGPKwwZLh8JE7hOg3fycZxtDKcZt+eNdYRyQuPrz/nHvd63B63hGkIosF
         LbjLqtTDvvB6bGS8e95CGOUopqqE+IV7i9Mcr6rk3WyD6+UWu6XHuNCTPI8SGFGJmpnY
         YIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+QoWRX7bC3RgFAM5yx64WsSgv6hx8W7jLt17/mFEKNE=;
        b=DH4cw9STvUjZ36522TZ+lIFdTsbtHTbT0U3XgccclrItkJV6OlAVPCULbwFPzuTdY3
         9Vwl0XQG6scYK1kJtf6SA8s2CAVd3QNjvy0YXjvtZMS08lI4x8Sen9GAKIEsrjSYaqMS
         adajQjwNNMkuYfaEZEPkTsSIc33apWBdxPBThpmcOWQFNKnGNXyDFJsbJVXrOKhcBbLj
         rM954D3GLkWLs0fz7zPmgQfk4Zv08Rx2tpOOAoWywzxlz35op+tJAEBJAaP0mh6b/kyp
         Inf49qDXqYCJvlTv6WzPsalsWSWFb4qYDKrWFzVE7+IMeFEgDiEmWpJNvcc4V/RVgCbn
         Ic+Q==
X-Gm-Message-State: AMke39lZBxDQBXRma3yo2YymsfF4LWiHKRIVyevT/cgIZ95Mgb3Ho9NwRxF6OoyWZybYFIGTNZt/NjG8JFQV6g==
X-Received: by 10.46.32.193 with SMTP id g62mr2771021lji.119.1489012092352;
 Wed, 08 Mar 2017 14:28:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Wed, 8 Mar 2017 14:27:51 -0800 (PST)
In-Reply-To: <CAGZ79kbwMhL-ZnL-iYwPH=tWa8cNQbEGOYYQBw6OzFCMhOWE-w@mail.gmail.com>
References: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
 <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net> <CAHGBnuM3iM-kHdxdox_1i56uLbv7gQ5ZUY9Xqf4BG7G_kTf+jQ@mail.gmail.com>
 <20170308140110.wgdedquqwm75zws2@sigill.intra.peff.net> <CAHGBnuPGPcWwbrZX_92XDJu47bpH=kj2PZ7yWHK=MRfZ_RHXrQ@mail.gmail.com>
 <CAGZ79kbwMhL-ZnL-iYwPH=tWa8cNQbEGOYYQBw6OzFCMhOWE-w@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 8 Mar 2017 14:27:51 -0800
Message-ID: <CA+P7+xp1nbXGAq_KfLpMeMbQEXMuA7oVSTPzY+ZhPKv4_9K2DQ@mail.gmail.com>
Subject: Re: diff.ignoreSubmoudles config setting broken?
To:     Stefan Beller <sbeller@google.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 11:04 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Mar 8, 2017 at 7:07 AM, Sebastian Schuberth
> <sschuberth@gmail.com> wrote:
>>
>> + Jens
>>
>
> + Jacob Keller, who touched submodule diff display code last.
> (I am thinking of fd47ae6a, diff: teach diff to display submodule
> difference with an inline diff, 2016-08-31), which is first release as
> part of v2.11.0 (that would fit your observance)

I don't remember doing anything with ignoreSubmodules, but it's
possible I broke it...

-Jake
