Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87F0A1F462
	for <e@80x24.org>; Thu, 30 May 2019 19:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfE3Tnc (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 15:43:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:52629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfE3Tnc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 15:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559245404;
        bh=YRve+qJP3qGbaGyRiWVL2MNl3trrdzseH57TCioG+Xo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BQI8ns3mEddZQ05RV8GKmwVNpVqzw939BQ66LzX845KbDxLPhYQKk+ZtiJ1oyKUYC
         8i6XTdQI5gUyuKnzw0n6ys7whyHXh8/D3xgOHi8SY0betwscd8ZXp/3nwj0eoTg5xs
         Lx4suhBIUN+Knosc8IZeiIrnESVG4BjQ6iUzcB8s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof5H-1gmbkj11FR-00p4He; Thu, 30
 May 2019 21:43:24 +0200
Date:   Thu, 30 May 2019 21:43:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.org>
cc:     James Harvey <jamespharvey20@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: Request: git add --interactive: split hunk: When can't split
 further, split on empty lines
In-Reply-To: <aad93135-6280-ac6a-c72a-8a325fbbaf67@iee.org>
Message-ID: <nycvar.QRO.7.76.6.1905302136400.44@tvgsbejvaqbjf.bet>
References: <CA+X5Wn5bt-3zHUqtRDWtc0A82SFmWPuQ0+RvRLaAV6Vn24nf4g@mail.gmail.com> <nycvar.QRO.7.76.6.1905301644020.44@tvgsbejvaqbjf.bet> <aad93135-6280-ac6a-c72a-8a325fbbaf67@iee.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:icqKvWe7bvvjjk1HRDNW2kbE4NV5TT5gXtepmd+ZHgbYhnPQyx8
 LKAcdMcCQxx0Ays8Z2cySgzjda73gYSxtUMxw6C2ESC5Z7jTyI/5eHTPP8hg9rY3vOtlbq3
 LCmG9xCBvS8VvCPH41NS5aqvuAABr28q8OOz8ah5grcMnO+tnrISfUrZ9k8l4Y5TUzWKALS
 6PtT6wlcnUmtD8Hj3RWVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1RkqVqMlH+E=:yfWhwgZXw4ziYOx3etpio4
 9VVi1kwtiIPhBOiOOCzy0py0ALok8oMqy/7owc3pFiJOH0/zTuyFM7vNwSSEhaLsHH/jc78Og
 wvUVPlGf0qSmCnODWE6V7MgqdtDZfT7SQsCM061CUisaj9KlOdW8B/O3VljFJrOhKFjFa85vv
 xeC2UdrPVloksnZhzSgR4jGHSvTO0GbGdL/5s8o9sXm0CKGTfro5Ap9kE7BCWjdHEiUgkoqyX
 AlWi0EhasEMxx+UTUGmPeEMfAFz9U3Ave5aOE94ncF7vhuP+OrCXiJY3Cm/SH326DJ8E+svDW
 yAa1uMAcqL37F7bKjDvaU7DZtPQbJaWm6InPQ7g7HrezxfMhM6kvNpuV8cW51gGNbLGntiver
 rD4N7pe/MVigNmavjV6XsS8DVbMEma6gBwlITilfTVoSUfeWFM9MU0d32KwPj1FdE3/9P6iUw
 WGEirLbIZo/AuFKKz+y2W+DzaJownd+Hr5hcr8GmDghtUpI4b3QsSj/1UxYq7WDp3GbFWJsjq
 zCSOsu7/ttUbwxGPZjE9TBma+e0ZPgxlCVFDBpGsK8Uo02MtZHT65oKbsYXl2P4TiSkz1EDlU
 lBG39WtQ4FHUjVcf1DsQDPbZ2xhMkadzAyJOEaZXFikTuVUN8wh9bJAG4vG7YCxeoItZXAUlP
 7OssiqRa0XpcRaaBItpaVYmelCFWpDijNygVoyfEJQ0sBgVXhO6qGux3BnLQYUc09vWlzQRIS
 u34WF/b48jNIJwjwV+Jt3HSrb/3j9DOwRltDXfNCrfpQiNWPC2U0hElH+fAY0IQtb0NliKtpB
 FD9CeNAQCfdKvhdPL97XhSb/1Pxq5gOb3fovfSneis3td8Do3g9Fil9gsnuEXBb85by+0UnCX
 r7c3eHhoWvqgAd9SIBBKgRpiCqMB8tjnfuCsBOSDN7ij900SLskO4QifVw5Mw9PLLxs6phdCO
 IdXrFHd3HjskLut611vIbhqM0nAzR5Q7kFbA9Rn31qnM2fDsMak7z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Thu, 30 May 2019, Philip Oakley wrote:

> On 30/05/2019 15:53, Johannes Schindelin wrote:
> >
> > Having said that, there was a patch series recently to add the ability to
> > stage individual lines,
>
> I believe that the git-gui (in tk/tcl, but using git commands) was
> already able to stage individual/selected lines, so there may be some
> ideas from there.

Sadly, no.

There is one very big difference between Git GUI and `git add -p`: when
you stage a line in Git GUI, it is staged *immediately*.

When you stage a single line in the Git GUI, the diff you see in the
window is reloaded. That is quite slow in the long run, and no fun.

In contrast, `git add -p` does not stage *anything* until you're done
selecting what you want to stage.

Therefore, `git add -p` does have to do things quite a bit differently, as
it will have to eventually build a single diff that is applied in one fell
swoop, no matter how many lines you select individually.

And naturally, there is also the difference between the user interfaces:
while you can ask the user to select (part of) the line to stage in Git
GUI via the mouse, that is not at all an option in `git add -p`.

Likewise, the very convenient option to navigate via regular expressions
in `git add -p` is not available in Git GUI at all.

In short: I think that it makes more sense to come up with a design
specific to `git add -p` and not get distracted by Tcl code that works
quite differently.

Ciao,
Dscho
