Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AAA520188
	for <e@80x24.org>; Tue,  9 May 2017 08:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbdEIIEl (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 04:04:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:47961 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752395AbdEIIEj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 04:04:39 -0400
Received: (qmail 31588 invoked by uid 109); 9 May 2017 08:04:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 08:04:36 +0000
Received: (qmail 21767 invoked by uid 111); 9 May 2017 08:05:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 04:05:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 May 2017 04:04:34 -0400
Date:   Tue, 9 May 2017 04:04:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] Make diff plumbing commands respect the
 indentHeuristic.
Message-ID: <20170509080434.dkqa7pvsq34sygn3@sigill.intra.peff.net>
References: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
 <20170427205037.1787-1-marcnarc@xiplink.com>
 <CAGZ79kbUqVfz+6Y0XkTL7FCZfaD+2YRMZ_v0vP8-DOFhWc+ELw@mail.gmail.com>
 <20170428220450.olqitnuwhrxzg3pv@sigill.intra.peff.net>
 <CACBZZX5f81HKCjRjTDyXzNMVuef9Z_ECS+0SVk2xpbwXudgxCw@mail.gmail.com>
 <20170509031653.7hc36pil3vzrobsz@sigill.intra.peff.net>
 <CACBZZX5yHRDU6R3F8=qnqEGu6UCYNOj3rqMDbP1G7cJnvG7R=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5yHRDU6R3F8=qnqEGu6UCYNOj3rqMDbP1G7cJnvG7R=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2017 at 09:58:28AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Out of curiosity, how do you generate the patch-ids? Is it with
> > something like diff-tree piped to patch-id?
> 
> This:
> 
>     my $cmd = qq[git --git-dir="$repository_path" log --since="$since"
> --until="$until" --all --pretty=format:%H --binary | git patch-id];
>     open my $patch_id_fh, " $cmd |";

Ah, OK. I was specifically curious whether the decision to respect the
config switch in plumbing would have any impact for your script. But it
wouldn't, as it was already using log (though I suspect the real
protection for your script is that it is used from a vanilla
environment, not by random users).

-Peff
