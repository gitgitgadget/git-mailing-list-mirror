Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6FFFA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 20:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJaU0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJaU0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 16:26:48 -0400
X-Greylist: delayed 573 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Oct 2022 13:26:45 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F912AE5
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:26:44 -0700 (PDT)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4N1PZY1dyKz1r1gh;
        Mon, 31 Oct 2022 21:17:09 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4N1PZY1F9dz1qqlR;
        Mon, 31 Oct 2022 21:17:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id PcZSUxixQXgk; Mon, 31 Oct 2022 21:17:08 +0100 (CET)
X-Auth-Info: AW3rerImvXGEs+M7bDoiNQZlxQPiwcg2qEkpFGGVd4uJT/QzjlufbGrLVEjyg9Pp
Received: from igel.home (aftr-82-135-86-233.dynamic.mnet-online.de [82.135.86.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 31 Oct 2022 21:17:08 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 53A842C35DD; Mon, 31 Oct 2022 21:17:08 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Mark Hills <mark@xwax.org>
Cc:     git@vger.kernel.org
Subject: Re: Consist timestamps within a checkout/clone
References: <2210311614160.25661@stax.localdomain>
X-Yow:  Look!!  Karl Malden!
Date:   Mon, 31 Oct 2022 21:17:08 +0100
In-Reply-To: <2210311614160.25661@stax.localdomain> (Mark Hills's message of
        "Mon, 31 Oct 2022 19:01:20 +0000 (GMT)")
Message-ID: <878rkvychn.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Okt 31 2022, Mark Hills wrote:

> It's entirely possible there's _never_ a guarantee of consistency here.

I don't think the order in which git writes the individual files is
defined in any way.  Thus depending on the precision of the time stamps
in the file system whether a file ends up newer than another one may
vary each time due to timing differences.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
