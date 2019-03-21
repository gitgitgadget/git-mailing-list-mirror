Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143BF20248
	for <e@80x24.org>; Thu, 21 Mar 2019 12:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfCUMcx (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 08:32:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:34149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfCUMcx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 08:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553171564;
        bh=mgS7EXLv19dUdvqBv7/JI2z+hWd6oiFzXqHLMm6KND0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TBK/Wb9yaob4MY5PcvGgFKvo3xy2z5FzhHMuLdgz8j5AH7nSljhH21MXY2O5wI/Q6
         ls9uhWNqAU8TXxZl08jHc9TQhB7tUsyCTueZyruREPD/FT6tdwscc93jlkhPGI9AKg
         D7BN/c6j6j9WnY1mAgb1ojZJeQkzWPhCydvmWoeU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Me8RK-1hMzQI2Yak-00Psrc; Thu, 21
 Mar 2019 13:32:44 +0100
Date:   Thu, 21 Mar 2019 13:32:28 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fsmonitor: demonstrate that it is not refreshed
 after discard_index()
In-Reply-To: <680444e1-d670-607b-e84b-c1eb4355b047@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1903211329500.41@tvgsbejvaqbjf.bet>
References: <pull.165.git.gitgitgadget@gmail.com> <f451752656ea5d1e9898e5fa0b2d41de6550781b.1552729745.git.gitgitgadget@gmail.com> <680444e1-d670-607b-e84b-c1eb4355b047@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dJFZH/9VL4CBkJpEGIdXv/pcCZik4J/ILW//21E4GyX56F06wl0
 H5yzfIX5RU9jwECjnjfnQzqH0DESdhMyHCEyipn22wniuFYTgrNXW5skDH/+GsDdsVZk1P+
 S7UWCX6q04pmU6vckA1w1JXjaKbCo7c0zUBc1u1UyO9Uc71QIUY2JpVYzgXzrgrwY3kKWSO
 PLy9ySv5hkfebZ+tyQLug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:76IIjYCgEUg=:krMs6PkRATUQqtJousi9l0
 Ee1qSAzeibaQ9OjA0uU7CLTxj2nndUYKLQhd8nti6lXp0RUHiNGlSRHFLd4x6Zs2bY3ZzwzKd
 1RT8pl/m7z6GgDGC5etxw4+EgPH/tVaMMc2emqss72druHSAFWCvkzmJtbmMUSj5E6YAKQzd9
 rd220KZX/1+m8QmQl8pObw3AszPpCA7w81Uiqy7YUf1OorXdnf2YkjnTx5ycGAtozsraDl8Lw
 1q/G3CrucoxuD7jsZ8TPnWPjYy3+2KtTyWZvb110G2pdYnzrQ1QlaLiFIKdNywBW+59LppwrV
 xeJa1xtU/PoRIexbZ92F+uSxkVNPNT/q3HpXkJoH+0A0IkvASlbLZaxnHJY5IDtkRgHjBPjAD
 tQGxS1VlSL3HJPAMBOGdyjXVYlDJZb5OMuCEAK9VRlUp6D2MPNmHPwIwnQeY52H+MAY5cZh+v
 5B+XYZSmWmj3sb8TeVfS7FMwrN8IxAh6J3WU6RNx4oAXTPeQsn3o4rGhZbt838ls6IuP+dqoo
 5nutEAJIqKkfaT22g6gvEm79is8sE3iVi2ztlV+eJu2Zs6IRm0rAXKbEc/JW7JTE4wLazVrO3
 XiqkFw1mLiLrIo62X3tfPfBEFgDOViZ/gMy+Fok2Zk5TRJHyWYp+j6bUMVDGKyh3aNPgRG67L
 MqFwd6vfy/oSvGEb6dz2BoZF/+aCJHjeYaiJgTlr/ue7ObEbK7zWmMY5IdvBse2X4H/jDYBWJ
 FwY4kOypoqqqJbF6xgQ9X1ZDBYU0CI2vlcEyOqQ9VN73zuFgzV3IP2k51NWUmVJlwHEQbHqSp
 bk6sXCmyH/M1zCmQDRaN+77OSplOmK7/qvAFxpPQ4XXPrbnjoWmmPX45PqD0/BOdVD23LIy+F
 EaVG3/q3L/DLuetIPzXljKTk6nnY2sRjGcnvMHXmLhQZl5XCpnJbiZzFmo+7hO8S8YuP0EsNl
 khH+35j3q/Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Sat, 16 Mar 2019, Johannes Sixt wrote:

> Am 16.03.19 um 10:49 schrieb Johannes Schindelin via GitGitGadget:
> > diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> > index 3e0a61db23..918bc323ab 100755
> > --- a/t/t7519-status-fsmonitor.sh
> > +++ b/t/t7519-status-fsmonitor.sh
> > @@ -346,4 +346,14 @@ test_expect_success UNTRACKED_CACHE 'ignore .git =
changes when invalidating UNTR'
> >  	test_cmp before after
> >  '
> >
> > +test_expect_failure 'discard_index() also discards fsmonitor info' '
> > +	test_when_finished \
> > +		"git config core.monitor .git/hooks/fsmonitor-test" &&
>
> Did you mean
> 		"git config core.fsmonitor ...
> ?

D'oh, yes.

> > +	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
>
> And then, does this not unset core.fsmonitor after the test anyway?

It will unset it, as you point out, not *re-set* it to the value it had
before.

But I guess that's par for the course. I am just worried about side
effects in our test suite. I run into those all the time, it is not even
funny: when a prereq is not met, or when you just want to
`--run=3D<this-one>`, you can't, because it is almost as if more than half
of our test cases depend on the output of *some* previous test case.

But you're right, I should not worry so much. After all, I am adding a
test case to the *end* of the test script.

Will send out a fixed version soon.

Thanks,
Dscho

>
> > +	test_might_fail git update-index --refresh &&
> > +	test-tool read-cache --print-and-refresh=3Dtracked 2 >actual &&
> > +	printf "tracked is%s up to date\n" "" " not" >expect &&
> > +	test_cmp expect actual
> > +'
> > +
> >  test_done
>
> -- Hannes
>
