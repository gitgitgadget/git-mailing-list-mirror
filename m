Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BDCC28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 19:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA5F21582
	for <git@archiver.kernel.org>; Sat,  9 May 2020 19:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KMW33G7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgEITBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 15:01:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:51247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbgEITBR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 15:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589050873;
        bh=kwoYEiB7rtyumKcGyYa+Wuci/D7J7K8jovTMNGk2bgo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KMW33G7Zw6zWQNsx9/7eZyrD9UjPIZ8LzW8ceRp/ngMLyXXzb5Vpw1lPy6OrUzAzY
         7uR7Lmy8eCHvS6Y/BUBfxFs8StPMv+yWx5/0FdqkyNbrnuseNBeR7vIRuDpeSsbSGZ
         Ozck7eE3uHP2/tH1D48gHrK6K9i9rIBbpBpbvROY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([213.196.213.48]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1jDBmE2Cuh-00yQ3q; Sat, 09
 May 2020 21:01:13 +0200
Date:   Sat, 9 May 2020 16:41:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/rebase-autosquash-double-fixup-fix, was Re: What's cooking in
 git.git (May 2020, #03; Fri, 8)
In-Reply-To: <xmqqftcavz79.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005091640550.56@tvgsbejvaqbjf.bet>
References: <xmqqftcavz79.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uUyZFxwyMld5Oh0taPKExkRejQwhsVxLSU1I1JUrlx4Q3bnw8oM
 PsDOpdBV77mC+pRDqbCSWH41uNbjTxQmKS6KF/fIleuExAGUe7sKla2FqmifCDglPM/SdDq
 Q47RfmvGtekUf27pU4R3XHSX0UOJ1B1IDeaPMdb8OcFBcbn3YMqa6u3cu5RV1W7xLCv/wAX
 fDX8pHQ4oI1V9PGoRDWnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qf6YV6jxO+s=:WkceFl2J1OvDve0/fxMMHt
 jwiszr4j/QRY+R04ivn8ETBHtFwgxhRtczK5F863Ab0wtGd0rUe6zNDv35RrZlNE0RrP1o/1A
 6WxIWh3da5MR6Mv4bbqPI1AJ7gFVtuUHwGAWTF1lpVjfkICKijL8aD1fT8wUckSJCK96J0zqs
 TVExzBRZtYV6mt1oci+UxEX6OArMqCLVGkEgxNhPNOj5rd4w6PJPBI7jX7M7JdJJThjwC1DW+
 7RwQRpqk4GV9YiNQY9F9emfFJOsatWDG2M8vg9peMYThpF0tBtaC82d/6u5gFvCgv3swiiwnj
 ONiACqs8dVNcig7VrTKLGqSR0WZbruK++rwOXfJVYXiVbMcboQlwIwudnvuwh4XvhRf5W0Rtr
 G5+lf7z+02yQ+wmSTX7nnlAtesMcz4jbWvSSgHzpoAacHB2WmhgTPc48tg/tuQkgRGihhYEEI
 ARmRn09rxfjd2WFLTPsXW4uMGqybEWLmoKvydq8aDfB8zygkRNxT+lCdH2wVgtMJyYyR7O9Js
 FcQMgGoHvBsS2IWiPTiCDqGWNG7+mMKj3baKsQel1EidAO3vBj7jo6+n3Eqz3RZvfUu2iAc76
 FQRmZ1vYOOrrRZzEvHYXIAInGBL7plW8iUG+gls4S9ZOIJkWmraRrIDxp7TKD87X0oueqxf9G
 yZGFUU7Z4k/Zd3UuB3s1cz7XYaIsYQ3FVxyok62cVaq/YHMzpZRN+qGd7t3cMuudmTOSgGc64
 Z1jy/x0ntQz/sZvcgoTNgb7qQFxf1QQy1Z4XVGEFe289a0+Vx8ZUcd6EqGRO9l9drfbjUKHti
 AaX800h3x234STUSM7OPHclkpqGCF8q9XwpRgXhU1Kt7q88nHjAqXc8bUHpWntxsRhjeeC9iU
 gJ3vcV/40g9IWN0RtHeaf1cT3E+IpM60zJ1ZEhCw3W1Z6t+LD/FjYWIA1JoXWpryUgeZt4Qcg
 wJzTfzTD/FemUHZ4AyHIqelA/bBW0zypWM3x47nGEX24UZbw6jynpPISbE+K99bqZR7sGIG68
 Dj6eoesFU+fLxaOKHaP9hi91IsGdF4tVqFDqSaNoLRo+yhOCxsABQE0qDfP3Il8jOWM5VkJDP
 VnSxsgb+trt/baCrY5mbxlh9T5mJ2xWzT/iut/Bmf52dr07o4p3wUm5665i20JMXGOrNjs5dE
 bvvrHFddbDjRkOZQLv0x3ExZ9N/2ENEiy+GiH53N/uG9t1TOgHrNJhLLLTKDWVg5oehfh7bc1
 dRLXhK0HIHaA/moZt
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 8 May 2020, Junio C Hamano wrote:

> * js/rebase-autosquash-double-fixup-fix (2020-05-05) 1 commit
>  - rebase --autosquash: fix a potential segfault
>
>  "rebase -i" segfaulted when rearranging a sequence that has a
>  fix-up that applies another fix-up (which may or may not be a
>  fix-up of yet another step).
>
>  Expecting a bit more explanation in the log message.

Will work on this and send out a v3.

Ciao,
Dscho
