From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Secure central repositories by UNIX socket authentication
Date: Mon, 28 Jan 2008 02:56:42 -0500
Message-ID: <20080128075642.GD24004@spearce.org>
References: <20080127103934.GA2735@spearce.org> <7vsl0ix4gh.fsf@gitster.siamese.dyndns.org> <20080128004722.GZ24004@spearce.org> <7vabmqwgvt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 08:57:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJOry-0000iX-R6
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 08:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbYA1H4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 02:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbYA1H4v
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 02:56:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43026 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbYA1H4u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 02:56:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJOrE-000583-Ah; Mon, 28 Jan 2008 02:56:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3AD3620FBAE; Mon, 28 Jan 2008 02:56:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vabmqwgvt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71860>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Hmm.  core.sharedrepository is sometimes a bad solution.
> >
> > core.sharedrepository means I need to give write access to both the
> > refs database and the object database to all members of the project.
> > Some of whom may not be able to be trusted with tools like "rm",
> > but who need real shell access to that system anyway.  And sometimes
> > management won't allow users to have two accounts on the same system
> > (one that is fixed to git-shell, and one that has a real shell)
> > because the world would implode if a user was given two different
> > accounts for two different access purposes.
...
> Another approach to do the same I can think of, without having
> to add 50 new accounts for 50 users, would be to collect a ssh
> key from each of these 50 users,

Also, our network of servers and desktops is actually now managed
entirely through Active Directory.  So all possible users already
have accounts on every server.  Passwords are synchronized across
the entire network.

In other words, all of the management overheads associated with
user accounts has already been paid.  Centralized SSH/SSL/PGP key
management is only adding an additional burden.  For my day-job
anyway.

-- 
Shawn.
