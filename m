Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA4FC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 08:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiHJIkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 04:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiHJIk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 04:40:29 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5B4E49
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 01:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660120818;
        bh=YCz6ECLSFUAER/Fl6k+0pUgsFAbMdn5K2qjY6PlAadQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cJiTRhOl8vAHiIRomwuG6kWj4qy2uqOB37ivajTQGiPzism4Q148QANzFZEnCkqzb
         4VAJZ7a6obcvKWZkG8oOG5XKaVoK0CT9j/5KrTIOYajEWdjFHBWBOSHrnHtiPhGNeW
         WNW+/Hy02afljgHOamw9InDSq7MXMM7moYwmT/PI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91Pe-1oHrEq2DOY-006WMy; Wed, 10
 Aug 2022 10:40:18 +0200
Date:   Wed, 10 Aug 2022 10:40:17 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Calvin Wan <calvinwan@google.com>,
        Alexander Meshcheryakov <alexander.s.m@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] Unicode filenames handling in `git log --stat`
Message-ID: <20220810084017.gnnodcbt5lyibbf6@tb-raspi4>
References: <20220809182045.568598-1-calvinwan@google.com>
 <xmqqsfm4prqk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqsfm4prqk.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:C7qK+nWJvl+C8MzKT6kyDYn+Oh5dQLlplch+mG1A7w1Ubd/Ygow
 0B524tvAH4xyLyeC5lL4KHNzgQgHqLDO3iK3U+AwdHzWc8lVn6HrmH3KlrvKhlFOTxf5FXO
 Yv9CQg23J7Xjeb6JLciNm/mCdzeqhYaRH632PbpYLw245ZJh3Su7fGUC13JGRHN4JpNcKdu
 XNuUJmAdPOrkPuRasHLmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yg35v1ebVXE=:yqaeg+Fxm675XycqvzpPav
 lFPjC163jhWycYzu7M6LN6xYAXqdtQ+9ETR1X3yFmBeBP7fGVVtVpuCqi+PSUz1Se443oH9MO
 bV0Mg5FOHaScd/CQLMy8Ga+o4pkahlWdmrCx/odyqs7svFLavCfpyxIUqYwff5+osvf3sADmE
 WmFtyjXs9wPYnh48ylU9WEmUK1yJaygJBtLj/wuuJiYV3HPKhOvEBpxLIEh3YBEsylPQbBaqc
 sllfW67n2z5t7EmE9wCf/s6dMCwMxSy/TP7KBHK93bq/u/6qNFjDpupUkLJfx2Z3k4CxE8/1O
 /PuZtW11WJiZxkifWuicUb519g9jNes8D35lTWqNz7qwBwq2Uuw6B7QWKmNB2mTuFTv1cdvkg
 UbZ8pE6ThHzhW8BxuIXbXfTiFJy4yp+9aT3lzY5RQ9hFT/AhNP1LjiTxDlV7RCKPj/sKqLkvX
 LsS6SGdPdpwexUI5JdEnheYNoPOoT7TCMOPNlGhA0MG0PVzmx4RWZN4mdSHfUcCTNJPlZmsMT
 RyrpVY8DndE8kmIS344/krqL57q7dG5Y8LXg+etLonlTakr7VZ8VKVQp8B+K7JSOdTHEsQz0d
 mNc1KIsAfFajTBceli3JYdiXSgXM9yPtm9AbDr+RxTG/Oixv7FVHJzlbM2Madyl0FMfQOKxpx
 tTE8MmhnRv10wHPdvOIM/J61oDJ+ICenwWkzCTpfh+lAkTyMbYSq0WGP87rsIhQB4lw/nUaRX
 reBDycS1UOvDSQfhqvcMwut9bGQxdUU4XNmESkZ9SP4DbgLFI+PheZZH6drbDLrqSZ9Bou+wM
 IFp5UaHUjzFXX0NoheI2ig57RVMncOBf4A0+8dUKREjmqvDAGx7+8JZkDHLxEZeJx1PMzNwI2
 GGYQ9tvHEXbbBJX+xsiGKO+pWxJmQQcMBgbKIgXPvbPA5INVLGrmbGE/rxcfjSB2aTkS9LCib
 H8pqMgYlNeh41JsefEjF0c5eDMatK5NqaFYzvtqgp4sM5GJTCY4GSLnOVMNf7NSDThba6Mcro
 43chPENT2Ka/gpgzH0Wlm99NNMvzqAl9HqC0OqGj2c9wAS9aJhsH3iFm0YXKVm78zAfVKnr+h
 5TFJyGk7BEv0z4VFXbeRQYPb0hoDMuz7piKBd1vb7LGw51mzvxevzP/gA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 09, 2022 at 10:55:31PM -0700, Junio C Hamano wrote:
> Calvin Wan <calvinwan@google.com> writes:
>
> > Hi Alexander,
> >
> > Thank you for the report! I attempted to reproduce with the steps you
> > provided, but was unable to do so. What commands would I have to run
> > on a clean git repository to reproduce this?
>
> Sounds like a symptom observable when the width computed by
> utf8.c::git_gcwidth(), using the width table imported from
> unicode.org, and the width the terminal thinks each of the displayed
> character has, do not match (e.g. seen when ambiguous characters are
> involved, https://unicode.org/reports/tr11/#Ambiguous).
>

I am not fully sure about that - I can reproduce it with Latin based
file names as well:

 git log --stat
[snip]
 Arger.txt  | 1 +
 =C4rger.txt | 1 +
   2 files changed, 2 insertions(+)

=46rom this very first experiment I would suspect that we use
strlen() somewhere rather then utf8.c::git_gcwidth()

More digging needed (but I don't promise anything today)
