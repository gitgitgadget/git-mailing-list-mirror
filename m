Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70025C433F5
	for <git@archiver.kernel.org>; Mon, 30 May 2022 16:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241143AbiE3QvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 12:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240199AbiE3QvG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 12:51:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27155BE54
        for <git@vger.kernel.org>; Mon, 30 May 2022 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653929459;
        bh=WXtXxaTzd5TtUeUQkDxfp08ha5j1J6TaVwcGi4nQusU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gkSXkHelzz9hClZnYM+Wn04IvPRsVwxQyUAJHCSxGcroOtbHJzQlhDozn07bhobB8
         TwW1Cts+kyTLoHO6UJn/MrGJ5EvaLiX/fZyjj98bbzAk9iHP/a9AksFOUs+5KojIyo
         tx4Ey8KLJofWUCdXGTgrnvnw4CLeEUh+jCW9Qf7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.212.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1nfI5O3CiD-00uXMJ; Mon, 30
 May 2022 18:50:59 +0200
Date:   Mon, 30 May 2022 18:50:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Side effects in Git's test suite, was Re: [PATCH] revert: optionally
 refer to commit in the "reference" format
In-Reply-To: <xmqq35gzn9vk.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205301840410.349@tvgsbejvaqbjf.bet>
References: <xmqqsfp2b30k.fsf@gitster.g> <nycvar.QRO.7.76.6.2205231507350.352@tvgsbejvaqbjf.bet> <xmqq35gzn9vk.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:swS3sTx/BGmjOhx67S5KN/6CgPbojklrbE2Nk1MSmkVOtFSSMj+
 bMX6M3o1tgCSgRHGiEjKKr5CgwvXLBnw/gFv3Hjwc2eHKoN/YhG+8VQkzcTeUkbs7vyqRDG
 W3lbjoaTg/sMLfqAeNkuYITUh1/f5NU/mD+SuqTVQ6Pu6IgsgtwXNWxCfX2Yk0ahprg2l3b
 j4el5rNDTXH+e6RuBq44Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q0gCBfvOyYc=:VgeC8v/5vX9HYUBtI19e77
 BCw9wKjbdNB3etz0kdj6OHmQLQlhvXEG2PPiXo7mODGST/wnkL/plqsk8QH+1CQEhBEr9bNtg
 PGyvSLEsca4x4X6jJOCFdWvmgt9s+FAgridmkiJjbuep8y/B9qdK+uh55D4PxP8g5W8AlaskC
 TZBY1Z+eFrFSeXay7XDtaw22MOsjr1IAs7d9uI4OLvdWFc4fxQltVMPsh8p60oF1XKEaeS+Ah
 fJbf4dvo7yq+6qy061kGrsmnAU/cze+FNzP6rXVqtgfVwark0LFfYmbewEYoaHgVcjKxMGzJ9
 XidttIrcE/KhiuwW4SvqEfFdtVsRtM2yNBf+QY5o4J5SrRC1rdSgcyvpFcNeY6B2dxoOd3+HK
 uZsH0FyMBfScJAhE/TERpf/QE6FPD6eT1xoM7lOzNVvNIy2qPziAUwFEocyYN+2QN2Ou6zDtS
 ccll+bel6osTSf/IDl2VDlFPR9xrpv87dznd5BNDsqLF4brN0+ilaq2hgAatuNFURt5OEJ/t0
 jae7MQE1e1fKxaYD83L8njMv5cJRDPHZutsp3WZ7lmYAp5nk4yOAm2FvcJjL05yg7KjPK9yl7
 So6DNZSxvd8K8BqK+jSI05kNsqbnvNRRCy9V2ij95TX0O6JS3Z7qB0zj8aZxxRZ44r8jGEzV4
 XrGtGnzaD+jMWLsOFwTimay431jPOmZsdxt9coYCAfSd1ElPqKyOMGEynm0U2qz3Nu50qrKnN
 UMivQLwIiVS8K79frpqjydbGEOpj4rB9QRnpoxv2LtLmvt6bC947HIoNMP5wI7BQ7+cvD28YK
 PtvGIKKUmqkGV7S2ZLkIVlK74rsEykGEZ4vLDR2cWxeLMmO9+qyXoaWEtH677aXlybRZUajl8
 utYS6KzzcjUDG/XfDpg3e5RRX8zy4C5bPwrtqkBCKomhbSINDWmupQWFUNQrBkYCxMzGnviIp
 4ZQmuZXo+bPG38dVue6cvTBfBIPmXWsScXV+YL3i7yzt2WFQi7zktGvMiKEerClMIoW3HiOwe
 Iju+IaabROJ6JRScWs7AJZuMl8yY2RKkcUQRPfi9VrEokpmiR8ozia8TYlDWsLvKkOVJ1fkut
 TYuFP6evYjZn3rTiFdHUqj3/jbNbjRqA0NoNVtVcDN+JJgXAPh/BRa+MQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 May 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> +test_expect_success 'identification of reverted commit (reference)' =
'
> >> +	git checkout --detach to-ident &&
> >> +	git revert --reference --no-edit HEAD &&
> >> +	git cat-file commit HEAD >actual.raw &&
> >> +	grep "^This reverts " actual.raw >actual &&
> >> +	echo "This reverts commit $(git show -s --pretty=3Dreference HEAD^)=
." >expect &&
> >> +	test_cmp expect actual
> >> +'
> >
> > If it was up to me, I would combine these three test cases, if only to
> > help the `--run=3D<single-number>` case (the latter two depend on the
> > side effect of the first one to create a `to-ident` tag).
>
> I wonder if our prereq infrastructure is lightweight and scalable enough
> so that we can easily add a support a pseudo-prerequisite PREVIOUS that
> lets us say
>
> 	test_expect_success PREVIOUS "identification ..." '
> 		...
> 	'
>
> to mean that this test requires the previous test has not been
> skipped.

In theory, this sounds good to me.

In practice, however, side effects are awful and make everything harder,
from developing code to debugging to helping new contributors. I wish we
would do away with them altogether and have something more akin to the
before/after constructs known from e.g. TestNG (think `@BeforeTest` and
`@BeforeClass`).

One option would be to mark `setup` steps completely differently, sort of
imitating the prereq infrastructure instead of using
`test_expect_success`. Kind of prereqs, but required to pass.

This could potentially allow us to randomize the order in which the test
cases are run, to identify and fix (unintended) side effects.

A complication is that we have nothing in the way of `@AfterClass`, i.e.
we do not have a way to, say, run an Apache instance for the lifecycle of
a given test script _and tear it down at the end_.

Another, rather obvious complication is that we have 17 years of commit
history introducing side effects left and right :laughing:

Ciao,
Dscho
