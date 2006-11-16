X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 12:34:27 +0100
Message-ID: <8764dflj5o.fsf@wine.dyndns.org>
References: <87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<20061116011411.GB10512@thunk.org>
	<7vd57of2cv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 11:35:30 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vd57of2cv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 15 Nov 2006 20\:21\:36 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31572>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkfWT-0000DD-8K for gcvg-git@gmane.org; Thu, 16 Nov
 2006 12:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161995AbWKPLfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 06:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031165AbWKPLfJ
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 06:35:09 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:11699 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S1031163AbWKPLfH
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 06:35:07 -0500
Received: from adsl-84-227-189-80.adslplus.ch ([84.227.189.80]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GkfVm-0005Je-0W; Thu, 16
 Nov 2006 05:34:30 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 5185510A151; Thu,
 16 Nov 2006 12:34:27 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> I would rather say "use 'git branch' to make sure if you are
> ready to merge".  Who teaches not to use "git pull"?

We do that for Wine. The problem is that we recommend using git-rebase
to make it easier for occasional developers to keep a clean history,
and rebase and pull interfere badly.

The result is that we recommend always using fetch+rebase to keep up
to date, but this is confusing many people too, because git-fetch
appears to do a lot of work yet leaves the working tree completely
unchanged, and git-rebase doesn't do anything (since in most cases
they don't have commits to rebase) but has an apparently magical
side-effect of updating the working tree.

Ideally it should be possible to have git-rebase do the right thing
even if the branch has been merged into; then we could tell people to
always use git-pull, and when they get confused by seeing merges in
their history have them do a git-rebase to clean things up.

-- 
Alexandre Julliard
