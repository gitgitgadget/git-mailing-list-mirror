Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E356C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 13:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D3C60F6F
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 13:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhJYNMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:12:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:41795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233475AbhJYNMq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 09:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635167399;
        bh=bd4/+3Ii80nmpSNzPTQ2+L3XykXVX7h5U73tyNmSXK8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Vk7QkDmNic0ydulOZGif8knLMUP0L97fwCLpVqmwpZJDJwQhUDqRq/ixzNPVjroFg
         Q4RW6QJ/iVy8pW730r8GaRgZgFrt99tLanyJKVtwWm5pkjk56W0CyDaVZ9eWnIJXDF
         Sbn6+tlId162E0dJisbevb/rEXRlgMVAk21Oe7QQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXBj-1mS3R13UeX-00DaKw; Mon, 25
 Oct 2021 15:09:58 +0200
Date:   Mon, 25 Oct 2021 15:09:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] git-sh-setup: remove "sane_grep", it's not needed
 anymore
In-Reply-To: <xmqq1r4a6b9n.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2110251509340.62@tvgsbejvaqbjf.bet>
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com> <patch-6.6-556fa96dde7-20211021T195538Z-avarab@gmail.com> <xmqqwnm6ge7w.fsf@gitster.g> <nycvar.QRO.7.76.6.2110221625570.62@tvgsbejvaqbjf.bet> <xmqq1r4a6b9n.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SBNgJi+3xsBuD75v3pJkyDh182IXnvkt5omTInPFvVSdrdXIeEL
 HDS+Ts5PP2UonJMu/Eem/qvK8dIrl12/Ap5An4XiY36r2NXXr42bdg2HWxpmjbjRSgXE5Ix
 Or099ifyuzhn7NcdLpCpy47MBog5TJKjppxsjTWr7qZgCFDYEXIWDDpkccs2I5wk115J4e8
 yTQsLWh0JyKLdGqog+oPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Oce0epN2n8=:M+CmUwSse0Wq/ZMGcNqGic
 C0OsNLKEbDEsUs5z050LpZxARdWguJHLt+3AeCtMsb1ugshxRbDXivVr2wb9HemrBeshaO79D
 0aJmk/lUHAze5Dz8fuH6H3OiGHf9slWFR6y76Y/Yayn/2bg1AXEGiqCqKf/j/qdoZQHbuViDE
 b+i8070uJ2qY5SzHC6lJK5iUctHIK1KXlpU3BhhOLlKm+10hF37jVmYhcs5ZK9JmVtx3pRidr
 WTTcajEHFAP4cqQ62dC2q646E/zymYNVRgYUzhAa0V5DxFleu9uRfP/FT2Qi7niZRrH+zsCq/
 dzyjj1DeiVo3v/MEJbHRvHOJ7M5Y7Iiv0og/2pgouVP1Fqey/LaGZQtv84vhpeM2X/HTkdgg7
 zHoGCSTAOD67x9yNzbTjRdCzOJjAxUI4UN8hS/5Lg+FqgbIfUo0m6iUvbCMDv43DkEY5zkeh5
 wq+tEVESQBuDqJ1jDpWfWXNadl9Kli7VekmlVwqDPKKD5I7FXOH0qqJpKLnd6+wl8BQ2vEH90
 InMA67nfrNh/Y2kGcII43bkRU635dm9jPjtiUgbJPwrcyUUHa0Y+6nF81Y9KIAicAjaGSBza3
 oPdEbaE8wDOWLTOKptiTtxpii1iVNnN6eXQh+q6USmACMWUZcXjP1hlCCv5ujlhyLlTRCFqlq
 E2IOsg4WtFqzJ5DIZwwDaqzfT5g/ZoKuIfQhQ9Vfw4oimIqLoeh2k2y2mFE/kwkE1zzGObwOe
 tjjngR1lK/0pbo1xk3qJqcVQYrQXGXc6iUOEFqrj7TljJmQYOLPR5XiGB/ds6/80mq5qeE7fm
 L7/RYiys/Ipn/WkViK9pwgZF6lHLDOEImxue9t3TUTqawaAYDqbtrhRGmUbus85+0FZk4Su9k
 004hhVmSLHN0H9pQEALWlEWznkorZtbIQbHDklYegNe6sBO6pUH1S0STFLELfwkABq1v9QaAL
 zAD42tQ+h8urvaLupMaLP7WHSG8QnZRF2vgX5p/aVDe2KYOzVMJuxUfzuW2jkB5kkxIKttINs
 7tKAXUCZcvL9UEyGccrpFHsH81MpRjanNu16GYMQgkClvmW9VKajJXggW/PohKX/x1Rd5ERNm
 +VdVhWa2l+zywA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 24 Oct 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> For all other users, I think the above applies well, but the one in
> >> filter-branch deals with end-user contents, so we cannot say
> >> "contents of the tag cannot be binary".
> >>
> >> Not that I care about filter-branch too deeply ;-)
> >
> > You probably meant that you do not care about filter-branch too deeply=
?
> > ;-)
>
> I don't get it.  Not only I meant, I said so, didn't I?

Hah, I autocorrected your "Not" to "Note" in my mind ;-)

Ciao,
Dscho
