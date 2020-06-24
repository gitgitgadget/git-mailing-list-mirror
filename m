Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6852AC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444A320706
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="s5bftYI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403866AbgFXNFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:05:44 -0400
Received: from mout.web.de ([212.227.17.12]:55361 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390437AbgFXNFn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 09:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593003929;
        bh=O4TK9n4UfPD/QAkBuVsR5orv+3SO6quF4043lkJu+YI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=s5bftYI9DFrC5YZpJ0aqeYrFkojQh5dCFTL9zbfVYo1hlLDafqfIMpoKCookNWfnT
         tkHEsGzi+ug+IWr1a36D2nY1xEPcC26i+w78I2I/W03UJcRZmTxgqxjjuwgf/oYTKg
         8LK8N7Qb6XmwgstFqeR/IFZCPPSpde269WuEtFg0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml46w-1j9XgT2WTs-00lSgJ; Wed, 24
 Jun 2020 15:05:29 +0200
Subject: Re: Git 2 force commits but Git 1 doesn't
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Ward <mward@smartsoftwareinc.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Jeff King <peff@peff.net>
References: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
 <20200622202122.GO6531@camp.crustytoothpaste.net>
 <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
 <20200622204346.GP6531@camp.crustytoothpaste.net>
 <8ad16219-2426-6127-b41d-bb3007a9b993@smartsoftwareinc.com>
 <20200622210953.GQ6531@camp.crustytoothpaste.net>
 <2e43580c-9952-9ccf-6b35-27a4333fb83e@smartsoftwareinc.com>
 <20200623010519.GR6531@camp.crustytoothpaste.net>
 <09a7fa54-d7ae-772c-fb36-29dbd27bc626@web.de>
 <20200623151951.GS6531@camp.crustytoothpaste.net>
 <83e99359-2c24-d8cd-bd4a-6ba90ed54b7f@web.de>
Message-ID: <143f7207-4428-81bb-877e-8bbeb9a79a1c@web.de>
Date:   Wed, 24 Jun 2020 15:05:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <83e99359-2c24-d8cd-bd4a-6ba90ed54b7f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ODy94GfH+dGVRhmXiq0QMyCV7jPmgdkJjW1R/LV0mn9UHJDbJ65
 dOF9PAcRbm48l757Cxqo3r1dXYPgPJMIdzFpav+TUSQhmj6pJMATw6Xt0V7Bf8aPkjiaKVb
 vYxK6wHfXklA7kbyzdC5bGnQaeJievQnVntcmH7chBJqHiHtliNGe1Y6osAcUOv3+V1VAw7
 eNqi/JFmwSrHOWUMe0Vrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ldx0N4ykYpY=:DNes4rmb57rBTYhmkF3D6+
 OP5Yrqst3Fd576Ai2+v/F4FkkUdbYtPkKj1M/53p+fuWCd0yDJoypYo9bxgQ/FLHV4UMXvIPd
 no3WWG5kKUYLyRfdy5sCYShJVD068NsLwVtXk4bQXUF0F5CMRzcQiEGFNuf+S1rIa6btmcffW
 YzRvYoJaEhA8ZTXdZKfsuo5ipOH4IghQf90yUkJ8cDeBmAIF6QE6qq9jqUzAlgQvMW4KQQIYH
 JLbGAjjqQ1w/rfkhrvaTXjYJF1EFQ2gEm7qIxZLWx7rHXOYvpZdt2R0QVhS6sRDSiZYMKEikl
 xiAMwEk9vHTM6JkX3XeE6+wfNL4pzeqqiVoshrQLF+aS0Waj/IKdZSVBDIj24MvAzmWC8lOnA
 lggcfn8WjhpXMKyGmwfgYVlcnya2CesB+cNB04lgJWXZx+rTOvEkB4xr8yL51I16+RT9bIfAF
 6/z0MoDc864DA0gwL2AZ0WZcRQq6i+4Ay17/lEeVClDCnWGy8XfAhG8M4GZh9vr3L7LTGG2yg
 SdZvae0848Y+r7MbV2P+buHd0InVHQ88lzk0TfGUW7NvoY6idKuVO/eEtnJLd2azo4saTUbrO
 EYmFyOPrfkdcDmUsx4VHpM301UJXnVf1faFe7342UQA/wyOFBTpLULfrifftPpnJf91JtS5Ms
 1excuZ7n+NZWycdTMieVcN88cIPJJqPCkF/EYFnbrD9yNi17t/XrcdTfrBDjjFM1cq5fby3FC
 REdeHSbvineyRcFLLUZmnnb+oG3HRGhkeUVjKhxgBhiJlgEMK4j6Jne2XWy6+9Cs0s2hGEtdC
 zCY8P3tE3Hqa9b9m7DdHzcpqov5/9uT/FVywLoQCqTGoM7/kmpHaVAQVPYfUKAfnNm3cJI7+Z
 +O9I8XlSTlEsS+yQvM7wIGPNeIQ63GKJ04Ep7B4dLJNN0SH/cZ1T0TP/aB8b7n2CopwOKs999
 VVekNSgH/P3zUyHoH1RmrdlbybcvGME1nsk6Yn/6TJOCK0Dubpt52rtkyi0aAqgeYlSpqyEYI
 HiLW0WmR0r0C2VL6mVGH90QRO3jLoMCvKp8fHI4ctkva8dkxp7nubRZTNkCnuZFsKtheN7t9F
 Z+lvytIWcesyRSvoAbeN1BjWnnCAPlWuWZAS3wYIWcSiXkAFbj1li7ted+DHIvb3M132Ry8H2
 RDQ5KbJ+nvlOI1KP8l74f17SKU7j+wVluIoB9HNVQcgFQBTePNIG7TG23HkprJ96dwpwU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.20 um 18:42 schrieb Ren=C3=A9 Scharfe:
> Why do we have object flags and not commit flags anyway?  (I may have
> asked that before, but can't find the answer..)

Easy: There are flags that apply to other types of objects; e.g.
NOT_USER_GIVEN only applies to trees and blobs.

Adding a commit flags field sounds easy, but requires duplicating
several functions that work with object flags, e.g.
clear_commit_marks().  And there's the risk of confusing the two
flags types.

Ren=C3=A9
