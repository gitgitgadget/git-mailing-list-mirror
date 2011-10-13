From: arQon <arqon@gmx.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 18:19:26 +0000 (UTC)
Message-ID: <loom.20111013T193054-868@post.gmane.org>
References: <loom.20111013T094053-111@post.gmane.org>   <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>   <20111013145924.2113c142@ashu.dyn.rarus.ru>   <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>   <loom.20111013T152144-60@post.gmane.org>  <1318517194.4646.30.camel@centaur.lab.cmartin.tk>  <loom.20111013T171530-970@post.gmane.org> <1318525486.4646.53.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 20:19:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REPsj-0004w8-Va
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab1JMSTp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 14:19:45 -0400
Received: from lo.gmane.org ([80.91.229.12]:50455 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913Ab1JMSTo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:19:44 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1REPsc-0004qZ-EK
	for git@vger.kernel.org; Thu, 13 Oct 2011 20:19:42 +0200
Received: from 24-180-45-63.dhcp.crcy.nv.charter.com ([24.180.45.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 20:19:42 +0200
Received: from arqon by 24-180-45-63.dhcp.crcy.nv.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 20:19:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.180.45.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Ubuntu/10.04 (lucid) Firefox/3.6.23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183504>

Carlos Mart=C3=ADn Nieto <cmn <at> elego.de> writes:
> If file1.txt in the foo branch is different from the one in the maste=
r
> branch, git will refuse to switch branches. 'git diff foo master' sho=
uld
> show that those two files are different.

Right, but only for a definition of "branch" that is actually "a fully
committed branch", hence the confusion and the mention of "uncommitted
changes" in the topic.

An expectation that "co branch" should be analogous to "cd ../branch/" =
is by
no means unreasonable. YOU may know better, but it's surprisingly non-o=
bvious,
especially considering the -f option on checkout and the wording of -m,=
 both
of which strongly suggest that, in the absence of either of those flags=
, git
WILL preserve the worktree by refusing to switch until that potentially=
-
harmful situation is resolved by the user.

> Committing non-working code is fine, as long as you don't push it out=
=2E

Right, but for the problem I was describing it's actually "committing
non-working code is a requirement, in this situation, if you don't want=
 your
tree to get eaten". Going from "you absolutely must not do this" to "yo=
u must
do this" takes some mental adjustment, but you also have to be *aware* =
that
you now have to do something that was previously prohibited, which I wa=
sn't.

> The bigger problem seems to be your reluctance to accept that git is
> different from subversion

Not at all. If I didn't WANT something different, I wouldn't have been =
trying
to move to git in the first place.  :)

> but don't go around saying that git
> corrupts branches when that's blatantly not true.

See my first para in this post (or indeed, the original post). It's "no=
t true"
provided all branches are fully committed when you switch between them.
It blatantly IS true if you switch from a dirty branch.
Redefining "branch" to mean "fully committed branch" makes it "not true=
" in
that context, but so does redefining green to be red and saying that gr=
ass is
red in that context: it may be correct from a certain POV, but it's
incomprehensible to anyone who isn't aware of that semantic change.

Anyway, I think we're done with this thread. Thanks for your (key) obse=
rvation
earlier and several clarifications, and hopefully this will help the ne=
xt guy
who runs into this problem and gets confused like I did.  :)
