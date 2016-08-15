Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E7A1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 12:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbcHOMVB (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:21:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:52600 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbcHOMVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:21:01 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MN604-1bX3y00ncW-006iI6; Mon, 15 Aug 2016 14:20:52
 +0200
Date:	Mon, 15 Aug 2016 14:20:51 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Christian Hesse <list@eworm.de>
cc:	git@vger.kernel.org, Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] do not add common-main to lib
In-Reply-To: <20160815075207.31280-1-list@eworm.de>
Message-ID: <alpine.DEB.2.20.1608151418150.4924@virtualbox>
References: <20160815075207.31280-1-list@eworm.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+IUGmTaGitCBCUgZcnllusJ199TeHForhpcmzsCU070wDdt/hYN
 NVW9hUXC0qAxYt0xihUcYiJqaxn4YdWy1FAJgUnpynuzMpIsGe0ZbO8SA7LIjUi8XCISQva
 ttFTAcgg7fVZMDV7MvM1UylmFW9fxDvao/4SNTGIwlkNW8+4ygJp5RPmUfyW7rMB57nuKMx
 9MF8Qz8MC3Oh/+FVzuayg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Rx14vI04TB0=:9v/A1H3QN0TH97+MWXyrl5
 WQ9vIcOs3pzFwwOH2S6NSW604UT+nu1Qa1e+dzbQMShgv7lADlFWH2uGrDoH2Zq8LVYEia61R
 HIcYheF2gJ6IbzNlNJtzxGNTy8l0af8FWKdX3T2Ny4G5gRcDXgmt1esi9lfM2ZUb0jT79GQzf
 U2taOCE/3HdUZ0U/gFduXtscBPH1KKMKQ7X5fw8osvP0HnzBTmAhtUEGtAc4G8F/rl0haZC/T
 0StATUhRigvdpiAFjW2nofTKzTmgmvdxoVdaahRXDmHOIR45aF6LSDJquGhHBJ3eMM9aptGpJ
 3HT6cZEWnc2tXbr7YNchg3r8JdU/iyqdqiuWE4cj0i8qTO/SmhjFdi7+HiVDq5Fn+aYE34140
 1RedfcXa6gE/zQ0y0Pcy4l94eUeDT781d1DQ03R25/XQO3O0+te/ud7fzNaQjL03FtHNutvN9
 08PaG7+lDfF1MUxFZcXAj5IHHMvprkKkM1Ahs/RuKwkeBhdcWAsu5QjojTmdjggSkTDeya6N6
 GWjoKEMXM7JNheqvdwauwpI7Yu2EfnVqabmcJNAcAQ2bTLieNl8825i9lcHvmC1l8XbEN7oAF
 5wBEpzqr84IXQb/h+8ZksFpCqdH8gZ4w6PCBHzIS51krxz9K03HsujLrFKtTg8YFsPtSVWB65
 poJhahuqqmxGcBaW6ggi8A+ITiUj6XU9I5EwFHlJ3iUTgQ/7lYPpXylOhwCRLwPSyyYlUKUeq
 i5H/HhaGQFc5kdHtufUZw57DacZHq83ZVMSu1JbxmJlkGkGQoBOhPtU1SRjJsM51K+f8V6y7Y
 AS+9Pur
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Christian,

On Mon, 15 Aug 2016, Christian Hesse wrote:

> From: Christian Hesse <mail@eworm.de>
> 
> Commit 08aade70 (mingw: declare main()'s argv as const) changed
> declaration of main function. This breaks linking external projects
> (e.g. cgit) to libgit.a with:
> 
> error: Multiple definition of `main'
> 
> So do not add common-main to lib and let projects have their own
> main function.

I am opposed to this change.

For one, libgit.a is *not* a library with an API, for a good reason:
nothing in Git's development guarantees any kind of stable API. For that
reason, libgit.a is not installed, either, and neither are any headers.

And even more importantly: *iff* you *insist* on using libgit.a in your
project *despite* having been told not to, it is your responsibility to
stay up-to-date with the requirements of it.

One such requirement is that you now implement cmd_main() instead of
main().

So if you want to continue to have an out-of-tree project that links
against the (private) libgit.a, it is your out-of-tree project that needs
changing, not libgit.a.

Ciao,
Johannes
