X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 03:41:06 -0800
Message-ID: <7vpsbmmhbh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151516360.2591@xanadu.home>
	<Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
	<87velgs9hx.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611151339500.3349@woody.osdl.org>
	<87psbos4pb.wl%cworth@cworth.org> <20061115230252.GH24861@spearce.org>
	<Pine.LNX.4.64.0611151523290.3349@woody.osdl.org>
	<87fycjs5yg.wl%cworth@cworth.org>
	<f2b55d220611160957s2e68059dk99bbe902e7e1f416@mail.gmail.com>
	<87r6w3b68p.wl%cworth@cworth.org>
	<7vu00ysbwi.fsf@assigned-by-dhcp.cox.net>
	<87ejs2qvmb.wl%cworth@cworth.org>
	<Pine.LNX.4.63.0611171103150.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 11:41:54 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611171103150.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 17 Nov 2006 11:11:19 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31692>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl25r-0004ZK-1P for gcvg-git@gmane.org; Fri, 17 Nov
 2006 12:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933529AbWKQLlK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 06:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932877AbWKQLlK
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 06:41:10 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48104 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S933529AbWKQLlI
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 06:41:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117114107.XWT296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 06:41:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nnhD1V00a1kojtg0000000; Fri, 17 Nov 2006
 06:41:14 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> 5. Adding something like git-fetch --all to allow it to pick up all new
>>    branches
>
> IIRC this idea was rejected, but I would find it useful. Especially with 
> what Han-Wen said: you can store the branches you fetch with "git fetch 
> --all <nick>" under .git/refs/remotes/<nick>/<branchname>.

With separate-remote layout, this can be done without risk of
tracking refname clashing with local refname, which was the
primary reason for an earlier reluctance.  

While separate-remote layout also solves Carl's "do not want to
track tracking branches remote has" problem, local branch
namespace can have both for-others (not necessarily "public" but
could be "for colleagues") and throwaway branches, so --all is
probably not the right thing to do in most cases.  But I am Ok
with the approach of seeing how well it works out in practice by
doing the simplest "--all" and giving options to restrict it
later.
