Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6E3C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757C920659
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="X3VGCKKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgEGOgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 10:36:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:52289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgEGOf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 10:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588862156;
        bh=QYAKJmEFDkAo09cjUcorLlGGs0Td0kObSeoAw2RHLLw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X3VGCKKnpsiDe/hlGlAoegEpN8B4AtY0AU1hP/o4+g1edGU7ZWqx8H8OGxEVBszgk
         2WpxQDzqGmCQnbxLrHxiElI0SL+dX4pzdS5RasUnDnyr5/BoeWA8jaefTl1CW/zO58
         D6X60UNXoUL2wdKE0GbSFOne9Est+D8si13ULyRY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([213.196.213.71]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJV6-1isfmc23hm-00fV0B; Thu, 07
 May 2020 16:35:56 +0200
Date:   Thu, 7 May 2020 16:35:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5500: count objects through stderr, not trace
In-Reply-To: <20200506220741.71021-1-jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.2005071635270.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2005062304410.56@tvgsbejvaqbjf.bet> <20200506220741.71021-1-jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KXgZeA1BJ/Z+V7/tezAf2DrDsp8YrhTBkUnzMipzLCXo9MjY5R1
 gaRjqzUzyR5kTQaBxrx0HhSTFpQowsYtSVrqdcv1Bif4ZJ23eMPqKSn9da5jXvuT1vMwFSh
 rlmTdZGIMtsHrPgyCvROG+ZsFP3YNBWXpo1KpxeZDBboUAn2FwU37ZK/gW/TfsV1birMnnY
 3ikeHjYyutpeaix95G7vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PBg09lHBb5I=:zTd7tV8DCLb3w8bXlC8OMe
 BL0rp3BvLRyzwJfWipVaaHT0jdJwQw1zqc/cylaR9xounkyskBKmN6sGEEdRMNVf0gRZ1zvjE
 NxdqtsBobaoNw2DThzGYdaoiiJVWUEaZIa2+XbwIssnW2pX4NjZ4jPQzaREEQXAaJ3jnzwo1B
 YaLL03rAdwmPFGcA/P8ii4ieOGuBoTtMtLk+qwVd4eeZrCTlUdCani47BqvO9Q68/geW86dKz
 GuZscGb7CS0YzY985MAbOLfCtx/wJPVVqxMAvOeYtR86gcO/bEBETlElFGYOs9/YRRaxiFsfx
 HJRNg0ZeF+YqCUrtx8ToVUcFLwFmRuFdLhidL4PSayrmJ2G0on6lx3O4Iqvmwaw1wUjF9o7vC
 K9BtzigGrCefP5XPH5uxpK8LKDosHxVPROEdORXH7wWrnI7PgMoQN1zfpluGeAneAM1brXKI8
 TzoDX2YlxnR8QZtFyZSychm8fonKCMf2Yf0HMNEAvzaxeKNUoqw/PQpMglU4p2jMJwmoINHY2
 eousfCVhfWjGo+vfpvMctV2F6XR+hfA9Jo8HFGdNLdxgq72s/15yBRwTEssZ8OAvod0BJwTVs
 JCOVF9POie/GhkH0j9hDJhqka4uP72UhbXtFCSvbJrlCVVPhIx5DI8fTJxqwtTgnWpueB7Tmd
 ZcdmRCrrMZpDgj4oxqGsS/OjemnS3oKXZNjcPLbNLPd5U5npTQGD2klDB5O/PKuYyI8tFFXs8
 ookOuEfGTMPmkRjUeNdIPMj/3EM8Yw4Pc3tqQ34c6x2CSJu1oeIsAK2kx5pIeMRrLngDPLz58
 fZrkE1/DpVJhgFkZXXbR8B6SfcSp76FcGJlMTGdmK8Z4l0F94b5ARvpbDwm7K1yaJeiBerqJ5
 kZeNxZ0GS8E8Ekh2bT4Ysh7UXi2Kft9LQd4CDSR/NOj7nZCW2Sule4/Qx64kYo5GNw0U8bjub
 SiiqfJXN8RFkplz8XxWyChgD6mRSXh1Z8nYoKSvCpadjm90nUL89zy7Vog+B1SO6f2UJtT3Ef
 8qMXu0W5LDKrwJOCWMbGuETWbdxUgRj7CQQ66VqWnKuHZOxmKf5a4b43vIvtaDiVoAq1Cn4mW
 kwpzyStDYIrRXed+9Sf+HhJlTGt56lXFjvO9s/cVZnLXaRplXlsbHOWPShBrG1Be/W2DJmq2z
 b2+5GdQ6tveGwaAILWwJhgiUE0z50Ajh5q0zTSGBNeYg4VqYuixUPNzYHkAaVGd4y+lyeX50c
 +PDWpn7ePy6IZ6UJB
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 6 May 2020, Jonathan Tan wrote:

> In two tests introduced by 4fa3f00abb ("fetch-pack: in protocol v2,
> in_vain only after ACK", 2020-04-28) and 2f0a093dd6 ("fetch-pack: in
> protocol v2, reset in_vain upon ACK", 2020-04-28), the count of objects
> downloaded is checked by grepping for a specific message in the packet
> trace. However, this is flaky as that specific message may be delivered
> over 2 or more packet lines.
>
> Instead, grep over stderr, just like the "fetch creating new shallow
> root" test in the same file.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Thanks, Dscho. The commits introducing the flakiness have made it to
> master, so this commit is on master.

Thank you for fixing this so quickly. I agree that the patch addresses the
underlying problem.

Thanks!
Dscho

> ---
>  t/t5500-fetch-pack.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 52dd1a688c..8c54e34ef1 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -386,7 +386,7 @@ test_expect_success 'clone shallow with packed refs'=
 '
>  '
>
>  test_expect_success 'in_vain not triggered before first ACK' '
> -	rm -rf myserver myclient trace &&
> +	rm -rf myserver myclient &&
>  	git init myserver &&
>  	test_commit -C myserver foo &&
>  	git clone "file://$(pwd)/myserver" myclient &&
> @@ -399,12 +399,12 @@ test_expect_success 'in_vain not triggered before =
first ACK' '
>  	# The new commit that the client wants to fetch.
>  	test_commit -C myserver bar &&
>
> -	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C myclient fetch --progress ori=
gin &&
> -	test_i18ngrep "Total 3 " trace
> +	git -C myclient fetch --progress origin 2>log &&
> +	test_i18ngrep "remote: Total 3 " log
>  '
>
>  test_expect_success 'in_vain resetted upon ACK' '
> -	rm -rf myserver myclient trace &&
> +	rm -rf myserver myclient &&
>  	git init myserver &&
>
>  	# Linked list of commits on master. The first is common; the rest are
> @@ -429,8 +429,8 @@ test_expect_success 'in_vain resetted upon ACK' '
>  	# first. The 256th commit is common between the client and the server,
>  	# and should reset in_vain. This allows negotiation to continue until
>  	# the client reports that first_anotherbranch_commit is common.
> -	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C myclient fetch --progress ori=
gin master &&
> -	test_i18ngrep "Total 3 " trace
> +	git -C myclient fetch --progress origin master 2>log &&
> +	test_i18ngrep "Total 3 " log
>  '
>
>  test_expect_success 'fetch in shallow repo unreachable shallow objects'=
 '
> --
> 2.26.2.526.g744177e7f7-goog
>
>
