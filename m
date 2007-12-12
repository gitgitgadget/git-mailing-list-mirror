From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Using git with Eclipse
Date: Wed, 12 Dec 2007 01:29:43 +0100
Message-ID: <200712120129.43878.robin.rosenberg.lists@dewire.com>
References: <475DC0CE.9070109@saville.com> <20071211024442.GJ14735@spearce.org> <475E265D.5090106@saville.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 01:28:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2FSF-0000xh-8e
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 01:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbXLLA1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 19:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXLLA1l
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 19:27:41 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11490 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbXLLA1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 19:27:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5098C802E0A;
	Wed, 12 Dec 2007 01:18:11 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06352-03; Wed, 12 Dec 2007 01:18:10 +0100 (CET)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id D84678026DC;
	Wed, 12 Dec 2007 01:18:08 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <475E265D.5090106@saville.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67975>

tisdag 11 december 2007 skrev Wink Saville:
> Shawn O. Pearce wrote:
> > Wink Saville <wink@saville.com> wrote:
> >   
> >> I'm trying to use git on an Eclipse workspace and the .metadata 
> >> directory is chock full of files and was wondering what, if anything, 
> >> should be ignored. At the moment .history looks like a candidate for 
> >> ignoring there are probably others.
> >>     
> >
> > Ignore all of .metadata; its Eclipse private state that you don't
> > want to version.  I'd add it to .git/info/exclude so its ignored only
> > in the repository that is using Eclipse, rather than in .gitignore
> > (which is published).
> >
> >   
> Shawn,
> 
> I added .metadata to exclude then used git rm to remove
> .metadata from the repository. I then cloned that
> repository to see how Eclipse would work. (As part of  my
> workflow I use git as a backup so I wanted to see what would
> happen when I "restored".)
> 
> As I'm sure you know with the metadata gone my existing projects
> in the Ui were gone and they have to be recreated as well as
> some Eclipse and plugin specific configuration.
> I understand you and others are working on an Eclipse plugin
> for git, will it also ignore . metadata?

I don't put my projects into the workspace directory so I don't have
that problem. I think mixing projects and workspaces is a bad idea
(from experience, especially when testing different Eclipse versions
on the same projects.

As for settings you can configure project specific settings,
rather than workspace settings for most interesting settings. You can
also export/import settings. Getting projects into a new workspace
is best done using import. Point import to a directory  and it will scan
for all projects and let you import them all in one go.

Egit doesn't ignore .metadata by default, I think. Probably should. For now
you can tell egit to ignore it via the workspace settings, which egit honors.
Eventually it will honor .git/info/exclude etc, but currently it doesn't.

> 
> Do you need any testing done or is it too early? I'd be glad to
> test if you feel its solid enough that I won't lose data or if it
> uses a separate different repo then I could use both.

Sure testing is needed. It's solid enough to be usable, but probably not
bug free and isn't feature complete. So if we can root out some bugs and not 
just introduce new buggy features that helps. Not that development is very 
fast nowadays, but having real users spurs development and hopefully gets 
more contributors.

The likelyhood of loosing data is probably very low as few operations are
dangerous. Of course, there is no warranty etc. etc. and we haven't done
very much monkey testing (unless using the plugin on windows counts).

I use egit and git on the same work dir in parallel, sometimes using egit, 
sometimes git-gui and sometimes plain git depending on which does the
work better.

-- robin
