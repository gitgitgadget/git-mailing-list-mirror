Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A93C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbiCGQNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbiCGQNc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:13:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA7EF1F
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646669550;
        bh=RX7lQP8BRSH6LvUHZsbazQQVge5uEXeZX3I1YXWvDgI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jlLmBQuBWJEivRzWuVDhumVNn+zNvBxqQzXk4LC5jE3NBPu8oTKWrL53R1nBxfDzv
         7mE+spZAt48/a1j/HKXHNa/Wz1Ekaw5UIJ7uH6TnjC0blM5JR+DSC5ZSLtPPK95gP6
         Z7R6g8UQHVoqMMIcyDSZnQrCO5IaNWOzzwBjNZgQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1o4SLP41uU-00eHwY; Mon, 07
 Mar 2022 17:12:30 +0100
Date:   Mon, 7 Mar 2022 17:12:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for
 usage-strings
In-Reply-To: <20220304142154.2350-1-chakrabortyabhradeep79@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203071709540.11118@tvgsbejvaqbjf.bet>
References: <xmqqv8wu7jpf.fsf@gitster.g> <20220304142154.2350-1-chakrabortyabhradeep79@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iOv1blWhZcfPwZvZ/kRWd1OMKjK6iux4R0Eoeqqrd9XnPWZp7bO
 z79D3alRf0KcYwN3WEykvIRqnfWOp4UcdLRW/hj1wKW86DcsWCi7V8LIyz3YNnqi1EYbrWt
 Vo/fRxboXnEJO/HcKa2/mkKiCc3JCZh3vanjh3Bans0UZBg5XJBI+x8iJFsfwqM3rpf+M76
 COomi3eUr7w8sDx/IKWWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+CJdX9cjRLs=:+gpmFWepbYnAJRtENqlWCu
 ZZPUdHMhCq4+U/hpE3ob0keKfJ0GxYeQ/wAucygBGRnLMylzIaZTsolRHVsyxrdoyvnDD6d0s
 qgWfmTRHDDP3zP9VfSu5H2zBdA4U3mH/YOcEM8EE5oHsW6oF5B3QnOFrZs5dn5fYjB/p3Kfgc
 aNdUojp1E95bg0mfUZnd44ck8ynR0OXaxymiJgpGxG7+n+DLdvSS2DsVhPaggcUvuN72O8pJp
 alxO2yov5+LkotZtbl8YDa9suXCiiOOLhfHfvhSfTEj1uVz1T0UPvRuo+IPh2NqwJzsibPp0N
 R4XacACWcsLhPuVdS2+JTbWx60PcogkSN0ivXD/w5OUF+g/r77M33/Va8YZUyrGDC4ZDZCk61
 mAnwXTdF3vl8sh9YykdsoBXFnzNHNY79P1Td4lb/5Kz/v207QOUu35bgs5if6hxFyLsPXQfu4
 xYFkrXLjQ6XJ20Px0tPNurBmzpD2/X+qiUXP/0T431teLP/kkWCHklIMz1bVsD0Khe8cWoxH+
 +YruSdCYTqcbno2nQCP9jQYAp+hu+79+4vTuqOTK3gMO/XcaalN1Y31ly84n8DGnsmMaylriV
 3nhQfq5QRr/hOrdAB6B0T47e3sJxiRbfoWocvgD77RzvvUDAV0WK4CzA04Y/Nxvb5bC3oywGv
 Epqmoget8EobAghU5hMEyc1nEBoHqKSzpWthJPX3y8qzqyqALg9y4A99daL1UCFc1jbqk+5qD
 DjDK0lHFaNCndJLXyDy6nJcCynu1c5VJKTj2lwpb/hVUDaMPwK7Ck+1J/w3K+yArWnsuzLJ/9
 iXeGo+b0e1JZTnlmKF1IEi40+beCxtiuyyMbbXdDFDHTzWfpTxMTBasPYKwS3YoZA+djoLc0/
 R8FQCxwKBpOjweuhJ09+DOIKBWJs+wlfOp1IFaZi1wCu32cIbZrIjM4u+Ll9I6F/+i+PY1SuH
 nWvUpPRNnHl+Mpb888F2a1HoxWwvarQ4aJIk0PQjtXnviPLWB6qlPwCHqvzZnWRdOZpdorFKw
 yePV9lYPlpQujN/spF2z1lkutOTdYj0s00z/30Fdp/lCVpScaJq5pLfkEtImJP2/XIk6AGtS2
 5TEwBWVds1Ghs0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 4 Mar 2022, Abhradeep Chakraborty wrote:

> Junio C Hamano <<gitster@pobox.com> wrote:
>
> > Yup, if we can have static and dynamic checks of the same quality,
> > static checks are always better alternative.  In this case, runtime
> > check would probably be an expedite solution suitable for a shorter
> > term to fill the gap, as a static check with the same quality as it
> > would probably need some time to develop.
>
> Got it!

While the runtime check would address the concern in the short run, paving
the path for future static checks revolving around the same area will pay
off quite happily.

> > I do not have any particular interest.  If it is a tool fit for the
> > task, it would be good to use it, that's all ;-)
>
> Okay, then I would like to research if that is a good fit. Johannes
> is pretty confident about it though.

Yes, he is.

And he wishes he had the time to work on it himself because it sounds like
a really fun (if challenging) project.

In other words: If you ever get stuck somewhere along the lines, please do
push up a work-in-progress branch and reach out here so that I or others
can help.

Ciao,
Dscho
