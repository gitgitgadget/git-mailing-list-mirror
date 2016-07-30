Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033121F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 19:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbcG3TLM (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 15:11:12 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35211 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbcG3TLL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 15:11:11 -0400
Received: from mfilter23-d.gandi.net (mfilter23-d.gandi.net [217.70.178.151])
	by relay2-d.mail.gandi.net (Postfix) with ESMTP id ABE1FC5A5D;
	Sat, 30 Jul 2016 21:11:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter23-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter23-d.gandi.net (mfilter23-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id z_z8tFbZnzFi; Sat, 30 Jul 2016 21:11:08 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C9E85C5A55;
	Sat, 30 Jul 2016 21:11:06 +0200 (CEST)
Date:	Sat, 30 Jul 2016 12:11:05 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: [PATCH v2 0/2] format-patch: Transition the default to --from to
 avoid spoofed mails
Message-ID: <20160730191104.2ps5k7eji7aqgufg@x>
References: <20160730181246.4aifnvqfeenddzdl@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160730181246.4aifnvqfeenddzdl@x>
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

v2: Unify the various places setting from into a single helper function.

Josh Triplett (2):
  format-patch: Add a config option format.from to set the default for --from
  format-patch: Default to --from

 Documentation/config.txt               | 10 ++++-
 builtin/log.c                          | 47 +++++++++++++++----
 contrib/completion/git-completion.bash |  1 +-
 t/t4014-format-patch.sh                | 68 +++++++++++++++++++++++++--
 4 files changed, 114 insertions(+), 12 deletions(-)

-- 
git-series 0.8.7
