Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8388BC2BB41
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 10:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiHPKsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 06:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbiHPKsj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 06:48:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA3BBD2AB
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660644699;
        bh=WjA2ubCaP3btfL4Oiw7dZVMywjB4qg0KBSj8Hgcc1rk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VJ37OnNNE+hEYE9IAyQRlYNB7V4EraZ2dzs8wO8Pm5K50jf5pxMHungDdLg31h7ZU
         3izot0VJSn2OIyfR8s5xdTooTFbUl7N2Qnc5EUHDPopUFiRiaYeIbvsFYqE25fsodJ
         7Xczkk3hsPsR16EAcrC1CU1evNhtivbS0GLu3z5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryXH-1ncRFW3EZR-00o0XS; Tue, 16
 Aug 2022 12:11:39 +0200
Date:   Tue, 16 Aug 2022 12:11:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] cmake: align CTest definition with Git's CI runs
In-Reply-To: <xmqqczd8m1lr.fsf@gitster.g>
Message-ID: <7ss9r585-14rs-so68-o2n3-9qn9qn530742@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <9cf14984c0a71b1ccdff7db0699571bf5af1209b.1660143750.git.gitgitgadget@gmail.com> <xmqqczd8m1lr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LUf9PqDd6B0vvw79Ivmv0Kjs1CpZb2vpm51DGSx4btuv/TF5xGT
 Yi1Kd8sS5wA23jqNT2uhbRdCRPmOjA/rdmvuzMI5N7Vh9bgH/zciDxSuj3lT2j4VeYN+5ZG
 LezFy3ndIhAolyfNlmQKsvKXoZJnVA16bHbgopzleN5btt1Zmz5ZYDlY5uAeWxdsBX1vRq0
 TYx9XvzgxbtqhRzs1S4tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tC3H8UhKSYg=:/1gfX+4Gvk1jlkXKdchWOc
 Ytnt6oBeuSeDkckfDTrQrsaOdQPv3Mn5ZLn8VBk4gWzPIUa/mlhMOeBcgl0S2iMSkKITgmAm4
 CLXoR+u5aDbefUdC3oOrOflowDq2TauBgxYzHlnj8mjGcjyrm8mngEDOJE2rbe8rNXkcotjYK
 Ao5OQM138TlWUuk1RGi4KmmAIZj4FPaIk+bd8s3evdh7PWtRZKCcAslfmXTOXL+Xn0a/haGWU
 H+rqk9HAxWWOctQcMcHJ+vI5cG81VtDzWXpiTqp4fBZ58n7tMP8clC/Zg/wuw5UMMZga+hE5h
 TbKBNkZHKsCGDC3aBQrl3WoFXShlD7wqmZq2WqhHlBQTx8muP8ER7gA3bceRqE6urTJVg1pBY
 jQTp1uIGWtMVlRmOyy2d/rI1S9lp38sOgQrbJnDwifpCKkb10Z27eYE38gCSOM52A0WRyLUFi
 /apwab08gmCHq/vEVNi61giDlNnTn0To+ysghfvUZWpP+iwxN9b2JyHcw2rDhS7wX8oYs6VSM
 5SJC13S9/l0qQKoAcpa/36S0bi8V2hnG8WpU6JXHlRkh/sAp5wjf2ETtF5sK8pJj79fylIiZS
 7pnIu7KZNlZrE5Holksb0l7+4jaye+rtJZttcO82RZ10K0hw9rzuYoTXWsYvbv4y0BSyE89pK
 wDGkZCFWgq5HRiFoD/DjaSwtgBQELanlFbnnr6DscGipGQkMT3YVxLfZVI9RpTAq3rrPCbqN+
 8F1hHhdmOQln+zBqe1csueEl0OyUvldecPuGz928kqKrPjVhUmri/vrWnIcjHlg7c05wWIdhx
 C5mS8GffEgPCsgfsnxfmopgnlF9b7vXl2N/95wLpIEWqn0yKz+YEl5YK11P0OJprWi/0tvsGY
 WVLJ9JSiarHU8DbJcbC06j+HGTSI70DXMQESj3O3RzSyhPZ2qDO0bPSaDYhAr8DfqEsfaZSiH
 19cbDlZGjTB37lgVCLrt2cLEkGYa9XfYUnb/lJjJUkpZsGwoUuYWoxf1TjOqrLPVmUiV6aPlq
 Jo58QsCttDp4PT59I9s1xzUOo8mtYxu7JwWFr+0y68jKYWSB0lCXPwQiCri690mjHSpJbAX4u
 bL1aT0BuA+kMlIzEumGxBf7b+9klobVUgT0sXCxz1GY198tkU1m3TeVVQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Aug 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > While at it, enable the command trace via `-x` and verbose output via
> > `-v`, otherwise it would be near impossible to diagnose any problems.
>
> This sounds like a completely unrelated change.

It may sound like it, but it is not. In order to make sense of the broken
tests, I needed access to more verbose output than our test scripts
provide by default.

When running the test suite on the command-line, it is easy to tell the
user "oh, if you need more information, just call the test script with
these here options: ...".

This is not an option when running the tests within Visual Studio.

Does this clarify the intention and validity of the proposed patch? If so,
I will gladly try my best to improve the commit message to explain that
intention better.

Ciao,
Dscho
