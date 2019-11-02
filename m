Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273B51F454
	for <e@80x24.org>; Sat,  2 Nov 2019 23:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKBXD4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 19:03:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:60331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfKBXD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 19:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572735828;
        bh=QcOSKSeQYPCXQgkJtSAKbHQvqNMR86rZC6Lo94wyJ28=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h/iYJd1ZFZxT6hJK23Fjp/z2q2PAwo9ZKC71i9rz35mEXXB9vY0OiTSXUAx4Zc3xH
         lWCe0nfcuVogaEZr3VSa9gVmRKsl8PINzGjvyR6N647fSMOLdRPaJERiZyOt8aiEil
         ygUjgMDKy3XuYaV6EPZ5CdW+gLHqbi8nuEET1UZA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRMi-1iWdX532lQ-00Tiwm; Sun, 03
 Nov 2019 00:03:47 +0100
Date:   Sun, 3 Nov 2019 00:03:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] update-index: optionally leave skip-worktree
 entries alone
In-Reply-To: <xmqqpnib567f.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911030002410.46@tvgsbejvaqbjf.bet>
References: <pull.355.git.gitgitgadget@gmail.com> <pull.355.v2.git.1572261615.gitgitgadget@gmail.com> <86dbb11f159375da281acd6266df019106abeadb.1572261615.git.gitgitgadget@gmail.com> <xmqq5zk7593d.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910300930440.46@tvgsbejvaqbjf.bet>
 <xmqqpnib567f.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KkvMnkBXM0NDG/Gv4PsK92brT7w5qU5F47RHBS/W/b1eEk6GrJt
 07ZGeecAbgQUnoBBxSaXw18bfPu8A9roUmMJvhs5MPpGyBH0UymVmzRS4V26cVhf3O5jju5
 5EhBZeC6axqRxRlb29HPEAW7+fXTONm9CYXh6jybbGT9Msgjyct6UHk5VMo8hsLHKJGTMzF
 Et7YOqFcWWnZOURuZllTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I6lyy1x1n24=:Zfdg5Gx0Ulnb0UtTDeJlMa
 HxtYkDXr07XlADj8eEsZ6tQ4GJM9TLUOdVBaHsCEzRrbvUozRaGOrW9lBvGZfbcF0usz5zxuS
 KaH08rKyZUq6AZm79NIfE/FY0pQO/Tjnr8v8szmqqdv9Hwt6tqfBFUI2K3OF9ZCnLPTyyykoe
 zrjks36xfMnBkcnukRkqxaTiporYGHN5fBWLHqMb/7JNY54h+CjHluRpsI5R7fmJIuBDZUr0H
 TygtpffGYvKjKevU6O8CMgdIBJd3cgIWMp7QdaGZiYJMcXDFA3np5DbKtK9wRacdsLl0K5teM
 Asd5SN5d/UEdOrSsTjMfQmWWjC7caBSu61Y94kee80CO3qvYfxvwp43LzQrBGcCg1zIVajpCV
 K+gMMEVewMBb4Qa2WOKuvMMM0PVVBM8Yn+8osdJKb0BKMwoPDK7hDHG2ILNvAO+Immg+96euN
 F73FHH/9A0/a9bnmg8uemHSHye7ptG3DlhIyCXbWiZjRBLLVzFve6Gp27lsEM8XHL2sLrRn5s
 MTg3b8r6YGr0c4kUKvQvVa71iGIvqskv2ZG1XU91omSl/WF9luuKgt/0GH4nbn7ibnat3pUYv
 3Yg7aWKE4rCEBv4+39KGRESTSgAcM+e+U2O4dGUbf10AZSKHwXA1UK61ftPPDPkYw1i3mJxo7
 3aniJ66ARZx+3PfwMnsDS8lh/Kssb7p/wX1MXQidj/C67mHsFDRbIVUMjV1AX/NdFkLzGSrq/
 t/AOgfPUMQ0PdCPHN4+fA363gHhGBj5o+Yikl4/g409gBlZqOFtEzXfEC+3E6YQCZDjhcWGTb
 bOBcAptL9XxuQ6gXAXHJBT/2AfWzGOI5HMWXq5aHeRiHbPj/c+LKPKjpbf5JpONoIZ8fwUbQ5
 vAT8vUCCqM9wouz3M/YHHR5PwTfNzlMIijo4AFk8VKksUHmmVBj4kDumnuv+AnbvEr/xzFoe3
 HNS+DCnoPNo5q67dl3R3uvALPLuWmFirrOZ/SXHykevybNWRFCN3BROeTovxJxc6+3fZ1xM9+
 mYATXAP4cnb+LNSCMrchlVtq/p/jPURwG4UK/78JZ8S+8ShmamrCorMhDBxU0+9EpUIddFHde
 xenxcNpSht3mURbI3ntko9h1YHlTJFB8J5hpJB9Tpm2ioYALbAluwDNYn4T/k9Rq2+vymKUQr
 kRUx9hc7AqOdiQAtHuYPZ/lKoHZk5t9i6wQi7BYsB5104pGLrOaXGeYnuOBivIfYWF4nk7Prn
 OGs14Hphfu9O5qBZrlxULFOD650BbudjZbZg0vLj2AIINWNSOJ1zBEvsbpH4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 2 Nov 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I changed this locally to `keep-me`. But then I saw that you merged th=
is
> > patch pair to `next` already... Do you want an add-on patch, or revert
> > it out of `next`, or leave as-is?
> >
> > I'd like to know because I still want to merge this into Git for Windo=
ws
> > v2.24.0-rc2, and I would love to deviate as little as possible from
> > git.git there.
>
> >...
> > So: revert out of `next`, add-on patch, or leave as-is?
>
> Sorry for a late response.  I was under the weather and mostly
> offline for the past few days.

I hope you are feeling better?

> Whichever is easier for GGG is fine, but for the purpose of
> resulting history, I think revert-replace would be the best.

Technically, GitGitGadget should be fine with reverting out and
re-integrating. If not, that's a bug ;-)

Thanks for replacing,
Dscho
