Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47FBC352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 09:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDE220848
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 09:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ax7mym2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgBKJWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:22:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:34315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbgBKJWV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 04:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581412940;
        bh=PpMdL69j7osvQn7Ji2f/NYiff6kZJGFLL4VAuZeSTYM=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=ax7mym2Gi39awnTv2ecdJpv7sFfm2gsg7dbdT51x3ko3C6BoLOXkQ6C+UQdZ4uOYZ
         gBYU6gAD7VHD9Vz3oC+yz1+/1xz76D99MCvzR41QPg3+5m1ixN41fUk4TVnnkEzs+R
         JGlaVZwY3B47oyMFGXGTZI19RNHWnVjKbYQC8+OA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [194.114.62.122] ([194.114.62.122]) by web-mail.gmx.net
 (3c-app-gmx-bap62.server.lan [172.19.172.132]) (via HTTP); Tue, 11 Feb 2020
 10:22:20 +0100
MIME-Version: 1.0
Message-ID: <trinity-f39d7ed5-e4c9-45fe-944c-b5cb101cfdcd-1581412940557@3c-app-gmx-bap62>
From:   "Steve Keller" <keller.steve@gmx.de>
To:     git@vger.kernel.org
Subject: Develop a patch series with git?
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 11 Feb 2020 10:22:20 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:BZw8jNpcqpHboPh1GdPtxBvbHBJpgRyYRDzxhXqu3NtbmIqen425Vd7MMcaACxJx+A2RL
 0ljV5X+ydCJrKQHAWYc5P7w7UKiTDUtvDMBaKxLS9O7KhxIKM4Tf3N8EF2dH/Wr9ovVXUBXVV9Gk
 muREKes5jmGUYJJkzxyAdvGJZn6F8HJJSxMRyCVu+A8WXA3qeBm6yoqv4QE/lKcoxb+6EW9lzzy9
 fBvRvd6EPFoX5ecJl5rIBAtEPev4PyDKCAzrhe7aoaljR5VWv+O406YfMNmfBMOvUiAxmjeuI0Eg
 3s=
X-UI-Out-Filterresults: notjunk:1;V03:K0:a9mKFXY1Clg=:A33I5j5+Dxl5pnJgX0P4y0
 rSZ0FT79/D/fbXr8tfwBbZwtjrEOwchEeNS6bNbJoH8G6p5Br+knoHzbSJdTwDylsPtI27LfF
 df/Yoll0YJwMRGeG04HS7WjNAyCoSZpOOGGkqxgGI1zrPBeAenxqsZ5AM2FEnQwx+piUdcvyP
 uT+Gjz5lm3m06hjBIQsZTDXN1UZgTuM/u8xlRcQkl/2i3ZVF0DbC0SseTRPoYHdkjt1B9knfK
 Gr9IWxKbcwICrSuxtP9N+kdPVuFcekXOzRnTTKDJmY9YDwpTRIjFOlImGPVTCXKbVg4WWB9SE
 /E6YWb2gw3X89ZaWipNHVl/jjzMm7wjAYzRhjjhPPZfmlZ68d9jCla3/iDGrUhip4i039jZuE
 c8jgI7bW7dYSYJDw65LmJ//OtSB3iN+n9X8VWme++z7FX6L8h/wsqN2hk4CoUjBo0Gh+5upIT
 vhOAE74t4oUZlAzAlWB7Di25icQdAHqqCVbi1KVQdXTMm8ijcd5bj5CPGvRZZX+f4tmoK9yY3
 V84Pu9FUGHUHPreqkKGPH0nX+WkEaGYVuFbGyjyvmGAeNKsPRbaklkiij0M6v7ToqXXZt2/1P
 RvuhRUDZZ/w5silpFZoWlHCeVztUA0X68yfgditbBnTAb8Mq2D4rJ4WfUjbN5D5W3d7zeGQv5
 txVbEaaQCqQJ4oMewgFwW6Rxem3qDi+dF9x/fbT8vf3CEGFOASMkjyb0bpc9IlFcyBpo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wonder how git supports developing a series of small patches.  In my
usual development I go back and forth along a series of patches before
I can commit them all.  I use quilt for that.

Say I want to add feature FOO and start a patch "FOO" editing some
source file.  In the process of doing so I realize that I need an
extension of some function to base my patch on, so I do "quilt pop" to
undo patch FOO and insert a new patch BAR and then re-apply FOO by
calling quilt push.  No I can use the new extension from BAR in my
current patch FOO.  The patch series often contains quite a number of
patches and I push, pop, and edit these patches quite often.  Only
when everything is done I use git commit all the patches into the
repository.

My question is whether there is git functionality to replace quilt.
Or is the combination of quilt and git common?

Steve

