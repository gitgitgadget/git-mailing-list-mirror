Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCF3C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 15:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiFBPWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiFBPWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 11:22:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F78165BF
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654183342;
        bh=A1lUY1T4UMcMKXVDJsImUNe6Tg+LVX91mPbTuhnTGlk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ASdURs4Uh3AWLWDjG/gr1Se9B1EApe8fv5Lzwziq4f5mql/IQatSvVGgYQOf5e8ct
         Ry+s09wdhLTh00tdeF0Jo8iUuVXyeUlnmWS1z+ytzPVl2cwOJRfbeazXHoB5qXXmQn
         jEcp1BzpwCoGfFbyjPPoHgo9FM51QU6kC4u+IggQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.212.145]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1nbvml2AeD-00wpVm; Thu, 02
 Jun 2022 17:22:22 +0200
Date:   Thu, 2 Jun 2022 17:22:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Ed Maste <emaste@freebsd.org>,
        Git mailing list <git@vger.kernel.org>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: Investigating Cirrus CI FreeBSD failures
In-Reply-To: <xmqqczftx0e0.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2206021721070.349@tvgsbejvaqbjf.bet>
References: <9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com>        <CAPyFy2AETzTCJUtbxS+RmygajrUS5XUkZvF-1FVbJ67t61bJtg@mail.gmail.com>        <e31d26ad-3b0b-15c0-262f-4eee83220949@gmail.com> <xmqqczftx0e0.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:azWXNgCDCvCqiGEdKy/fEY/tt8vQqG9QosLAZKBZAEOXec1OEbQ
 IHn7cE1a7Aj+p27D7+2mYCzel3eg87tI9azeiiQwc5Fc9V2X+Z/cYfHQpU89JbZYHXelMR+
 vx42R2WdWJgf9j7N7fdTlFghQ+hZcPMFp/URO2CwM6teuacSHAqR0LlwR2nXbjvV7lEsK+1
 UoLOuBnJVPm03zR+5mbmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rlv/6nH7Feg=:bDEgnx8pzlCnMY1afCNXiA
 +SKdznWNcyiyiV0doyKhuCrUsWAq0pj17enw2vJx6Q7y+IdJINuGncbSQGmm9FOx6tyNlAr1w
 VKsUfOFXDn5EcuSuovDOE6aGKhOErEfawHXmDAWTV1popxFKFarLOnabqGaxr4/jpNkoJwA3A
 22po6Dh+qRqSlGtkRrQk/98fw2lbKGdTkDJxezchCtyXRMgsg8bVG273oRRBX+w3S3dyuQU3d
 FNG+l1vYB/0U/mcJAZNDQnWRdaXvS/0mH7wsj6KRY6uwLvI71ixOp+HtbqEB/Cc7ZZhrDalgK
 wtjt1R4KuWBvkYSDXpRvFb48dBC60Xm9ThH2h7oQhgjafJeSSkaVCEmh3DlKBB6xFLyDDXHl1
 nmtzo5ojPVSBb5dKLrbxfwDjs5NnC4z1eMeuSYcwI5kqUStRp2f3p2HBMcsT9Bg1aF0bZ/C/f
 2luwud9LCW20t/Yde3vSlpYXyoQK+ridZAeuvatT5bOKmJ0VHxvYQNwt8490sg4cO0S5nrtxi
 x2g1igVzodhfjfR+7/7gxTag9mk6yL6+JZPNc3LU2K0CEiZkJ2J9qsPOQGPqmuugTF5MZfWNT
 uPaMa3b0LoVU5YndDWePbzMxmMoHvzus39BtKtshubmPWVCu6KpzMlj2EDHD56Z7DgEbG2Pzi
 oqLpyidB5qlfzxLGHK0boFx1abfaB8oUnJQxm3Bzd1xQP8i7oXn22IcMY8KW38rgZpgFTqJpt
 UelrNsXOEZhmS6mzYFlpmn6RjjOJ7YlZuNnPKDPwQfZwkwxV8k4sfbfSaWoAA2B+v8BG15nxO
 vE+3n/K4SPVYpEWUfiaRyMuXXFZDn8g/o1ewF6djmCuA/781sP98yu1J+HTbWy+IcdJZl2Lmc
 HSIlqPGE4jCOOE8eyuQQz0QFFQrdT2Ka/myT3MG/KdfPMkHGyVbCeIcJV18ggMGLcu3JaRv8p
 B+s+coACXquvu92kZ/Ilmlz4xhGLzybEk4M9y1M04XKspFM2JO2W7lojk03xrvhajk2LIUjnj
 UoOkU3oEISdaQTcGuW8/dRS3aFZz1WJ0/u1o20v1rtIVJco8c6d/XXpjicv4QGx+wDhMKNBup
 WtQDiiOqOQcvx1MRarYKx4/3hV0/BSQJjJVKP6iYNlWj1OxclBFSeVf9A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 31 May 2022, Junio C Hamano wrote:

> Philippe Blain <levraiphilippeblain@gmail.com> writes:
>
> > For now we opted to just update to 12.3, see [1].
>
> Indeed we did.  Let's make sure we fast-track the topic down to 'master'
> and possibly to 'maint'.  I do not think it is worth letting it sit in
> 'next' for a week, like we do for usual topics.

I am very much in favor of merging this down into `maint`, as every PR run
of GitGitGadget's PRs fails right now (and some new contributors already
were worried about this).

Thanks,
Dscho
