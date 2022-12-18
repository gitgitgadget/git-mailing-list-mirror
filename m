Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3331CC4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 09:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiLRJQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Dec 2022 04:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRJQv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 04:16:51 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D9AA183
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 01:16:45 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4NZcfN0dn6z1r15l;
        Sun, 18 Dec 2022 10:16:44 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4NZcfN0JlFz1qqlR;
        Sun, 18 Dec 2022 10:16:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id Lc0IblWvIhht; Sun, 18 Dec 2022 10:16:43 +0100 (CET)
X-Auth-Info: +9hXWFWs5kDtLuI3Qdntr28w/K9Kl2JcynTtbu/uVOaiWMS4Cjk9LFulXxdtQZsd
Received: from tiger.home (aftr-62-216-205-197.dynamic.mnet-online.de [62.216.205.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 18 Dec 2022 10:16:43 +0100 (CET)
Received: by tiger.home (Postfix, from userid 1000)
        id E72EE149079; Sun, 18 Dec 2022 10:16:42 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Askar Safin <safinaskar@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: https://github.com/rust-lang/rust is not bisectable
References: <CAPnZJGABhczzs-6Pri2SAOkujJXT1+JDH9FiwdDns6=miZmvFQ@mail.gmail.com>
        <878rj6rnuo.fsf@igel.home>
        <CAPnZJGAMRY02s6UvMg7B6f=NSAgK0PJQAoftwnhXk-ufD2YknQ@mail.gmail.com>
X-Yow:  I just had a NOSE JOB!!
Date:   Sun, 18 Dec 2022 10:16:42 +0100
In-Reply-To: <CAPnZJGAMRY02s6UvMg7B6f=NSAgK0PJQAoftwnhXk-ufD2YknQ@mail.gmail.com>
        (Askar Safin's message of "Sun, 18 Dec 2022 06:15:44 +0300")
Message-ID: <875ye9vzph.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dez 18 2022, Askar Safin wrote:

> At some point that "bootstrap" word appeared, then at some point it
> disappeared again.

If you have more that one distinct range where the bad condition exists
then bisection will not work correctly.  Bisection assumes that there is
only one commit in the search space that introduces the bad condition.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
