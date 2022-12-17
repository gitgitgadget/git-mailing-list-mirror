Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0396C3DA6E
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 16:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiLQQeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 11:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLQQeM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 11:34:12 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC54F12770
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 08:34:09 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4NZBPX1clLz1r159;
        Sat, 17 Dec 2022 17:34:08 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4NZBPX1Fpvz1qqlR;
        Sat, 17 Dec 2022 17:34:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id jZvNYARwdx8K; Sat, 17 Dec 2022 17:34:07 +0100 (CET)
X-Auth-Info: Xg+i8XEt3B7zuR6pdnBWQG7+3LaPw8YH11W33vpVWFY2kK+Uf9Bab84eT/17AcK2
Received: from igel.home (aftr-62-216-205-197.dynamic.mnet-online.de [62.216.205.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 17 Dec 2022 17:34:07 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 4A3102C333F; Sat, 17 Dec 2022 17:34:07 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Askar Safin <safinaskar@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: https://github.com/rust-lang/rust is not bisectable
References: <CAPnZJGABhczzs-6Pri2SAOkujJXT1+JDH9FiwdDns6=miZmvFQ@mail.gmail.com>
X-Yow:  YOW!!  I'm in a very clever and adorable INSANE ASYLUM!!
Date:   Sat, 17 Dec 2022 17:34:07 +0100
In-Reply-To: <CAPnZJGABhczzs-6Pri2SAOkujJXT1+JDH9FiwdDns6=miZmvFQ@mail.gmail.com>
        (Askar Safin's message of "Sat, 17 Dec 2022 19:00:49 +0300")
Message-ID: <878rj6rnuo.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dez 17 2022, Askar Safin wrote:

> Okay, so "git bisect" gave us commit
> 26562973b3482a635416b2b663a13016d4d90e20. And here I see a bug:
> 7175c499ecc32cb3ff713be0bbac9fd12990a34e is NOT ancestor of
> 26562973b3482a635416b2b663a13016d4d90e20!

26562973b3482a635416b2b663a13016d4d90e20 is an ancestor of the bad
commit, and not an ancestor of the good commit, thus it is a candidate
for introducing the bad condition.  In a non-linear history, there can
be multiple good commits that are not directly related, each one cutting
out branches from the history.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
