Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB981F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 13:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbfJ2NAp (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 09:00:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:38845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387868AbfJ2NAo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 09:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572354038;
        bh=asCLmhMUOyNbRTvbR5T2t9Bd44WXPbep0D1vP3+iGAs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NODlKxW3rYDhmWRkhOfUhAWT8FgjJr4+ffg8WmPQ0AnwwUfTKQk5BPF8eFCNT34mK
         kxS2g246yVohbS8E59kjBq0msp4L5g/3LRtZ6NFW2mf4uHUJvXbYjCSZy/8yjpehxB
         opiqdJKnvzrBcQJgCd8QeFszNYiKErtCs5Kpel9k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDbx-1i7Dlw48S5-00uZLV; Tue, 29
 Oct 2019 14:00:38 +0100
Date:   Tue, 29 Oct 2019 14:00:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 0/3] commit: fix advice for empty commits during
 rebases
In-Reply-To: <xmqq8sp48fxl.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910291358420.46@tvgsbejvaqbjf.bet>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com> <xmqqr234i2q0.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910251402190.46@tvgsbejvaqbjf.bet> <xmqq8sp48fxl.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Wn13W5FsqP54FyCL2jCrQVvGFe1DT/HuDyMde/XMrVySEeHQgZd
 48bAdIEvV0KgYfuSDVLeQpdnIA7vBsc7ScDMW+skEfUJULJcDZPXg5UY/qTfmu6xu1etWxU
 j0B2AKRkuqn/YkxHdIbTAx+jUZrMiTZzDNKG993OFp2mISZXb5tzjQWVrwe5Puodc5ejW+b
 pv/R8VOXhdB0hMvk3caQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8A3PaY8MPbQ=:at5UtGKtP3LbkmZRVKSdYT
 rakKqkKkoqmydgHxkfRSsjdT7ZA3AawQMh+w2OuX72KUqPJLLIBGX8Ts90yViqEf4nC54ei2E
 SBzjdN8eHm+l5gtFg/nIEU5Sa8ENqKovk6F+R+LmtuzQYGCSjywEImbp64aU4q23ch43/8Vgm
 EL8VxX9MstYGN1PNp+gBsA2OgQyOJHXY2GYKSynyDsNE0L4eB3gHmogk2TDX0+RgXbQV5bRIb
 YRaPkISLQljVQzFoWI4wPe20ox+64doq3XRFotk1bjFcQP+bk9xlJF8QC4fuAca32gSfd+OVu
 EgIdoa7trFjtROnvZqQ9Q4eMsdguGzuNUZ+uyqwfYu4ur8l+Edaduu1bL9Y6wsxoOLHgXJFzt
 dl9LU8APQKKhVMd1ywP3Ru2gF+i+tizKrybAzIvLbUCvHG7grSMYfYGxlLaZn06d5XkOEneNd
 z0gJT2IpX9h4dpBAgXl2CNzP/KmPEWXKSMh/mmB+SFgySnuVZlWLMsHHhxFrRyrjhHNwMYOVq
 evQOmVYhTb/IidPpef1FPUoA5ONAyvwGOfN3BibZxGsFVQCZ0t0wwhGrD/RyQxNq+QwSHf5cZ
 Y/DD0s93bZP9j/Q/qhLC4xFNTUMQjWfic/sIRJGMw8tlUj6bJY1D8PA4xK0okQG7Xzg5123gk
 6ZWYYQLGgZZGjO0anqNm09M024KwfCNxWo6ipf3+Awhs5qDj/X+2tdyrp6QIGjprn7yTg+jO0
 9rXHPkmOWNVKbuWTMh2SRVwpJFwDQXKx3QSPG1aEbhpD8C3eJsbqH+GDeax5StCU+bsU6C6g7
 SUghnXzQU9Dk9/X1qg85lk4pM90N3vKcZjZK0sb6A25O6dKo+r1xL9sLq7qWb5Na79nivGlUt
 Iy9BrJcK5haJSxMetRyWhmkOXNsxzjHTZqaplXNEKzcxb3W8WmFGFrogGuqKU0MWPq5MXLHlF
 /ouJge+shnEyOhCoXjLc56/5GaVzXnXNIAR9T6HzXj7l+hB6jsGXpXELxVJTRMqdgyzO4DLOq
 dT8cwMxdBNW7DZtP8aoCeEp+LfsDOD35mt+7OlMaBGBBeMCxK6R7v4NPhhq59hupVvV6pPo3N
 KkoOfG5yLFF//gx8FdfUGlQcSI1AH/NQdA925pHvsEClx2xAU1/gH2sH+eC0LH8TuNdJ5+o2R
 jbZAZ13NcmntGuG6UZ7WQK3s1S9Lwm2bB/eTfgz/akxJ4s/31TxBdNvDMBvnWDKW99cqM8W2S
 I68ZuuI5934T70oZ13VoQX5+bVq16ewTmSsUjsrz/FuA/+VOEXgL0k8XufvI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 29 Oct 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > As the bug was introduced in this cycle, I would like to see the bug f=
ix
> > in v2.24.0, though;...
>
> Do you mean that before the change you blame for the "bug" things
> worked better than what we have at the tip of 'master', or do you
> mean that the change you blame for the "bug" changed the behaviour
> relative to the previous released version but the updated behavior
> is not what you consider correct?

What I mean is this: previously, when an interactive rebase interrupted
due to a now-empty patch, the advice given was correct, of clunky. Now
it is incorrect.

(Previously, the advice was to `git reset`, which was not completely
helpful, but now it suggests to `git cherry-pick --continue`, which is
incorrect.)

Ciao,
Dscho
