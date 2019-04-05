Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9278420248
	for <e@80x24.org>; Fri,  5 Apr 2019 14:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbfDEOzp (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 10:55:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:60605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfDEOzp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 10:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554476137;
        bh=kwSu6LAAhgrZXv6iSVfc2i+OHgluDG/Lw1SYC1DivPA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d+9+rA3uvu4QbbXm/UPeOq6Voa0ZWMZwWOukthlAUnBC+GOcWfdn4N7oig2eO7g2d
         YfTr76rQ3JFtOPjxdO69SZOZPeoIxAEEpaBpJOGJmKgldIwI3edAMiaZ+y9d1vsjuK
         LPEiMXj0auaupZ9I1EFXQQJJb0MgM++werhu818M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Le5bY-1ga25t0nCG-00ppv5; Fri, 05
 Apr 2019 16:55:37 +0200
Date:   Fri, 5 Apr 2019 16:55:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 1/4] t3431: add rebase --fork-point tests
In-Reply-To: <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904051653360.41@tvgsbejvaqbjf.bet>
References: <20190328221745.GA3941@dev-l> <cover.1554151449.git.liu.denton@gmail.com> <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HiXNtTVxLMKP2N74OjwmXizG3K4Xnbz05CUkbF3IYJQodeGKfOs
 L05YvZa7cUUlARq4WgWlEQ/DO3PypipqTQ2JIbLtU/c/4IQD/5D15rcm8epXFt3L6Q+GXfR
 BJ02Y8osFULwegxU7ZE5Z72VOU/WUgDqPMcuWA30zZl62FJeBtp5ksVZupzSMNQqx74U78Z
 p+OBBvpeLM+tm/y/vqN1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7jegafPBHp0=:3tXzWaavjYBtn/GcKvlPd9
 ikxSMBYFlFQnkXmAFuISvgpovjihDkUjq3gMzw47M5tL56nikXBRtbJeppkXCX7/k3V59Idx3
 GecQH35Ti6F82ftriFml7xifGjEo/NrkorB1gl8GO/Hv0UW0Cwfb7OzvrBMb7MAWPsTfYYkmL
 S6ErGR9pCfDVPYA5fcxjOPzuHpznVXnMr5jyTsw6kEo1kz5FrgNHbLitDm+ktLukIo06JM7c5
 XGqAoZSsBzk7B31yvVh9xmqEoTBhfxuguKkN/WekLTiePNqie4sYuvo3GxjaiZsMAh6SFs6/y
 vRALgLJNt76Ll4OAnVpHMZDp6Qw8NltiSYTyiHZRJOSwMZKU78UAZuo/kFEm5ahBHk8Pl1h63
 mr+m4hV2kc6kMLiNfIObtL6M5iadyrxr+LQ+Yl+b2/H+eGVUEOaIK4fYV9tmw9FcYRMlLQLPV
 9HxR6FEzf6qOWFgomyvC6J0+w1HpDo7tEjQ+rP+HcTceAhl+SNsTrTY38K8wlAmqK6u/ab7H1
 LjhYz5Uhev8ADjJP0bn3eaAKxe1qvWUmPX6I3B+O8/S+NXEe3GhCjleZMwhYCdw0fNZ7wc6Vp
 Xr7XdYQkXut+rYqF0NXD2p6QJfYpeSGMohR5rCs72XO8OH92NG19EFnRZ5fvSscTD40Pm2Ush
 nynA8dcVcBR+v0N6nlmL0KMuLtdpols7ZB7qBPO5S1U/V7f+acbbzp6VYPgCn7y9ao6cicCKs
 RnjITyNE4D2Gd5lq5YO1MzLw5becwgK+ltaVnTPH8XueG14u4VOc0wp0wgHGek95PeJRgi/qP
 wnnSPikdldTCPPP14Up1ZvGsMlfkY09dCcyY7IWW1F83u03Z8rGFFqKwGcnzq4lc3qIRHLz2i
 DYCkGmkpkLvEyr2K352Mhzr/mGIIntBSnKgMXUdjSJ4ywfQ0qoV/UOllJT55OY+WWKtusDR9B
 4cYnIHmcX0Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Mon, 1 Apr 2019, Denton Liu wrote:

> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> new file mode 100755
> index 0000000000..8e2483b73e
> --- /dev/null
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2019 Denton Liu
> +#
> +
> +test_description=3D'git rebase --fork-point test'
> +
> +. ./test-lib.sh
> +
> +# A---B---D---E       (master)
> +#     \
> +#      C*---F---G (side)
> +#
> +# C was formerly part of master but is side out
> +#
> +test_expect_success setup '
> +	test_commit A &&
> +	test_commit B &&
> +	test_commit C &&
> +	git branch -t side &&
> +	git reset --hard HEAD^ &&
> +	test_commit D &&
> +	test_commit E &&
> +	git checkout side &&
> +	test_commit F &&
> +	test_commit G
> +'
> +
> +test_rebase() {
> +	expected=3D"$1" &&
> +	shift &&
> +	test_expect_success "git rebase $@" "
> +		git checkout master &&
> +		git reset --hard E &&
> +		git checkout side &&
> +		git reset --hard G &&
> +		git rebase $@ &&

I think we need this patch, to make the macOS build happy:

=2D- snip --
Subject: fixup??? t3431: add rebase --fork-point tests

Try to fix the Mac build, which currently fails thusly:

    ++ git reset --hard G
    HEAD is now at d8775ba G
    ++ git rebase $'\177'
    fatal: invalid upstream '?'
    error: last command exited with $?=3D128

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 4607e65de6..b41a0c0b68 100755
=2D-- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -34,7 +34,7 @@ test_rebase() {
 		git reset --hard E &&
 		git checkout side &&
 		git reset --hard G &&
-		git rebase $@ &&
+		eval git rebase \"$@\" &&
 		test_write_lines $expected >expect &&
 		git log --pretty=3D%s >actual &&
 		test_cmp expect actual
=2D- snap --

Ciao,
Dscho

> +		test_write_lines $expected >expect &&
> +		git log --pretty=3D%s >actual &&
> +		test_cmp expect actual
> +	"
> +}
> +
> +test_rebase 'G F E D B A' ''
> +test_rebase 'G F D B A' '--onto D'
> +test_rebase 'G F C E D B A' '--no-fork-point'
> +test_rebase 'G F C D B A' '--no-fork-point --onto D'
> +test_rebase 'G F E D B A' '--fork-point refs/heads/master'
> +test_rebase 'G F D B A' '--fork-point --onto D refs/heads/master'
> +test_rebase 'G F C E D B A' 'refs/heads/master'
> +test_rebase 'G F C D B A' '--onto D refs/heads/master'
> +
> +test_done
> --
> 2.21.0.695.gaf8658f249
>
>
