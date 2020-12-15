Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5BAC2BBCA
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 16:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B872222B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 16:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgLOQK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 11:10:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:50669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbgLOQKs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 11:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608048550;
        bh=ifgEVaWpTvAPICWKThU7ZuMkYw5vghMBoY7mfal7xxA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZqxaTewPcfcJb4fP+dtT4cHVoUTEAwferb5E92fC/FNeIBZjvI1PtfwFsUT2lJSYw
         1haqazFMkvd27Y4b/NtPWqyCtOLsS2GdZW2wj8+GChdEzoArFNB6VMBNxtK2M8Dr7c
         nKTM8hSLtDNH/kRVEn/9PF7P72EckNj1CFI55OKQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.214.172]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDJd-1kJzrd30zH-00qfkt; Tue, 15
 Dec 2020 17:09:10 +0100
Date:   Tue, 15 Dec 2020 17:09:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/init-defaultbranch-advice, was Re: What's cooking in git.git (Dec
 2020, #02; Mon, 14)
In-Reply-To: <xmqq3608duhp.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012151708110.25979@tvgsbejvaqbjf.bet>
References: <xmqq3608duhp.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iwOayioxtc+fgRU5IiVurYK2CsatoH2Wnu1MFDLuw7a6ofHeb1t
 Hup+Wuemt+SRWvZRntHiAJeumTbYBmA3Ushp2reaDXHFdxh04hVc6Z/ogfSlWhRrzUaSBoh
 /4WGDIyKtIlOvpZwSi5QYREwVQurhSVlFxHUmMfHiDVeXvnz118Du2R0zacQR9bvi6GXBe7
 Ysi6apW7cA4YIyqXeD4aQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DpWcKrm+KkA=:FPBlntsXV+oyBPM54VnLMu
 /Y1c0EVDjjukpUS9mmDpf/ctRNj+NMNK+hfHK9AaV+DsTug+ATGs4wn6vR+DJkGdMz2ez51GE
 bLatMiC6EdpIBfZLh60dUzDNfZXT/9WuZdtNLrM8k9Zm6Gaqqr+mea4k2pFXfwKWPlJQpDG4D
 JKKcKM4nUVqVfpRlbrh86EQJOorDgbuq/H6G5oijqKXgYVruOZhYbidYaBAGP3EpSqrmlV1Ps
 kMoKcCVx2eNCKZjBzPIyAvZAJ4vc+DHrOIAsdoTcAwKK168fxQmyknAx2BZFW5nRNMDTNHnKB
 +WFpK0iFQlLTt3fbG3oh2bAJv6L2HLiwhZUqBi8CePVYq5C9oMy62Yn8drDJfP0x4t8cH3KX0
 Dr3x9tQEdtqnS2sN3VOEaPYrh9aAU6MKyu+mPvCCn8fe+op/BoALUYPyyecpgkmrv1y8ho2pG
 +vuhPDVBIzUFLGVJCuoGDn9RWhLeTLzKRWh4IiQHCaDK24HlPMcJu1Ilr62c88W4NK/u8oQRu
 KWCV0iB2W5/Ver+hg13rwoB/c7gSSfO4Cm3znmYG89kyhPk764lhnjv1ognBO42KluAIjogAK
 eo5tifJNY/CW+rZ7B5IKNIhLfMCwhroGNk+RLRhCzu4biCGzH1Kd6APFJps/dAtJV4qLsWB87
 FwRanQy88l1czAtiQSgpiLxLPN7tQQxLD5TMA9r0bUITw2sE3n/mRme+fFtGlUQL6/3+8K2xJ
 ic9Nr6CwGZ9mvRwfBaaMsprO/OfkoE30c/XTyljbuQ5rddpSWpOKttc9yojxXMSWzhmgHbU5L
 0wF27suG7EXQrRbQOvBabyQy5c8nMjOwtG5u/Hzaftul7HkXgYqIZUvBuJfzwn2YJCD06KU7L
 WaIWP1QvSbb2D71GFT6RLZhJdY1cWKSd3Nxbgg4r4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 14 Dec 2020, Junio C Hamano wrote:

> * js/init-defaultbranch-advice (2020-12-13) 4 commits
>  - init: provide useful advice about init.defaultBranch
>  - get_default_branch_name(): prepare for showing some advice
>  - branch -m: allow renaming a yet-unborn branch
>  - init: document `init.defaultBranch` better
>
>  Our users are going to be trained to prepare for future change of
>  init.defaultBranch configuration variable.

Do I understand correctly that you won't consider this for v2.30.0?

Ciao,
Dscho
