Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A699B1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 16:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbeGSRQh (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:16:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:33173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732048AbeGSRQh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:16:37 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnPGI-1gEfmj3lra-00hbyg; Thu, 19
 Jul 2018 18:32:32 +0200
Date:   Thu, 19 Jul 2018 18:32:15 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Duy Nguyen <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
In-Reply-To: <xmqqfu0glbqm.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807191831410.71@tvgsbejvaqbjf.bet>
References: <pull.10.git.gitgitgadget@gmail.com> <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com> <CAGZ79kYem+uMrhv+CUSDNXtE3C8Pv1cx=aZOyBLG=uo-aQWXeA@mail.gmail.com> <CAPig+cQj5_bEiLyAAS4xnsUQEPzqT_2yerdAQxd8FidVpJ5CxA@mail.gmail.com>
 <65d51c26-e248-f16d-bac2-e6ba0a3be8e5@gmail.com> <nycvar.QRO.7.76.6.1807181427120.71@tvgsbejvaqbjf.bet> <CACsJy8AbT3=wzKecGqvj8ibHmquU=NfP872f1cAM-VFOLSLSGQ@mail.gmail.com> <xmqqfu0glbqm.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Q5LHAvjFH2D7RnvZXRoW6/p8GnSDo42+LZeE51RfzXKO4T3th2u
 TUt2aEoH/68Ug0lbiJa2/FDOuaJPmXIPITPKxiBmBH7XV7lcn7GF4I8EbA3pIr2bTYI6fWX
 47vdWu2tg47jJq/gq90fCnAaJ5WxmfrOgqv9wk4McXanfYK4VP4C2r4YeT4v21nJnOf1e1T
 V878rR5OV4oTtMJTtuj7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m6Y4Zf49CKM=:iQo5pfsckLTPwpsjjTFfNZ
 aV3vgr85MOZBMImQ5NSuWENwU+vFzMThIXjkt3khD9NG+d8wp7JfT00fGt/tfXGwP5THBByeP
 Z+fEI41AzWbo7m7jleHui9VgxZ/jt+Vs5fpygw5Q0rGc9/ALD1sdO3QI5u1sKuuWIoRqgdkAM
 DfBCFrR7uBSD9IT24Njirir4wsfMHR8fZNs+yVZUCB+Y5dMJNh9LzMHsWFZt0luwKSJftK1TQ
 2qBUYtUeh+Bc8dMeZrvS6X4ZnwV8YENVHPpMMaeZAwgsfaE0/Bnr+c/W+ayM7CUqAf8x3RvYf
 nkDSrRfNKWfB8GJ99EEmG14gzimJ226tibGiQ8IO1Vi8gnholh6PFKXeZE9OSWvM4TP6AO7Ug
 39XJbeXVZiOjTEhxLQI9YpFWF9oPmDwb0u00oFwnXkBM9GzVDhicUWLs1qhc6N2MBBwXKuVNX
 MZ+ieCCKeOTU/8ESh7CjjyHvQnrSoLv0ywaALT0hQDcr1XqpoEJ7vddEDhQp9q8J61i7hrlb0
 ieIf409h1rwdedoUJ0Q7tPnQ/ZOzgfUG6mGXrYzKr7jDGy/iPirYi+VTyES070BWqvpgx1zjl
 GP47kOD6Wb2ZAGZ+YFAxTgXYTLBOPmmgb5h/1Kzyi6+CjEOgSISWCwRZNf99FuT7mBej+aYpH
 RglGhkHGampveIp5kcVMWol6NIfx5s8pn0+r/D7Idu1D74cZyX81x713m+CfHtA7Yci0jj6GE
 z0rVHm7+RN0PYYGG6LhAwSlvqdpbf5P01w0FCChHmeUK7XVUgzo73z0u9nJwQ77OTNidzeJXz
 pxhnFkd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 18 Jul 2018, Junio C Hamano wrote:

> That won't stop those who want to improve the tool.  But I'd wish
> those who want to make Git better spend their time on making Git,
> over making GitGitGadget, better.

And I'd wish that you would not make this task harder by refusing to fix
your process to update refs/notes/amlog.

Thanks,
Dscho
