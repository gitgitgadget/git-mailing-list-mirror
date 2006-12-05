X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 05 Dec 2006 17:00:19 +0100
Message-ID: <20061205160019.GR940MdfPADPa@greensroom.kotnet.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <200611281335.38728.andyparkins@gmail.com>
 <20061129160355.GF18810@admingilde.org>
 <200611292000.23778.andyparkins@gmail.com>
 <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se>
 <20061205090125.GA2428@cepheus>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 5 Dec 2006 16:00:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061205090125.GA2428@cepheus>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33350>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grcia-0004re-Up for gcvg-git@gmane.org; Tue, 05 Dec
 2006 17:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968390AbWLEQAX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 11:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968391AbWLEQAW
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 11:00:22 -0500
Received: from smtp15.wxs.nl ([195.121.247.6]:50832 "EHLO smtp15.wxs.nl"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968390AbWLEQAW
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 11:00:22 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by smtp15.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built
 Jul 14 2004)) with SMTP id <0J9T00IL85SKXD@smtp15.wxs.nl> for
 git@vger.kernel.org; Tue, 05 Dec 2006 17:00:20 +0100 (CET)
Received: (qmail 32371 invoked by uid 500); Tue, 05 Dec 2006 16:00:20 +0000
To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>, Andreas Ericsson
 <ae@op5.se>, Martin Waitz <tali@admingilde.org>, Andy Parkins
 <andyparkins@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tue, Dec 05, 2006 at 10:01:25AM +0100, Uwe Kleine-Koenig wrote:
> Hello,
> 
> Andreas Ericsson wrote:
> > The only problem I'm seeing atm is that the supermodule somehow has to 
> > mark whatever commits it's using from the submodule inside the submodule 
> > repo so that they effectively become un-prunable, otherwise the 
> > supermodule may some day find itself with a history that it can't restore.
> One could circumvent that by creating a separate repo for the submodule
> at checkout time and pull the needed objects in the supermodule's odb
> when commiting the supermodule.  This way prune in the submodule cannot
> do any harm, because in it's odb are no objects that are important for
> the supermodule.

I _think_ Linus argued against doing this (for scalability reasons),
although he didn't actually answer my question when I asked him directly.
In his proposal you wouldn't need to do this, because the particular
checked-out copy of the submodule that is located in a subdirectory
of a superproject would not be allowed to be pruned and it seems that
Martin has also implemented it like this.

