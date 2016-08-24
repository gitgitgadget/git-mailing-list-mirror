Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C982018E
	for <e@80x24.org>; Wed, 24 Aug 2016 16:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbcHXQLK (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:11:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:57240 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754460AbcHXQLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:11:09 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LdYSM-1av2HX2H5u-00ihX0; Wed, 24 Aug 2016 17:54:37
 +0200
Date:   Wed, 24 Aug 2016 17:54:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/15] sequencer: lib'ify read_and_refresh_cache()
In-Reply-To: <CAPig+cTP+GNubCaveO6Sf9t44VQit0EaFjXCFexq2CtCMG2=Fw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608241754080.4924@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <131eea01901cc3c366bad2098f6abe8738922d58.1471968378.git.johannes.schindelin@gmx.de> <CAPig+cTP+GNubCaveO6Sf9t44VQit0EaFjXCFexq2CtCMG2=Fw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6XwbEpk02/xz+IQeDFn842Odab1ehn9tufKtxdAcAmv7qH1LM7c
 zlW/zPHwy1KdxFmsOVO7+C2zoJ+6N0A5xZb6wgOQHhMOWdr8qRDFb3JvH3Mxn9QgemRa5pz
 ZOtl/KdYUB1JU0JXeWS9AWTlDFtdnIDj8USFXAYl9dHXyQUJlNBiNt8QGYa/9QR6DfXdu5B
 SNGVRaHhcw1BVtHMXPXWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VXnl5DitQlE=:Purt/YZZJbxMH0d0fvjzrM
 uuQcSwQ6WAzGGVOrCG+zKqmW5iyl1HnJWJdQJrKwfCllMAxtOONjULnmMADS5cPUJKZt7e7Tv
 1r0Cu2DFGKHdFP48yFstmqd5izdEmMJ0BzOiFrq1gB3r6/oaPlcw35wLrPwgYRj8unEiBwqVY
 mq8zyc9Q6egPlJesmxW+KZRYsOoNY1Rza9xzuDE3ZHElPIzkNEt7Jdu//3pCyXWhLbzBs0Ifv
 nD9xOpzQvAgq/zRt9JP2XVU7CE2cBxaeGoOV+qKRECAkmteoudm+WEVAWbPzk3EkG3Lxk1e7J
 3vggjHevnq/obueUVpWLHUTXSYaOmmoE18LvlkC885VPeRx9BDUvn/RVEmc9/BgitMggBJW+x
 mS2FopC9gzXiwL4njdoAeE6Y0CI2otp0s8lxoTUT9Ikh18FYG07eIek15+Fv4dHduGJQ7DlKD
 6WxHgZG9paWAPVBg4ye7AylPD4L+PdzgfWBfRO1Hq82puqMIvuIcBrRSc/XzMYv+eSkAkDGyc
 yXzKoYhJZABK1cTabwPFBya7Uor7ZvfULRqjGpVvmIQ2k3+lbqnFGnXzEQ1CO+2so5d14BlXI
 s6RHSE4N/MqfzFhH9hIgU4KycHl6ip2BgJcYdt1sPzk8omHq45eLA0LKYjhhFakwoXltAKVgn
 lWKcyfgxvkUbbqt6zonSlA88UeeEFTcLQ/BtjUp/wekDkGrEUyQHJ/QRIkAJSA+nd43L7th/Q
 MBvOqnHHDR8BmV2oal+2g/VbPuU/zhsvl/d2r3jC5VE0tky0snoua0Hc3TifcsrHqMo0BrX5v
 3yUaYZW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 24 Aug 2016, Eric Sunshine wrote:

> On Tue, Aug 23, 2016 at 12:07 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > To be truly useful, the sequencer should never die() but always return
> > an error.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/sequencer.c b/sequencer.c
> > @@ -638,18 +638,21 @@ static int prepare_revs(struct replay_opts *opts)
> > -static void read_and_refresh_cache(struct replay_opts *opts)
> > +static int read_and_refresh_cache(struct replay_opts *opts)
> >  {
> >         static struct lock_file index_lock;
> >         int index_fd = hold_locked_index(&index_lock, 0);
> >         if (read_index_preload(&the_index, NULL) < 0)
> > -               die(_("git %s: failed to read the index"), action_name(opts));
> > +               return error(_("git %s: failed to read the index"),
> > +                       action_name(opts));
> >         refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
> >         if (the_index.cache_changed && index_fd >= 0) {
> >                 if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
> > -                       die(_("git %s: failed to refresh the index"), action_name(opts));
> > +                       return error(_("git %s: failed to refresh the index"),
> > +                               action_name(opts));
> 
> Do these two error returns need to rollback the lockfile?

Here, too, the atexit() handler does the job, and again, this is not a
change in behavior.

Thanks for your review!
Dscho
