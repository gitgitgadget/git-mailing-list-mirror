X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] git-svn: documentation updates
Date: Sat, 02 Dec 2006 17:52:48 -0800
Message-ID: <7vd571yccv.fsf@assigned-by-dhcp.cox.net>
References: <1164768702941-git-send-email-normalperson@yhbt.net>
	<11647687042130-git-send-email-normalperson@yhbt.net>
	<456D36CE.1060300@midwinter.com> <20061129085419.GB4486@hand.yhbt.net>
	<loom.20061129T133305-813@post.gmane.org>
	<20061203013955.GD1369@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 01:53:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061203013955.GD1369@localdomain> (Eric Wong's message of "Sat,
	2 Dec 2006 17:39:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33081>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqgXc-0006lI-2b for gcvg-git@gmane.org; Sun, 03 Dec
 2006 02:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424736AbWLCBxN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 20:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759487AbWLCBxN
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 20:53:13 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:37363 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1759485AbWLCBxM
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 20:53:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061203015249.UZCK97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Sat, 2 Dec
 2006 20:52:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id u1sy1V00i1kojtg0000000; Sat, 02 Dec 2006
 20:52:59 -0500
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> Both push and pull are git/bk/hg(?)-specific terms; most SVN users are
> not accustomed to them.  Using 'pull' with git-svn has already been
> discouraged for a while (since the introduction of dcommit); and
> having a 'push' without a 'pull' would be very confusing.

I am not sure how 'push' side should be integrated, but I wish
people could simply update a branch that is managed by foreign
SCM interfaces such as git-svn and git-cvsimport with 'git fetch'
by saying that the remote URL points at a non-git "repository"
in remotes/ (or corresponding config).

git-cvsimport builds the git objects from the changeset without
using the working tree, and it would be very natural and simple
to integrate it into 'git fetch', pretending as if it is just a
funny transport.

If the interface uses the working tree to update the state from
foreign SCM, then integrating with git-fetch would be
inpractical.  I guess git-svn works that way?
