Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65112C2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 13:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F7820936
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 13:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Akg8D48+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgKLNtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:49:41 -0500
Received: from mout.gmx.net ([212.227.15.15]:40943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgKLNtk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 08:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605188975;
        bh=u3R6GyG01MPVSnZWkOLuG+tqZhSsxRmiuOI/fzGKcRw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Akg8D48+sfe/dfhQv2PzMJRduZLzgQldVyVPeLvatUEjcNf9gJhsoYouiNs00/IPm
         0XP67/vDAvoyalCtyAcqDwrW17Pe/lpvvA1PdPcNQzG4dJWjvH09QgLQ+yBBeLqF6Z
         dBttbOBkLw+J+YnKCfa6bBywMV0t+yBLwwLGTDz4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzf6-1kmasf3JPW-00Qzfx; Thu, 12
 Nov 2020 14:49:35 +0100
Date:   Thu, 12 Nov 2020 14:48:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] t4013: prepare for the new default branch name "main"
In-Reply-To: <xmqqsg9f36nu.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011121443100.18437@tvgsbejvaqbjf.bet>
References: <pull.783.git.1604829561838.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2011112137390.18437@tvgsbejvaqbjf.bet> <xmqqsg9f36nu.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HbTS/z1DFbJTrZICaWbSr96PAHFsbOh6hdDLpLABx5RuzvjTsYK
 md9lF3C0MSlCczwwTT9DEKvwlvWhLBXcb0bYXbgCUt3dZ3bg8OvOk/xH+h09m2l2am81XEn
 Fb9hy4eOWgdnsmD2vKbItyc/8thyTNVTDDO8TcwSk12+mq/ooFnsbQbcN1x1UmILVNAA765
 t/ExDFUJ8pZA+DhZX6MIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8dQSj2b8OOQ=:a5qR9tqrp70+Ge5Sl03+YS
 haZqi+B+t+gLSCdL4FjwPVyLyQxf/kPmMFjQxVOVYxeif6o6A2Cojmnq2TwjxDpnoq69gGSdf
 K0y4IXvD4eY9PcDmnbDBzvJ9jF3sAk+wj0ShpgsW4D0Xo2MvJMgOIS4SsB5EKyVj9A44AGB7L
 7xtvID1tcZ2n2x7IlRQxq9bSfcH9oDxSt9cXXUiNAhXHzl9oVYjL3eRFX/5BSwJU1JdS9LNBK
 DNm2gug2S8cve74DFDCOpIdqH/MjHJl4OwHmD4uyBuou5pT6gPMfHf/unici7iXcWaDOfLuNS
 qNyQFcK0MsfNagQfDcZGCLR/fZat06AQJ5RDtLJCG4kNfjDwOaVxE/YNKSRivSLuvYPW+UZrD
 j8brkX7zsB3KMDtc/zr5X2pxKcT/J9OHB6uOn4zoCXxgdvdZ5H6uPs7TUBoNeMELkbofCcTry
 0WzGQARKTjmzSdNXioX2Qw41bxj2xlPYSQR2Dod++OR1ltOYet+gzn+wylonX7DT17eT4ilAf
 aDU/3r2VFJ4+7gcDC5C+qd4DyPlalzIo1Y/RpfE/gKSQezA3ngGYlsyOEM3xB5CCERBcBCROb
 iz87rTJFb/MzstwE7yqaBF6oXuomZxVA2yOdTN9OIzd3uH3d+XQGmYf+zolQN29jZieGJ/PcA
 SdVGy6EUtChc8w4lNe4omESs3YXV4UseonwO7Z4yxoFcxzqQ/dKV7S8sSjJ3t0VLKtUumD9sq
 u3RPg4WqtqI2v1dsdBW33lV8CfJqfUVkF9u2dccu1p1NHoFjyxx0aE4mEulXkFwvGenfPSHnT
 te/wNPQZoZ1XAev7wuGvqjRP/gwM/FWl5pEhfgcTxqOCZ264eTy2sSIznf9RTEzYHrs+UM0ek
 //irIlvAd9+NZh7IFlSlDLMHf5DT9J9YM+79KiHF4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 11 Nov 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Could you advise how I could help advance this patch further? This is =
the
> > last patch I need that is not in `next` to get to the patch series tha=
t
> > actually flips the default of `init.defaultBranch` to `main` (see
> > https://github.com/gitgitgadget/git/pull/762).
>
> Is it an option to add
>
>     git config --global init.defaultBranchName master
>
> at the very beginning of the test script without making any other
> change?

Unfortunately not because at that stage, `HOME` is still not overridden.
It will be overridden in `test-lib.sh`. Which is also where the initial
repository (and hence, the initial branch) will be created.

So: the suggested command with work neither before `. test-lib.sh` nor
after it.

I understand the desire to leave t4013 alone for the moment. If that's
what you want, I can send off a patch series that _specificall_ excludes
t4013, and will the follow up with a pair of patches that ties up that
loose end.

Sound good?

> After all, we may want to avoid 'slave' but 'master' by itself is
> not all that bad, especially given that it is used only in the test
> script.  If we were to have "does the configuration variable work
> OK?" test somewhere anyway, why not make it this test?

What's wrong with the test cases in t0001-init.sh that are labeled
'overridden default initial branch name (config)', 'overridden default
main branch name (env)' and 'invalid default branch name', i.e.
https://github.com/git/git/blob/e31aba42fb/t/t0001-init.sh#L554-L572?

Thanks,
Dscho
