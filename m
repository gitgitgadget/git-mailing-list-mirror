Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603E5C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 23:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8EC23609
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 23:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbhAGXZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 18:25:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:57299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbhAGXZf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 18:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610061840;
        bh=E0JR6Kacw6jEWCxbp3ADVLlsMuqA8p4SaIes6zBvkY0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k3eERbDJOOIObH8MgJUtmV6nzmB938G1I4MTdK94WlZmcln9naENC/fXiB2bgeKDm
         o5gOY1N6WznXohmMJq65JvFU0LZZfVQUHjgRfVb1uQ6o6AeFK5l21EA7Mm/1iQOKmY
         jZfhRgd/1pfHpLOGe+drJhjbzGBheVkDd9gIkilc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1kIX7V2WH7-00fEEm; Fri, 08
 Jan 2021 00:24:00 +0100
Date:   Fri, 8 Jan 2021 00:23:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: ss/submodule-add-in-c, was Re: What's cooking in git.git (Dec
 2020, #05; Mon, 28)
In-Reply-To: <xmqqturvxa9t.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101080022310.2213@tvgsbejvaqbjf.bet>
References: <xmqqeej9g325.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2101051640150.2213@tvgsbejvaqbjf.bet> <xmqqturvxa9t.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QSwatayquJgiUmxV8DF7RkdFBNzgE8eTyF+gYLIay/nsNorl8Xq
 qXnAhqd9KYpdTgxW1Zez6SsUgxdqZHH2WOa6vr+60TLQFp80zDA10S/E5d5pPUIcpQ4jLsx
 vcl30domM9qW7x09FdGau3OcmgodBi25LqBUp3CVGZKTbosWd69m6+JGaqPsIErewWShMl2
 YkIWWSspd5NcWQP4RmvzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0SKtGnq+qJo=:megdkoNwNZaCHir1te5zbJ
 i/WAETtA53t+6esrApoS2LiGh2aaio/mUdTdLrmAtHtqWs28GEKgbF4J3lWmV7AhNWcpELTfG
 n0KSaYvJ9X5fcsKyARvHftuPGK0YZ4oL14z/XM9eVbZVGRbEOtQtQjRvnfMAtBSV+f9UHJyfi
 UgctfoOj2rW1WT0ZHWeOHZVBS9fK1dEgVIuAopI+Uv5Kwbl2JxVaLhum3seY8nCFTg8mNfDtS
 1UgdLkb2A0YeIpjDR4Dk5xfTcPhdYdmV2mqJpH9LrSNSKFcKsV6t8TgbKh0yR18waIZ9pTR8e
 gQvnqNrlJhB8M5HgKrs0g7sx+yTlCz4hjbyDL9ttPyAdksXM9RGlpIhVr+LlpOvoApm3GozRm
 X2lj7c6SCNAy+nlFaCMgRSHLb08SiIccfjRwJF6LkFjRbVVXYxKWB/wGQqirp1NeRloFgMIn5
 pA+RE4fpOHnNxgBZ5X96fbAkiPrYoUlLdOsVrPTp5hyUaVYWaczdFGICeXVrCcfWxNndzzL+o
 jN+GZ7V6zX0BisiARiaQu8fb7RqTyo7FU5SuIsgtaCo7Pkfhny3ypuv+D7go2WZhazIcvC7F7
 Vgc4KlHjf7SljXTfg7Ps5yd3vnAsiQ18JvlH7XQoIi/ioas4fkH16W7xxEH5ErRbpEgEbmZPN
 gKXm01n4Y5mHHKG1AViKjfM5i6iG9MSFY23bwkKdzG0AimSaaUsMMQlyTpY+T0o3digAn3u/y
 mIM8Q6ryqTDepUAoNzcH7anAoNalAGfB3ye84nXsKVPTAUBkIZsMYHLtlFwLC+vzuWRoxvIrl
 9ouktkoXFKVSgPLThj7iB87x9By3XNQMy426k3EnZZJc+ISvGtlg98qDTQUbFFNbjG8fKeqzJ
 hH3cu1Gf7z/eHe2h7Kw48tkXoQ2NDzEBm6FDqQlNM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 5 Jan 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Mon, 28 Dec 2020, Junio C Hamano wrote:
> >
> >> * ss/submodule-add-in-c (2020-12-15) 3 commits
> >>  . t7400: add test to check 'submodule add' for tracked paths
> >>  . submodule: port submodule subcommand 'add' from shell to C
> >>  . dir: change the scope of function 'directory_exists_in_index()'
> >>
> >>  "git submodule add" being rewritten in C.
> >>
> >>  Expecting a reroll.
> >>  The patches are split incorrectly; part of 1/3 belongs to 2/3
> >>  cf. <nycvar.QRO.7.76.6.2012190104140.56@tvgsbejvaqbjf.bet>
> >>  It seems to introduce a segfault on 'seen'.
> >>  cf. <xmqqft3xflw7.fsf@gitster.c.googlers.com>
> >
> > Maybe nycvar.QRO.7.76.6.2012190104140.56@tvgsbejvaqbjf.bet would be a
> > better reference,...
>
> That is the first message-id referenced in the above, isn't it?

What I meant was to say that my message clarifies the segfault issue
better than your reply...

Ciao,
Dscho
