Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB581C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 23:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjB0XGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 18:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjB0XGP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 18:06:15 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F5A248
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 15:06:14 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 31RN5l6P1082478
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 23:05:47 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Git List'" <git@vger.kernel.org>
Subject: Problems with CSPRNG in wrapper.c
Date:   Mon, 27 Feb 2023 18:06:07 -0500
Organization: Nexbridge Inc.
Message-ID: <003d01d94b00$16abc7a0$440356e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdlK/307ZhgCXj8+SYiqMXZMQBUs2g==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've hit an issue with git that has me stumped at a customer site - so I
have limited visibility on what is actually wrong. This is pretty urgent
that I resolve this.

In git/wrapper (lines 477 from :
       if (csprng_bytes(&v, sizeof(v)) < 0)
       	return error_errno("unable to get random bytes for temporary file");

First, I was not aware that csprng was a git dependency - not sure why
because we depend on OpenSSL_random that should return random bytes. Does
this still mean that there is a dependency on PRNGD, or is there another
dependency I am missing.

Should I get them to revert back to an older git version (which one)? Is a
patch needed?

Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.






