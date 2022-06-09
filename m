Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB4C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 08:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbiFIICY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 04:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbiFIICW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 04:02:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3766C6441
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654761739;
        bh=gNDKoNih3Pp1thf3XPGXuYXKGc/O6JZ5lX/+U3LHHPs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bCAmNyUc7H74Taj9hoF/8KuZaUmdVdWRaYM1Zs3Yy2OecbTaM1950oAUXzE/oSuHJ
         vFS0pgpJPtbXT+M7W/Y004BPr8FxyDoAnydOSZ3wpY1zCBPyUMxeYQrm3u0Qf27DDy
         O1BsNzWeSkjOfN6S+HIWulaKcWz1EyEzKwvDaueU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([213.196.213.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzfl-1oENQw021p-00XNDP; Thu, 09
 Jun 2022 10:02:19 +0200
Date:   Thu, 9 Jun 2022 10:02:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Rodrigo Silva Mendoza <rodrigosilvamendoza3@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Best way to update `HEAD` in mirrored repos
In-Reply-To: <CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqddjUOA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206091000590.349@tvgsbejvaqbjf.bet>
References: <CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqddjUOA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hfddzmL7AHtCMBKLEPVI3KzSyL9mxNHWMummPl5qaNsrBScSGcb
 M9MHoO3iFziLoCtOsUyZm2bm7x6lHRYZ8qiauvL2S8GeEr1J7IWZu5Cfi5tTWZcDjvMfxwj
 a8O3pYBMxUpDmrJq4IowoIf1ORh1X6g6yZDOsRX4/JmO4H/Xi+e8Vz3k1xSxMA8+5hfqwA6
 4YvW7pEw0C8P+z0tGxYmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n63MY5c2SBU=:og0O6ZxCaXogemokQPwhy0
 CbENgV0Hp84fj8NMk5mn0tO2VywLck5RMCN+uwg3ege9ZF0aBIZb4Rr7nbuFa6dWdJ040eiJ5
 Tkam4nSCkY3zRAe7J2yEMN8P1zrCymGuf+1hXt/RFp03t6YN4eSVDbXelYbhDEP6wuvCraWQZ
 E2RJIsn+VP7+wH5u4D4sr2ShOJKmZwBP2fZKKwdDAv6YjKsz9CgYXCt73jSfBt8Yiq1AW56QR
 rOqkD8R6ymyynMtNIsODjVUw7dppaZap/2vZotEG5qHjHYmuBQSOQO7cL9Bnc8iaQVbaRbgPD
 6xktD6ubyRs6FU0CyjBc4xtqQvJ3zM/PsuheR+45ScYaWiSJP8sQHYdpJoyZBaf2ULq/CSTxA
 d4SLCyh9qJeikD8FvtuR/V4EbnVlE73xuIYb/1nilxBEGVNt5Ub3XZTSQ8B3+UoiREw5pPTzc
 jk36BPr74NweufmQlebt79p74sQOFms/52PWqJXwqOJ7WyqeinqnqIq21skjlD43JvJ+sDcH2
 KzH+W/HFHMYiyLRH2DycByylHzyeylMQ62mNgZ8H1wQeWOTbztHikWScvCsxBPHp8PlF7x/G2
 nnG+jWaXW69tlstAMuHLWrGRjfDV12OdTRejar3qqehoLj6zkeoVJhxb03PT2HylxLUJncMLw
 dMkIeG0JXgMtvWzOvBZgguLMFXdZ2hYR7dG7r18/qMGOqCDZHA02E4A4OfolKuvXgfw7llkgy
 JmFJucix2JxyNSrrl8TYeJwzGSX+QnRevFloWi6Luvy80lFZuiB2uYZtN8lH3Ex4QfHfxhoKh
 xHqfWUwSsLjVErKBwTljA3APoZ2XMKdIHsZJZxzhOOFXPnB5d53aA+CWp902Lg71RiWyz6lQA
 K78ok7JsHya2wem0hdTG/YJIMQKGs+zIzM2UcR3HGjoehIteX6X318rYZPLKJlmza8UJrCFX1
 vFFkO98kG9IXF85kHMuB4TTfc6tdzY8puXzSLyUpYK49qN3KCQk6RuqbtjkZkBLIGG+cC1Vzi
 n0iwxYKYPAwoV8oS85mlv22wN9epjQngtB1GSq3/6GkqUAyK9/ftfqrq24b15OthTAff5clA9
 YArF00vO7uVpkjM139NivCpoJV37kfwb4oI12xg/+jNlAA9166Ul/C5sA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rodrigo,

On Wed, 8 Jun 2022, Rodrigo Silva Mendoza wrote:

> `git remote set-head origin -a`
>    Fails with "error: Not a valid ref:
> refs/remotes/origin/good_main_3". The ref it fails with is whatever
> the remote HEAD is.

The reason is that `set-head` expects options to come before arguments,
like so:

	git remote set-head -a origin

Ciao,
Johannes
