Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419EAC433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 10:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKXKs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 05:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXKs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 05:48:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEBA4093D
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 02:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669286896; bh=MVV3KEksh56bIfNKZ6EHdd4Xs0TFGfShCqR6XYYCKfE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jX6a9H+SoCJj+jBM26RBhuRohvD/ReZJ116bjQT4EhDaNIhh75tvzVVcqupJSK8m3
         kGEXAcqNApEzAEF22QcNzVqwzLI47ZErK7VJpOFubNFrocpJJslQiYDspCcWrV1aAx
         yXh4+gvyy8dLSCW94fZoGCva3hedaYv7DNk8SJz/079wxKORRo2+epv49DGU24mkyz
         yDvQxLalSTxZICe17sTFlV25e9DPenoPn+t84e1hZfg+/goHrwwitnlyL8Xrm3DOE1
         zHG1830O4tmGtgi95sZHovJwDOqizk52Cmed3v0vlFxl0UQnsB2b60z8nCFadhbvGR
         /x3tMfzEo5VsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.58.20] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1pA4MM41Wn-00wmt3; Thu, 24
 Nov 2022 11:48:16 +0100
Date:   Thu, 24 Nov 2022 11:48:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 0/3] Fix broken CI on newer github-actions runner
 image
In-Reply-To: <2219s80r-q7s3-391o-o3or-7q70sn37ooo9@tzk.qr>
Message-ID: <4oonnq45-s269-sr8n-o5sr-n214593nps8s@tzk.qr>
References: <20221123150233.13039-1-worldhello.net@gmail.com> <20221124090545.4790-1-worldhello.net@gmail.com> <2219s80r-q7s3-391o-o3or-7q70sn37ooo9@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NJ1/1LtAhLPISGPHpeeQgGJRB229o6UGrrH+JS72JI3104CPBfU
 K2DiyLAOJRLvlSHf07nPitBojnpKOgueZQqJk4bEHL0I5cYODqKmcmqHoapzLyjjThJGNtN
 URF58JhwEDDd3pmr/ffWt5dj8YA4QrfsDmIziPSkgPud575k8SkT57T7k2RCSZKGJQqY63h
 bUTeVGbzagmVM0cs+v5/g==
UI-OutboundReport: notjunk:1;M01:P0:lLqlORbFmIA=;iQS09HBXamEXoR/mfiEXHyVKVqd
 SjhnlGKIiPZPxU9WCf9dFdVM3sJIjRax2dbLQvMEmU8zQ5wKWg+xfYCX9JSvF/t/m0A7yGkez
 1Q8feQi7NE9Rq+H3/z9hB4Mpq/9ZdCROffrPWYuIGtF/PPdiXd7BidEMc3OPzlPI/Wxw49Dzg
 hIsrY149KxmOEtLsFR23vGdG2kqadJ1SsNEUbCzPwStTTG8jnjUpCbH8jlt1D5lmQv4VSweSd
 MM4pq7TKypZbpbzz5j6quZIHO8Y7Wy2hg8oh1kYPwblwH/BWx9/TZDPlEMkXmj60xOPQcCqfE
 KjXny0NK+sLV3AMx4NWI6tAvQ/CIiD0b58W7ys2AUdeHUGwYDfemtZfpirRxVi3uqRj9zBz11
 2SPA5bZB0Vcquu9DceQNWAdqzPjXgD5Cs8yWaanHfQ7dTVgU3rMIJwcERYRsjuyQKlERBpVpn
 vKNuW3fDJGLUQaGQFvEwRbATzrgbRdo50XiYPK+CMEQROTSuWQ3RONvWodaiqP/Pu/Zche8f9
 0T7BF1TOuMq9cV0z2icLCdKQe8WKAjHxyMOhlasibbeQhrfxI+241xqXKfYoLySAVLnjNByGg
 DgT1Hxmb/hhBqeD9gXVpApdoqTZ+bB1Uga2B7PK8ODfAVdju3DOdL4qg65HnNbxvIwDyXO6Xi
 nu+fNZkU40m0OVY3IR5mtZSn1Fpjxn3oBSdHEwTlCQnYIXxVHHzgJvFiUjjvsYGadwXHF4diZ
 wosx2QLDgV/plGICpj7zeXdXLpPeEQdMtbs/XjbHGFdxI0FrrQycOIUExDSS6hHLbRwjlT4Dq
 pi2fN0CqyPuXVZYfq+usEA+i1/KWeocpj3NBvrdSVJypDgfVvoZT4SftMT/Bl5WQMxL9vNq0W
 +6qMubTrX7I9LT8duUMoNs3XAJ5Z9r0ErgISpWo1I6uMv3DMBQ/WPTO7ThT3ZLQl89Q9BLFCu
 MFmP7ZYqaOaPV7EXpwfdRoyUcQQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 24 Nov 2022, Johannes Schindelin wrote:

> To build even more confidence in the patch series, I will now start a fu=
ll
> run (which will take *a lot* of build minutes, unfortunately).

And it passed: https://github.com/dscho/git/actions/runs/3539451056

I also had a look at the range-diff between v1 and v2:

=2D- snip --
1:  ef80c39de1e5 ! 1:  6d4607a4ee46 github-actions: run gcc-8 on ubuntu-20=
.04 image
    @@ Commit message
             ubuntu)
                 ;;

    +    In this way, we can change the "ubuntu-latest" runner image to an=
y
    +    version such as "ubuntu-22.04" to test CI behavior in advance.
    +
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>

2:  1d0903c8b2f9 ! 2:  eba96648368a ci: upgrade version of p4
    @@ Metadata
     Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>

      ## Commit message ##
    -    ci: upgrade version of p4
    +    ci: upgrade version of p4 to 21.2

         There would be a segmentation fault when running p4 v16.2 on ubun=
tu
         22.04 which is the latest version of ubuntu runner image for gith=
ub
    -    actions. Upgrade p4 from version 16.2 to 19.2 will fix this issue=
.
    +    actions.

    -    Also add some instructions to show errors of command "p4 -V", so =
we can
    -    see why the output doesn't match.
    +    By checking each version from [1], p4d version 21.1 and above can=
 work
    +    properly on ubuntu 22.04. But version 22.x will break some p4 tes=
t
    +    cases. So p4 version 21.x is exactly the version we can use.
    +
    +    In addition to upgrade p4 from version 16.2 to 21.2, also add som=
e
    +    instructions to show errors of command "p4 -V", so we can see why=
 the
    +    command output doesn't match.
    +
    +    [1]: https://cdist2.perforce.com/perforce/

         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    @@ ci/lib.sh: ubuntu)
      	# image.
      	# Keep that in mind when you encounter a broken OS X build!
     -	export LINUX_P4_VERSION=3D"16.2"
    -+	export LINUX_P4_VERSION=3D"19.2"
    ++	export LINUX_P4_VERSION=3D"21.2"
      	export LINUX_GIT_LFS_VERSION=3D"1.5.2"

      	P4_PATH=3D"$HOME/custom/p4"
-:  ------------ > 3:  8e432f13bef8 ci: install python on ubuntu
=2D- snap --

The changes look good!

One alternative I considered about 8e432f13bef8 (ci: install python on
ubuntu, 2022-11-24) was to drop testing Python v2.x (it's years past end
of life after all, see https://endoflife.date/python).

However, as we see frequently demonstrated on the Git mailing list:
losing focus, trying to force patch series to address more than a single
concern, gets us nowhere, and not even fast.

So I agree that the best idea in this patch series is the stop-gap
solution to install `python2` on `ubuntu-22.04`, and deal with deprecating
Python v2.x support separately, later, or never, whichever comes first ;-)

With this, here goes my (probably final, because I think this patch series
is ready):

	Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you so much for working on this, it was a thoroughly enjoyable
experience for me!

Ciao,
Dscho
