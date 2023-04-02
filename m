Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAEDC76196
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 14:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDBOQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjDBOQT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 10:16:19 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390BB23B61
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1680444974; i=tboegi@web.de;
        bh=3pXjhrNANJ3ufxNpUorIsELvUteWtHocrHGbD+JSjpk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=oGtcvgDQhDX6W2TBm4RJbDAH/yWkkD6O7e/R2nuElZmeZEvnkAKsJ/Tgm1YheauN/
         di/ZnpLozDHeYDVO+B95peuXz/H9BJs2nG8Wu3MQ+qBKR+T+8EmzNfvsbMT2ax2v+p
         OgF+ANB1/23ziS/wG3LbXoUjED19UdCpCT9fI/TjbvQc+ob9boGtJjuWj4LhjlayCO
         aSkISX5+wsdTfamA/WCPyP05dieskV0Mz4qcfO4wB91iGCPZMqMQtQtIGsMQYI93dJ
         VrWIlpGrmlJhTauOTZlgdRIk/VtSYOdB2NvTUntO4V45QTaZ0DkzyPYqENRAZFZ5FD
         RG7GA0linqx8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Igl-1qfURW4183-00xIYx; Sun, 02
 Apr 2023 16:16:14 +0200
Date:   Sun, 2 Apr 2023 16:16:13 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git revert with partial commit.
Message-ID: <20230402141613.yeseo5fj3lafuf7w@tb-raspi4>
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:QihJhdcTbSqb9aeK4Iytrzy1CHvnThQogTOX8ocJwH+8ASwTjdp
 6Sqnkd0szxx6sdhUs0I05b32I4blKEYuOsvMqwJcP1zlp9J9fMeCk97gAvgxPtyLx8VmmLj
 yIQv9N2/lmimqw9j3L7IZWnNqeJcUYy+pb8hoOIZikuashmHsVw0A9OZv6SsOuDjnuTIFIJ
 RQD8rYUsq7p/KHkctrwyg==
UI-OutboundReport: notjunk:1;M01:P0:udH3p7/4gPo=;TECZcFBa1weVN6wJCJXPA1nn3id
 AIxZcUgAe04cJB5hLnG5Bonb19b4RxVtrmdzGjcCAgkohK1ygizQZIVyLHkQcVF/+OJ+fSOh1
 aIf1WDEy+SR+FGzE8R29sgIyJOhGbYs5dlcpm7F47yiqYYNdney8Fzp01wyLd7sXEbWGitNlD
 5HRJrkivjEsQj7iquFFAaKyTJr9eBG6dCb88YIJ3AkEddIbnLC5/pKaa33b1+HSHiZ5hIr4Ns
 6gKOJ+qBHfxAOAgbTg+MFjPKUDVl9EI1KoNGA2mJeH5nmKDQ2ObKShexdrmAFq5PMHEyQug/2
 UPp2XUHRtOY39pVybgUJqzUkzZWH5zrEUEezkPVDFrZEU7nho8vNc6QGXDnChN6xV3rB3PYId
 dFZXoL55uEQ3Eu54Y16gq8vwFakOoudSomXshXTAko1bkcB7srewEdE9UtKwmfUDNW9Isrcwa
 mEtkxj7GFyCyreBuxMGhtYvNwVPUAsRSiyQm+85NaxzX1MJX3/87tSuKGSQCBlYhbMsdAxqDX
 mQHPB72f8ddtLpJKtLV2TBr2I7tpUbG5gtwrfoo7ZnZOsKEIxUdmamiNgNRfbyLyvu2uWy96j
 7NcHdki24VTrnMxtax2Lkyw+Qmb/ibugfYN91cccc8qiogFnZet04nh18hSXsv7DTz5pqDBTV
 TCQvy2CEmaJHXUgRcbf9JyzsCSSz7Oli0KF/cUtFzP0OwHe2S4IXA9ijOvpWuDp1+schUlc86
 EKmOElJz/D6AMJ9OhxUdcuQM139CtdJtEyTU1S4RW6QQbVwIjuA5AqO25Nul54cj6ZxnTPbgy
 VyD1V0LC9Gh4bE/y0HGry9hYHXucut60AhPww3HL9GfOyMuMseCUb6StFhpc50dZaGl6EhPZj
 ZNkDMkJQ7llr5L4ueVsTPxG2lZIXxO+3gUNzmZ8XeEUmx0gfUm+FxGdkkS+sjF8tq18wA8StT
 7KCmww==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 02, 2023 at 05:17:30PM +0800, Hongyi Zhao wrote:
> Hi here,
>
> I want to revert a previous commit partially, as follows:
>
> werner@X10DAi:~$ git log |grep -A3 -B5 -m1 texstudio
> commit f18fbd1e16a1ca4215621768d17858c036086608
> Author: Hongyi Zhao <hongyi.zhao@gmail.com>
> Date:   Sun Aug 1 20:01:02 2021 +0800
>
>     deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
>     deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh
>     modified:   Public/repo/github.com/Dushistov/sdcv.git.sh
>     deleted:    Public/repo/github.com/goldendict/stardict-relative/bigd=
ict
>
> More specifically, I just want to revert the following ones:
>
>     deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
>     deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh
>
> Is this possible?

It is.
Find the last commit that had those 2 files, in other word the commit
before f18fbd1e16a1ca4215621, say it is xyz.

git checkout xyz -- Public/CTAN/IDE/phonon/compile-install-phonon
should get the first file back into your working tree and staged.

(Of course, this is out of my head. And you should be able to "restore"
both files in one go.)

Good luck.
