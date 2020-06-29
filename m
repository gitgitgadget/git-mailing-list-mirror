Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B9C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 13:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D128206C0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 13:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LiYSuHLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbgF3NaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:30:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:34169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732108AbgF3NaH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 09:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593523798;
        bh=B8uTWHaCsI83I24ueNicocqWdG0+QKT6PkLoqPu9GV8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LiYSuHLmP08nPpYHR4Hog3TCkFV3zcqkmr53RXS3w/8hDxyGjcc1kPzRffXMyPRUt
         UMLEYm2hKZ9PjQJRoWQPAVge819z/S/arajgCVrhYocvoxuy5GFtm0wMPs+DGC1qpD
         DFqDE/NYb2wnRsnITBI5+DAeSf8Xet+gCmT487VM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.212.146]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1jHCdC1wq8-00ZNWv; Tue, 30
 Jun 2020 15:29:58 +0200
Date:   Mon, 29 Jun 2020 15:40:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Accommodate for pu having been renamed to seen
In-Reply-To: <xmqqpn9o8o7p.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006291538500.56@tvgsbejvaqbjf.bet>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com> <pull.668.v2.git.1593010120.gitgitgadget@gmail.com> <20200624152409.GA143253@generichostname> <xmqqpn9o8o7p.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1420957276-1593438059=:56"
X-Provags-ID: V03:K1:t1Eo767ofNJy2gO+H1yUtBwrxM2YGdtVc94hamZCXEfXuDw3JWg
 Bb0i85h7ICiWPbuZDa0LrspD6vOvPu2izBvwHwALqHfJwsVJ5/2clhikAzGZez7VmE96Ywr
 8kSgIw1BTOHL0Tf5uifj9PoTehYxM5Nha0VT6Ndi++1q+BVLQAiW+ID53Zbm25phO5ZT9VW
 aWFgvIkIXhWXKO2Yd2aYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ofQF1iCqhM=:F2D58NBJ/iMS/+d2WBN3qt
 dGzHHhQ+gXW86nVxdXXVXlpxwKXcwoOmSKToAEtiGHTQNUrqdgzkPVEtOciAZDgGrcTSRRMMW
 neGDqEJkmR4UrOd27yJRmDlY5vXl6PMQeqEGor/Q8bl7tKLI25zW7C+OBglz4/a9UIoEzcK9P
 DVoOvrVbzmCNSIpJ5zrjWhjFwbO/SqmGlLqdLLlA2esIx0tZQA5mZ+d7nceBarfBin9rD2Asm
 QsramK9nipBKxxJqyOAncfpsB2lChVWErpEGRkZVxTBupLvzCFoPSk6xi+vynpjNHmE0eRoML
 ALUM7wCncM3I51VtzJ6HC3uVH5yIcKRcLwmZdYsdd61KUp6YqMBB/YzR8BwFu+/73gDJb+hd+
 wsBDdYC2vBuZnUI4eArVQQ/qrEoyyOV15fTGixSYA7F+UpIROLlD/5X/5YzWZquHh+HvhZhB4
 PdQNoDxHtK1apFbrJeCHmrrjDA7bhfR3V/YMEGZ0YhUSIJyum2DNxfIgPze/w8EIkRA3Xw3wx
 fcqg8PNZPcuMVdtmjE6U23mrJraN9d0gDfcSKbJ5CVvIjBBuBcNbOUlhTlY9xuMZUNYkXfa58
 Qx8vqc2W5uuEY2U8cN0WeV5QwTJd8IkRptsXs0+yY5XWNQQadCKyUVfZisTxpIyjQC8rb+mco
 MPb+RRXqjC9iCMXZ/fVW3+bxU0XBRNHYylVSo1cx4IqoVDhX6vRML7CsTJ9w8ndw2fiQua3Bo
 F3hVHwlE2eoKpwz97oCCb2GPqXDC+ZHEGlbbYhyfQQWnMgQGgP4Tf1XFodysSaXUy0bhmrkiK
 E+30MemtOjWyexRTcbZ6wiQeQvKm2eniNkI62lsM3Z8VQcmGTltWxWnKCvC95+7PNewQI9HRY
 uIGTPrwXBpC8z2aOeI9f6QELjzBiMC0ed/QR9OioTw7xGSZEvcMwAQXrlY0UOtkCMkTZ5zbZK
 7spr+62ekXCciQBWj82YglxaG6+SDjIuBe5YnpI46pF4y5qcz1k54Ad91GZpqfIwHra4PYaKK
 smHbOQa5tW2CJnB5XG2975fDd8RRleoaITFW+ZxLji5lThHNwZQnZptFGHp1+SL2CeKJ/o/Wc
 RjQgvI/AB4B86I8z7RtHQPk3BS/xQqWUXHTXQYcpUyf4a7BJBm8K8GG+wsVBTfwr+tx62wAll
 mvaPfBYlVW80ap+bRbmiH9W81tKZvmohJSi4e6htgStnEZ9zjyCjpsKwyvC2Sl7GQ7u2/L/wk
 lIKUqut7FDDXZYLCI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1420957276-1593438059=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 24 Jun 2020, Junio C Hamano wrote:

> Denton Liu <liu.denton@gmail.com> writes:
>
> > On Wed, Jun 24, 2020 at 02:48:37PM +0000, Johannes Schindelin via GitG=
itGadget wrote:
> >> Changes since v1:
> >>
> >>  * Rebased onto master (no conflicts, so it is safe, and it is more r=
obust
> >>    than basing the patches on seen which already contains v1 of these
> >>    patches).
> >
> > Out of curiosity, why would we ever want to base any patches on `seen`=
?
>
> Never.  Even bulding on top of 'next' is discouraged.
>
> Either "prepare a merge on top of 'master' with all the topics in
> flight that you depend on, and base your series on top of it,
> risking that any one of these topics can take your series hostage"
> or "wait until these topics graduate and then base your topic on
> 'master'".  I'd vastly prefer the latter, as it would become
> cumbersome if one of the topics you base your series on gets
> rerolled.

I recall having had to base a patch on `seen` (n=C3=A9e `pu`) because it
would otherwise have needed "two base branches". In another instance, I
made a patch to fix incorrectly-resolved merge conflicts.

There _are_ occasions when you want to base your patch on `seen`,
admittedly not very common occasions.

Ciao,
Dscho

--8323328-1420957276-1593438059=:56--
