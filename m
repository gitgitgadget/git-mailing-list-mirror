From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Fri, 17 Apr 2009 15:41:04 -0700
Message-ID: <20090417224104.GT23604@spearce.org>
References: <1239916256-10878-1-git-send-email-mh@glandium.org> <37fcd2780904170924t61168a49uf1800098cdb1d730@mail.gmail.com> <20090417194919.GA7611@glandium.org> <37fcd2780904171400uf9d1f36g4d24e02aebf6ac3f@mail.gmail.com> <20090417223649.GA1881@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:42:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luwld-0006S7-Oa
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbZDQWlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 18:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbZDQWlH
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:41:07 -0400
Received: from george.spearce.org ([209.20.77.23]:45049 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZDQWlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 18:41:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E3F9338211; Fri, 17 Apr 2009 22:41:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090417223649.GA1881@glandium.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116801>

Mike Hommey <mh@glandium.org> wrote:
> On Sat, Apr 18, 2009 at 01:00:35AM +0400, Dmitry Potapov wrote:
> > Besides, you made SSH_ORIGINAL_COMMAND to take precedent over explicitly
> > specified parameters given to git-shell. Maybe it should be the other
> > way around?
> 
> If SSH_ORIGINAL_COMMAND is set, which means forced-commands are in use,
> I don't see why other parameters should be more important.

Gitosis runs by forced-command, and invokes git-shell to get to
the real requested git command.  I'm not sure if it unsets the
SSH_ORIGINAL_COMMAND environment variable before launching the
git-shell...

But, in git, command line arguments override environment variables,
which in turn override config files, which override any defaults
that may be guessed from the host.  So Dimtry is asking that you
follow that same convention.

-- 
Shawn.
