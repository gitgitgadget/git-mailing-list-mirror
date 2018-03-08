Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F6C1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 10:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965024AbeCHKRl (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 05:17:41 -0500
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:36643 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964945AbeCHKRi (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Mar 2018 05:17:38 -0500
X-Greylist: delayed 2229 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Mar 2018 05:17:38 EST
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=dagon.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <ijc@hellion.org.uk>)
        id 1ets2E-000105-PB; Thu, 08 Mar 2018 09:40:26 +0000
Message-ID: <1520502026.23648.29.camel@hellion.org.uk>
Subject: Re: How to use filter-branch with --state-branch?
From:   Ian Campbell <ijc@hellion.org.uk>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Michele Locati <michele@locati.it>
Cc:     git@vger.kernel.org
Date:   Thu, 08 Mar 2018 09:40:26 +0000
In-Reply-To: <87zi3inckw.fsf@evledraar.gmail.com>
References: <P56D58$52E406B139FE9D3C295CB5ABAB5C8893@locati.it>
         <87zi3inckw.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2018-03-08 at 10:25 +0100, Ævar Arnfjörð Bjarmason wrote:

> > The first filter-branch call required 7168 steps, so did the second call...
> > I also tried without the --prune option of remote update (I had to add
> > --force to the second filter-branch), but nothing changed.

You can see an example of the usage in:
    https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/

in the `scripts/` sub dir (flow is `cronjob` → `filter.sh` → `git
filter-branch...`.

I think the big difference is rather than `--all` you need to give it
the `previous..now` range since that is the update you wish to do
(first time around you just give it `now`).

The devicetree-rebasing scripting arranges that by keeping the previous
in a separate branch.

Ian.
