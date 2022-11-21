Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD550C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 19:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiKUTSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKUTSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 14:18:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABB211A
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669058316; bh=LGyjN6XVOCtpimrh/xQMv0Du6nfHJeV2ca7bU3E7/z0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ruI8qU4kc3o7sy9bX4Twkc0QceqCNnTOSdluWowpxzS7iq+eslQonba5KZh3yhug1
         mOkJzeBHlYmI7dfp6P29WrhzyMgXDGe/piVQLqxyqUHR6h+KTXJBiTMSgXvaQjZgsw
         JoWY84F+7TjqGzlNlddLmdcONCXYsa+SRYZpRYodFmgBKc20iJ465qeWK6egzMzQNP
         zxg950tOW+0SRT9UOYpM/H7pxloVdqXELMnGxCSBSLGrA1en2Y5b4a7L811B50E7FU
         4IuY8FDzIqO0AazUJxvfaldRr0y+BgCXxfe9mbvYwjtitC0KcxQWjGMlUFEKfMDJ4V
         7hnTEiK74BZUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8obG-1p1zGU0dM6-015thJ; Mon, 21
 Nov 2022 20:18:36 +0100
Date:   Mon, 21 Nov 2022 20:18:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] config: introduce an Operating System-specific `includeIf`
 condition
In-Reply-To: <aa054864-203b-3c06-0706-6cc40310a830@dunelm.org.uk>
Message-ID: <0p39pqos-5rn9-q0np-qon6-0r0qqq644on9@tzk.qr>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com> <221121.86pmdgbdwa.gmgdl@evledraar.gmail.com> <aa054864-203b-3c06-0706-6cc40310a830@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1209186548-1669058316=:189"
X-Provags-ID: V03:K1:c77V01IwkO+FpquejRb6YSOigJ9Ed1IPnXH3pofwM7jLehjjRom
 EDCTj9aUp1WCR/VHC0nstBEEmStYzb9qCxi8uiDR3FsmB5ZA8dIFS2OrvylhsYdFVtxm322
 GJCIzzsE/gnkClFBgfYRFkMwY37I47f37yNq5zCT206fPc1lHC5FYU2Wy6rnFo/D93VjCfJ
 sv4ArSYOLnNE2z+rUTCJg==
UI-OutboundReport: notjunk:1;M01:P0:7jhXnlx2Fww=;g/WpxAJ0fk4yvKVe3sdCG58K3XH
 Wi2Hjqfoi9G8Cx0NgRTp+DlPiRiTBid071XttyE80XVbruaAnS2nLNcNQ+zD+ORs857Hug8C7
 geWkteXiYTqlh5ka6KiKwaw9azsowX8+gTk4up14a/jK19WfGRboCJMoWGjPQQI88BOkm90Kf
 bEC2WcFjqQf6Iy4EgLOSkJxl8RQUQ35UFsKGgMfVajbsqDYbl3m+/NHCwVPnFv4UxjE6zBj0Z
 bFApX9qgXv+aTdWrdmQ38GhrUbnPiBpEu9tHDVP/t9vxRrgw53n2wp3+8l4zq7QaBi8rj7ZZD
 52gfWvvHW5C09FMXYX4b2hOmMtF7DBR/g0IrHr6bfIsJDUYQtQJGcJKmy8Y8OJCrUY28IPwa3
 f1btiPuLd12KoUL659aQzypamhkIDTqKivxW70yVdgUf9LeIJQAsTL9Nu/+X6X+NL8w4cinPb
 tR4FpZufZKX8KXkPIhMC+07hFeQzn8ie6Leq93DGAcoItKDfQ9XbHRJ6O9iQCgxVYdvRnXqCc
 10ukBMpsa6Gb56HjPbZ1Om7kRvjDL+uBYbEMPtLRXrpr2N77OsG4kqww9FhipithtZKElk1xd
 N6zHebqktOYsvDN1VGcOderEFPlRlfPJuKWysDKkolikccUd3WEVmEtwdb0SxkRbT2/wudQYZ
 yU7g+9SgJFdzFCV7J5QycedNZaYyOBhPDOEjmrHwpSF6pzsv0S65sROqiYhLdeR0d8QI7gDG1
 Rl1Qvw9oa8LVc3MF0VnpD/APYuH3MEymvTZVZfK5moXUI1Ah6zuMSercLPunsiHUhA5uagyvN
 a6rQBOwM02b+Rms+CM/Pcsl+fIjOLLDKxqhTzC7Ya+ORprCY3IGnd9Hveu4XMFCqzjxaKRzpS
 D0HZ2XQZjG1PrMM4M6K1afyoRaWx3CBeSn8DZ/TN2tTfL/fqjE789Dc8Z3vj6PllFazE49X5O
 rCVmeA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1209186548-1669058316=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip & =C3=86var,

[=C3=86var, in your mail, which I suggest could have used some editing for
spelling and brevity, I found only the concern about `uname -s`
relevant, and since Phillip's suggestion is more actionable than the
somewhat diffuse excurse about something to do with something in a
StackOverflow thread, I will only reply here.]

On Mon, 21 Nov 2022, Phillip Wood wrote:

> On 21/11/2022 13:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > On Mon, Nov 21 2022, Johannes Schindelin via GitGitGadget wrote:
> >
> > [...]
> > > +`os`::
> > > +	The data that follows this keyword is taken as the name of an
> > > +	Operating System; If it matches the output of `uname -s`, the
>
> Maybe add e.g. "Windows or Linux" after Operating System?

Excellent idea. I'll also drop mentioning `uname -s` because it assumes mo=
re
about the users' setup than can be assumed.

I also replaced a space character in the added test case that was doubled
by mistake with a single one.

Ciao,
Dscho

--8323328-1209186548-1669058316=:189--
