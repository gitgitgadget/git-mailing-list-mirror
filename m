From: Shantanu Pavgi <pavgi@uab.edu>
Subject: Re: removing files from history but not filesystem
Date: Tue, 28 Jun 2011 23:10:54 -0500
Message-ID: <D56E9579-BD93-42AC-BA45-E0DC20F4BB48@uab.edu>
References: <CFCCFA00-B4BF-4A88-88A5-2F588630F7BB@uab.edu>
 <218bf1d3b2bf197a5f56d542c6a91960.squirrel@mail.localhost.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-1?Q?Christof_Kr=FCger?= <git@christof-krueger.de>
X-From: git-owner@vger.kernel.org Wed Jun 29 06:11:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbm7R-00042s-RL
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 06:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905Ab1F2ELN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jun 2011 00:11:13 -0400
Received: from uabexht3.ad.uab.edu ([138.26.5.103]:53434 "EHLO
	UABEXHT3.ad.uab.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1F2ELL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2011 00:11:11 -0400
Received: from UABEXMBS5.ad.uab.edu ([138.26.5.38]) by UABEXHT3.ad.uab.edu
 ([138.26.5.103]) with mapi; Tue, 28 Jun 2011 23:11:06 -0500
Thread-Topic: removing files from history but not filesystem
Thread-Index: Acw2EpBvf+SHMIEyQOy9/cNYwbh+gQ==
In-Reply-To: <218bf1d3b2bf197a5f56d542c6a91960.squirrel@mail.localhost.li>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176432>


On Jun 28, 2011, at 2:04 AM, Christof Kr=FCger wrote:

> Hi,
>=20
>> $ git filter-branch --index-filter 'git rm --cached --ignore-unmatch
>> */one.txt' HEAD
>=20
> The following should work:
>=20
> git branch temp
> git filter-branch --index-filter 'git rm --cached --ignore-unmatch fo=
o' temp
> git reset temp
>=20
> This creates branch "temp" pointing to the same commit as "master".
> Then you filter-branch the "temp" branch. This leaves file "foo" in y=
our
> working directory intact, as your current branch is actually "master"=
=2E The
> third step resets your current "branch" to the commit pointed by the
> rewritten branch "temp". The default for git reset is --mixed which
> according to the man page leaves the working tree alone.
>=20

Thanks for the reply Chris. It worked for me. I am not following last c=
ommand "git reset <branch-name>" though. I have used SHA1 commit object=
 names in 'git reset' command, but I am not sure how <commit> is using =
branch name here. Is  it because branch is a commit pointer in the git =
history?=20

Also, how do I specify rev-list HEAD-1 so that 'git rm' will be run on =
all commits excepts latest commit? Following didn't work for me, so I g=
uess I am not following syntax here. =20
{{{
$ git filter-branch --index-filter 'git rm --cached --ignore-unmatch ap=
ple' HEAD~1
Which ref do you want to rewrite?
}}}


Any help?=20

--
Thanks,
Shantanu.=20
