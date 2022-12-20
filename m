Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DC8C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 22:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiLTW4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 17:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLTW4R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 17:56:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE7C17AAD
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 14:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671576971; bh=iZLjeZkLQ2mWpk15NPBspU+KpBXwXJdv9gQSm60r3b8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B4Tyr7vzYiyZRHSgVOs7SBIKJhNTYGZRxX/RgRdHGCTYL4M8/hG74nqZGCXtwn46I
         OzH3aofL+vHoDvG3iKM5xcwQstFmF95yELRZMQyIW40LsAR3G+nj+m8SIZu+gdqLE/
         +PF6DpSEGFUiHGqBs29T7o6/5fdyVROlnxXHZ1zHsx7CzV151De4MQnMfibV88sTDq
         +K1CpH8wZrFP/AglWeGj7Dle0lIwjWRZI+r97Ywm6PeiCJaz80hoLwOMvKkuIqnz1B
         VQt05hTNIWeLZevkmGoUNPeV+fYB5ocUQS1P/7C1jq+LbKionhzs/FiIY8P7E3jo/d
         C6eavQ8EC+D8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.64.45] ([89.1.213.120]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1ojjL10Bui-011x6F; Tue, 20
 Dec 2022 23:56:11 +0100
Date:   Tue, 20 Dec 2022 23:56:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #06; Sun, 18)
In-Reply-To: <xmqqh6xtw4uw.fsf@gitster.g>
Message-ID: <b3e0db14-6c57-4188-7217-b38b5b0acdde@gmx.de>
References: <xmqqh6xtw4uw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fIdyPY/yOT1vYwjXP8vnhHX5QpLiAEL2idj+ific1FCPkd5QCmT
 k58QWFE0Y94goXfQFfSFdg6g72q/a+DwY0doQnV+72SIZn2AKrPA20Bq0YxNkjku3+c5ZKL
 V4yklWmKtRX9NcNgHFPVOqL8xlRNGWsZSl/S54HBWcOR/riHCaOl5xnZpBAE1vDRw+y65Fl
 9f3uqs264lGfZYi7D48pA==
UI-OutboundReport: notjunk:1;M01:P0:Oh6+7+4Igec=;qhBmxMLnvzkJaWhqQeGPBPmtTWL
 RtFF3SM+h3yCdOEDO2oArZX9RgZMgTi32JMQnv268VHUs6YodZ/bTCRZfpbExkn3A3Ut5d4dD
 HxtoMYg63rIwLN8B45rMYjqAQV2SQG/1jCsCNa1jBLbELIx19f1Tnbpyq4lg6AmrO67TOp66Z
 rcaiHwLZk0fHWG9gnaHYEOCQtDsuPW5XCzt8JJ2dOKL0mDaWy68rv3w3667IkEdXuhRI9bGT5
 5z5KTEGtN2SgJWep37h3u/u5LuZ0LQCJQljTCTNyif/PSXWd9cwf34hWVwV+AgfuhFAYj5i9P
 v6beAD2D42nQ9FiLMAgrTkhwKGsfiyRCWQ78lWrmxU2PNu+Bw2ulz69CEfZYeiEMaS+zSXSuN
 XmDk25iJ5EqPtEwW40u58AYCnZ0pqX8m2booQ1pA8F4N0A0OBettrpbYHs2m+LhwbtJRjkOop
 lg5La+eFoh9djLznTE53pNgTzuA4T0m+DO8ddNkDa6Ye8PIGdM3HdohlGjHfJRJwpJu8pBLSI
 UhgJoqtwGCOh/8DvWFu20y0Jdm/Xmt8xAgvnnoOxjT1nPLeyUSSlNRZ00dfiOspSokHBT4Cox
 NKsiMWFKbTskGg8cv8AbTYvY7xa1VA3Ylz9znq9wnlYlQl6q3ontlMXPNdEKHK4Rp+IIAeXUI
 KP16o4sjxpbTslheA1Nh0bRoM4wWNHuC2Yr8jiEUvonEEEeiAJiJqdODkJ0YR6qT8rFxiXXfb
 Fqzy0SYmd0jJzX5AEpgAy9bmzw7iDlH3RawZc68W4Odin7b5ubuem0j9zY8taO/8OtfVsPpUl
 UjpdqQhZqrLiDixPsYTjSQKU7ezMNrKH8GngKcGRVykzf4FGaiF9U2/Bi+vnHQF+PYazB6GQX
 bM8ov2fxA3az0zn1jUXhb0lOwZLG8OfksO/dAkphWXsy29EKyi2dSF7HcUH/P6Y4SGcMRJEbn
 chDn3w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 18 Dec 2022, Junio C Hamano wrote:

> * pg/diff-stat-unmerged-regression-fix (2022-12-15) 1 commit
>   (merged to 'next' on 2022-12-16 at 2a61376847)
>  + diff: fix regression with --stat and unmerged file
>
>  The output from "git diff --stat" on an unmerged path lost the
>  terminating LF in Git 2.39, which has been corrected.
>
>  Will merge to 'master'.
>  source: <20221214174150.404821-1-pete@jpgrayson.net>

This probably should go to `maint` soon-ish, as it is a 2.39.0 regression,
right?

Speaking of regressions, there is also the bundle regression fix at
https://lore.kernel.org/git/patch-1.1-2319eb2ddbd-20221220T133941Z-avarab@=
gmail.com/
and the not-quite-ready p4 bug fix at
https://lore.kernel.org/git/CAKu1iLWvd+PVOK405Q+SNDyyYnhbi=3DLtovZvWw55y6e=
QqoRpaA@mail.gmail.com/

Are there more regressions that would maybe merit a v2.39.1? How imminent
do you think Git v2.39.1 is?

I ask because I'll most likely have to prepare a Git for Windows release
before the holidays for a couple of regressions in components that have
been fixed in the meantime, and naturally I would like to avoid releasing
Git for Windows v2.39.0(2) only to release Git for Windows v2.39.1 a few
days later.

Ciao,
Johannes
