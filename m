From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: [RFH] git-svn documentation [was Re: git-svn and u-boot broken]
Date: Mon, 16 Oct 2006 23:44:42 +0200
Message-ID: <015f01c6f16c$4a447440$1267a8c0@Jocke>
References: <20061016183101.GL27128@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 23:47:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZaIT-0006Rw-4I
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 23:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbWJPVqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 17:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWJPVqy
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 17:46:54 -0400
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:1409
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1161118AbWJPVqx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 17:46:53 -0400
Received: from Jocke ([84.217.9.178]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 16 Oct 2006 23:46:49 +0200
To: "'Eric Wong'" <normalperson@yhbt.net>
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AcbxUV4ZjuwHQVaNSx2lyxY4HvRjDwAGh6bA
In-Reply-To: <20061016183101.GL27128@hand.yhbt.net>
X-OriginalArrivalTime: 16 Oct 2006 21:46:49.0208 (UTC) FILETIME=[9568E780:01C6F16C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28988>

> Joakim Tjernlund <Joakim.Tjernlund@transmode.se> wrote:
> > Eric Wong wrote:
> > > I would do something like this:
> > > 
> > > ... (same stuff as above before with svn setup...)
> > > git clone $ORG_REPO $GIT_REPO
> > > cd $GIT_REPO
> > > git-svn init "$REPO"/trunk
> > > git-svn fetch
> > > 
> > > # sync the SVN repo with initial-uboot
> > > # this will just commit a snapshot, without history, 
> which I assume
> > > # is what you want.
> > > git-branch initial-uboot f5e0d03970409feb3c77ab0107d5dece6b7d45c9
> > > git-svn commit initial-uboot
> > > git checkout -b svn-branch remotes/git-svn
> > > git-pull . tmcu2
> > > 
> > > # this should work assuming the path from 
> initial-uboot..tmcu2 is linear
> > > # use gitk initial-uboot..tmcu2 to check
> > > git-svn dcommit
> > 
> > Great! This was exactly what I wanted, thanks. I never 
> realized that one should
> > do git-svn commit initial-uboot to get that single commit.
> > I also replaced git-svn dcommit with git-svn commit 
> remotes/git-svn..svn-branch
> > as I don't have that version yet.
> > 
> > You should add this as an example I think.
> > 
> > Can I ask for an example that used multi-init and 
> multi-fetch? I tried, but
> > could not make it work.
> 
> git-svn multi-init https://svn.musicpd.org/mpd -T trunk -t tags -b branches
> git-svn multi-fetch

This is how far I got too(sorry for beeing unclear). It is the 
remaing bits that I got stuck on. How would the remaining git-svn
commands look like in the above example?

> 
> In the latest git-svn (should be in 1.4.3), you can re-run 'git-svn
> multi-init' with no arguments to discover new tags+branches.
> 
> Anybody willing to supply patches for better documentation?  I'll be
> quite busy with other projects the next two weeks, asciidoc is quite
> slow for me; but I'd like to have better docs for git-svn in 1.4.3.

That would be great, I am still very much in the dark.

 Jocke
