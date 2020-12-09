Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5D1C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E02923B42
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgLIONU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:13:20 -0500
Received: from mout.gmx.net ([212.227.15.15]:44881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgLIONU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607523106;
        bh=BM0Pg/BUvqpJxa8iYefybazRlxi6rE2WSIDB45ii2vY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HdCSxI3R/7UgEfcSndBOA/+gvjg319HGThcIAV91EMiVqcBRPwuD6glG/+RUbEzY7
         3qstZIHqv+rgPUo8Wt47cHeCKZh70uB/aUhojN3R9aGG7KVrjBTcq7410BnGDZc6HN
         /xYOCmUv4chlCyuDZFTMion74H4XkokIMjeDAKns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1kNsZg3wWL-00jXrP; Wed, 09
 Dec 2020 15:11:46 +0100
Date:   Wed, 9 Dec 2020 15:11:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/init-defaultbranch-advice, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
In-Reply-To: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012091510280.25979@tvgsbejvaqbjf.bet>
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cDDrIGozQ5nZWK0jvprdwJ3O1B9OZ9cB+izXe1WHrQ+PdSOJvHO
 IRmKEJHGlWHXTup2RIgrLWsjYqG3oecUyF/nLT8p7DCaY6PrdvxtdtNi9qrdSPMYZutZRMp
 tuE2HZ4bg+rfZZ0rHTjHYf8xXdfBiB7U+jiqqr0HMAx90lxp0A82ICYjeD8e/5MldJN+wl0
 JSKMYN1Mseh9W4kQ5kZRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w5ufi1lfnKs=:JbMbzdCXP6csIHN4d1+N+K
 JYctDjqiLBBKtKxlerxTM26l4PPnV9z6kmuA+L3RR3bng5av/AKZswLWiRTf3D5Qm5Z5uP6vO
 xGLl79ZcrkSPM54dsFUqJh9iTVE/Lh6EUZzb5SOCUlRgyoXX9v+DzYyVUsCLP8dK7w3k9kkma
 0wENnDORblMcnZ38gImHGEq7lCRsXQ/c/e9eSgRH4Y4UYvuHfielulzI5GZJIaQePee+pKGAk
 7I6Mo8KVAKA5Izy35iJoUoNnjipVGHWJDGCcpOId1EHOt3Y8ByoujkhhIZ6u2pREXl9YK1bmM
 FFZZ1ET647CjvCJkzUo67Yv8AzIZhkclei3+4YyT52s/EfobtQMj9O0K9Me6JP+9oYgJu9lxT
 ZDU5NRpylUswxOfSlUapDzXRu6KCwy3XlxDRHa503wNUS2umgonn1L3duKnnvSH/Kyzog2zT2
 GxANVfOMT1b/4Q1Imfz3yivt+hNMrSNVmcjBUUIY8IjQsC2UITiCDjP4fyT6p4/wrLpVHHP4u
 CfQm+P0/OZFNCWKW7JWybWSzfpUJ9rpRwfDUPhqnfhPlGmx7xcr5qKKGw8Cnhil3i4ux8jh0/
 mmEIhjbEsJmWiVHOaP0ljwRdX9gh07jL3/2sVrYH4zWfQyHwYuuITD/AWLOYrnuWtMwbAcGm6
 Yq4a/AttV7Dv5dU9sfFOlN5Vr+RgifluxXh1pG2gl/it/AZjEC1BZvAiABiQbx6ijikO34Kpa
 4/ja+n/LLnAkHP4XSW508DSxn13LpdXEIFCraJ1xQTqRezUp/LXfDHU0ndWt2J2ze0Gto0Nfw
 UWrhKW/GydJEL15DA/YnA7aWHcCEI7DCFpMAWhsK1Om0tv6XoliSmI7uhWcIRQXsI752b5RTr
 FG90Sek16MTKisCc9RjSWuhyfrn8DWGv2o8hw53dnOR868RyPvxqd/BUOFYmuDvEsU6QfvCfg
 4iZDzmTC01w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 8 Dec 2020, Junio C Hamano wrote:

> * js/init-defaultbranch-advice (2020-11-24) 4 commits
>  - init: provide useful advice about init.defaultBranch
>  - get_default_branch_name(): prepare for showing some advice
>  - branch -m: allow renaming a yet-unborn branch
>  - init: document `init.defaultBranch` better
>
>  Our users are going to be trained to prepare for future change of
>  init.defaultBranch configuration variable.
>
>  Expecting a reroll.
>  cf. <xmqq8saqjx2n.fsf@gitster.c.googlers.com>
>  I think a new advice.defaultBranchName is a bad idea.

Unfortunately, this objection is news to me. Why would it be anything but
a legitimate interest to say "yeah, whatever, Git, just use the default
branch name, I'm fine with it"?

Ciao,
Dscho
