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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF2420248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfDESvc (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:51:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:33503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731183AbfDESvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554490285;
        bh=K8W8bcBVww8WuinQ6p/ICGjHt/x2MxmHQf1FyumiTz0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ykf2bD2OpdH5TvzEnJd2IZF8uOTFcFjHZNRyzFsZnyej/J4CXrjVYAMdSkqY1rHGh
         LGxwJu8c1JHYjB3rWjwLMIfisoWeHdkBWggRiZ8UYTd0sTmhNCDRQG6wxxIS5rhyaR
         tf1GnoGIricIp6gIR4vPgtzNvmdXfQgoccb3vTmE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYOY5-1hPSNI18oz-00V809; Fri, 05
 Apr 2019 20:51:25 +0200
Date:   Fri, 5 Apr 2019 20:51:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 1/4] t3431: add rebase --fork-point tests
In-Reply-To: <34af9bf5-4031-63ed-c34b-9f2c7ff76c51@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1904052047240.41@tvgsbejvaqbjf.bet>
References: <20190328221745.GA3941@dev-l> <cover.1554151449.git.liu.denton@gmail.com> <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com> <nycvar.QRO.7.76.6.1904051653360.41@tvgsbejvaqbjf.bet> <20190405172536.GA11212@dev-l>
 <34af9bf5-4031-63ed-c34b-9f2c7ff76c51@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:buoCV7ZzMiJ9uqB+Ehm8Aoi22M1jD9rzCtJjcg7FOv1bT0wBP/V
 3QHvftE9Vhlh9r7oDsMa3DxWe/8+yHXQ30Lhm+b9J/GD5LVeOt4TDyg2xpiXPEjnq/i+lyt
 4Xx+W7cUx61kYMhoBFv1ldo5zoqQ0VZ0Mjx4rPBP5DY/eahVM3Dt9t7F09TnfFXlG7b0qbA
 cxLUXmAvPZ+ftJ5LObG2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P8BO+BeT+t8=:uzhozCPV2Acv8sKDNqqg6U
 wVYu/GqivgeOhYSNRmTfgxZCKKVrQV8XPxxvrKZOV/43BTa4wMiFJdZ+8/mJwYf7if7EtChmg
 G/j9VeMmkrD0RJuqu7l3EZLCcnKOKIXnrFYAUyXX5popJEdrXl761hDPIr6ehXZ4WuCiqVxGb
 vtruGRIHcXxucb9r1o0rIyHpSa3KmNnhSEsj7pYJYmiJby7eSITeK5NIIDu3NwIOE2wFvodW2
 b8hrIViG7+4XSbKeF7ZB+I6K2n9ViNydFdRsrrlYHkT/mD7laiPkNbnyBIQyZlRhRs+tzdE4r
 rq9RH/oX579LCyczl65QkYH5OZIVwZo9XvKoiVNoikcw5sD+jdGQNJHi2Co+OrdC+kMQ6XXUm
 SSyMWQH87xeNcvNNSXk6T6sY8JPmyPDgL3Pl40hhpw4ZKGoZBqlZz1KR/CAn+BZZT5+2dIjz9
 xIT5raWtArQlt0A7obEfiFDl7oUGSg07FLrJyU/XH8M54N/EKa/fflPDjnFD2+iyBoNiSaa8D
 JQWHNV0uX5gPtLVTr+J/6MrQQEbrjQgtV+fenEQU5mcdnXx4b8wVB8nGm6sNmIeIbVv47snFN
 Bqx/XnNyjFyhB7IcsSVXcnMBeoHPGlvP9bkq2QFX0sEMeXpMTALOxxffzBaCH1SXXdi0Yu2PM
 XN8Rf5RRvgOiO6jM9fpRrsq2MuXRxRYRt06Ht6jbtIinUOTS+Ihj42Va1FwbBd7eSfZg4b3PD
 ls6Z+gGH20MF6dXfbPT02i+GJxXsRj6x/zT0W5V8h/Elar1FxIsbLK21Oj9Q/rxT7q75rO8IS
 XoKJpGFvpoAlwaihZkbUP/pZxWCLq/DGv8WumK6axKU9PsW3YM9J6rboPP4zMcNhjpxwKxjVI
 a8WdPkekfrTvaal1Gz1WzFD0HaX3mjxoOU+cvWNMxKCKaUKln9BRxCUxfnbDCBJRm7T4R3IOi
 q4BfMJMHY4w==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes & Denton,


On Fri, 5 Apr 2019, Johannes Sixt wrote:

> Am 05.04.19 um 19:25 schrieb Denton Liu:
> > On Fri, Apr 05, 2019 at 04:55:37PM +0200, Johannes Schindelin wrote:
> >> On Mon, 1 Apr 2019, Denton Liu wrote:
> >>> +test_rebase() {
> >>> +	expected=3D"$1" &&
> >>> +	shift &&
> >>> +	test_expect_success "git rebase $@" "
> >>> +		git checkout master &&
> >>> +		git reset --hard E &&
> >>> +		git checkout side &&
> >>> +		git reset --hard G &&
> >>> +		git rebase $@ &&
> >>
> >> I think we need this patch, to make the macOS build happy:

Actually, my patch did not even fix the build, I looked at the wrong
(succeeding) build, sorry for the noise.

> > Thanks for digging into this, both.
> >
> > Out of curiosity, t3432 is written similarly:
> >
> > 	test_rebase_same_head() {
> > 		status=3D"$1" &&
> > 		shift &&
> > 		test_expect_$status "git rebase $@ with $changes is no-op" "
> > 			oldhead=3D\$(git rev-parse HEAD) &&
> > 			test_when_finished 'git reset --hard \$oldhead' &&
> > 			git rebase $@ &&
> > 			newhead=3D\$(git rev-parse HEAD) &&
> > 			test_cmp_rev \$oldhead \$newhead
> > 		"
> > 	}

That is curious, indeed!

> Using $@ in these expansions is wrong. You do not want to forward an
> argument list, but you want to construct a command line. $* is correct
> here. Then you can remove the single-quotes at the invocation, like so:
>
> 	test_rebase_same_head success
> 	test_rebase_same_head success --onto B B
>
> Function test_rebase() could be done in the same way, but the first
> argument, expected, still needs quotes at the call site, of course.

That's a good idea, let me run with it.

Ciao,
Dscho
