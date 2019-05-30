Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462BF1F462
	for <e@80x24.org>; Thu, 30 May 2019 14:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfE3Oxb (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 10:53:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:34599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfE3Oxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 10:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559227999;
        bh=0qV3lEIi8HZ9nj5Oc/K9eXSDdko2a1hG75mO2wi0xXc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fIMKlelc6tjxfdsHbbIGomA/2Cvg5//aQtUT7v/MQ8ymSBreM2+wcN0i4O7vEF3YU
         k+bBpY9eC+NFx5Rsl+yRSQT9myVjFP8Snmls5d7JtarorBpI6b9dm4hNKL4idtFtJB
         y2vF9fzvNL480d9KLJBKLRax2tmqD6IkcbHxDXB8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.166.183] ([95.208.59.239]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QwW-1gUrt30NhW-011VgI; Thu, 30
 May 2019 16:53:19 +0200
Date:   Thu, 30 May 2019 16:53:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     James Harvey <jamespharvey20@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: Request: git add --interactive: split hunk: When can't split
 further, split on empty lines
In-Reply-To: <CA+X5Wn5bt-3zHUqtRDWtc0A82SFmWPuQ0+RvRLaAV6Vn24nf4g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905301644020.44@tvgsbejvaqbjf.bet>
References: <CA+X5Wn5bt-3zHUqtRDWtc0A82SFmWPuQ0+RvRLaAV6Vn24nf4g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dRXGv5GvrkHD6JT+0Hct3gXuPXId1kjMwzwLz07ie/uBQ7Yditg
 vHu6bZWq3pncqHsWSpVDer/mQaXqTY+pci9RsN689fjmwiyFn+bYgSpZ+WKrlVs7Obz68k3
 FqkSb+HcOlZ65tCNqK6pVmgpFQW9TZlmqGwgZhZqUOWyLPoSAuqNH8a8vytymRS0hLBq2EO
 ulQSu4dcmMj5ownBgFTcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SbtntX4/ISE=:B/6gb4VsXNQ0fZJgbJ4DAn
 2H8EdK1psLXT1uwjUC93sazIoYzy9Zev15fyyLhpd96SYKhxF4gzYDS0bSuVIOeiq/qMJ/ecD
 0MMq9ky+FTbBiYcKt1upSiZSDPf0wRVMl6pG1euBcO3t9N/1bgnS1YFEqBuSATiO45alkWjPV
 /3/FRuLMmxHbEzZHTnSKs36/PLtHzrZVi6PNR8vf2z2Zb6GxBgPVBn915VphLjS4tS032j0ef
 Jbw3FIU01Bp4p2M0vitysS0O3bkSYfuv0WkBCfRWcTE44CB8cC/nCX6ftqznrqHNXeYEEoGvA
 WhuzfQ2gFY+DG+kGpN0bIZQYI6b0vXsQERR0hzblTJhUKA5cB6hpBs7l64462rdhr1LZkml9H
 I0s2wth4P0vzTYE31VtmNiJH9Atwm+eyac/ITmfQOLf9GLrdACgiy724tQ65eK+Wk7SOeGfUH
 FIDcNRl8xn25GDzBSSGoiw9cuHY/5dYCZOiXAUpGe87bPTDw22H7PXc2XLVYDnxgnmGMQzftK
 In5i0IC9dta4NSx1kMPGgiIu458KPedVQ+Da8OneM/hKuDwWgq0UGHLH8nUzIeaZplIZU2IrI
 Na3xnHU1n+tvJI8oWi0nBlpIS3vRTRulUXrSQTesPC3O76kbTHHBguyPorx5dAWGcu9U/lbH+
 0uC/6+FPIYoEV2QlU1a2a3MVFlnv4jjLw7i6Sdg+ubDXNQNAwlmF9QyQmEaMfCtraYcB+9ZBA
 8XUMFCiDtNZLuQAc9Tr+J1eYcEtOPunjFp7C00RMVSztvYaNbC7HgMxSOhal+y78hDB2EMpxl
 ydSPMkaocmobmW4S/k8euRL87T4BWQ7FkM9GShaC8+CN0VgHbbmMI5OkrHnh2UvhVAwKALUhx
 DfYldBimf/CvmyGpWLmlpjTEIj+5Wv9VCoS3k+CAvjbIsrSjKiuzk03SHhEdWmuUVckzlRICE
 y63GRvncmQZBo9/NZCyodUsNVisbAByNOAOzwpHRa4kw3yK8S2lg0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi James,

On Wed, 29 May 2019, James Harvey wrote:

> When adding interactively, 's' can be used to split the current hunk.
> Once it gets down to where 's' reports "Sorry, cannot split this
> hunk", it could be useful if it would then start splitting based on
> empty lines, probably leaving empty lines at the top of the split
> hunks.  It certainly wouldn't be perfect, and might create many hunks,
> but it would be a nice alternative to manually editing the hunk.
> Certainly someone could still manually edit the hunk if they didn't
> want to use it in a particular situation.

While a neat idea from the users' perspective, I think that it is
technically a bit challenging, as you then have a problem to coalesce the
patches appropriately.

The thing with the splitting at context lines is that you have a much
easier time to merge individual split-hunks into a "coalesced" hunk
because the context lines stay context lines.

Having said that, there was a patch series recently to add the ability to
stage individual lines, and I think that your feature request could be
implemented on top of that.

In the meantime, an Outreachy intern and I worked on turning `git add -i`
into a built-in (it was written in Perl, and the built-in is written in
portable C instead), and I *think* that the plan with the patch series to
stage individual lines was to re-implement it on top of the built-in patch
series.

Would you be interested in participating in that project?

Ciao,
Johannes
