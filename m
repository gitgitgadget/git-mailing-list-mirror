Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAF51FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 23:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941881AbcLVXST (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 18:18:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:60865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941233AbcLVXSS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 18:18:18 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lg6op-1cwZJ02pKd-00pbKo; Fri, 23
 Dec 2016 00:18:05 +0100
Date:   Fri, 23 Dec 2016 00:18:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 3/3] mingw: replace isatty() hack
In-Reply-To: <04859cf9-e67a-28ab-ccb3-249687e696c8@kdbg.org>
Message-ID: <alpine.DEB.2.20.1612230017030.155951@virtualbox>
References: <cover.1482342791.git.johannes.schindelin@gmx.de> <cover.1482426497.git.johannes.schindelin@gmx.de> <5e3c505a206a735e6ba0bfaf4c73965e95a928eb.1482426497.git.johannes.schindelin@gmx.de> <e9f8a015-4106-fa88-082a-9e8c06ff61f3@kdbg.org>
 <alpine.DEB.2.20.1612222235200.155951@virtualbox> <04859cf9-e67a-28ab-ccb3-249687e696c8@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:40kwkysVj/lD3Bx+SZNiGa8P1DQ9KZGrNJlNxF5Hi78kRjuDk0E
 MMd+JKEqJYv5LhchEq7qIOomhwA96nRavdyFneoOGv5hKD6ijP1ly1/UIpGf6E960dSktKo
 xJ4tb7PsRhWyTLVgbAqoRofEFWpWI/h4vwBNF5JLy3GQ/DAyQGULUTAdHlkYhGoxNUoy9kR
 /dnvzFc7sC80qd9pR69Qw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cbEgkdH4fyA=:vPx4m6I7QoiPY5WHbFDzQC
 scsjt24tThLh6ShJkqi4at5/PFro5IHyQMEK9Rg+B9eYCL/laVmOFpjXHxka6k29ipXlCTNtp
 ew/ptGY/WnKsD9ohoChyiQOMOKls0wQUNIxfyjTDvve9MfmD1Vto2M2M/SP8vovJoQWZjOE38
 pxRVxfbaoo9BJCOmKJ2A9u9T0haF8UK3H0yMsDmiYg15+xZ0kXXiAsE02vqsYurCzVRDMBZB+
 p/rFVsMCYyVdcLmaXztvzAVbcR0JKazoN3asPIwdWnRFf0bouRCnQiUCC9LHV/ymi/mXql06d
 xlhSH0xkvivfNGlEER4L1evAyB7jZl0+c6YpeVzRITtnPfhANNNCfDH5nW9KQjUAAuNOEz1bS
 uECoPtoa9oOAl/Gq4F+FsCXkJi6AZrP0wndDSxpe2IrIydRzOyh7HfCrinUgbxlq97CbWO+Pe
 KFiObpLHdcNlun630tWrJYi3NsXnWgea8aN+ldzBWDtBXyg3/+WisqiFQ/JTzZJohhFhn3yxf
 tjWJaLBmxFcCE2Zht3zlUOOQkLuML2H0JJLB485b2bdk8JwmBU01l5LzSlNlbyR7g/XGbZHqt
 iIqpyGc3H6uDpK5dYHvDNfU6Lt0Nt+T4nk96PlP77GAhZVTvrVd6XXChJg543RZo2VNpjs83L
 Lu33bXgBleK0TK0xvO0zQv6VkSEBWn6fmJpd4rMn2oYnYhGQN9omoPyDygH3NrEHkwdXO6zjY
 dsNTfDnWOpupBsQjBR2X6P+w60MklxkOuTTIoTJNwBBnlB7n7CVE6HYA4uf195ZKXgdEaQSoc
 uVkK8sA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 22 Dec 2016, Johannes Sixt wrote:

> Am 22.12.2016 um 22:37 schrieb Johannes Schindelin:
>
> > Would you have a suggestion how to rephrase the comment to make it
> > less confusing?
> 
> Perhaps
> 
> 	 * This might close the cached console handle.
> 	 * We must cache the live duplicate instead.
> 
> Then update the cache before the dup2, because at this time all 3 of console,
> handle, and duplicate are live and cannot be recycled:
> 
> 	if (console == handle)
> 		console = duplicate;
> 	dup2(new_fd, fd);

Good point. I reworded the comment slightly differently (see the interdiff
in v3 0/3), hope you don't mind.

Ciao,
Dscho
