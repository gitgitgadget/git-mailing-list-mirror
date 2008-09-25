From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: having to pull twice
Date: Thu, 25 Sep 2008 20:49:42 +0200
Message-ID: <20080925184942.GA3959@blimp.localhost>
References: <fb6605670809241758r186eef51sc6ed6d334a64495d@mail.gmail.com> <20080925010150.GI3669@spearce.org> <200809250905.09646.trast@student.ethz.ch>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Michael P. Soulier" <msoulier@digitaltorque.ca>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Sep 25 20:51:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KivvY-0002Sc-OM
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 20:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbYIYStu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbYIYStu
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 14:49:50 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:10307 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbYIYStt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 14:49:49 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE81p7LJ
Received: from tigra.home (Fab79.f.strato-dslnet.de [195.4.171.121])
	by post.webmailer.de (klopstock mo54) (RZmta 17.4)
	with ESMTP id N0738ck8PHwRMd ; Thu, 25 Sep 2008 20:49:42 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 8FB75277AE;
	Thu, 25 Sep 2008 20:49:42 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 813BD36D1E; Thu, 25 Sep 2008 20:49:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809250905.09646.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96789>

Thomas Rast, Thu, Sep 25, 2008 09:05:02 +0200:
> Shawn O. Pearce wrote:
> > "Michael P. Soulier" <msoulier@digitaltorque.ca> wrote:
> > > I'm finding this happening from time to time.
> > > 
> > > soulierm@espresso:~/work/mitel-msl-tug$ git pull
> > ...
> > > error: Entry 'mitel-msl-tug.spec' not uptodate. Cannot merge.
> [fixed by 'git status's index refresh]
> > 
> > Time or dev/ino skew in the index file vs. what we read from stat.
> > 
> > Running git-status rematched the index file to the working directory,
> > and during that rematch it noticed the file wasn't actually modified.
> 
> This keeps coming up every week or so... maybe git-merge should
> attempt to refresh the index automatically?  Of course it's an
> expensive operation, but if you really want to do the merge you have
> to bite that bullet anyway.

Maybe set "core.trustctime" for this repo to false?
