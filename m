Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434101F453
	for <e@80x24.org>; Tue, 23 Oct 2018 14:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeJWWar (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 18:30:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:45243 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWWar (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 18:30:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 07:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,416,1534834800"; 
   d="scan'208";a="101739574"
Received: from unknown (HELO ldmartin-desk.jf.intel.com) ([10.255.70.244])
  by fmsmga001.fm.intel.com with ESMTP; 23 Oct 2018 07:07:11 -0700
Date:   Tue, 23 Oct 2018 07:07:10 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        lucas.de.marchi@gmail.com
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
Message-ID: <20181023140710.GA7073@ldmartin-desk.jf.intel.com>
References: <20181010150916.4295-1-lucas.demarchi@intel.com>
 <87in29dj55.fsf@evledraar.gmail.com>
 <xmqqmurkgaap.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmurkgaap.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 05:25:02PM +0900, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > On Wed, Oct 10 2018, Lucas De Marchi wrote:
> >
> >> Do like it's done in grep so mode doesn't end up as
> >> 0160000, which means range-diff doesn't work if one has
> >> "submodule.diff = log" in the configuration. Without this
> >> while using range-diff I only get a
> >>
> >>     Submodule a 0000000...0000000 (new submodule)
> >
> > I'm not familiar enough with this to tell what the real problem is
> > that's being solved from the commit message, but if it means that now
> > range-diff works in some configuration, presumably that can be reduced
> > to a simple set of commands that didn't work before but now does, and
> > therefore a test in t/t3206-range-diff.sh.
> 
> Yes, I agree on both counts (i.e. it was totally unclear what
> problem is being solved and what the root cause of the problem is,
> and we would want a new test to protect this "fix" from getting
> broken in the future.

have you seen I sent a v2 with proper test?

thanks
Lucas De Marchi

> 
> Thanks.
