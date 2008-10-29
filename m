From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit as a jira plugin
Date: Wed, 29 Oct 2008 16:08:16 -0700
Message-ID: <20081029230816.GA31926@spearce.org>
References: <5915DAE3-7BDF-4296-9DB3-6FBEE504A317@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Longman" <longman@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:09:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvKAQ-0006PC-Rr
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755692AbYJ2XIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbYJ2XIS
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:08:18 -0400
Received: from george.spearce.org ([209.20.77.23]:49246 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484AbYJ2XIR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:08:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 793343835F; Wed, 29 Oct 2008 23:08:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5915DAE3-7BDF-4296-9DB3-6FBEE504A317@xiplink.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99433>

"J. Longman" <longman@xiplink.com> wrote:
> I've integrated jgit into a plugin for the Jira Issue tracking system.  
> There is more information here: 
> http://confluence.atlassian.com/display/JIRAEXT/Jira+Git+Plugin

Cool!

> 1) I noticed that there is a maven pom file.  Are you present in a maven 
> repository?  Also any problem with embedding a working snapshot in my 
> plugin?

No, we aren't hosted in any repository yet.  The pom file exists to
make it easier for people who prefer maven to build, but its not the
primary build system for jgit.

> 2) I'd like to find out the jgit way to achieve the equivalent of 'svn  
> update'.  I understand that fetch can do this but being new to git, I  
> don't really understand quite what I need yet.  The goal is to have git 
> the latest commits from the origin before indexing.

Use a Transport instance to execute a default fetch (no args) on say
the "remote" origin.  That will download the objects to the local
database, but it won't update a working directory.  But I'm not sure
you would care about the working directory in the backend of Jira.

> Thanks for jgit - it took me a day or two to wrap my head around getting 
> the list of files changed in a commit but otherwise its great to have 
> something that can be integrated into jira.

Yea, about that, we wanted to write more tutorials on the API...  ;-)

-- 
Shawn.
