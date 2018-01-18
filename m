Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C2D1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 22:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbeARWuW (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:50:22 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:39697 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeARWuU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 17:50:20 -0500
Received: by mail-yw0-f193.google.com with SMTP id v196so820172ywc.6
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 14:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/RI6svJ5AwtS/88khot5qrzq/WG9qmzThME4PPZ/zFw=;
        b=Ob3dtDAyKb0iDXnStHywZOPiTYEiOIDK7UBuZWQ0mZtF3kHzL5oMvHQyOMC2qfs/Kd
         avTMu45TloikW2uRuaxDozpr9IvU5IRnfi48sNelNhcBEpnhRQ+jabDFEYc/fIn+4ui2
         WZM1SD2lvWaVj65t/65YypcmJDG4dkQgPHCe/NCLUsvytUXaSxtuqffJXr62oh85Qxzg
         Ki3bZoY3W8DDbEqk1wZihqtX5grNLzCMR/HovuV+oruiZB99m3+Sh3bk5RCKYFZTNUyU
         q8iXQTuE6tEuOZiGs3IKU/o9BZrszXShXezExW8WKNEbiXcQwMwu0Tg0oki0sM5mWJZr
         gAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/RI6svJ5AwtS/88khot5qrzq/WG9qmzThME4PPZ/zFw=;
        b=grHSle+4uCJABF+3L2oC6uiCsAj7lPBnPMNqtcTbPEO/RvVyPi8Tuv+zEefmChKTLJ
         sosciI337NB4do8YcJjQc2VjdQcyXcQAd3mkWgkKAxR9OTdQg4K3B4oUG7FtsGsvjBoD
         kSn2TCn408pRfMSDPWfNI6VW1elYofUyowA+YhF7r7VxVtw5qMGmy1c8RMNXvf172a+5
         2wkTtk21qQJVU5UiOwQC+ZJlM5K7kkWmU3JOXP/2pmKbCx70gnpP5aHGVzwMAVovfZrN
         LLFedutaLrAzZV+gR2By2U5Ww/MUSFAvDpacMOu0Iy9qPURA7ehVaXqvPKYNALBS+T0B
         ccZg==
X-Gm-Message-State: AKwxytc6gpC08QYmOXnIxKMgxTx7BDcM0hZ8zij1Zm3HY+DMaNtUSVbv
        /scwXfm83ILJNr450Oco4UhmmizVwzv0BI94e5x5Y/gRkPY=
X-Google-Smtp-Source: ACJfBoujCZ5cNo9ttiMTL8dkeLP5fHs4OVM+Yac/0mkSto59KGZBuVPgXk4VPnDpjyItxYgVZrUpZD/0BduMzTQ3vBI=
X-Received: by 10.129.119.131 with SMTP id s125mr7313612ywc.166.1516315819779;
 Thu, 18 Jan 2018 14:50:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.134.197 with HTTP; Thu, 18 Jan 2018 14:50:19 -0800 (PST)
In-Reply-To: <20180118224243.5016-1-randall.s.becker@rogers.com>
References: <20180118224243.5016-1-randall.s.becker@rogers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Jan 2018 14:50:19 -0800
Message-ID: <CAGZ79kb4Zr6QnNydRX56B_4Jo5fveufBFJAD7r_8U-NRSMa2qQ@mail.gmail.com>
Subject: Re: [RFC PATCH] NonStop port changes for git 2.16.0.
To:     randall.s.becker@rogers.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 2:42 PM,  <randall.s.becker@rogers.com> wrote:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> Explanation: I'm looking for comments on how best to handle the changes
> below that are needed for the NonStop port.

Ideally you'd send them as single patches, each of them describing why it
makes sense generally (such as the s/read/xread/ line) or specifically for
your arch (these #ifdefs and Makefile changes).

> The hashmap.h and
> transport-helper.c will not be included in the final patch as they have
> already been communicated but did not make it into 2.16.0.
> It is likely that some of the changes below are in the wrong files
> (for example: NSIG, intptr_t) and should be moved. This is just the
> current state of the port, as it grew (and fortunately shrank a lot)
> over the past few years. My objective, as the platform maintainer, is
> to clean it up, and to try to get the platform's modifications
> included so that we can just (obviously) pull directly from the standard
> repository and not have to apply these mods in future and focus on
> any platform-related breakages.

Thanks for keeping up with the latest version! The xread issue sounds
like you found a bug across all platforms, which is valued by the wider
community. So feel free to send individual patches and the list will get
back to you. :)

> Further: there are 6 known breakages that have been reported. The perl
> issues relating to completion codes are being examined at present by the
> platform support teams so are not addressed by this patch.

For perl I'd suggest cc'ing =C3=86var (cc'd just now) as that seems his
field of expertise.

Thanks for such a report,
Stefan
