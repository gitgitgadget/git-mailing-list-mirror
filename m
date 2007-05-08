From: Michael Hendricks <michael@ndrix.org>
Subject: Re: git-svn: importing branches later
Date: Tue, 8 May 2007 09:34:29 -0600
Message-ID: <20070508153428.GB5349@ginosko.local>
References: <20070507190702.GE342@ginosko.local> <20070508085149.GB24409@diana.vm.bytemark.co.uk> <m2odkv2wtd.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 17:49:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRwc-0000Iz-Gh
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968287AbXEHPqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 11:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968117AbXEHPpi
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:45:38 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46877 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755262AbXEHPec (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2007 11:34:32 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id B771721F755
	for <git@vger.kernel.org>; Tue,  8 May 2007 11:35:49 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 08 May 2007 11:34:32 -0400
X-Sasl-enc: Bdne50zj3kgJi++MWYz1GFpWbXgfajaGOZTsaQDP7Lq1 1178638472
Received: from localhost (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id 01CF52E48F
	for <git@vger.kernel.org>; Tue,  8 May 2007 11:34:31 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m2odkv2wtd.fsf@ziti.local>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46596>

On Tue, May 08, 2007 at 07:51:10AM -0700, Seth Falcon wrote:
> Karl Hasselstr=F6m <kha@treskal.com> writes:
>=20
> > On 2007-05-07 13:07:06 -0600, Michael Hendricks wrote:
> >
> >> Now I want to import the 'foo' branch from the same SVN repo witho=
ut
> >> grabbing all the branches. Any suggestions?
> >
> > I seem to recall that just adding another "fetch" line to the git-s=
vn
> > configuration in .git/config will do this for you.
>=20
> Yes, this should work.  As long as you started out with a fairly
> recent git (sorry, I don't know how recent is needed) you should have
> in your repository a git/config file containing something like:
>=20
>     [svn-remote "svn"]
>     	url =3D http://main.svn.url.com/
>     	fetch =3D trunk:refs/remotes/git-svn
>     	fetch =3D branches/b1:refs/remotes/b1  <-- this line added by yo=
u

Thanks Seth and Karl, that does indeed work.

I noticed that after changing .git/config and running fetch, git-svn
retrieves the log for the entire project (presumably because it doesn't
know when the new branch was created).  In one project with ~30,000
revisions, I found it beneficial to specify "git svn fetch -r
12345:HEAD" where revision 12345 is somewhere close to and before the
point at which the new branch was created from trunk.  That makes the
initial fetch must faster.

--=20
Michael
