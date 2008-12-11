From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: help needed: Splitting a git repository after subversion
	migration
Date: Thu, 11 Dec 2008 09:10:09 +0100
Message-ID: <20081211081009.GA14639@atjola.homenet>
References: <493C0AAD.1040208@intra2net.com> <20081208142447.GA20186@atjola.homenet> <200812081834.26688.thomas.jarosch@intra2net.com> <200812101733.36221.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 09:11:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAgdw-00021t-4A
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 09:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbYLKIKO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Dec 2008 03:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754339AbYLKIKO
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 03:10:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:36870 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751302AbYLKIKN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 03:10:13 -0500
Received: (qmail invoked by alias); 11 Dec 2008 08:10:10 -0000
Received: from i577BAEE8.versanet.de (EHLO atjola.local) [87.123.174.232]
  by mail.gmx.net (mp049) with SMTP; 11 Dec 2008 09:10:10 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18r/zEzqZErF9DsBxn4nNVVsgQgMNxFXJOYaSrZCD
	+nvvecz7usGI0z
Content-Disposition: inline
In-Reply-To: <200812101733.36221.thomas.jarosch@intra2net.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102788>

On 2008.12.10 17:33:28 +0100, Thomas Jarosch wrote:
> On Monday, 8. December 2008 18:34:20 Thomas Jarosch wrote:
> > 1. When I run "git rev-list --all --objects", I can see file names =
that
> > look like "SVN-branchname/directory/filename". Is it normal that "g=
it svn"
> > creates a directory with the name of the branch and puts files belo=
w it?
>=20
> Ok, this seems to be a PEBKAC: In the history of the subversion repos=
itory,=20
> f.e. I once copied the "branches" root folder to tags/xyz. One revisi=
on later=20
> I noticed this and retagged the correct branch. git-svn imports all b=
ranches
> from the first tag, which is the correct thing to do :o)
>=20
> Now I'll manually check the history of the tags/ and branches/ folder
> for more funny tags and write down the revision. If I understood
> the git-svn man page correctly, I should be able to specifiy
> revision ranges it's going to import. I'll try to skip the broken tag=
s.

As long as the breakage only involves branches/tags that are completely
useless, it's probably a lot easier to just delete them afterwards.

And if you accidently added changes to a tag, after it was created, it'=
s
also easier to manually tag to right version in git, and just forgettin=
g
about the additional commit.

And for a bunch of other cases, rebase -i/filter-branch are probably
also better options ;-)

Skipping revisions in a git-svn import sounds rather annoying and
error-prone.

Bj=F6rn
