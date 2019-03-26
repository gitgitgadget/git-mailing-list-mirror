Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25C9620248
	for <e@80x24.org>; Tue, 26 Mar 2019 13:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfCZN2F (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 09:28:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:39097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZN2F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 09:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553606883;
        bh=7pJiA2PN6uyDYZUrisnsXAsQ8IgrTkrbKJQWr3a9Nx0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZYZ6XtbgQuPrgGzflHAacqcMv3FL3kggoe21J7ED/z9vPtgzlIcJlrPhNDo0dPLfh
         SfTE7nhT3mw9s9oL2xakKHAkybKTOz9fqjfehUvpG/eEj6xW2lC1ga124rCjJiarfZ
         Mj4WEz2zCQTSrl75fF4bN/cFAG8VHk7nEAHzCnDc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.144.175] ([95.208.59.4]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfkJC-1gbLB23UDq-00pNh7; Tue, 26
 Mar 2019 14:28:02 +0100
Date:   Tue, 26 Mar 2019 14:27:47 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] rebase: teach rebase --keep-base
In-Reply-To: <20190325192928.GA31067@dev-l>
Message-ID: <nycvar.QRO.7.76.6.1903261424270.41@tvgsbejvaqbjf.bet>
References: <cover.1553354374.git.liu.denton@gmail.com> <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com> <nycvar.QRO.7.76.6.1903251948200.41@tvgsbejvaqbjf.bet> <20190325192928.GA31067@dev-l>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4WcXmZhxY5rRb8KmwGKxMuZAB6QKJlPlSvJAywBXqQEPIwafAR9
 xw+OAHSB/ZmDjyZUq/XUHMHvF2XwCZ7G8gk+FhxVETdwhBpU+ofSWy6BBhj3qp6yHwmw9PE
 4dE0KDJTC5PuueP9vnv3R2NSZwnDfEOawytpI5YoOdUO0aBWXZC/PwYygd/pVCYc47S2Cuu
 /rGkq+yhQ4ZzIO5tweNdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ayio8ckfaM=:Jw75bRJ5sSO2HZGsjXURMU
 v2Ho7qOxrG7Yqf7Yh3/3sWXRxhzkqCw5tkj13G+7ucrHzHvBKJa1dBipAMNhkX6O0EmJdDETA
 sg8Y/nPHzEvycbf8VdaiZyNxWIcdUTOnDS+RlEYpnFKkJphOwVLrAOZYRCYjJjZo1ec6AwMz6
 cLwj2vPm8dxvJBSO33hEY3QWavbspRTBXGZhoCYtWpzhtISrODRx1kHXQpfXviSE0rzhVmhoE
 XtB4Iatu2JGjICAnE7eR7dgo9VlLWDnK+doN3Ersr6XWgsRBST1+xLX4pa8cvmxlwAO/pWSYg
 +BwkOnys0W73TpVDrR+iYa32pO2FIr1edqXocgLvjo4PcsNmPg7heGAXw17NcSb03+IVdWJ7r
 eR7Oo8VeEl/sknFhDIyrqEmyHmVJldqFqu0xtgpCcGqrxYfxSRx6uDPX9Z3bS41ygKLaCYa02
 dD3wbe/+TAltqZM4Cm3Gf9QgOHRJ7OF3J1VRAJm3rpd/nwzczMmEZlr2vGrsuKksdXHhIu1Hg
 eIaddlUf9CMf17737rAiShVkLwmzewE+Ak+GQ0kuIWC4cYI1U9EETODx+uRxKCtSpJqm22kKU
 yATYuINNhy1BJuwmiiqn4AK3nqqjcHdBqmF9M5EGiNE5IJHQYIh9jaF69MZ42rw+qHe//X/es
 Xb/z4Bhywrj93i2xZY0ov6XITm4pJtcNnMV0b5eYe3d4KmmGV/xufyyHZFAUHAbt9Zfx5dTuc
 Vup66XrvaTKvYFK+36508XYqNxOIvxaLpQPO7DMAkix8NAEiuGdgZQ+2Eqe0X3+VP6B4IkCc0
 ZrAnklOtlrG5lExOMs7WiYHVF83NOEc6FodCK2+IeCIyVpfQ3NorvZaRq8hrBrAsj3TGNbaYV
 HBv18+poG9O6ua4ORcSFfQR6yMTLxUwZv6dQwyIPQejorHqj0WqTRHB2BjLHjgccBsERNarGn
 E/vmApAY8nyxi4RUoXn0xsb0Zm6DJa10=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Mon, 25 Mar 2019, Denton Liu wrote:

> On Mon, Mar 25, 2019 at 07:50:38PM +0100, Johannes Schindelin wrote:
>
> > P.S.: Did you run the test suite before submitting your patches?
>
> Usually I'm more diligent about running tests but I wrote this patchset
> in the back of a car when I was running low on batteries. I only ran the
> rebase-related tests but I guess that wasn't enough.

I totally understand that kind of scenario.

> My mistake, though. I'll be sure to _always_ run tests in the future.

Please do not feel bad. I did work pretty hard on making the Azure
Pipelines support as fast as it is for the very purpose of helping exactly
situations like yours: to hand off the testing to the cloud when batteries
run low (or when you want to use your laptop for something else than
running Git's test suite).

And of course to verify that you don't break things on platforms other
than the one you happen to develop on. And to check the documentation. And
to run some static analyses.

:-)

Maybe you want to open PRs at https://github.com/git/git or at
https://github.com/gitgitgadget/git to benefit from that kind of automatic
testing, benefitting from my work (which would make me feel real good
about spending that amount of time on it).

Ciao,
Johannes
