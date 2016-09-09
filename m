Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0760A1F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbcIIK3X (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:29:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:64395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbcIIK3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:29:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M4Gup-1arAEY44SB-00rr2U; Fri, 09 Sep 2016 12:28:54
 +0200
Date:   Fri, 9 Sep 2016 12:28:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/3] diff_flush_patch_id: stop returning error result
In-Reply-To: <20160907220409.oowxymhvkof2xsk5@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609091219350.129229@virtualbox>
References: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net> <20160907220409.oowxymhvkof2xsk5@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BACKHVbQjGZR9BCweIyHr0JOGPQ3OdNQ/MFPsOLuDSGw3yiFmlX
 ncSHxOmOxIyBPBcwDgqEDYz8Na5D9YxyYpmC0w3tvhjI9swsDDwLnVVHY0nzDhLxrT8htwz
 rVS+CPT3MAxpX2SRgkoW46uei8Zvu7648ck0W4rdVGo6q1qvHdvH43Ew23zt5ABvACIuwRM
 ajm+sRa3xP8nV4FdzLCtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HU78w/Zx0Q0=:0z3HSEzirJfX+gnMZj9F2g
 gK/Db1BtTJP2W5ss7nDnrbGY4hcwFw5IDyenw55QpvFKDlcx+h7TeEk0lUFxJjUyAVV0A0v59
 iV4vemAs0m2PQKyAkDh6QXrhzcZz6UFLmMfZFakp7ul66RIsPslQY3bVGH4XFNuWuI40E/K2N
 N/eFsmgRgeutWaUy+jBigT25rXvCe0161/UWNmEkrvMyGUg4TjIm3e4J/955EsH8tAV3A/moQ
 VRG7COFaKRweq3ib3Fe234xBW1HFHbe3Aiw60Wm7JYhZtAtE0o8rSIQ01qn783PHiWxVxIW3L
 Ye8KtsVyZldiLASV6oE8VSTyLVvmhiUtVUBczVH97Xavi+QJwhefKbkvlpeMgBzV7XLpHRReM
 Setjl+RfwftbGv6PDADOSaU93/NLbRaJwZNAl/LE6kA9ZZ7AqSL/fYD5KlvrDbK36ztxf48qx
 mfsM1QNAGJIfSwdVjn5KBz4+0vdYqHlI40ZkJuKeGC6y+dABiCNz074XL+vYJrvkXfZrr0Pfs
 rUy31yfkHMPcJuN56qiTBOjzRVkr9FwSV7Gp2b+wdfhT5GY1h2o+Z/cNMZ0WLYW1PT4T2RH8d
 4En3OEy7nVdBU9WNw48F8+IMUODyk1ahd+P8XtYsVWVK1on3yb6T60U0NvPGiwm6jMqjn58QU
 Dz2hnZQT9pG9S9jGnVYftLB5P8zUtCxEI9cAv6VKbCUKHc74r0lk1oX5mWqwTDCp+6kCA2guJ
 vcWTTSxRD5Zy59ECI23Iba7Xv25mxQkdoY4cBopX/8gnz1KdHWq6zwbjfkoutDHQjCjNS0it2
 vtS5ebg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 7 Sep 2016, Jeff King wrote:

> All of our errors come from diff_get_patch_id(), which has
> exactly three error conditions. The first is an internal
> assertion, which should be a die("BUG") in the first place.
> 
> The other two are caused by an inability to two diff blobs,
> which is an indication of a serious problem (probably
> repository corruption). All the rest of the diff subsystem
> dies immediately on these conditions. By passing up the
> error, in theory we can keep going even if patch-id is
> unable to function. But in practice this means we may
> generate subtly wrong results (e.g., by failing to correlate
> two commits). Let's just die(), as we're better off making
> it clear to the user that their repository is not
> functional.
> 
> As a result, we can simplify the calling code.

I like the simplification, but I *hate* the fact that the calling code has
*no way* to inform the user about the proper next steps.

You are touching code that is really quite at the bottom of a lot of call
chains. For example in the one of `git pull --rebase`. I just spent an
insane amount of time trying to make sure that this command will not
simply die() somewhere deep in the code, leaving the user puzzled.

Please see 3be18b4 (t5520: verify that `pull --rebase` shows the helpful
advice when failing, 2016-07-26) for more details.

A much better way, in my opinion, would be to introduce a new flag, say,
skip_merges, and pass that to the diff_flush_patch_id() function. You
could also consider consolidating that flag with the diff_header_only flag
into a "flags" argument via something like

	enum diff_flush_patch_id {
		DIFF_HEADER_ONLY = 1,
		SKIP_MERGES = 2
	}

But it is definitely not a good idea to reintroduce the bad practice of
die()ing deep down in library code. I know, you want proper exception
handling. We cannot have that. We use C. But die() is not a solution: it
introduces new problems.

Mind you: I agree that there are serious problems in the cases you
illustrated. But none of those problems give us license to leave the user
utterly puzzled by not even telling them what is going on: spouting
internals such as "unable to read files to diff" is *most definitely* not
helping users who simply want to run a `git pull --rebase`.

Ciao,
Dscho
