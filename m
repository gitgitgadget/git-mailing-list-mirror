Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F681F453
	for <e@80x24.org>; Wed, 24 Oct 2018 09:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJXRqX (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:46:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:48803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbeJXRqX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:46:23 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXZNq-1g3ikx1gec-00WXR8; Wed, 24
 Oct 2018 11:18:57 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXZNq-1g3ikx1gec-00WXR8; Wed, 24
 Oct 2018 11:18:57 +0200
Date:   Wed, 24 Oct 2018 11:19:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stephen & Linda Smith <ischis2@cox.net>
cc:     Anton Serbulov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anton Serbulov <aserbulov@plesk.com>
Subject: Re: [PATCH 2/2] mingw: fix getcwd when the parent directory cannot
 be queried
In-Reply-To: <6700297.8bfoVLpaf1@thunderbird>
Message-ID: <nycvar.QRO.7.76.6.1810241118460.4546@tvgsbejvaqbjf.bet>
References: <pull.54.git.gitgitgadget@gmail.com> <3e3b1c3b1ff3363b216574f09d2c9cf22d25ad30.1540291965.git.gitgitgadget@gmail.com> <6700297.8bfoVLpaf1@thunderbird>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rp9w2pqjyVtnWC5AVME0ZN7T7mKUWJdoTZc/NuejcYoWS2DZfNo
 yU5R7vOjl8QAUd6bEVPRngZFj9zuGioh4O42C72PJrBlZvDDG1chqi7EE5ruPxcCl+mbyh0
 +eAK9IPh1cN52cvI+30dHfMEWZdz3HHaWxmi0ZT70YIguxKJKSlPnQk/7z4ZLQ2OhaJCZLz
 w8QFsmUKTFlP8303qSPTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MrZwuLAf1oE=:rG0yiqQqmDI8//urypowhD
 SRcu4Qq66xAWPvMROzd3W1p2s0Vs3YviNTdH4tyIaeWScBFkm6S6i03O0dU0Ko616dVyF6e76
 5WcDvE0MhXUZKai4ZgqE4O4YNSP2VX0ksdv4GGQe6BNBQIFBnqLqIx7dnXuljTuWjwmuwda65
 Qv2Eg5gkb+3Os43QHaLj+ra8BL3IZzkUrx1JOdKVajvQ4GynUJ98Q4CFx6PuQdl6YVOxyAtnb
 jm1HHIbf770T7LX6X3S4S1QYPFniJZUVIQXugYzGFjRbrFXLOGMJWXptni9CLu2SuuhNkEJZP
 3x356wKn4i6Lf4y1YGXL5FC7vRMTRJeytbamL66ZVreFDfxHXISrhUnSIPxgI/sDoWJeSK+GJ
 wz7VVVdh8+TnwUjMinYEXrw2GLJ7IpQpKkcUnC/0NB5Ihaj3w9NQxVFheoH6HrWtV7ZpY2mHI
 LctsP5/mtq59NOTyfZzn7XhYqAxijY1B2mZBIIRLlUf6+EWCfjqK7WXZfTcNGxK8DjW7XwO42
 iR1dHuh1tWC6BF3rY5zTlMUZV9Dkc0N2G37tbXzTT5QzbUCyihtM3b86mQlpyv9/mN0GHZ4Mj
 4R2Pd6n8VLtog/8hqNzbcSIIWKArSvhASD/pPj98HFFAb2Y2ur0ZO9fomSJxUXBk5rCXtjQII
 hQ14w1VSfQTPnWqQ85hWReYYmbqxiswhVVMD3VIwc4rRuXT+WEo3QUbx8cSk9a0P4n1UGE6cV
 u4U7u09fdDIQhLhkD7AO/m101XjM5ByScEvZGCNfNM7Haq7MkZQfs7U0g5codDfDGdQN9WWjC
 v/o8FCan9Xanxm5JfnlBFHk3jGGqg4DnbnelR2i9PeYgysKXzk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stephen,

On Tue, 23 Oct 2018, Stephen & Linda Smith wrote:

> On Tuesday, October 23, 2018 3:52:49 AM MST you wrote:
> > From: Anton Serbulov <aserbulov@plesk.com>
> > 
> > `GetLongPathName()` function may fail when it is unable to query
> > the parent directory of a path component to determine the long name
> > for that component. It happens, because of it uses `FindFirstFile()`
> s/of it/it/

Thanks, fixed in v2,
Dscho

> 
> > function for each next short part of path. The `FindFirstFile()`
> > requires `List Directory` and `Synchronize` desired access for a calling
> > process.
> 
> 
> 
> 
> 
> 
