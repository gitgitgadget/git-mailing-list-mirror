Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41BB91FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760595AbdACSre (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:47:34 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33223 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760598AbdACSrc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:47:32 -0500
Received: by mail-qk0-f175.google.com with SMTP id t184so384466841qkd.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kj3GjT1eRcHGJ7SAeuhyUkeVCTh66VelcAvgMwV6hSY=;
        b=qe2YBzwxV13NFIYzs19PR/vBOrEDj1aBOCEQAuncOVRV9Gzttw0uCqaemLkgiJmAvY
         2WdumMlKaUFkXCXV7VXSx9agdEmceEHV23fuJSvW58XVhR4nIfD13tvkqqh6y95CCBM2
         h3eDp67NWB0u/2KEL140jqHvEZ3gVTvm9vvFVGQtKyZyIJlp1KODAORNtu/0OaUBzxeG
         WBHKTVqEHnH+4l7M3Ky9dvOhQ1GNHC4UR0fZzqX24UegiaTtEj+MsEEU258SMV53SRtr
         /awhw9z7Rwmg48Opa4K3m77kn/mc/7JCQZlANHXZadJ1PGkfAI9jPBeCZJtF66AZXVAv
         0nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kj3GjT1eRcHGJ7SAeuhyUkeVCTh66VelcAvgMwV6hSY=;
        b=QqlJ9e0pqW0GbNU2eUv534VB8E8gyN76rsA3sOEE0g++q2gRhryalNFCfBAd27kykA
         ZIDDEuXrHnwJcmH2zO+y1XaqexpBvMw0TD2l3BIjJt/b6bW3X09Kmiz6s1DhaPhk+uXy
         2y4Y+SEAZ/Kz4JJEB+epFEHENEZX/fZiPJOH75OfuSN3bTVrRsxRmhGSu0mEen2bedRF
         LW6mS68NC95EUc95J4Xgna/1GXODOFZ81u8pZM7EMEYlZIC3pRxJST/aMy5Ky4Qzv8ma
         uurhbxaiG9hH6B46KcoQnTQJm9FWGygmDQ9ciPVXoeE8v830psY60SmDrXNrLP8hg114
         foDg==
X-Gm-Message-State: AIkVDXJ7HvVAMzDII5lH8wmPXljQcllA2RcQmVoPrC8i9zK2TyF2fABjARttX0x9Q+fK7fF7CGqUpT45EFKSNhGz
X-Received: by 10.55.90.68 with SMTP id o65mr29076521qkb.47.1483469243504;
 Tue, 03 Jan 2017 10:47:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 3 Jan 2017 10:47:23 -0800 (PST)
In-Reply-To: <CAGf+dSjM9nuroeSM9mkQmO3ho4XcZhLo1CR76q-jbeQ-WNGG+Q@mail.gmail.com>
References: <CAGf+dShpkPvsC8wQN6mWmYeMZ3=i-ZOzDNSM1aa0rinKW6+-+g@mail.gmail.com>
 <alpine.DEB.2.20.1701021712010.3469@virtualbox> <CAGf+dSjM9nuroeSM9mkQmO3ho4XcZhLo1CR76q-jbeQ-WNGG+Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Jan 2017 10:47:23 -0800
Message-ID: <CAGZ79kaMnFUefiMagU82euxjeQdnc9KdgSwyDvkDp--QT-MbCA@mail.gmail.com>
Subject: Re: builtin difftool parsing issue
To:     Paul Sbarra <sbarra.paul@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 2, 2017 at 11:05 AM, Paul Sbarra <sbarra.paul@gmail.com> wrote:
>> I would have expected `git difftool --submodule=diff ...` to work... What
>> are the problems?
>
> The docs for difftool state...
> "git difftool is a frontend to git diff and accepts the same options
> and arguments."

I think such a sentence in the man page is dangerous, as nobody
was caught this issue until now. There have been numerous authors
and reviewers that touched "diff --submodule=<format>, but as there
is no back-reference, hinting that the patch is only half done, and the
difftool also needs to implement such an option.

We should reword the man page either as

  "git difftool is a frontend to git diff and accepts the most(?) options
  and arguments."

or even be explicit and list the arguments instead. There we could also
describe differences if any (e.g. the formats available might be different
for --submodule=<format>)
