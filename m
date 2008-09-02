From: Magnus Hjorth <magnus.hjorth@home.se>
Subject: Re: Committing with past date?
Date: Tue, 02 Sep 2008 04:42:14 +0200
Message-ID: <1220323334.5476.29.camel@magnus-desktop>
References: <1220179469.5518.5.camel@magnus-desktop>
	 <m34p51qvzv.fsf@localhost.localdomain>
	 <1220286321.5474.6.camel@magnus-desktop>
	 <200809020231.32780.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 04:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaLs3-0000sL-HK
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 04:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbYIBCmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 22:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbYIBCmU
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 22:42:20 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:37563 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752557AbYIBCmT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2008 22:42:19 -0400
Received: from c83-254-118-193.bredband.comhem.se ([83.254.118.193]:52017)
	by ch-smtp02.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <magnus.hjorth@home.se>)
	id 1KaLqU-0001l9-6v; Tue, 02 Sep 2008 04:42:18 +0200
In-Reply-To: <200809020231.32780.jnareb@gmail.com>
X-Mailer: Evolution 2.22.3.1 
X-Originating-IP: 83.254.118.193
X-Scan-Result: No virus found in message 1KaLqU-0001l9-6v.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1KaLqU-0001l9-6v ef62f978f081eef3c6afc4f4eb529807
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94642>

On Tue, 2008-09-02 at 02:31 +0200, Jakub Narebski wrote:
> On Mon, 1 Sep 2008, Magnus Hjorth wrote:
> > On Sun, 2008-08-31 at 04:12 -0700, Jakub Narebski wrote:
> > > Magnus Hjorth <magnus.hjorth@home.se> writes:
> > > 

> > >  
> > > > I'm trying to port over old version history that I maintained manually
> > > > (tarballs and changelogs) into a git repository. 
> > > 
> > > For that, I think it would be best to take a look at example
> > > fast-import script: contrib/fast-import/import-tars.perl;
> > > there is equivalent contrib/fast-import/import-zips.py if you
> > > perfer either Pyhon over Perl, and/or zips over tarballs.

> By the way, is there any reason _not_ to use import-tars.perl from
> the contrib/fast-import in your case?

Well, I was planning do a lot of manual cleanup of the files also
(splitting commits, removing auto-generated files etc), so importing the
tarballs would just be the first step. But I'll try it, it can still be
useful to get a starting point...

> > 
> > I have successfully imported the CVS history using git-cvsimport, but
> > now I want to add these older revisions that were made with tarballs to
> > the same tree, before the CVS revisions. The last tarball and the first
> > CVS revision have identical content, and I would like to somehow "glue"
> > the histories together.
> > 
> > Can this be done? 
> 
> It can be done for example using grafts. Search git mailing list for
> graftshistory (or something like that) script, which was used to join
> using grafts git "current work" Linux repository (started from "scratch").
> Then you can check in gitk if everything is all right. If you truly
> require connected histories, and not being able to locally turn on
> and off the historical repository, you can always use git-filter-branch
> which (among others) can turn grafts into true commits.

The grafts approach looks interesting.

I still need some way to create multiple unconnected trees in one repo.
Maybe the safest way to do that is to create a separate historic repo
first and then transfer the historic branch using git-bundle to my main
working repo.

Regards,
Magnus
