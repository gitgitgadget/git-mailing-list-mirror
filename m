X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bug? + question
Date: Sat, 04 Nov 2006 04:03:39 -0800
Message-ID: <7vejsjxvtw.fsf@assigned-by-dhcp.cox.net>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
	<7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
	<20061102224549.499610d1.seanlkml@sympatico.ca>
	<20061103203610.GB7585@spearce.org>
	<BAYC1-PASMTP01F45766D9195AAFD81789AEFE0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 12:03:53 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Miles Bader <miles@gnu.org>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30923>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgKFU-0001M4-17 for gcvg-git@gmane.org; Sat, 04 Nov
 2006 13:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965343AbWKDMDm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 07:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965346AbWKDMDm
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 07:03:42 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44975 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S965343AbWKDMDk
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 07:03:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061104120340.YZUR2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Sat, 4
 Nov 2006 07:03:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ic3J1V0051kojtg0000000 Sat, 04 Nov 2006
 07:03:18 -0500
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> writes:

> I think your Nack was a little rash here.  The feature would be quite
> useful to work flows other than yours.  It sounds like what _you_ want
> is a feature to select branches when cloning rather than the current
> default of cloning all.  That would stop your developers having to 
> delete branches and editing .git/remotes/origin immediately
> after cloning.

I think this conversation demonstrates that this previous
statement of yours was also rather rash:

  The essential point is that most of the time the Git user
  should not have to manually create the merge entries in the
  config file.  Git should be smart enough to get it right most
  of the time automatically.

There is no "get it right most of the time" that would apply to
every workflow.  We should just admit that no default layout and
configuration would suit everybody's needs.  What we should do
is to try to capture a handful useful patterns and make it easy
for people to apply those canned patterns.

For example, that is what we did for "git clone".  We identified
two common layouts, traditional and separate-remote, and we
support both.  The reason we might want to favor separate-remote
over traditional should be based on the expected workflow and
expertise level of the majority of users.  If a census turns out
that the more experienced people tend to prefer traditional
layout, then changing the default to separate-remote would be
easier even if people with workflow separate-remote is more
appropriate is not the absolute majority, because the layout can
be easily changed by more experienced folks.

I think the "what should the default merge source be" topic is
very similar.  There is no single _right_ way and to some extent
what the vanilla default is does not really matter.

