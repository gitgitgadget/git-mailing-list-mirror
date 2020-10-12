Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EE1C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BB42074A
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sC6Dyvh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbgJLTTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:19:54 -0400
Received: from mout.web.de ([212.227.15.4]:48487 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730275AbgJLTTx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 15:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1602530389;
        bh=1ozC5TntdoUjP0sHCbZoczLAToH2lmWwVFiVDpIpvpI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sC6Dyvh8JIo2+2Gi+YIM1VVYguMrciEebOp2chlvmm0EQNhop2f1k2yC0gw5P4R5E
         iarcT2eC9Nquyj3GvmrGVJkp7KlfQ3Rmt28WZNnjMnstP69tvEKGIMrqwaWfuxDsD0
         kaGTRBP1GM+LiO6AiZ0cUDFOzDziVUQLi5IZHarM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.28.94]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lheu9-1k6B0e0Bph-00mtE3; Mon, 12
 Oct 2020 21:19:49 +0200
Subject: Re: [ANNOUNCE] Git v2.29.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq7drzv1bn.fsf@gitster.c.googlers.com>
 <ce8f482f-9a78-6867-38ae-601bcc2c9f66@web.de>
 <xmqqmu0rqu8h.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <61bafa3b-bd23-f01f-9a4a-c348b7588f37@web.de>
Date:   Mon, 12 Oct 2020 21:19:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqmu0rqu8h.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:giEAXckexlZqJahfMcH7YBlK4Yg/LoH3hUyySVIFky9mqATKRe8
 qYi/DDUN5wYUmLac/+4A4Zs7WkUgxR51BKWsPwR9q7bL+HigzFN2qY6Eq9dFlxXeqhJR6Ia
 AsH7Ix1G2gSZIvCHPzdvU0j9Im6UUedXV0+tF7rlp3qvs44vrqTChACDpzc3xFQtd8fAxvu
 y6PNxDZZpFZXfgm4n/xmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CYPkTzWy6bg=:sRcx1X06+OxkUPKpgAlRXt
 kTZukeqDW8sD2ryneCfXzM181rSaOnJNY5bt4Nzw0J1rshExfwNqIRIF5W6WfPF0l51siTLpF
 OC333lu8lDWKqidx2IqV4a0U6ttpQZHcG5oNHq5olSQdhwWQzOGvL87/JykxRfPJruzGbgi+h
 V+36Iy4obOaHkpTDz+2Nd4Wr8S8u+bFP/XQvCpzH4Co1ek4b3c3AutK0EA9ESR/cKSQ89JnuX
 Mh246mb8XTWz14o0Lu/H0/VzEtiLP0+RrNq51YHQKsTDjFjj9J1FtPlacgVtjgecaPjEhiWCc
 pzL7a25hf7d72IA7hsDDztabCaymwN3mvoeQ0Yfdn/YO9jXE4Rb5ClqNrJAQXMxAcqFvKCqFF
 QAXTOo06oEfFH3aQ2kW0KD/+lYzHbM0jGwNekliw00mdaTH5SmGMF9oILvVUQmoy+XDIZp4CA
 Z7MqJsGKMmfcpI7dpB1qruSvZ+SgWwu15BTBElTjsQ18mnIrdo21sAY//j8cqmLRxGb1zVrRT
 /tJoTeOuSOeyLSxt0CvqsAbg+eiB5EN7IHbo3W9/blySYiMFCjyA/xOXctZLl74AYgFbxA3Ti
 I3R0lKvKy9XDkGlJjcU/8X1ZnPXeWc1T7/usBOqXfLas9zCTJE06zno8UFc07D0JuIDGIIU3b
 PoNy9Z9usIXCXKaZWvrAYi24dQsLRWhqMKHEK4l9Z/i3Yw2yZ1HeIkaTa5dcFurWhTDOPn1Gw
 AfE8/xgGlAJq4p7GMBgE2pgdvffBASkhPLlJJPxjwBSyAwNjvURqaUlm2M8cUHIAh+sXI9M0n
 XHqyjtEggsrC0Z9G4rR5wtrLFVROQE2lHqHgjY5OSH/V+oIOJM/m5cxxHuksZYoVR5hpglVBh
 YZqzPPau5IRVeVNsptGwaXkRxK2n+EkK8FFegLtjehtbDpQdIotXlJmJaFGa6fOV+26dzE7jJ
 hjSXvTD3f19/LCkyr0W/e5QMOR37QtkXMhGjmJ2weTZmNn3aHW+TZ0znLI5H6UBNQ2briwd8+
 zrleQNWUgqcRhbreYFmJyP/tbwY4qpUdayDeMWQ/MBSQof23qR1fDu8usCIeinng0ZuHqCoIx
 0NeKoDh0BsTN74hLsTsprCoAhB/fYtlSH6T00PVz3ws67wxk9iuMkPh+tkySvBmPtaLXaktmM
 SYU1B+PCOwITx7B0FQk3KjLXEBIYw3+xw5q0X3M/U4SNFXbPiCrgaSkffTBDtE93v12E1DXtA
 AdXVZjTuak+jQW9Mv
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.10.20 um 18:33 schrieb Junio C Hamano:
> If this "feature" were experimental and if the experiment turns out
> to be a failure, would we have a viable alternative definition?
>
> Perhaps "--add-file names an untracked file in the working tree and
> the single '--prefix' that is used for entries that come from the
> tree object is applied"?  Or perhaps remove --add-file entirely as a
> failed experiment?

Removing --add-file entirely is certainly possible, but it's used in the
Makefile now and I can't imagine what would make its disposal necessary.

Turning it into a standard OPT_STRING_LIST option for full untracked
paths and using the last --prefix value for all archive entries would be
a more straightforward UI and might be versatile enough.

Ren=C3=A9
