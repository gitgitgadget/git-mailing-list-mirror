Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99936C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 17:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBORYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 12:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBORYn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 12:24:43 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B2BAD31
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676481881; i=tboegi@web.de;
        bh=1gnpwond+n5Ui1gJ7AXy30eSEeskpheWlQTyuAqCxc8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=v1Jhsp+AXfSF9Aa0E/2omNjtwXIZNQsQqmSDQeIEtldqE1JuaaAmokuHGBg9/X0js
         Mx1I/IvpFEisJqBoumCRmnN3aqsc0h+Juycva5vTtH8x9Urlk0pyO0Iyhu5TJgBAlx
         TByhVMagNq8P0tSCo4Gv9Pvg3FLQoCWPl93SJr3UjY9UgOIKAwYx8vhhGvonvb3acq
         u8jwIKTbGUhwksQC4SdgHrdopOPMLV6GzaA1ZXTqYplSwKQdHiB1UJfbcA8nGpXQ0l
         6E/CpkfNZdtSliIeWoyZN78a39F27bZtliNizTb1E8hULwfD/ZXtgxmRM133hWX1Rc
         32BtNSHCh8L5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mhnw2-1oxfRt0E9g-00dgzc; Wed, 15
 Feb 2023 18:19:25 +0100
Date:   Wed, 15 Feb 2023 18:19:24 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
Message-ID: <20230215171924.6dutxlsi64h4upkg@tb-raspi4>
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net>
 <20230215162648.py7diaasrymezntl@tb-raspi4>
 <CAPig+cRmgGssbN=dDmeDeNeBJhcjvtzxg6O_ZNX5U9kWY0jfZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPig+cRmgGssbN=dDmeDeNeBJhcjvtzxg6O_ZNX5U9kWY0jfZg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:PkdmIUqMx2A1oNtlEwe82vuM3IvFSYhEzxGxJ+gVweMq8Js/6go
 FPfGU49umytjdxPSl7QxpAISCTmVhZHYdEF5fe2HNViaE7IjGkJqFRoLPkTsTMinttyPwti
 YFL74rbxeahzvZbzqU1n9o9EzlfIEewzqxBP6WNpTlKF0NjAybQNkRjX+WoSrcUTdOlMQeI
 VZoa5ci5JuuALwbwv15dg==
UI-OutboundReport: notjunk:1;M01:P0:lAYIp+ob47Y=;yFtF13VdokJKNdvTfbjASYTWTXp
 yJHiWGtEPZ7AVdransKFPGW5he4tu96ciMGde2E/KRRHoe8D644bXNvQCRh0Llc4bqUvTFh8R
 8ao4t20R2TUvUZVqBV4CjoTwr0uKBV1WuwcdCnT4t/tdg9nJEGl8EwmoPHRMKcmv11vkwqK5A
 L6tiJBC5D/OBwpd6EQHgEyVxjaP2D3YZmc2sZLEqW52n1HB7J6yQrSPWF84Pp3MDRCMvB3asl
 DE0qy7NrHZKYDZ3idHGTdi9OUROBLTlkhnNLJn2Z6Ina0xL+BjhVl1Z+/MFqKzy1+9LlUTqsP
 vHslf2pOaQfRoM//Ms4wbiS8h4QGEEayCeZAaWwtpHzD1h9MPyQtFZ2LJmVStfJioEfUB0PXS
 +43bVgsXJlKQOyrL2n334wm2eZqH2snqajrSSHo5oVNZ8x19ENFQSPx9AHhY2qzyRGFCEJ8Ul
 hMbkUo6NI91L6PRGilMhgakGbbw7uEcxPFdW+j8oxdFLPIMSLor0zwxzBPyPlrcNkPVPOccOm
 cMwFWl1FS5JP39O27Ptosxc/Jvp1KwxPWEK6o8dkwrY9iIPvWGg/XNbeUc2+nA0tBoSDsLW7n
 eO8SwPsW9MH6Jtb+YPRV2EMo27kWeDaTyksjKUdSfyw1CAclL421wwdonZlqcfRL1qwnJ/YWL
 DCe6pKNO01BCt8lID5fL3BueYUw3tCs/wIp3jUerdBySjYbuiLnnGuxCvzR0iKT2+X/cIvhVI
 5cIxNsyA+wMfyM/GB722ww9pzC6XiOoQMOLc+/HKMWikgqHLmauVpIERIMoKe6npg+SgQPAyj
 zJb8N0KD8l5FrOpg4bbY41068UxMjH/tAqcn/EODySmQTddzYkhkzfIv79hbRJm16ICnnTbKB
 Xfh24sNSBbOe5AQjeWwJkrrbWMY0z6+tqlt+JwbSUD/IfXLL2tC/gZU27YyP6YyNdlm/STOCf
 PDOVKQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2023 at 11:37:11AM -0500, Eric Sunshine wrote:
> On Wed, Feb 15, 2023 at 11:33 AM Torsten B=F6gershausen <tboegi@web.de> =
wrote:
> > It would be helpful, to pipe the result into xxd:
> > git symbolic-ref --short HEAD | xxd
> > And then see, if there is any garbling inside or outside of Git ?
>
> Here's what I get:
>
>   $ git symbolic-ref --short HEAD | xxd
>   00000000: e6b5 8be8 af95 2de5 8a0a                 ......-...
>   $ LANG=3DC git symbolic-ref --short HEAD | xxd
>   00000000: e6b5 8be8 af95 2de5 8aa0 2de5 a29e e58a  ......-...-.....
>   00000010: a02d e58a a02d e5a2 9ee5 8aa0 0a         .-...-.......

Interesting.
I just saw that there are already fixes going on:
Is the fix from Peff helping here ?

And what do you see on disk ?

