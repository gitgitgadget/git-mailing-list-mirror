From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Add a -z option to 'git status' to safely feed shell
	programs with path names
Date: Sat, 17 May 2008 12:26:00 +0200
Organization: glandium.org
Message-ID: <20080517102600.GA10290@glandium.org>
References: <20080517023340.GG10006@kali.thurne.chezwam.org> <20080517025133.GQ29038@spearce.org> <alpine.DEB.1.00.0805171109000.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sebastien Gross <seb-git@chezwam.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 17 12:27:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxJdD-0004dE-VA
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 12:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbYEQK0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 06:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbYEQK0Y
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 06:26:24 -0400
Received: from vuizook.err.no ([194.24.252.247]:48715 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742AbYEQK0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 06:26:24 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JxJcB-0007N3-3I; Sat, 17 May 2008 12:26:17 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JxJc0-0002hl-HF; Sat, 17 May 2008 12:26:00 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805171109000.30431@racer>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82344>

On Sat, May 17, 2008 at 11:14:01AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 16 May 2008, Shawn O. Pearce wrote:
> 
> > Sebastien Gross <seb-git@chezwam.org> wrote:
> > > Add a -z option to 'git status' to get a list of all files
> > > but ignored, starting with modification type or 'untracked'
> > > as prefix and ending with '\0'.
> > 
> > Hmm.  Is the plumbing really that broken that you need to add -z support 
> > to porcelain rather than using the -z support already built into the 
> > plumbing?
> 
> To answer the retorical question: no, it is not.  git ls-files already has 
> the "-z" flag, and we even have the scripts in contrib/examples/ to prove 
> that it works very fine, thankyouverymuch.
> 
> Just as an example: this ugly, long line
> 
> git status -z | gawk 'BEGIN{RS="\0"; ORS="\0";}/^untracked/ \
>         {sub("^.+:", "");print}' | xargs -0 -r rm
> 
> could be expressed like this:
> 
> git ls-files --others -z | xargs -0 -r rm

or git clean -f

Mike
