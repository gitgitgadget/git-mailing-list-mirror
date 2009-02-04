From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Compute the author/commiter name and email from
	the git configuration
Date: Tue, 3 Feb 2009 16:59:07 -0800
Message-ID: <20090204005907.GA23383@spearce.org>
References: <1233695594.8042.6.camel@localhost> <20090203231357.GZ26880@spearce.org> <alpine.DEB.1.00.0902040019030.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Simon <yann.simon.fr@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 02:00:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUW84-0000R0-Pb
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 02:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbZBDA7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 19:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZBDA7J
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 19:59:09 -0500
Received: from george.spearce.org ([209.20.77.23]:58615 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbZBDA7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 19:59:08 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7AFF838210; Wed,  4 Feb 2009 00:59:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902040019030.9822@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108282>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 3 Feb 2009, Shawn O. Pearce wrote:
> > Yann Simon <yann.simon.fr@gmail.com> wrote:
> > > +			username = System.getProperty(gitVariableKey);
> > 
> > Shouldn't that be System.getenv()?
> 
> According to
> 
> http://java.sun.com/j2se/1.4.2/docs/api/java/lang/System.html#getenv(java.lang.String)
> 
> getenv() is deprecated.  However, in later editions (Java5 and later, to 
> be precise), that deprecation seems to be lifted...

Yea, funny thing about that.  In 1.3 getenv() worked.  In 1.4 they
not only marked it deprecated, they changed the method to always
throw a RuntimeException.  Java developers were outraged, so in 1.5
(aka Java 5) they added it back in as a supported method.

JGit only runs on Java 5 and later.  So we're safe, we don't have
to worry about this #@(!@(! method and the 1.4 mistake.

Hell, Java 6 added an executable flag to java.io.File.  This is
a rather funny concept on Windows where executablity is based on
file name and not a "mode bit", but its in the Java 6 S2SE API.
At least even on Windows getenv makes sense and provides data.

-- 
Shawn.
