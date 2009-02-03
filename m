From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH JGIT] Compute the author/commiter name and email from
 the git configuration
Date: Wed, 4 Feb 2009 00:20:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040019030.9822@pacific.mpi-cbg.de>
References: <1233695594.8042.6.camel@localhost> <20090203231357.GZ26880@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yann Simon <yann.simon.fr@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 00:21:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUa4-0005U7-UC
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbZBCXTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbZBCXTc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:19:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:48796 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751374AbZBCXTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:19:31 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:19:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 04 Feb 2009 00:19:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5W11rlKm5qzYcMdwOW6zyMnLUs1yfCDPhRSBshe
	JIBcCCTQ/opTKH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090203231357.GZ26880@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108265>

Hi,

On Tue, 3 Feb 2009, Shawn O. Pearce wrote:

> Yann Simon <yann.simon.fr@gmail.com> wrote:
>
> > @@ -308,6 +312,83 @@ public String getString(final String section, String subsection, final String na
> >  		return result;
> >  	}
> >  
> > +	/**
> > +	 * @return the author name as defined in the git variables
> > +	 *         and configurations. If no name could be found, try
> > +	 *         to use the system user name instead.
> > +	 */
> > +	public String getAuthorName() {
> > +		return getUsernameInternal(Constants.GIT_AUTHOR_NAME_KEY);
> > +	}
> > +
> > +	/**
> > +	 * @return the commiter name as defined in the git variables
> > +	 *         and configurations. If no name could be found, try
> > +	 *         to use the system user name instead.
> > +	 */
> > +	public String getCommiterName() {
> > +		return getUsernameInternal(Constants.GIT_COMMITER_NAME_KEY);
> > +	}
> > +
> > +	private String getUsernameInternal(String gitVariableKey) {
> > +		// try to get the user name from the local and global configurations.
> > +		String username = getString("user", null, "name");
> > +
> > +		if (username == null) {
> > +			// try to get the user name for the system property GIT_XXX_NAME 
> > +			username = System.getProperty(gitVariableKey);
> 
> Shouldn't that be System.getenv()?

According to

http://java.sun.com/j2se/1.4.2/docs/api/java/lang/System.html#getenv(java.lang.String)

getenv() is deprecated.  However, in later editions (Java5 and later, to 
be precise), that deprecation seems to be lifted...

Ciao,
Dscho
