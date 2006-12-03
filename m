X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3] git-svn: documentation updates
Date: Sat, 2 Dec 2006 18:12:44 -0800
Message-ID: <20061203021244.GA30316@hand.yhbt.net>
References: <1164768702941-git-send-email-normalperson@yhbt.net> <11647687042130-git-send-email-normalperson@yhbt.net> <456D36CE.1060300@midwinter.com> <20061129085419.GB4486@hand.yhbt.net> <loom.20061129T133305-813@post.gmane.org> <20061203013955.GD1369@localdomain> <7vd571yccv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 02:12:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vd571yccv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33083>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqgqX-0000Fk-Kb for gcvg-git@gmane.org; Sun, 03 Dec
 2006 03:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759489AbWLCCMp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 21:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759492AbWLCCMp
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 21:12:45 -0500
Received: from hand.yhbt.net ([66.150.188.102]:24986 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1759489AbWLCCMp (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 21:12:45 -0500
Received: by hand.yhbt.net (Postfix, from userid 500) id A6EAB2DC034; Sat,  2
 Dec 2006 18:12:44 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Both push and pull are git/bk/hg(?)-specific terms; most SVN users are
> > not accustomed to them.  Using 'pull' with git-svn has already been
> > discouraged for a while (since the introduction of dcommit); and
> > having a 'push' without a 'pull' would be very confusing.
> 
> I am not sure how 'push' side should be integrated, but I wish
> people could simply update a branch that is managed by foreign
> SCM interfaces such as git-svn and git-cvsimport with 'git fetch'
> by saying that the remote URL points at a non-git "repository"
> in remotes/ (or corresponding config).

Ack on being able to use 'git fetch'.

> git-cvsimport builds the git objects from the changeset without
> using the working tree, and it would be very natural and simple
> to integrate it into 'git fetch', pretending as if it is just a
> funny transport.
> 
> If the interface uses the working tree to update the state from
> foreign SCM, then integrating with git-fetch would be
> inpractical.  I guess git-svn works that way?

git-svn only needs a working tree (hidden away in .git/svn/ and the user
should never see it) when it uses the command-line svn client.  If the
SVN:: libraries are available, then git-svn just uses an alternative
index like cvsimport.

-- 
