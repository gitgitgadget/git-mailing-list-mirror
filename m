From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Terminology question: "tracking" branches
Date: Thu, 23 Oct 2008 10:07:07 +0200
Message-ID: <490030AB.8090207@drmicha.warpmail.net>
References: <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com> <48FDA5A0.8030506@drmicha.warpmail.net> <48FDF28A.9060606@xiplink.com> <48FF3FEE.8020209@drmicha.warpmail.net> <20081022161302.GC16946@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 23 10:09:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsvF8-0006fG-OV
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 10:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbYJWIHO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Oct 2008 04:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbYJWIHO
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 04:07:14 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54985 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752866AbYJWIHL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Oct 2008 04:07:11 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 7DE77181954;
	Thu, 23 Oct 2008 04:07:10 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 23 Oct 2008 04:07:10 -0400
X-Sasl-enc: rPou5yzDIdoiDEeiv2vI52RVDoRNvk+sZc+kW6QOj636 1224749230
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7B82131687;
	Thu, 23 Oct 2008 04:07:09 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <20081022161302.GC16946@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98946>

Bj=F6rn Steinbrink venit, vidit, dixit 22.10.2008 18:13:
> On 2008.10.22 16:59:58 +0200, Michael J Gruber wrote:
>> - a remote branch (a branch in your local repo which is a copy of a
>> branch in a remote repo; stored under refs/remotes, never to be modi=
fied
>> locally)
>> - a (remote) tracking branch (a local branch which is set up to pull
>> from a remote branch by default)
>=20
> (Remote) tracking branches are actually what you called remote branch=
es,
> at least according to the git glossary. But I wonder, what is the rig=
ht
> term for a branch that has the --track setup for pull?

Ooops, I'm sorry. I went by the name of the "--track" option and was
sure that that "git help branch" used the name "tracking branch" for th=
e
branches created with "--track", but I was wrong. So:

"(remote) tracking branch" is a local branch stored under refs/remotes/
which is a "copy" of a branch on a remote repository.

That leaves open:

- What does "remote branch" mean, if it means anything at all? It could
be used for a branch in a remote repository, i.e. the other side of
fetch/push refspec (remote branch:tracking branch).

- How to name a local branch created with --track off of a (remote)
tracking branch? Local tracking branch? Downstream/work/modification br=
anch?

I think that linguistically, the confusion comes from using the noun as
well as the adjective "remote". As an adjective: "remote something"
cleary is something residing remotely. As a noun it's the config added
by "git remote add".

Note that the glossary doesn't define remote at all. I'd volunteer
changing that once the discussion reaches a consensus.

My suggestion would be:

remote (noun): A configuration as created by "git remote add" which
points to a remote repository (using a URL) and sets up refspecs for
fetching and/or pulling. Note that the URL may point to a local
filesystem or even ".". See also remote (adjective).

remote (adjective): Anything residing in another repository. See also
remote (noun).

local: Sometimes used to emphasize things residing "locally", i.e. in
the repository at hand, as opposed to "remotely".

tracking branch: A branch tracking a (remote) branch on a remote
repository, i.e. a local branch stored under refs/remotes/ which is a
"copy" of a branch on a remote repository; typically created by "git
clone" or "git remote add/update".

remote tracking branch: Synonymous with tracking branch. [remote is a
noun, an object for track here]

[adjective to be found] branch: A local branch which is set up to pull
or rebase automatically from a tracking branch. Used for local
modifications to remote branches. [I'm tempted to use local tracking
branch here, but that would just add to the confusion.]

Come to think of it: "Off-track" branch would be the ideal name for a
local branch created off of a (remote) tracking branch, using --track t=
o
specify the track where things go off. But I'm not sure everyone would
like the implied pun...

Cheers,
Michael
