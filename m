Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B6CC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 12:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiDGML6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiDGML4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 08:11:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321121D0
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649333368;
        bh=HHizSyKJY2GsttnP3RuqtJlEt0MdxzbT5JoLCynLN7k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A31EfmH2VihM7hk6mGsHg7ZZH2aNE9Xi5i4RM98Z20iDOpyh6OhsjNf0deZQyImHS
         5LOUIiQBjUSSHaaO8ptYZmA1IiljeM5S1H6c1tXlH8P+Bm+eiOl1BvfxPzWND0br6X
         ATgryJqnYmtj9iIUGncJ8jbRD2oGBv/Ub84dM2C8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.255.204] ([89.1.214.127]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel81-1oAfNN2ouz-00akd9; Thu, 07
 Apr 2022 14:09:28 +0200
Date:   Thu, 7 Apr 2022 14:09:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/3] run-command.h: rename "env_array" to "env"
In-Reply-To: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2204071407160.347@tvgsbejvaqbjf.bet>
References: <Ybtb6Shdj56ACdub@coredump.intra.peff.net> <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-795814729-1649333368=:347"
X-Provags-ID: V03:K1:ysFFCTONx627FWV+nS1RVLsJreJghcfVY7zrbP8GGA39j7Xqmny
 VzpZ1mzzGQ2zZA0w0b+XZpc2ZUGKlgTMcKiqnMR2e0JpMtMTi51cLDJTVostYQvvXgg/+5W
 1GaLYcjbRRXle3P7AJU17Wf5m+9JmUer0q/81au3GWT5LZ46UjhPD1msNQafT22Ogv6NI8+
 z2hoiyhrESDbOQSGhNUEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E/r2C50SIbM=:v5zsbqq8t0KhGxcohcvCV1
 Ig5IJB1dRPhWzyO1QxMksJZrl9jJuE2R4oRyGJXcuZB/nqztP6rBM9rNiVr9Ma3v4xbYoz87y
 9JD8vV8gfsMJcMdIL2fydTQkFbOR5TSIhRwFxR2Zhs7DR+isEc5Zg4X1Hom+RoL07OlR75d6w
 LnklTFym8FA+ATR4qK2MZ7fDhwUmz43BJWkOm10zSfX/F9L5zN+wofkLFS8oK2OxqcE1sJArk
 i1NKm8JNCYTChDtNGKi1hmqzMIEVplO55rC4PSdgkkJEXbrlae8tMfz55S4a6aQ6Mufgc69Hf
 Mmzsjsk/2p4rphAhoWAfOZ5egTookOOTigfN9vrRcxnsNPzg79ouWHZVa/O7Fs296m+98vwVe
 cUQO3VOu/IuIXVdIkTgdmEx4QZCt/xT3cE8Pw2iqtRSs5400vaJH3EaenTZKfUSEsc88nEsGZ
 PrVNbpUqg2zEv51K28dx5UPQYAi71/46mNMdT7tktl0eOsdMb53GdW1V2pTbBeIP/6X98EgMQ
 kRG5+RAa3HuSpwyAWM9aEJWv/DEu5NZ0tvSZ7nJfwKu5HRNj3O0ttTHYc11W7uGh5RBloEhDp
 kTVc3BgCa1iKrHwr7b6XjbvP78v+9j+VXF9/FcwRWs4SRI4XPTEISzCMfZlq/7X7M1ZFLn3XW
 TqRybUHXHt4zpSPpHW/7p7246/kQSg1PoVcwj7ZhZh4fBvkSM/j1ljg4MXXdAXsfNX2vg0bG1
 4yKCajzNEF7deXo24dhurfLqa3C9JgPR5FVFCa853hAE0GRIKprTmrLlTDREn1RewKCZWTf56
 9KCee4TolyAQu3hjacgcHwu3W+ulUIs2/YDPjQFr+UQ3Esosa5Rtkk59ygnM423Fjavc5R2JA
 xfoeqkJd3c1jN7Ivbn9OV5Sqij6baSrHIbZ1UrH8ovMQBg2zXE1oPu/ZJa2mJRFxg3EkTDJrL
 Ff0EM4OzNLKqvJei3633X0VWj1Qvnt8chtE3HpLlJytUHzgsHE7CUeObFeS1sZ5jkVvR+xK37
 DpwBwhe7PlQswreG2cgsvFAW1pY1SdkBfjz/9EIrHcaRu9uMRwZthLQ3il7pbi5xsbqQioepx
 oc3E6Jjg0LL7HI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-795814729-1649333368=:347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 6 Apr 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Junio: We're in the RC period, but perhaps this change if we're ever
> going to make it would be good to make around that time of patch
> slowdown. I.e. for the first batch after release.

Good thinking about the first batch after release. However, please do send
such cleanups really only after the release. The reason for the patch
slowdown is that we want to be able to focus on making a rock-solid
v2.36.0. This here patch series is very much a distraction at this point.

Thank you,
Johannes

--8323328-795814729-1649333368=:347--
