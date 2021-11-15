Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB2FC433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 01:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA21E60F22
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 01:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhKOB0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 20:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhKOB0S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 20:26:18 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA915C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 17:23:20 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id a11so8461190qkh.13
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 17:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYGmqszzg70Fg0a7kNe42nBjym/wCe/ZdxNOY8jNX3g=;
        b=XLCsU759PrSQawuFsBctpdsLJdlN11mFRIUm5vZxBvE0/BjQ0Pn0pRNp+ZmPkKjl0h
         6EeXiRLQleEcxJ/L2f2O8K4CWM7Sp1yxzVNOHuZmctvd2rfhX0N4GquDrbLiKyZjbaFA
         FbUj9ttH7B5lsZbT268/dYm6oLju5URKIgvsCBRpGqS5T3Qhu4jx1xoMwEj98uyzznKd
         n6AmO2wCsdJ248rrCRAASGmp7S7A5GFoWN18zoeaoY0Ecz/gLWdP2yO1Injgkm2G1wkh
         YrHMQKKd2GcxLqbQZi0DB7YmxBPCzZuzb1nNCCcdyeFJ47jvK85DF4uFSKObDowusMF4
         GIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYGmqszzg70Fg0a7kNe42nBjym/wCe/ZdxNOY8jNX3g=;
        b=2XT1NfDEKQPkAuc1OgcrOECCiKIYq/1kLLSvEcNhgqUeNL7LrPCKuiNRmb1TUn2H9i
         P9Lb+XZwbS4Ogjo/VZmQCdwF7adPQ71HfBgRKDzkIdIrpGO5ytu++U0QGMn7rJ4EuMZz
         ehLFV81OGhYXmf2rtVga3Rj9DBJpCFwULXDUY77/eRDuNCrB46vMx5m3vhyPpGQmDeZS
         7uu28V/sJTHrAMqluyij6+Fbf5cj8jOnhaYeg1fUwmR053SWbJYO0mPnBeooY4oZkB/O
         ehQ5XucGhi9CIRcZZuHwxaNHF1ErVE6I4uwQZFzOsDofRdV53G8xXEBnPfdYVgjavuJ2
         316g==
X-Gm-Message-State: AOAM532yHhmb8KOS19KZaBDReU+LZRD8tSIs+Q0BPENiMpRl037YbDC+
        wW96rhX0ljZYg/PvtVn2KBmmarRSYH59HiDFYfw=
X-Google-Smtp-Source: ABdhPJx6kvDwOG37NW0IqUMIeZIjj9KgAf7M20+y7MBdHwEggedpbQrF3RLBwoxSH8nG5uuPDw6YZjAEnNefBD3sl7I=
X-Received: by 2002:a05:620a:710:: with SMTP id 16mr26933172qkc.379.1636939399003;
 Sun, 14 Nov 2021 17:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20211114122952.11564-1-worldhello.net@gmail.com>
In-Reply-To: <20211114122952.11564-1-worldhello.net@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 15 Nov 2021 09:23:07 +0800
Message-ID: <CANYiYbGEf1OaPwUaHhhUswq3JUm918qpEFV5_AYKu_bPCMe6wA@mail.gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.34.0 round 3
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 14, 2021 at 8:29 PM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> Hi Junio,
>
> Please pull the following l10n updates for Git 2.34.0.
>
> The following changes since commit 6c220937e2b26d85920bf2d38ff2464a0d57fd6b:
>
>   Git 2.34-rc2 (2021-11-09 13:19:51 -0800)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.34.0-rnd3

Hi Junio,

Please pull tag "l10n-2.34.0-rnd3.1" with additional l10n commit:

 * cae3877e72 (l10n: pl: 2.34.0 round 3, 2021-11-14)

--
Jiang Xin
