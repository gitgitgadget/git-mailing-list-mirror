Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A5DC433FE
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 13:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385987AbiAYNcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 08:32:07 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:43247 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbiAYN3u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 08:29:50 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Jjnl80TbYz1r4JN;
        Tue, 25 Jan 2022 14:29:39 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Jjnl76L7vz1qqkC;
        Tue, 25 Jan 2022 14:29:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id mh0YEDYlNgbx; Tue, 25 Jan 2022 14:29:38 +0100 (CET)
X-Auth-Info: Zrx50YYO7ZtBbuBwEZXwyYCWHjYqpnzL3NaF5YyTmA3cl/4mjdKkwVLTcyuGXija
Received: from igel.home (ppp-46-244-168-172.dynamic.mnet-online.de [46.244.168.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 25 Jan 2022 14:29:38 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 8F16A2C39E4; Tue, 25 Jan 2022 14:29:24 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michael Herrmann <michael@herrmann.io>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: A puzzle: reset --hard and hard links
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
        <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net>
        <xmqqilufl5cv.fsf@gitster.g>
        <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
        <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net>
        <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
        <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>
        <xmqqk0ep57ou.fsf@gitster.g>
        <CABrKpmB7UEGzLCiNHQtY5-Dt16jLkpcpBEx3o8y9OBGZ418keA@mail.gmail.com>
        <xmqqfspc3k8k.fsf@gitster.g>
        <CABrKpmDjrTPhL_55YaXEAVTEmu8iZEsKUJYab7OgK0=w9d_7MA@mail.gmail.com>
        <220125.865yq8ghae.gmgdl@evledraar.gmail.com>
X-Yow:  There's a SALE on STRETCH SOCKS down at the "7-11"!!
Date:   Tue, 25 Jan 2022 14:29:24 +0100
In-Reply-To: <220125.865yq8ghae.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 25 Jan 2022 12:33:56 +0100")
Message-ID: <87pmog2bbf.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 25 2022, Ævar Arnfjörð Bjarmason wrote:

> I don't know of a tool to take two directories and hardlink things where
> possible, but it wouldn't be hard to write.

https://github.com/adrianlopezroche/fdupes

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
