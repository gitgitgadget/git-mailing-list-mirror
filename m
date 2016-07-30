Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CABE1F858
	for <e@80x24.org>; Sat, 30 Jul 2016 09:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbcG3Jlx (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 05:41:53 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57042 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcG3Jlw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 05:41:52 -0400
Received: from mfilter44-d.gandi.net (mfilter44-d.gandi.net [217.70.178.175])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 9C649172095;
	Sat, 30 Jul 2016 11:41:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter44-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter44-d.gandi.net (mfilter44-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id hV2kihGkSD9w; Sat, 30 Jul 2016 11:41:48 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id CAB6A1720A4;
	Sat, 30 Jul 2016 11:41:46 +0200 (CEST)
Date:	Sat, 30 Jul 2016 02:41:44 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: [PATCH 0/2] format-patch: Transition the default to --from to avoid
 spoofed mails
Message-ID: <20160730094144.ajtkdveuhpf5hmvg@x>
References: <20160730055717.i7rtgswbi6q2cdsg@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160730055717.i7rtgswbi6q2cdsg@x>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

As discussed, this patch series allows transitioning the default
behavior of format-patch to --from, to avoid spoofing mails when
formatting commits not written by the user.

The first patch introduces the format.from option to set the default
value of format-patch --from.  This patch doesn't change the default
behavior of format-patch, so it can go in without any transition.

The second patch changes the default to --from.  If you'd like to delay
this patch for a release and mention the planned change in the release
notes, let me know and I'll provide text for the release notes; if you
don't think this needs a transition period, you can go ahead and apply
the second patch.

Josh Triplett (2):
  format-patch: Add a config option format.from to set the default for --from
  format-patch: Default to --from

 Documentation/config.txt               | 10 ++++-
 builtin/log.c                          | 14 +++++-
 contrib/completion/git-completion.bash |  1 +-
 t/t4014-format-patch.sh                | 68 +++++++++++++++++++++++++--
 4 files changed, 89 insertions(+), 4 deletions(-)

-- 
git-series 0.8.7
