Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1F7C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 12:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiHVMqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 08:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiHVMqK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 08:46:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4B33341B
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661172365;
        bh=4HF2nTCPxA9HazWhmljIdj5E7yYc9Cfds+34Xw5ooNM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IEv0Eq2jOA/Z1MpQtCEn4xj+ND1uW3uEWvLwa9abrTvJfLX9fbvvb1yu7eDl/SVZ4
         2AAB+bUK8zFBKlasEm5Gnn7xj9Z1U0imJuDPee+3xXlfeRLyXEUbj4yfdtSM+ARkOm
         ucc3DPDOffyu3cHyiBXI9mevUQ56AHah7Yee8yE4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.137.196] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFvj-1oZhjk1iUv-00AB64; Mon, 22
 Aug 2022 14:46:05 +0200
Date:   Mon, 22 Aug 2022 14:46:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t64??: convert 'test_create_repo' to 'git init'
In-Reply-To: <pull.1303.git.git.1661034837118.gitgitgadget@gmail.com>
Message-ID: <3pso553o-rr64-9412-n1q3-q2n457r51448@tzk.qr>
References: <pull.1303.git.git.1661034837118.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rFMaLgxZCuHLrAt/S8ONGx/14QW9WfzOTq3dZdKx050DPLbmGPO
 LfuzKOGBjJsW2H3/5BWdVPhd4TCKBCpI/j3LwfCiJpLF2j/YmN7QoHhtX+hce395vcfBAAi
 JIfjpiA3Q0LujM8UlzRfAcH+0x7UWFFfbNT4P3Fb8AIh0fUAjS7GIK9uuYz61q1XvxD8M2u
 xv4Mz9UQIuY1RO2FGzXjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/l0nHXNwkf4=:84cEhjWgKwCUHOD8Oxvntt
 sNoLpeSx0Sm3kc3kZNnbrMwp5bA4Ll2SzI6YEltxAL45zBdIbyT3sS1QalFyRi/OyZxNibgo7
 8n/tCX5SOeLaCs4sX04ZADdsuXDSjzqOxI3SFKV/N2HVAOy7mrI5za4hblMOgYPKugcukYUk3
 /wJ1xLkQCVVEMtlzmERNPbfiPct/zmLWXEarnTPl01X7fzd6SyVGU3uQSVuxX3zZHFXw7B44c
 zi2QpwhmHyPQ5/ilJ4E0zfA0XA2Oqa2Scsxm7U213gZLIzBxxWzIpYN8qP7/6uxGmxwL0PARt
 TlM3vPartZufjs8JGrTDUpaDNVE1TT8s9GD79tPxMhVrhnpX06ql+BpFP2oz7MNrMkaNCs9ZN
 50J+88yJkhqdvVZ1jextCzfLZ4t32xh74WzSFr1cygULqn04YfLevRbPlSq6zcylQxVV0KqTA
 +25gHZhyj1af0mnLICnHdc5zVQmICD0EbWcJes33XVhe0yXE6Pt+Kp8cpajSX7SC2JbFwe0+2
 AC8XCwJiHsu8u3jQdoZNFKJ+yNWBgZFZBTMEBDfQckPS7GkMRgjUPuojQEbwLTZQ2QaKy+JEx
 rnyg1aC+yA81l61Dro8yOXAJRl2qo2fvreKE2Il4opt4Dj5gv9JIAJtEh71zUFxvt6AKHh82c
 3V7wphTJexcCKCTDbeVAhe7fUGSPn1eFk2/nZUFwa0ZKGrXj8pEgx4TG5jl0pSG5kx2zBE31d
 PU5idj/gh+XQmB6wge1BXjTMYQZupOpD+c0vl/aUEMrMTfbD8fA6S/qSM1VjcgEGKpYYEF8bY
 XerqyOO5XwBLivSOoXjreVW3/WpXPk93+NotOB5E0mcAeAfmQjol3Wg1/GLscaFx7RKgHXD1O
 ex9rksZDgWD7MbQwh/n5W+z4+WqIwE8Cpcn5kxWnRyMZc9sEa8jukFeDOw6+HJgmUd+2aNLg6
 YS1fK13Ql+8R4Yt0SQYQvdaLIeRT94hEQKXI1Z1RwgFZcOxBtrysKFx140ok8J5k/vNAaxeLI
 BjXmwooP4R1kyoYLP8vq2u6bPKFad5Zki3uCP8C2/jTzFV8VAFfA2WCEt2K1Uoq6eVn49UMO0
 fCR5SqP5rWCmjrdSJ5whEr0n0yv1xoQhASRProaMxLmfehDI0Hk4PrMrg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 20 Aug 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> As promised[1], convert the merge-specific tests over to using 'git
> init' instead of 'test_create_repo'.
>
> [1] https://lore.kernel.org/git/CABPp-BEcojvfeuhp7rSi-O+9oEu4KpwPDwbKS-M=
iD1qCKde-CA@mail.gmail.com/
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Large patch, but easy to review, and the commit message is clear (and
despite being short, follows the structure outlined in
https://github.blog/2022-06-30-write-better-commits-build-better-projects/=
:
Intent, Context, Implementation and Justification).

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you,
Dscho
