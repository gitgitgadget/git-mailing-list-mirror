From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: Re: keeping remote branches in sync
Date: Thu, 9 Oct 2008 11:37:39 -0400
Message-ID: <20081009153738.GJ18241@morganstanley.com>
References: <20081009141418.GF18241@morganstanley.com> <eaa105840810090743pba41a98ocdf79b7c06d76e9e@mail.gmail.com> <20081009151636.GT8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 17:53:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knxlm-0001kA-Qa
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 17:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbYJIPsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 11:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbYJIPsb
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 11:48:31 -0400
Received: from hqmtaint01.ms.com ([205.228.53.68]:60355 "EHLO
	hqmtaint01.ms.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbYJIPsb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 11:48:31 -0400
X-Greylist: delayed 651 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Oct 2008 11:48:31 EDT
Received: from hqmtaint01 (localhost.ms.com [127.0.0.1])
	by hqmtaint01.ms.com (output Postfix) with ESMTP id BA8D06CC033;
	Thu,  9 Oct 2008 11:37:39 -0400 (EDT)
Received: from ny0032as01 (unknown [144.203.194.95])
	by hqmtaint01.ms.com (internal Postfix) with ESMTP id A09CC2C030;
	Thu,  9 Oct 2008 11:37:39 -0400 (EDT)
Received: from hn315c1n5 (localhost [127.0.0.1])
	by ny0032as01 (msa-out Postfix) with ESMTP id 91F36C94645;
	Thu,  9 Oct 2008 11:37:39 -0400 (EDT)
Received: from menevado.ms.com (unknown [144.203.222.190])
	(Authenticated sender: yes)
	by ny0032as01 (msa-in Postfix) with ESMTP id 6DE804C0029;
	Thu,  9 Oct 2008 11:37:39 -0400 (EDT)
Received: by menevado.ms.com (Postfix, from userid 49008)
	id 33B075300F5; Thu,  9 Oct 2008 11:37:39 -0400 (EDT)
Mail-Followup-To: "Shawn O. Pearce" <spearce@spearce.org>,
	Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20081009151636.GT8203@spearce.org>
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.35/RELEASE, bases: 09102008 #1162917, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97863>

On 10/09/08 11:16:36, Shawn O. Pearce wrote:
> Peter Harris <git@peter.is-a-geek.org> wrote:
> > On Thu, Oct 9, 2008 at 10:14 AM, Kevin Green wrote:
> > > After topic branches are merged to master, we do some cleanup by deleting them
> > > from the shared repo.
> > >
> > > One of the issues we have is that _my_ local repos remote branches aren't kept
> > > in sync with the shared repo.
> > ...
> > 
> > > I'd like some comment on whether our workflow could use some improvement.
> > > Specifically, if there's a straightforward way to handle the issue above, that
> > > would be great.  I've been looking through the manual on git-fetch and
> > > git-pull and not seeing any options to do this.
> > 
> > Is "git remote prune" what you're looking for?
> 

Yes, it seems to be exactly what we want, though we'd want it just done
instead of having to run it ourselves... :)

> I keep meaning to add "git remote prune" logic into "git fetch",
> e.g. as a "git fetch --prune" option.  fetch has all of the data
> it needs to implement the prune already in memory, it just doesn't
> have the loop to do the prune cleanup.
> 
> Now that "git remote" is in C it should be easy to share the prune
> code between them, and make this more automatic.

That would be great...  And a config option to have it done by default each
time so '$ git-pull' will just do what we want for our origin remote?


Thanks

--Kevin
