From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Simple commit mechanism for non-technical users
Date: Wed, 19 Aug 2009 09:49:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908190940430.5594@intel-tinevez-2-302>
References: <ef72456d0908180905u18593b63tdc850b8552db30b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: D Sundstrom <sunds@peapod.net>
X-From: git-owner@vger.kernel.org Wed Aug 19 09:50:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdfvk-0003Oy-2H
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 09:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbZHSHtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 03:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbZHSHtu
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 03:49:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:48909 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751543AbZHSHtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 03:49:50 -0400
Received: (qmail invoked by alias); 19 Aug 2009 07:49:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp047) with SMTP; 19 Aug 2009 09:49:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18otxgOlaUoMzw5M1TEFP3ghU2eYjv7eRZTqwobAI
	z1mF1LJcuGbZ1Y
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <ef72456d0908180905u18593b63tdc850b8552db30b9@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126513>

Hi,

On Tue, 18 Aug 2009, D Sundstrom wrote:

> I use git to manage all project artifacts, including documentation, 
> proposals, presentations, and so on.
> 
> However, I have a hard time convincing non-technical staff to learn
> enough about git or to take the time to go through the effort of
> committing changes to a repository.  So the steady stream of email
> attachments with "Acme Specification v3" or "final final spemco
> proprosal" continues.
> 
> I'd hoped there was a simple web interface that would allow a user to
> upload and commit a file to a repository, but I've had no luck finding
> one.  (I've used cgit for browsing, but it is read-only).
> 
> Is anyone aware of a simple way I can have my non-technical users
> manage their documents against a git repository?  Ideally this would
> involve no installation of software on their machine (unless it were
> compelling, for example, the Finder plugin for SVN on the mac was a
> great tool for these users; or at least those on a mac...)

You contradict yourself here, the Finder plugin needs to be installed, and 
SVN, too.

As for your problem: I think you need a specific solution.  If I 
understand you correctly, files which have the same name (but maybe a 
suffix "v3" or similar before the extension), and they should be 
committed to a Git repository.

Then you have a bunch of people who do not want to care about learning 
proper version control.

This is what I would do: write a very simple .cgi (I'd use Perl for that), 
which has a file upload button, takes the name as commit message (or maybe 
adds a field where you can type in a commit message, but that might be 
asking your bunch of Aunt Tillies too much), strips the "v3"-like suffixes 
($name =~ s/[-_ ]*v\d+(\.[A-Za-z0-9]{1,5})$/$1/;), set author and 
committer information according to IP (and refuse if the IP is not in the 
internal mapping) and commit.

The whole script would probably not be larger than 50 lines, and require 
Git to be installed on the server.

The bigger problem is that your Aunt Tillies most likely would not love 
gitweb, so you need a fancier interface.

Ciao,
Dscho
