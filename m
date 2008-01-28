From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-daemon is insecure?
Date: Sun, 27 Jan 2008 22:20:40 -0500
Message-ID: <20080128032040.GB24004@spearce.org>
References: <20080127103934.GA2735@spearce.org> <7vsl0ix4gh.fsf@gitster.siamese.dyndns.org> <20080128001655.GY24004@spearce.org> <7vk5luwt6q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 04:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJKYf-0006au-E4
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 04:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbYA1DUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 22:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbYA1DUq
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 22:20:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54450 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYA1DUp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 22:20:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJKXv-0001RH-9F; Sun, 27 Jan 2008 22:20:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6C64420FBAE; Sun, 27 Jan 2008 22:20:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vk5luwt6q.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71848>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > With regards to this patch, yes, you can export your entire $HOME
> > and maybe expose things you shouldn't or didn't want to.
> 
> That was not what I meant.  git-daemon running as nobody.project
> will allow read access to project group's files, and the
> whitelisting and --base-path are ways to limit it to files that
> are in the repository.  But the process still has the power to
> read files outside that can be read nobody user or project
> group, the only thing needed is for git-daemon and whatever it
> spawn to have bugs.
> 
> But the point is that "power to read files outside" is still
> limited to nobody.project, even if there are such bugs to allow
> it escape the whitelist/base-path jail.  It won't extend to
> anybody's $HOME.
> 
> If you run git-daemon as spearce.spearce, you cannot rely on
> that built-in limitation.
 
Sure.  Which is why I was planning on running git-daemon as
gitadmin.gitadmin, with all central repos owned by gitadmin,
and basically nothing else at all.

I can just as easily start lighthttpd on $HOME.  Or Apache.
Both are insane.

-- 
Shawn.
